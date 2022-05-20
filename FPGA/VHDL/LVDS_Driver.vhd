----------------------------------------------------------------------------------
-- Company: Lumicks B.V
-- Engineer: Jelle Komen
-- 
-- Create Date: 03/09/2022 02:56:19 PM
-- Design Name: LVDS Driver Module
-- Module Name: LVDS_DRIVER - LVDS
-- Project Name: Fast Force Clamp Architecture
-- Target Devices: ZYNQ 7020
-- Tool Versions: 
-- Description: LVDS Differential to Single Ended stage for DCO and DATA + Single Ended to Diffirential stage for Clock and CNV 
-- 
-- Dependencies: 
-- 
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: ADC: AD7262
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity LVDS_DRIVER is
    Port (CLOCK_P     : out STD_LOGIC;
         CLOCK_N      : out STD_LOGIC;
         CNV_P        : out STD_LOGIC;
         CNV_N        : out STD_LOGIC;
         DATA_P       : in STD_LOGIC;
         DATA_N       : in STD_LOGIC;
         DCO_P        : in STD_LOGIC;
         DCO_N        : in STD_LOGIC;
         CLOCK        : in STD_LOGIC;
         CNV          : in STD_LOGIC;
         DATA         : out STD_LOGIC;
         DCO          : out STD_LOGIC
        );
end LVDS_DRIVER;

architecture rtl of LVDS_DRIVER is

begin
    -- IBUFDS: Differential Input Buffer
    --
    -- The current version of the Xilinx HDL Libraries Guide
    IBUFDS_DATA : IBUFDS
            -- Edit the following generic to specify the I/O standard for this port.
        generic map (
            DIFF_TERM => TRUE,
            IOSTANDARD => "LVDS_25")
        port map (
            O => DATA, -- data buffer output
            I => DATA_P, -- Diff_p data buffer input (connect to top-level port)
            IB => DATA_N -- Diff_n data buffer input (connect directly to top-level port)
        );

    IBUFDS_DCO : IBUFDS
            -- Edit the following generic to specify the I/O standard for this port.
        generic map (
            DIFF_TERM => TRUE,
            IOSTANDARD => "LVDS_25")
        port map (
            O => DCO, -- DCO buffer output
            I => DCO_P, -- Diff_p DCO buffer input (connect to top-level port)
            IB => DCO_N -- Diff_n DCO buffer input (connect directly to top-level port)
        );

    -- Internal single to LVDS output  
    CLK_OBUFDS : OBUFDS
        generic map(
            IOSTANDARD => "LVDS_25")
        port map(
            O  => CLOCK_P, --Diff_p CLOCK buffer output
            OB => CLOCK_N, --Diff_n CLOCK buffer output
            I  => CLOCK    --CLOCK buffer input
        );

    -- Internal single to LVDS output  
    CNV_OBUFDS : OBUFDS
        generic map(
            IOSTANDARD => "LVDS_25")
        port map(
            O  => CNV_P, --Diff_p CNV buffer output
            OB => CNV_N, --Diff_n CNV buffer output
            I  => CNV    --CNV buffer input
        );

end rtl;
