----------------------------------------------------------------------------------
-- Company: Lumick B.V
-- Engineer: Jelle Komen
-- 
-- Create Date: 03/17/2022 11:44:29 AM
-- Design Name: ADC Controller
-- Module Name: ADC_Controll - Behavioral
-- Project Name: Fast Force Clamp Architecture
-- Target Devices: Pynq Z1
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

entity ADC_Control is
    Port ( RESET : in STD_LOGIC;
           EN : in STD_LOGIC;
           CNV : out STD_LOGIC;
           D : in STD_LOGIC;
           DCO : in STD_LOGIC;
           CLK : in STD_LOGIC;
           CLK_OUT : out STD_LOGIC;
           D_READY : out STD_LOGIC;
           i_out   : out std_logic_vector(7 downto 0);
           D_OUT : out std_logic_vector(15 downto 0)
        );
end ADC_Control;

architecture rtl of ADC_Control is
    type machine is(start, delay, clock); --state machine data type
    signal state   :   machine;                  --current state
    signal clock_out_en    :   std_logic;
    signal data_in_en      :   std_logic;
    signal D_OUT_i         :   std_logic_vector(15 downto 0) := (others => '0');
    signal i : integer;

begin
    initiate :   process(CLK, DCO, RESET, EN) is
    variable clock_count : integer := 0;
    variable clock_count_out : integer := 0;
    variable i_clock : std_logic := '0';
    begin

        if RESET = '0' or EN = '0' then --active low
            CNV <= '0';
            state <= start;
            clock_count := 0;
            clock_out_en <= '0';
            data_in_en <= '0';
            CLK_OUT <= '0';
                
        elsif rising_edge(CLK) and EN = '1' then
            case state is
                when start =>
                    CNV <= '1';
                    clock_count := clock_count + 1;
                    CLK_OUT <= '0';
                    if clock_count > 4 then -- CNV after 20 ns
                        CNV <= '0';
                        clock_count := 0;
                        state <= delay;
                    end if;
                
                when delay => 
                    clock_count := clock_count + 1;
                    if clock_count = 15 then
                        data_in_en <= '0';
                    end if;
                    if clock_count = 16 then -- after 100 ns msb
                        clock_count := 0;
                        state <= clock;
                    end if;
                
                when clock =>
                    clock_out_en <= '1';
                    data_in_en <= '1';
                    clock_count := clock_count + 1;
                    if clock_count > 18 then
                        clock_count := 0;
                        state <= start;
                    end if;
            end case;

            if clock_out_en = '1' then
                CLK_OUT <= i_clock;
                i_clock := i_clock xor '1';
                clock_count_out := clock_count_out + 1;
                if clock_count_out > 32 then --afters 16 clock pulses
                    clock_count_out := 0;
                    i_clock := '1';
                    CLK_OUT <= '0';
                    clock_out_en <= '0';
                end if;
            end if;
        end if;
    end process;
 
    data : process(DCO, i, data_in_en) is
        variable d_register : std_logic_vector(15 downto 0);

        begin
        i_out <= std_logic_vector(to_signed(i, 8));    

        if data_in_en = '1' then
            if rising_edge(DCO) then -- catch data
                D_READY <= '0';
                d_register(i) := D;
            end if;

            if falling_edge(DCO) then
                i <= i - 1;
            end if;
        else
            i <= 15;
        end if;
        
        if i = -1 and DCO = '0'then
            D_READY <= '1';
            D_OUT <= d_register;
            i <= 15;
        end if;

    end process;
end rtl;