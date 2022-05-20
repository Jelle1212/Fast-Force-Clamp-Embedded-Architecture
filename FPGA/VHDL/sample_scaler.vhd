----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2022 09:15:49 AM
-- Design Name: 
-- Module Name: sample_scaler - rtl
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

entity sample_scaler is
    Port ( DIN : in STD_LOGIC_VECTOR (15 downto 0);
           DOUT : out STD_LOGIC_VECTOR (31 downto 0);
           GAIN : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           RESET : in STD_LOGIC);
end sample_scaler;

architecture rtl of sample_scaler is
    signal din_i    :   integer := 0;
    signal dout_i   :   integer := 0;       
begin
    process(CLK, RESET) is
    begin

        din_i <= to_integer(signed(DIN));
        if GAIN = x"88" then                          --compensate gain in the dout_i
            dout_i <= (din_i * 8);
        elsif GAIN = x"08" then
            dout_i <= ((din_i * 32)/5);
        elsif GAIN = x"10" then
            dout_i <= ((din_i * 16)/5);
        elsif GAIN = x"18" then
            dout_i <= ((din_i * 8)/5);
        elsif GAIN = x"20" then
            dout_i <= ((din_i * 4)/5);
        elsif GAIN = x"28" then
            dout_i <= ((din_i * 2)/5);
        elsif GAIN = x"30" then
            dout_i <= (din_i / 5);
        elsif GAIN = x"38" then
            dout_i <= (din_i / 10);
        elsif GAIN = x"40" then
            dout_i <= (din_i / 20);
        elsif GAIN = x"48" then
            dout_i <= (din_i / 40);
        elsif GAIN = x"50" then
            dout_i <= (din_i / 80);
        elsif GAIN = x"58" then
            dout_i <= (din_i / 160);
        else
            dout_i <= din_i;
        end if;


        if(RESET = '0') then -- reset system
            din_i <= 0;
            dout_i <= 0;
            DOUT <= (others => '0');

        elsif(rising_edge(CLK) and EN = '1') then
            DOUT <= std_logic_vector(to_signed(dout_i, 32));
        end if;

    end process;
end rtl;
