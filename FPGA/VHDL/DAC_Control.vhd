----------------------------------------------------------------------------------
-- Company: Lumicks B.V.
-- Engineer: Jelle Komen
-- 
-- Create Date: 04/13/2022 07:18:14 AM
-- Design Name: 
-- Module Name: DAC_Control - rtl
-- Project Name: 
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

entity DAC_Control is
    port(
        CLK     :       in  std_logic;
        RESET   :       in  std_logic;
        EN      :       in  std_logic;
        DIN     :       in  std_logic_vector(19 downto 0);
        DIN_TEST:       in  std_logic_vector(15 downto 0);
        AVAILABLE   :   in  std_logic;
        DOUT    :       out std_logic_vector(23 downto 0);
        CPOL    :       out std_logic;
        CPHA    :       out std_logic;
        CONT    :       out std_logic;
        CLK_DIV :       out std_logic_vector(23 downto 0);
        ADDR    :       out std_logic_vector(23 downto 0);
        SPI_EN  :       out std_logic;
        TEST    :       in  std_logic
        );
end DAC_Control;

architecture rtl of DAC_Control is
    type machine is(init, load, output); --state machine data type
    signal state       : machine;                  --current state
    signal buffer_out       :       std_logic_vector(23 downto 0);
    signal buffer_in       :       std_logic_vector(19 downto 0);
    -- Command register bits defined on pg. 22 of the manual
  signal RESERVED                       : std_logic                     := '0'; -- Reserved bits should be programmed as zeros
  signal RBUF                           : std_logic                     := '0'; -- Output amplifier config; default
  signal OPGND                          : std_logic                     := '0'; -- Output ground clamp; zero removes ground clamp
  signal DACTRI                         : std_logic                     := '0'; -- Tristate control; zero sets normal mode
  signal BIN2sC                         : std_logic                     := '0'; -- DAC regisger coding select; default
  signal SDODIS                         : std_logic                     := '0'; -- SDO pin enable/disable; default
  signal LINCOMP                        : std_logic_vector(3 downto 0)  := "0000"; -- Linearity error compensation; default
  
  signal reg_config                     : std_logic_vector(8 downto 0)  := LINCOMP & SDODIS & BIN2sC & DACTRI & OPGND & RBUF;
  signal reg_config_reserved            : std_logic_vector(19 downto 0) := "0000000000" & reg_config & RESERVED;

   -- Data "address"
  signal dac_reg                       : std_logic_vector(2 downto 0) := "001";
  signal clr_reg                       : std_logic_vector(2 downto 0) := "011";
  signal control_reg                    : std_logic_vector(2 downto 0) := "010";
  signal write_bit                      : std_logic := '0';

begin
    process(CLK, RESET) is
        variable clock_count : integer := 0;
        begin
            CPOL <= '0';
            CPHA <= '1';
            CONT <= '0';
            CLK_DIV <= x"000002";
            ADDR <= x"000000";
            if RESET = '0' then
                buffer_out <= X"000000";
                DOUT <= (others => '0');
                CPOL <= '0';
                CPHA <= '1';
                CONT <= '0';
                CLK_DIV <= x"000002";
                ADDR <= x"000000";
                SPI_EN <= '0';
                clock_count := 0;
                state <= init;

            elsif rising_edge(CLK) and EN = '1' then
                if test = '1' then
                    buffer_in(19 downto 4) <= DIN_TEST;
                else
                    buffer_in <= DIN; --load sigend 20 bit in buffer
                end if;
                case state is -- state machine
                    when init =>
                    if AVAILABLE = '0' then 
                        SPI_EN <= '1';
                        DOUT <= write_bit & control_reg & reg_config_reserved;
                        state <= output;
                    end if;
                    when load =>
                        SPI_EN <= '0';
                        buffer_out <= write_bit & dac_reg & buffer_in;
                        state <= output;

                    when output =>
                        if AVAILABLE = '0' then
                            clock_count := clock_count + 1;
                            if clock_count > 1 then
                                SPI_EN <= '1';
                                clock_count := 0;
                                state <= load;
                            end if;
                            DOUT <= buffer_out;
                            state <= load;
                        elsif AVAILABLE = '1' then
                            state <= output;
                        end if;
                end case;
            end if;
    end process;
end rtl;
