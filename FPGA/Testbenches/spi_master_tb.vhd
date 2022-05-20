----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2022 10:22:23 AM
-- Design Name: 
-- Module Name: spi_master_tb - Behavioral
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

entity spi_master_tb is
--  Port ( );
end spi_master_tb;

architecture sim of spi_master_tb is
    --constant clock speed 100 MHz
    constant clk_hz : integer := 100e6;
    constant clock_period : time := 1000 ms / clk_hz;
    signal clock        :   std_logic := '0';
    signal reset_n      :   std_logic := '0';
    signal enable       :   std_logic := '0';
    signal cpol         :   std_logic := '0';
    signal cpha         :   std_logic := '0';
    signal cont         :   std_logic := '0';
    signal clk_div      :   std_logic_vector(15 downto 0) := x"0010";
    signal addr         :   std_logic_vector(15 downto 0) := x"0000";
    signal tx_data      :   std_logic_vector(15 downto 0) := (others => '0');
    signal miso         :   std_logic := '0';
    signal sclk         :   std_logic;
    signal ss_n         :   std_logic_vector(0 downto 0);
    signal mosi         :   std_logic;
    signal busy         :   std_logic;
    signal rx_data      :   std_logic_vector(15 downto 0);
begin
    i_spi_master : entity work.spi_master(logic)
    port map(
        clock => clock,
        reset_n => reset_n,
        enable => enable,
        cpol => cpol,
        cpha => cpha,
        cont => cont,
        clk_div => clk_div,
        addr => addr,
        tx_data => tx_data,
        miso => miso,
        sclk => sclk,
        ss_n => ss_n,
        mosi => mosi,
        busy => busy,
        rx_data => rx_data
    );
    clock <= not clock after clock_period/2;
    process is
        begin
            wait until rising_edge(clock);
            reset_n <= '1';
            cpol <= '0';
            cpha <= '0';
            cont <= '0';
    end process;

    process is
        begin
            loop
                wait until busy = '0';
                wait for 100 ns;
                enable <= '1';
                tx_data <= x"0E80";
                wait for 50 ns;
                enable <= '0';
                tx_data <= x"0000";
            end loop;
    end process;
end sim;
