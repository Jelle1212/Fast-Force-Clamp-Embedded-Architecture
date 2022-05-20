----------------------------------------------------------------------------------
-- Company: Lumicks B.V
-- Engineer: Jelle Komen
-- 
-- Create Date: 03/18/2022 09:40:45 AM
-- Design Name: 
-- Module Name: ADC_Controll_tb - sim
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

entity ADC_Control_tb is
end ADC_Control_tb;

architecture sim of ADC_Control_tb is
    --constant clock speed 200 MHz
    constant clk_hz : integer := 400e6;
    constant clock_period : time := 1000 ms / clk_hz;

    signal RESET    :  std_logic :='0';
    signal EN       :  std_logic :='0';
    signal CNV      :  std_logic;
    signal D        :  std_logic :='0';
    signal DCO      :  std_logic :='0';
    signal CLK_OUT  :  std_logic;
    signal CLK      :  std_logic :='0';
    signal count    :  integer :=0;
    signal D_READY  :  std_logic;
    signal D_OUT    :  std_logic_vector(15 downto 0);
    signal i_out    :  std_logic_vector(7 downto 0);
begin
--Device Under Test
    i_ADCCONTROLLER : entity work.ADC_Control(rtl)
    port map(
        RESET => RESET,
        EN => EN,
        CNV => CNV,
        D => D,
        DCO => DCO,
        CLK => CLK,
        CLK_OUT => CLK_OUT,
        D_READY => D_READY,
        i_out => i_out,
        D_OUT => D_OUT
    );
    --Process of generating the APPEND_MODE
    CLk <= not CLk after clock_period / 2;
    process is 
        begin
            wait until rising_edge(CLK);
            EN <= '1';
            RESET <= '1';
            wait for 800 ns;
            EN <= '1';
            RESET <= '0';
            wait for 800 ns;
            EN <= '0';
            RESET <= '1';
            wait for 800 ns;
    end process;

    --test bench sequence
    process is
        begin
            loop
            wait until CLK_OUT = '1';
            wait for 10 ns;
            for i in 1 to 16 loop
                DCO <= '1';
                wait for 2.5 ns;
                DCO <= '0';
                D <= D xor '1';
                wait for 2.5 ns;
            end loop;
            wait until CLK_OUT = '1';
            wait for 3 ns;
            for i in 1 to 8 loop
                DCO <= '1';
                wait for 2.5 ns;
                DCO <= '1';
                D <= '0';
                wait for 2.5 ns;
                DCO <= '1';
                wait for 2.5 ns;
                DCO <= '0';
                D <= '0';
                wait for 2.5 ns;
            end loop;
        end loop;
    end process;
end sim;
