----------------------------------------------------------------------------------
-- Company: LUMICKS B.V.
-- Engineer: Jelle Komen
-- 
-- Create Date: 03/24/2022 10:28:12 AM
-- Design Name: 
-- Module Name: Gain_control - rtl
-- Project Name: Force Clamp Embedded Architecture
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Gain_control is
    Port ( RESET        : in STD_LOGIC; -- Reset
           EN           : in STD_LOGIC; -- Enable
           CLK          : in STD_LOGIC; -- 100 MHz clock input
           DIN          : in STD_LOGIC_VECTOR(15 downto 0); -- Data from ADC 2s complement format
           AIS          : in STD_LOGIC; -- Select analog differential input from the PGIA
           AVAILABLE    : in STD_LOGIC; --check spi master for availability
           CPOL         : out STD_LOGIC; -- Select CPOL
           CPHA         : out STD_LOGIC; -- Select CPHA
           CONT         : out STD_LOGIC; -- continuous mode command select
           CLK_DIV      : out STD_LOGIC_VECTOR(15 downto 0); -- system clock cycles per 1/2 period of sclk
           ADDR         : out STD_LOGIC_VECTOR(15 downto 0); -- address of slave
           DOUT         : out STD_LOGIC_VECTOR(15 downto 0); --data for transmit spi
           GAIN_STATE   : out STD_LOGIC_VECTOR(7 downto 0); --gain stage
           SPI_EN       : out STD_LOGIC --Enable SPI master
        );
end Gain_control;

architecture rtl of Gain_control is
    type machine is(protection, gain_select, input_select, dynamic_range, buffer_out); --state machine data type
    signal state : machine; --current state
    type t_memory is array (0 to 11) of std_logic_vector(7 downto 0); 
    signal gain_register : t_memory := (x"00", x"08",x"10",x"18",x"20",x"28",x"30",x"38",x"40",x"48",x"50",x"58" ); -- GAIN values
    signal test_mux_register : STD_LOGIC_VECTOR (15 downto 0) := x"0E00"; --address test mux register
    signal gain_mux_register : STD_LOGIC_VECTOR (15 downto 0) := x"0000"; --address gain mux register
    signal input_mux_register : STD_LOGIC_VECTOR (15 downto 0) := x"0600"; --address input mux register
    signal g5_bit : STD_LOGIC_VECTOR(15 downto 0) := x"0080"; -- address g5 bit
    signal input_mux_in1 : STD_LOGIC_VECTOR(15 downto 0) := x"0060"; -- address IN1 input mux register
    signal input_mux_in2 : STD_LOGIC_VECTOR(15 downto 0) := x"0018"; -- address iN2 input mux register
    signal i_last_gain : STD_LOGIC_VECTOR(7 downto 0) := x"00"; -- previous gain setting
begin
    process(CLK, EN, RESET) is
    variable output_buffer : std_logic_vector (15 downto 0) := (others => '0');
    variable state_select : integer := 1;
    variable current_input_select : integer := 1; -- By defealt analog input 1
    variable index : integer := 0;
    variable load_buffer_output : integer := 0;
    variable flag_notify_gain_last_value : integer := 0;
    begin
        if(RESET = '0') then --reset system
            CPOL <= '0';
            CPHA <= '0';
            CONT <= '0';
            CLK_DIV <= x"0019";
            DOUT <= (others => '0');
            GAIN_STATE <= (others => '0');
            output_buffer := (others => '0');
            ADDR <= x"0000";
            SPI_EN <= '0';
            state <= protection;

        elsif(rising_edge(CLK)) and EN = '1' then
            case state is --state machine
                when protection => -- set voltage protection
                    output_buffer := std_logic_vector(unsigned(gain_mux_register) + resize(unsigned(gain_register(4)), 16)); --set address in output buffer
                    index := 4;
                    state_select := 1; -- select next gain_select state
                    state <= buffer_out; -- go to buffer out state
                    
                when gain_select =>
                    --output_buffer := std_logic_vector(unsigned(test_mux_register) + unsigned(g5_bit)); --set address in output buffer to 1.375 v/v scale
                    output_buffer := std_logic_vector(unsigned(test_mux_register) + x"0000"); ----set address in output buffer to default scale
                    state_select := 2; -- select next input_select state
                    state <= buffer_out; -- go to buffer out state
                
                when input_select =>
                    if AIS = '0' and current_input_select = 2 then -- select AIN1
                        output_buffer := std_logic_vector(unsigned(input_mux_register) + unsigned(input_mux_in1));
                        current_input_select := 1;
                        state_select := 4;
                        state <= buffer_out;
                    elsif AIS = '1' and current_input_select = 1 then -- select AIN2
                        output_buffer := std_logic_vector(unsigned(input_mux_register) + unsigned(input_mux_in2));
                        current_input_select := 2;
                        state_select := 4;
                        state <= buffer_out;
                    else
                        state <= dynamic_range;
                    end if;

                when dynamic_range =>
                    if (x"7FFE" >= DIN and DIN >= x"4000") or (x"C000" >= DIN and DIN >= x"8001") then
                        state <= input_select;
                    elsif x"7FFF"= DIN or DIN = x"8000" then
                        if index = 0 then
                            flag_notify_gain_last_value := 1;
                            state <= buffer_out;
                        else 
                            index := index - 1;
                            load_buffer_output := 1;
                        end if;
                    else
                        if index = 11 then
                            flag_notify_gain_last_value := 1;
                            state <= buffer_out;
                        else
                            index := index + 1;
                            load_buffer_output := 1;
                        end if;
                    end if;
                    if load_buffer_output = 1 then
                        output_buffer := std_logic_vector(unsigned(gain_mux_register) + resize(unsigned(gain_register(index)), 16)); --set address in output buffer
                        load_buffer_output := 0;
                        if state_select = 2 then
                            state_select := 3;
                        else
                            state_select := 4;
                        end if;
                        state <= buffer_out;
                    end if;


                when buffer_out =>
                    if AVAILABLE = '0' and output_buffer > x"0000" then
                        SPI_EN <= '1'; -- enable spi master
                        DOUT <= output_buffer;
                        output_buffer := (others => '0');
                        if state_select = 2 then
                            GAIN_STATE <= x"01"; --notify gain for voltage protection
                        elsif state_select = 3 then
                            GAIN_STATE <= x"01"; --notify the gain output stage 1
                        elsif state_select = 4 then
                            GAIN_STATE <= i_last_gain; -- notify gain setting
                        end if;
                    elsif AVAILABLE = '1' and output_buffer = x"0000" then
                        SPI_EN <= '0';
                        if state_select = 1 then
                            state <= gain_select;
                        elsif state_select = 2 then
                            state <= input_select;
                        elsif state_select = 3 then
                            i_last_gain <= std_logic_vector(to_unsigned(index + 1, 8));
                            state <= dynamic_range;
                        elsif state_select = 4 then
                            i_last_gain <= std_logic_vector(to_unsigned(index + 1, 8));
                            state <= input_select;
                        end if;
                    elsif AVAILABLE = '0' and flag_notify_gain_last_value = 1 then
                        GAIN_STATE <= i_last_gain; -- notify gain setting
                        flag_notify_gain_last_value := 0;
                        state <= input_select;
                    end if;
            end case;
        end if;
    end process;
end rtl;
