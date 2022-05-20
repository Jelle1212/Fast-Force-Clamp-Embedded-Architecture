-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\PID_Discrete\iir_filter.vhd
-- Created: 2022-05-04 08:16:58
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 5e-08
-- Target subsystem base rate: 5e-08
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        5e-08
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- OUT_rsvd                      ce_out        5e-08
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: iir_filter
-- Source Path: PID_Discrete/iir_filter
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY iir_filter IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        IN_rsvd                           :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
        ce_out                            :   OUT   std_logic;
        OUT_rsvd                          :   OUT   std_logic_vector(15 DOWNTO 0)  -- int16
        );
END iir_filter;


ARCHITECTURE rtl OF iir_filter IS

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL IN_signed                        : signed(15 DOWNTO 0);  -- int16
  SIGNAL scaleconst1                      : signed(15 DOWNTO 0);  -- sfix16_En17
  SIGNAL scale1                           : signed(31 DOWNTO 0);  -- sfix32_En17
  SIGNAL scaletypeconvert1                : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL coeff_a2_section1                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL coeff_a3_section1                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL a1sum1_tap0                      : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a1sum1_tap1                      : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL multiplier2_mul_temp             : signed(31 DOWNTO 0);  -- sfix32_En14
  SIGNAL a3mul1                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a1sum1                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL multiplier1_mul_temp             : signed(31 DOWNTO 0);  -- sfix32_En14
  SIGNAL a2mul1                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a2sum1_temp                      : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL a2sum1                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a1sum1_temp                      : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL gain1_cast                       : signed(31 DOWNTO 0);  -- sfix32_En13
  SIGNAL b2mul1                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL adder_add_temp                   : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL b2sum1                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL adder1_add_temp                  : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL b1sum1                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL scaleconst2                      : signed(15 DOWNTO 0);  -- sfix16_En17
  SIGNAL scale2                           : signed(31 DOWNTO 0);  -- sfix32_En17
  SIGNAL scaletypeconvert2                : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL coeff_a2_section2                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL coeff_a3_section2                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL a1sum2_tap0                      : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a1sum2_tap1                      : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL multiplier5_mul_temp             : signed(31 DOWNTO 0);  -- sfix32_En14
  SIGNAL a3mul2                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a1sum2                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL multiplier4_mul_temp             : signed(31 DOWNTO 0);  -- sfix32_En14
  SIGNAL a2mul2                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a2sum2_temp                      : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL a2sum2                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a1sum2_temp                      : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL gain4_cast                       : signed(31 DOWNTO 0);  -- sfix32_En13
  SIGNAL b2mul2                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL adder2_add_temp                  : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL b2sum2                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL adder3_add_temp                  : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL b1sum2                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL scaleconst3                      : signed(15 DOWNTO 0);  -- sfix16_En17
  SIGNAL scale3                           : signed(31 DOWNTO 0);  -- sfix32_En17
  SIGNAL scaletypeconvert3                : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL coeff_a2_section3                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL coeff_a3_section3                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL a1sum3_tap0                      : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a1sum3_tap1                      : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL multiplier8_mul_temp             : signed(31 DOWNTO 0);  -- sfix32_En14
  SIGNAL a3mul3                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a1sum3                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL multiplier7_mul_temp             : signed(31 DOWNTO 0);  -- sfix32_En14
  SIGNAL a2mul3                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a2sum3_temp                      : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL a2sum3                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a1sum3_temp                      : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL gain7_cast                       : signed(31 DOWNTO 0);  -- sfix32_En13
  SIGNAL b2mul3                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL adder4_add_temp                  : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL b2sum3                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL adder5_add_temp                  : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL b1sum3                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL scaleconst4                      : signed(15 DOWNTO 0);  -- sfix16_En17
  SIGNAL scale4                           : signed(31 DOWNTO 0);  -- sfix32_En17
  SIGNAL scaletypeconvert4                : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL coeff_a2_section4                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL coeff_a3_section4                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL a1sum4_tap0                      : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a1sum4_tap1                      : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL multiplier11_mul_temp            : signed(31 DOWNTO 0);  -- sfix32_En14
  SIGNAL a3mul4                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a1sum4                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL multiplier10_mul_temp            : signed(31 DOWNTO 0);  -- sfix32_En14
  SIGNAL a2mul4                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a2sum4_temp                      : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL a2sum4                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a1sum4_temp                      : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL gain10_cast                      : signed(31 DOWNTO 0);  -- sfix32_En13
  SIGNAL b2mul4                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL adder6_add_temp                  : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL b2sum4                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL adder7_add_temp                  : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL b1sum4                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL scaleconst5                      : signed(15 DOWNTO 0);  -- sfix16_En17
  SIGNAL scale5                           : signed(31 DOWNTO 0);  -- sfix32_En17
  SIGNAL scaletypeconvert5                : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL coeff_a2_section5                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL a1sum5                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL delay_section5                   : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL multiplier13_mul_temp            : signed(31 DOWNTO 0);  -- sfix32_En14
  SIGNAL a2mul5                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL a1sum5_temp                      : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL adder8_add_temp                  : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL b1sum5                           : signed(15 DOWNTO 0);  -- sfix16

BEGIN
  IN_signed <= signed(IN_rsvd);

  scaleconst1 <= to_signed(16#0A4B#, 16);

  scale1 <= IN_signed * scaleconst1;

  scaletypeconvert1 <= resize(scale1(31 DOWNTO 17), 16);

  enb <= clk_enable;

  coeff_a2_section1 <= to_signed(-16#74C5#, 16);

  coeff_a3_section1 <= to_signed(16#39EA#, 16);

  -- coeff_b3_section1
  delay_process_section1_tap1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      a1sum1_tap1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        a1sum1_tap1 <= a1sum1_tap0;
      END IF;
    END IF;
  END PROCESS delay_process_section1_tap1_process;


  multiplier2_mul_temp <= a1sum1_tap1 * coeff_a3_section1;
  
  a3mul1 <= X"7FFF" WHEN (multiplier2_mul_temp(31) = '0') AND (multiplier2_mul_temp(30 DOWNTO 29) /= "00") ELSE
      X"8000" WHEN (multiplier2_mul_temp(31) = '1') AND (multiplier2_mul_temp(30 DOWNTO 29) /= "11") ELSE
      multiplier2_mul_temp(29 DOWNTO 14);

  delay_process_section1_tap0_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      a1sum1_tap0 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        a1sum1_tap0 <= a1sum1;
      END IF;
    END IF;
  END PROCESS delay_process_section1_tap0_process;


  multiplier1_mul_temp <= a1sum1_tap0 * coeff_a2_section1;
  
  a2mul1 <= X"7FFF" WHEN (multiplier1_mul_temp(31) = '0') AND (multiplier1_mul_temp(30 DOWNTO 29) /= "00") ELSE
      X"8000" WHEN (multiplier1_mul_temp(31) = '1') AND (multiplier1_mul_temp(30 DOWNTO 29) /= "11") ELSE
      multiplier1_mul_temp(29 DOWNTO 14);

  a2sum1_temp <= resize(scaletypeconvert1, 17) - resize(a2mul1, 17);

  
  a2sum1 <= X"7FFF" WHEN (a2sum1_temp(16) = '0') AND (a2sum1_temp(15) /= '0') ELSE
      X"8000" WHEN (a2sum1_temp(16) = '1') AND (a2sum1_temp(15) /= '1') ELSE
      a2sum1_temp(15 DOWNTO 0);

  a1sum1_temp <= resize(a2sum1, 17) - resize(a3mul1, 17);

  -- coeff_b1_section1
  
  a1sum1 <= X"7FFF" WHEN (a1sum1_temp(16) = '0') AND (a1sum1_temp(15) /= '0') ELSE
      X"8000" WHEN (a1sum1_temp(16) = '1') AND (a1sum1_temp(15) /= '1') ELSE
      a1sum1_temp(15 DOWNTO 0);

  -- coeff_b2_section1
  gain1_cast <= resize(a1sum1_tap0 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 32);
  
  b2mul1 <= X"7FFF" WHEN (gain1_cast(31) = '0') AND (gain1_cast(30 DOWNTO 28) /= "000") ELSE
      X"8000" WHEN (gain1_cast(31) = '1') AND (gain1_cast(30 DOWNTO 28) /= "111") ELSE
      gain1_cast(28 DOWNTO 13);

  adder_add_temp <= resize(a1sum1, 17) + resize(b2mul1, 17);
  
  b2sum1 <= X"7FFF" WHEN (adder_add_temp(16) = '0') AND (adder_add_temp(15) /= '0') ELSE
      X"8000" WHEN (adder_add_temp(16) = '1') AND (adder_add_temp(15) /= '1') ELSE
      adder_add_temp(15 DOWNTO 0);

  adder1_add_temp <= resize(b2sum1, 17) + resize(a1sum1_tap1, 17);
  
  b1sum1 <= X"7FFF" WHEN (adder1_add_temp(16) = '0') AND (adder1_add_temp(15) /= '0') ELSE
      X"8000" WHEN (adder1_add_temp(16) = '1') AND (adder1_add_temp(15) /= '1') ELSE
      adder1_add_temp(15 DOWNTO 0);

  scaleconst2 <= to_signed(16#0973#, 16);

  scale2 <= b1sum1 * scaleconst2;

  scaletypeconvert2 <= resize(scale2(31 DOWNTO 17), 16);

  coeff_a2_section2 <= to_signed(-16#6B31#, 16);

  coeff_a3_section2 <= to_signed(16#2FEA#, 16);

  -- coeff_b3_section2
  delay_process_section2_tap1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      a1sum2_tap1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        a1sum2_tap1 <= a1sum2_tap0;
      END IF;
    END IF;
  END PROCESS delay_process_section2_tap1_process;


  multiplier5_mul_temp <= a1sum2_tap1 * coeff_a3_section2;
  
  a3mul2 <= X"7FFF" WHEN (multiplier5_mul_temp(31) = '0') AND (multiplier5_mul_temp(30 DOWNTO 29) /= "00") ELSE
      X"8000" WHEN (multiplier5_mul_temp(31) = '1') AND (multiplier5_mul_temp(30 DOWNTO 29) /= "11") ELSE
      multiplier5_mul_temp(29 DOWNTO 14);

  delay_process_section2_tap0_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      a1sum2_tap0 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        a1sum2_tap0 <= a1sum2;
      END IF;
    END IF;
  END PROCESS delay_process_section2_tap0_process;


  multiplier4_mul_temp <= a1sum2_tap0 * coeff_a2_section2;
  
  a2mul2 <= X"7FFF" WHEN (multiplier4_mul_temp(31) = '0') AND (multiplier4_mul_temp(30 DOWNTO 29) /= "00") ELSE
      X"8000" WHEN (multiplier4_mul_temp(31) = '1') AND (multiplier4_mul_temp(30 DOWNTO 29) /= "11") ELSE
      multiplier4_mul_temp(29 DOWNTO 14);

  a2sum2_temp <= resize(scaletypeconvert2, 17) - resize(a2mul2, 17);

  
  a2sum2 <= X"7FFF" WHEN (a2sum2_temp(16) = '0') AND (a2sum2_temp(15) /= '0') ELSE
      X"8000" WHEN (a2sum2_temp(16) = '1') AND (a2sum2_temp(15) /= '1') ELSE
      a2sum2_temp(15 DOWNTO 0);

  a1sum2_temp <= resize(a2sum2, 17) - resize(a3mul2, 17);

  -- coeff_b1_section2
  
  a1sum2 <= X"7FFF" WHEN (a1sum2_temp(16) = '0') AND (a1sum2_temp(15) /= '0') ELSE
      X"8000" WHEN (a1sum2_temp(16) = '1') AND (a1sum2_temp(15) /= '1') ELSE
      a1sum2_temp(15 DOWNTO 0);

  -- coeff_b2_section2
  gain4_cast <= resize(a1sum2_tap0 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 32);
  
  b2mul2 <= X"7FFF" WHEN (gain4_cast(31) = '0') AND (gain4_cast(30 DOWNTO 28) /= "000") ELSE
      X"8000" WHEN (gain4_cast(31) = '1') AND (gain4_cast(30 DOWNTO 28) /= "111") ELSE
      gain4_cast(28 DOWNTO 13);

  adder2_add_temp <= resize(a1sum2, 17) + resize(b2mul2, 17);
  
  b2sum2 <= X"7FFF" WHEN (adder2_add_temp(16) = '0') AND (adder2_add_temp(15) /= '0') ELSE
      X"8000" WHEN (adder2_add_temp(16) = '1') AND (adder2_add_temp(15) /= '1') ELSE
      adder2_add_temp(15 DOWNTO 0);

  adder3_add_temp <= resize(b2sum2, 17) + resize(a1sum2_tap1, 17);
  
  b1sum2 <= X"7FFF" WHEN (adder3_add_temp(16) = '0') AND (adder3_add_temp(15) /= '0') ELSE
      X"8000" WHEN (adder3_add_temp(16) = '1') AND (adder3_add_temp(15) /= '1') ELSE
      adder3_add_temp(15 DOWNTO 0);

  scaleconst3 <= to_signed(16#08DB#, 16);

  scale3 <= b1sum2 * scaleconst3;

  scaletypeconvert3 <= resize(scale3(31 DOWNTO 17), 16);

  coeff_a2_section3 <= to_signed(-16#6479#, 16);

  coeff_a3_section3 <= to_signed(16#28E6#, 16);

  -- coeff_b3_section3
  delay_process_section3_tap1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      a1sum3_tap1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        a1sum3_tap1 <= a1sum3_tap0;
      END IF;
    END IF;
  END PROCESS delay_process_section3_tap1_process;


  multiplier8_mul_temp <= a1sum3_tap1 * coeff_a3_section3;
  
  a3mul3 <= X"7FFF" WHEN (multiplier8_mul_temp(31) = '0') AND (multiplier8_mul_temp(30 DOWNTO 29) /= "00") ELSE
      X"8000" WHEN (multiplier8_mul_temp(31) = '1') AND (multiplier8_mul_temp(30 DOWNTO 29) /= "11") ELSE
      multiplier8_mul_temp(29 DOWNTO 14);

  delay_process_section3_tap0_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      a1sum3_tap0 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        a1sum3_tap0 <= a1sum3;
      END IF;
    END IF;
  END PROCESS delay_process_section3_tap0_process;


  multiplier7_mul_temp <= a1sum3_tap0 * coeff_a2_section3;
  
  a2mul3 <= X"7FFF" WHEN (multiplier7_mul_temp(31) = '0') AND (multiplier7_mul_temp(30 DOWNTO 29) /= "00") ELSE
      X"8000" WHEN (multiplier7_mul_temp(31) = '1') AND (multiplier7_mul_temp(30 DOWNTO 29) /= "11") ELSE
      multiplier7_mul_temp(29 DOWNTO 14);

  a2sum3_temp <= resize(scaletypeconvert3, 17) - resize(a2mul3, 17);

  
  a2sum3 <= X"7FFF" WHEN (a2sum3_temp(16) = '0') AND (a2sum3_temp(15) /= '0') ELSE
      X"8000" WHEN (a2sum3_temp(16) = '1') AND (a2sum3_temp(15) /= '1') ELSE
      a2sum3_temp(15 DOWNTO 0);

  a1sum3_temp <= resize(a2sum3, 17) - resize(a3mul3, 17);

  -- coeff_b1_section3
  
  a1sum3 <= X"7FFF" WHEN (a1sum3_temp(16) = '0') AND (a1sum3_temp(15) /= '0') ELSE
      X"8000" WHEN (a1sum3_temp(16) = '1') AND (a1sum3_temp(15) /= '1') ELSE
      a1sum3_temp(15 DOWNTO 0);

  -- coeff_b2_section3
  gain7_cast <= resize(a1sum3_tap0 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 32);
  
  b2mul3 <= X"7FFF" WHEN (gain7_cast(31) = '0') AND (gain7_cast(30 DOWNTO 28) /= "000") ELSE
      X"8000" WHEN (gain7_cast(31) = '1') AND (gain7_cast(30 DOWNTO 28) /= "111") ELSE
      gain7_cast(28 DOWNTO 13);

  adder4_add_temp <= resize(a1sum3, 17) + resize(b2mul3, 17);
  
  b2sum3 <= X"7FFF" WHEN (adder4_add_temp(16) = '0') AND (adder4_add_temp(15) /= '0') ELSE
      X"8000" WHEN (adder4_add_temp(16) = '1') AND (adder4_add_temp(15) /= '1') ELSE
      adder4_add_temp(15 DOWNTO 0);

  adder5_add_temp <= resize(b2sum3, 17) + resize(a1sum3_tap1, 17);
  
  b1sum3 <= X"7FFF" WHEN (adder5_add_temp(16) = '0') AND (adder5_add_temp(15) /= '0') ELSE
      X"8000" WHEN (adder5_add_temp(16) = '1') AND (adder5_add_temp(15) /= '1') ELSE
      adder5_add_temp(15 DOWNTO 0);

  scaleconst4 <= to_signed(16#0882#, 16);

  scale4 <= b1sum3 * scaleconst4;

  scaletypeconvert4 <= resize(scale4(31 DOWNTO 17), 16);

  coeff_a2_section4 <= to_signed(-16#6086#, 16);

  coeff_a3_section4 <= to_signed(16#24C7#, 16);

  -- coeff_b3_section4
  delay_process_section4_tap1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      a1sum4_tap1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        a1sum4_tap1 <= a1sum4_tap0;
      END IF;
    END IF;
  END PROCESS delay_process_section4_tap1_process;


  multiplier11_mul_temp <= a1sum4_tap1 * coeff_a3_section4;
  
  a3mul4 <= X"7FFF" WHEN (multiplier11_mul_temp(31) = '0') AND (multiplier11_mul_temp(30 DOWNTO 29) /= "00") ELSE
      X"8000" WHEN (multiplier11_mul_temp(31) = '1') AND (multiplier11_mul_temp(30 DOWNTO 29) /= "11") ELSE
      multiplier11_mul_temp(29 DOWNTO 14);

  delay_process_section4_tap0_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      a1sum4_tap0 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        a1sum4_tap0 <= a1sum4;
      END IF;
    END IF;
  END PROCESS delay_process_section4_tap0_process;


  multiplier10_mul_temp <= a1sum4_tap0 * coeff_a2_section4;
  
  a2mul4 <= X"7FFF" WHEN (multiplier10_mul_temp(31) = '0') AND (multiplier10_mul_temp(30 DOWNTO 29) /= "00") ELSE
      X"8000" WHEN (multiplier10_mul_temp(31) = '1') AND (multiplier10_mul_temp(30 DOWNTO 29) /= "11") ELSE
      multiplier10_mul_temp(29 DOWNTO 14);

  a2sum4_temp <= resize(scaletypeconvert4, 17) - resize(a2mul4, 17);

  
  a2sum4 <= X"7FFF" WHEN (a2sum4_temp(16) = '0') AND (a2sum4_temp(15) /= '0') ELSE
      X"8000" WHEN (a2sum4_temp(16) = '1') AND (a2sum4_temp(15) /= '1') ELSE
      a2sum4_temp(15 DOWNTO 0);

  a1sum4_temp <= resize(a2sum4, 17) - resize(a3mul4, 17);

  -- coeff_b1_section4
  
  a1sum4 <= X"7FFF" WHEN (a1sum4_temp(16) = '0') AND (a1sum4_temp(15) /= '0') ELSE
      X"8000" WHEN (a1sum4_temp(16) = '1') AND (a1sum4_temp(15) /= '1') ELSE
      a1sum4_temp(15 DOWNTO 0);

  -- coeff_b2_section4
  gain10_cast <= resize(a1sum4_tap0 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 32);
  
  b2mul4 <= X"7FFF" WHEN (gain10_cast(31) = '0') AND (gain10_cast(30 DOWNTO 28) /= "000") ELSE
      X"8000" WHEN (gain10_cast(31) = '1') AND (gain10_cast(30 DOWNTO 28) /= "111") ELSE
      gain10_cast(28 DOWNTO 13);

  adder6_add_temp <= resize(a1sum4, 17) + resize(b2mul4, 17);
  
  b2sum4 <= X"7FFF" WHEN (adder6_add_temp(16) = '0') AND (adder6_add_temp(15) /= '0') ELSE
      X"8000" WHEN (adder6_add_temp(16) = '1') AND (adder6_add_temp(15) /= '1') ELSE
      adder6_add_temp(15 DOWNTO 0);

  adder7_add_temp <= resize(b2sum4, 17) + resize(a1sum4_tap1, 17);
  
  b1sum4 <= X"7FFF" WHEN (adder7_add_temp(16) = '0') AND (adder7_add_temp(15) /= '0') ELSE
      X"8000" WHEN (adder7_add_temp(16) = '1') AND (adder7_add_temp(15) /= '1') ELSE
      adder7_add_temp(15 DOWNTO 0);

  scaleconst5 <= to_signed(16#418D#, 16);

  scale5 <= b1sum4 * scaleconst5;

  scaletypeconvert5 <= resize(scale5(31 DOWNTO 17), 16);

  coeff_a2_section5 <= to_signed(-16#2F9D#, 16);

  -- coeff_b2_section5
  delay_process_section5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delay_section5 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delay_section5 <= a1sum5;
      END IF;
    END IF;
  END PROCESS delay_process_section5_process;


  multiplier13_mul_temp <= delay_section5 * coeff_a2_section5;
  
  a2mul5 <= X"7FFF" WHEN (multiplier13_mul_temp(31) = '0') AND (multiplier13_mul_temp(30 DOWNTO 29) /= "00") ELSE
      X"8000" WHEN (multiplier13_mul_temp(31) = '1') AND (multiplier13_mul_temp(30 DOWNTO 29) /= "11") ELSE
      multiplier13_mul_temp(29 DOWNTO 14);

  a1sum5_temp <= resize(scaletypeconvert5, 17) - resize(a2mul5, 17);

  -- coeff_b1_section5
  
  a1sum5 <= X"7FFF" WHEN (a1sum5_temp(16) = '0') AND (a1sum5_temp(15) /= '0') ELSE
      X"8000" WHEN (a1sum5_temp(16) = '1') AND (a1sum5_temp(15) /= '1') ELSE
      a1sum5_temp(15 DOWNTO 0);

  adder8_add_temp <= resize(a1sum5, 17) + resize(delay_section5, 17);
  
  b1sum5 <= X"7FFF" WHEN (adder8_add_temp(16) = '0') AND (adder8_add_temp(15) /= '0') ELSE
      X"8000" WHEN (adder8_add_temp(16) = '1') AND (adder8_add_temp(15) /= '1') ELSE
      adder8_add_temp(15 DOWNTO 0);

  OUT_rsvd <= std_logic_vector(b1sum5);

  ce_out <= clk_enable;

END rtl;
