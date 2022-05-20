----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2022 04:18:21 PM
-- Design Name: 
-- Module Name: LVDS_Driver_tb - rtl
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LVDS_Driver_tb is
end LVDS_Driver_tb;

architecture sim of LVDS_Driver_tb is
    --constant clock speed 10 MHz
    constant clk_hz : integer := 10e6;
    constant clock_period : time := 1000 ms / clk_hz;

    signal  CLOCK_P      :  std_logic;
    signal  CLOCK_N      :  std_logic;
    signal  CNV_P        :  std_logic;
    signal  CNV_N        :  std_logic;
    signal  DATA_P       :  std_logic :='0';
    signal  DATA_N       :  std_logic :='0';
    signal  DCO_P        :  std_logic :='0';
    signal  DCO_N        :  std_logic :='0';
    signal  CLOCK        :  std_logic :='0';
    signal  CNV          :  std_logic :='0';
    signal  DATA         :  std_logic :='0';
    signal  DCO          :  std_logic :='0';
begin
    --The Device Unter Test (DUT)
    i_LVDSCONTROLLER : entity work.LVDS_Driver(rtl)
        port map(
            CLOCK_P => CLOCK_P,
            CLOCK_N => CLOCK_N,
            CNV_N => CNV_N,
            CNV_P => CNV_P,
            DATA_P => DATA_P,
            DATA_N => DATA_N,
            DCO_N => DCO_N,
            DCO_P => DCO_P,
            CLOCK => CLOCK,
            CNV => CNV,
            DATA => DATA,
            DCO => DCO
        );
    --Process of generating the APPEND_MODE
    CLOCK <= not CLOCK after clock_period / 2;

    --test bench sequence
    process is
        begin
            wait until rising_edge(CLOCK);
            --wait until rising_edge(CLOCK);

            wait;
         end process;
         
    process is
    begin
        loop
            wait for 50 ns;
            CNV <= '1';
            DATA_P <='0';
            DATA_N <='0';
            DCO_P <='0';
            DCO_N <='0';
            wait for 50 ns;
            CNV <= '0';
            DATA_P <='0';
            DATA_N <='1';
            DCO_P <='0';
            DCO_N <='1';
            wait for 50 ns;
            CNV <= '1';
            DATA_P <='1';
            DATA_N <='0';
            DCO_P <='1';
            DCO_N <='0';
            wait for 50 ns;
            CNV <= '0';
            DATA_P <='1';
            DATA_N <='1';
            DCO_P <='1';
            DCO_N <='1';
        end loop;
    end process;
end sim;
