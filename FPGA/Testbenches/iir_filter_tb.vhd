-- -------------------------------------------------------------
-- 
-- File Name: hdlsrc\iir_filter_test\iir_filter_tb.vhd
-- Created: 2022-04-29 15:24:05
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 1e-07
-- Target subsystem base rate: 1e-07
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        1e-07
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- Out1                          ce_out        1e-07
-- Out2                          ce_out        1e-07
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: iir_filter_tb
-- Source Path: 
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_textio.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY STD;
USE STD.textio.ALL;
LIBRARY work;
USE work.iir_filter_pkg.ALL;
USE work.iir_filter_tb_pkg.ALL;

ENTITY iir_filter_tb IS
END iir_filter_tb;


ARCHITECTURE rtl OF iir_filter_tb IS

  -- Component Declarations
  COMPONENT iir_filter
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          In_rsvd                         :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
          In1                             :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
          ce_out                          :   OUT   std_logic;
          Out1                            :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En10
          Out2                            :   OUT   std_logic_vector(19 DOWNTO 0)  -- sfix20
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : iir_filter
    USE ENTITY work.iir_filter(rtl);

  -- Signals
  SIGNAL clk                              : std_logic;
  SIGNAL reset                            : std_logic;
  SIGNAL clk_enable                       : std_logic;
  SIGNAL rawData_In_rsvd                  : signed(15 DOWNTO 0);  -- int16
  SIGNAL rawData_In1                      : signed(15 DOWNTO 0);  -- int16
  SIGNAL Out2_done                        : std_logic;  -- ufix1
  SIGNAL rdEnb                            : std_logic;
  SIGNAL Out2_done_enb                    : std_logic;  -- ufix1
  SIGNAL Out1_addr                        : unsigned(16 DOWNTO 0);  -- ufix17
  SIGNAL Out2_lastAddr                    : std_logic;  -- ufix1
  SIGNAL resetn                           : std_logic;
  SIGNAL check2_done                      : std_logic;  -- ufix1
  SIGNAL Out1_done                        : std_logic;  -- ufix1
  SIGNAL Out1_done_enb                    : std_logic;  -- ufix1
  SIGNAL Out1_active                      : std_logic;  -- ufix1
  SIGNAL holdData_In1                     : signed(15 DOWNTO 0);  -- int16
  SIGNAL In1_offset                       : signed(15 DOWNTO 0);  -- int16
  SIGNAL In1_1                            : signed(15 DOWNTO 0);  -- int16
  SIGNAL In1_2                            : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL holdData_In_rsvd                 : signed(15 DOWNTO 0);  -- int16
  SIGNAL In_rsvd_offset                   : signed(15 DOWNTO 0);  -- int16
  SIGNAL In_rsvd_1                        : signed(15 DOWNTO 0);  -- int16
  SIGNAL In_rsvd_2                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL snkDone                          : std_logic;
  SIGNAL snkDonen                         : std_logic;
  SIGNAL tb_enb                           : std_logic;
  SIGNAL tb_enb_delay                     : std_logic;
  SIGNAL ce_out                           : std_logic;
  SIGNAL Out1                             : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Out2                             : std_logic_vector(19 DOWNTO 0);  -- ufix20
  SIGNAL Out1_enb                         : std_logic;  -- ufix1
  SIGNAL Out1_lastAddr                    : std_logic;  -- ufix1
  SIGNAL check1_done                      : std_logic;  -- ufix1
  SIGNAL Out1_signed                      : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL Out1_expected_1                  : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL Out1_ref                         : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL Out1_testFailure                 : std_logic;  -- ufix1
  SIGNAL Out2_signed                      : signed(19 DOWNTO 0);  -- sfix20
  SIGNAL Out2_expected_1                  : signed(19 DOWNTO 0);  -- sfix20
  SIGNAL Out2_ref                         : signed(19 DOWNTO 0);  -- sfix20
  SIGNAL Out2_testFailure                 : std_logic;  -- ufix1
  SIGNAL testFailure                      : std_logic;  -- ufix1

BEGIN
  u_iir_filter : iir_filter
    PORT MAP( clk => clk,
              reset => reset,
              clk_enable => clk_enable,
              In_rsvd => In_rsvd_2,  -- int16
              In1 => In1_2,  -- int16
              ce_out => ce_out,
              Out1 => Out1,  -- sfix16_En10
              Out2 => Out2  -- sfix20
              );

  -- Data source for In_rsvd
  rawData_In_rsvd <= to_signed(16#0000#, 16);

  -- Data source for In1
  rawData_In1 <= to_signed(16#0000#, 16);

  Out2_done_enb <= Out2_done AND rdEnb;

  
  Out2_lastAddr <= '1' WHEN Out1_addr >= to_unsigned(16#186A0#, 17) ELSE
      '0';

  Out2_done <= Out2_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_2_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check2_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF Out2_done_enb = '1' THEN
        check2_done <= Out2_done;
      END IF;
    END IF;
  END PROCESS checkDone_2_process;

  Out1_done_enb <= Out1_done AND rdEnb;

  
  Out1_active <= '1' WHEN Out1_addr /= to_unsigned(16#186A0#, 17) ELSE
      '0';

  -- holdData reg for In2
  stimuli_In2_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      holdData_In1 <= (OTHERS => 'X');
    ELSIF clk'event AND clk = '1' THEN
      holdData_In1 <= rawData_In1;
    END IF;
  END PROCESS stimuli_In2_process;

  stimuli_In2_1: PROCESS (rawData_In1, rdEnb)
  BEGIN
    IF rdEnb = '0' THEN
      In1_offset <= holdData_In1;
    ELSE
      In1_offset <= rawData_In1;
    END IF;
  END PROCESS stimuli_In2_1;

  In1_1 <= In1_offset AFTER 2 ns;

  In1_2 <= std_logic_vector(In1_1);

  -- holdData reg for In1
  stimuli_In1_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      holdData_In_rsvd <= (OTHERS => 'X');
    ELSIF clk'event AND clk = '1' THEN
      holdData_In_rsvd <= rawData_In_rsvd;
    END IF;
  END PROCESS stimuli_In1_process;

  stimuli_In1_1: PROCESS (rawData_In_rsvd, rdEnb)
  BEGIN
    IF rdEnb = '0' THEN
      In_rsvd_offset <= holdData_In_rsvd;
    ELSE
      In_rsvd_offset <= rawData_In_rsvd;
    END IF;
  END PROCESS stimuli_In1_1;

  In_rsvd_1 <= In_rsvd_offset AFTER 2 ns;

  In_rsvd_2 <= std_logic_vector(In_rsvd_1);

  snkDonen <=  NOT snkDone;

  resetn <=  NOT reset;

  tb_enb <= resetn AND snkDonen;

  -- Delay inside enable generation: register depth 1
  u_enable_delay_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      tb_enb_delay <= '0';
    ELSIF clk'event AND clk = '1' THEN
      tb_enb_delay <= tb_enb;
    END IF;
  END PROCESS u_enable_delay_process;

  
  rdEnb <= tb_enb_delay WHEN snkDone = '0' ELSE
      '0';

  clk_enable <= rdEnb AFTER 2 ns;

  reset_gen: PROCESS 
  BEGIN
    reset <= '1';
    WAIT FOR 20 ns;
    WAIT UNTIL clk'event AND clk = '1';
    WAIT FOR 2 ns;
    reset <= '0';
    WAIT;
  END PROCESS reset_gen;

  clk_gen: PROCESS 
  BEGIN
    clk <= '1';
    WAIT FOR 5 ns;
    clk <= '0';
    WAIT FOR 5 ns;
    IF snkDone = '1' THEN
      clk <= '1';
      WAIT FOR 5 ns;
      clk <= '0';
      WAIT FOR 5 ns;
      WAIT;
    END IF;
  END PROCESS clk_gen;

  Out1_enb <= ce_out AND Out1_active;

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 100000
  c_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Out1_addr <= to_unsigned(16#00000#, 17);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF Out1_enb = '1' THEN
        IF Out1_addr >= to_unsigned(16#186A0#, 17) THEN 
          Out1_addr <= to_unsigned(16#00000#, 17);
        ELSE 
          Out1_addr <= Out1_addr + to_unsigned(16#00001#, 17);
        END IF;
      END IF;
    END IF;
  END PROCESS c_3_process;


  
  Out1_lastAddr <= '1' WHEN Out1_addr >= to_unsigned(16#186A0#, 17) ELSE
      '0';

  Out1_done <= Out1_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_1_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check1_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF Out1_done_enb = '1' THEN
        check1_done <= Out1_done;
      END IF;
    END IF;
  END PROCESS checkDone_1_process;

  snkDone <= check1_done AND check2_done;

  Out1_signed <= signed(Out1);

  -- Data source for Out1_expected
  Out1_expected_1 <= to_signed(16#0000#, 16);

  Out1_ref <= Out1_expected_1;

  Out1_signed_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Out1_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND Out1_signed /= Out1_ref THEN
        Out1_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in Out1_signed: Expected " & to_hex(Out1_ref) & (" Actual " & to_hex(Out1_signed))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS Out1_signed_checker;

  Out2_signed <= signed(Out2);

  -- Data source for Out2_expected
  Out2_expected_1 <= to_signed(16#00000#, 20);

  Out2_ref <= Out2_expected_1;

  Out2_signed_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Out2_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND Out2_signed /= Out2_ref THEN
        Out2_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in Out2_signed: Expected " & to_hex(Out2_ref) & (" Actual " & to_hex(Out2_signed))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS Out2_signed_checker;

  testFailure <= Out1_testFailure OR Out2_testFailure;

  completed_msg: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF snkDone = '1' THEN
        IF testFailure = '0' THEN
          ASSERT FALSE
            REPORT "**************TEST COMPLETED (PASSED)**************"
            SEVERITY NOTE;
        ELSE
          ASSERT FALSE
            REPORT "**************TEST COMPLETED (FAILED)**************"
            SEVERITY NOTE;
        END IF;
      END IF;
    END IF;
  END PROCESS completed_msg;

END rtl;
