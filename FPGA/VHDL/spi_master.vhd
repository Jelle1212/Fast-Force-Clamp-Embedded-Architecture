--------------------------------------------------------------------------------
--
--   FileName:         spi_master.vhd
--   Dependencies:     none
--   Design Software:  Quartus II Version 9.0 Build 132 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 7/23/2010 Scott Larson
--     Initial Public Release
--   Version 1.1 4/11/2013 Scott Larson
--     Corrected ModelSim simulation error (explicitly reset clk_toggles signal)
--    
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

ENTITY spi_master IS
  GENERIC(
    slaves  : INTEGER := 1;  --number of spi slaves
    d_width : INTEGER := 16); --data bus width
  PORT(
    clock   : IN     STD_LOGIC;                             --system clock
    reset_n : IN     STD_LOGIC;                             --asynchronous reset
    enable  : IN     STD_LOGIC;                             --initiate transaction
    cpol    : IN     STD_LOGIC;                             --spi clock polarity
    cpha    : IN     STD_LOGIC;                             --spi clock phase
    cont    : IN     STD_LOGIC;                             --continuous mode command
    clk_div : IN     STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  --system clock cycles per 1/2 period of sclk
    addr    : IN     STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  --address of slave
    tx_data : IN     STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  --data to transmit
    miso    : IN     STD_LOGIC;                             --master in, slave out
    sclk    : OUT    STD_LOGIC;                             --spi clock
    ss_n    : OUT    STD_LOGIC_VECTOR(slaves-1 DOWNTO 0);   --slave select
    mosi    : OUT    STD_LOGIC;                             --master out, slave in
    busy    : OUT    STD_LOGIC;                             --busy / data ready signal
    rx_data : OUT    STD_LOGIC_VECTOR(d_width-1 DOWNTO 0)); --data received
END spi_master;

ARCHITECTURE logic OF spi_master IS
  TYPE machine IS(ready, execute);                           --state machine data type
  SIGNAL state       : machine;                              --current state
  SIGNAL slave       : INTEGER;                              --slave selected for current transaction
  SIGNAL clk_ratio   : INTEGER;                              --current clk_div
  SIGNAL count       : INTEGER;                              --counter to trigger sclk from system clock
  SIGNAL clk_toggles : INTEGER RANGE 0 TO d_width*2 + 1;     --count spi clock toggles
  SIGNAL assert_data : STD_LOGIC;                            --'1' is tx sclk toggle, '0' is rx sclk toggle
  SIGNAL continue    : STD_LOGIC;                            --flag to continue transaction
  SIGNAL rx_buffer   : STD_LOGIC_VECTOR(d_width-1 DOWNTO 0); --receive data buffer
  SIGNAL tx_buffer   : STD_LOGIC_VECTOR(d_width-1 DOWNTO 0); --transmit data buffer
  SIGNAL last_bit_rx : INTEGER RANGE 0 TO d_width*2;         --last rx data bit location
  SIGNAL clk_div_int : INTEGER;
  SIGNAL addr_int    : INTEGER;
  SIGNAL i_sclk      : STD_LOGIC;
  SIGNAL i_ss_n      : STD_LOGIC_VECTOR(slaves-1 downto 0);
BEGIN
  sclk <= i_sclk;
  ss_n <= i_ss_n;
  PROCESS(clock, reset_n)
  BEGIN
    IF(reset_n = '0') THEN        --reset system
      busy <= '1';                --set busy signal
      i_ss_n <= (OTHERS => '1');    --deassert all slave select lines
      mosi <= '1';                --set master out to high impedance
      rx_data <= (OTHERS => '0'); --clear receive data port
      state <= ready;             --go to ready state when reset is exited

    ELSIF(clock'EVENT AND clock = '1') THEN
      clk_div_int <= to_integer(unsigned(clk_div));
      addr_int <= to_integer(unsigned(addr));
      CASE state IS               --state machine

        WHEN ready =>
          busy <= '0';             --clock out not busy signal
          i_ss_n <= (OTHERS => '1'); --set all slave select outputs high
          mosi <= '1';             --set mosi output high impedance
          continue <= '0';         --clear continue flag

          --user input to initiate transaction
          IF(enable = '1') THEN       
            busy <= '1';             --set busy signal
            IF(addr_int < slaves) THEN   --check for valid slave address
              slave <= addr_int;         --clock in current slave selection if valid
            ELSE
              slave <= 0;            --set to first slave if not valid
            END IF;
            IF(clk_div_int = 0) THEN     --check for valid spi speed
              clk_ratio <= 1;        --set to maximum speed if zero
              count <= 1;            --initiate system-to-spi clock counter
            ELSE
              clk_ratio <= clk_div_int;  --set to input selection if valid
              count <= clk_div_int;      --initiate system-to-spi clock counter
            END IF;
            i_sclk <= cpol;            --set spi clock polarity
            assert_data <= NOT cpha; --set spi clock phase
            tx_buffer <= tx_data;    --clock in data for transmit into buffer
            clk_toggles <= 0;        --initiate clock toggle counter
            if cpha = '1' then
              last_bit_rx <= d_width*2; --set last rx data bit
            else
              last_bit_rx <= d_width*2 - 1; --set last rx data bit
            end if;
            state <= execute;        --proceed to execute state
          ELSE
            state <= ready;          --remain in ready state
          END IF;

        WHEN execute =>
          busy <= '1';        --set busy signal
          i_ss_n(slave) <= '0'; --set proper slave select output
          
          --system clock to i_sclk ratio is met
          IF(count = clk_ratio) THEN        
            count <= 1;                     --reset system-to-spi clock counter
            assert_data <= NOT assert_data; --switch transmit/receive indicator
            clk_toggles <= clk_toggles + 1; --increment spi clock toggles counter
            
            --spi clock toggle needed
            IF(clk_toggles <= d_width*2 AND i_ss_n(slave) = '0') THEN 
              i_sclk <= NOT i_sclk; --toggle spi clock
            END IF;
            
            --receive spi clock toggle
            IF(assert_data = '0' AND clk_toggles < last_bit_rx + 1 AND i_ss_n(slave) = '0') THEN 
              rx_buffer <= rx_buffer(d_width-2 DOWNTO 0) & miso; --shift in received bit
            END IF;
            
            --transmit spi clock toggle
            IF(assert_data = '1' AND clk_toggles < last_bit_rx) THEN 
              mosi <= tx_buffer(d_width-1);                     --clock out data bit
              tx_buffer <= tx_buffer(d_width-2 DOWNTO 0) & '0'; --shift data transmit buffer
            END IF;
            
            --last data receive, but continue
            IF(clk_toggles = last_bit_rx AND cont = '1') THEN 
              tx_buffer <= tx_data;                       --reload transmit buffer
              clk_toggles <= last_bit_rx - d_width*2 + 1; --reset spi clock toggle counter
              continue <= '1';                            --set continue flag
            END IF;
            
            --normal end of transaction, but continue
            IF(continue = '1') THEN  
              continue <= '0';      --clear continue flag
              busy <= '0';          --clock out signal that first receive data is ready
              rx_data <= rx_buffer; --clock out received data to output port    
            END IF;
            
            --end of transaction
            IF((clk_toggles = d_width*2 + 1) AND cont = '0') THEN   
              busy <= '0';             --clock out not busy signal
              i_ss_n <= (OTHERS => '1'); --set all slave selects high
              mosi <= '1';             --set mosi output high impedance
              rx_data <= rx_buffer;    --clock out received data to output port
              state <= ready;          --return to ready state
            ELSE                       --not end of transaction
              state <= execute;        --remain in execute state
            END IF;
          
          ELSE			  --system clock to sclk ratio not met
            count <= count + 1; --increment counter
            state <= execute;   --remain in execute state
          END IF;

      END CASE;
    END IF;
  END PROCESS; 
END logic;