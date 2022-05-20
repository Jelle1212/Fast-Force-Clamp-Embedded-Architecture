----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2022 07:55:13 AM
-- Design Name: 
-- Module Name: DAC_Control_tb - sim
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

entity DAC_Control_tb is
--  Port ( );
end DAC_Control_tb;

architecture sim of DAC_Control_tb is
    constant clk_hz : integer := 100e6;
    constant clock_period : time := 1000 ms / clk_hz;
    signal RESET    :  std_logic :='0';
    signal EN       :  std_logic :='0';
    signal CLK      :  std_logic := '0';
    signal DIN      :  std_logic_vector(19 downto 0);
    signal AVAILABLE    :   std_logic := '0';
    signal DOUT     :  std_logic_vector(23 downto 0);
    signal CPOL     :  std_logic;
    signal CPHA     :  std_logic;
    signal CONT     :  std_logic;
    signal CLK_DIV  :  std_logic_vector(23 downto 0);
    signal ADDR     :  std_logic_vector(23 downto 0);
    signal SPI_EN   :  std_logic;
    signal TEST     :  std_logic;
    signal DIN_TEST :  std_logic_vector(15 downto 0);
begin

    --Device under test
    i_DACCONTROLLER :   entity work.DAC_Control(rtl)
    port map(
        RESET       =>  RESET,   
        EN          =>  EN,      
        CLK         =>  CLK,     
        DIN         =>  DIN,     
        AVAILABLE   =>  AVAILABLE,
        DOUT        =>  DOUT,    
        CPOL        =>  CPOL,    
        CPHA        =>  CPHA,    
        CONT        =>  CONT,    
        CLK_DIV     =>  CLK_DIV, 
        ADDR        =>  ADDR,
        SPI_EN      =>  SPI_EN,
        TEST        =>  TEST,
        DIN_TEST    =>  DIN_TEST 
    );
    --Process of generating the APPEND_MODE
    CLk <= not CLk after clock_period / 2;
    process is
        begin
            wait until rising_edge(CLK);
            EN <= '1';
            RESET <= '1';
            TEST <= '0';
            DIN <= X"AAAAA";
            wait for 500 ns;
            TEST <= '1';
            DIN_TEST <= X"AAAA";
            wait for 500 ns;

    end process;

    process is
        begin
            loop
                AVAILABLE <= '1';
                wait for 100 ns;
                AVAILABLE <= '0';
                wait for 100 ns;
            end loop;
    end process;
end sim;
