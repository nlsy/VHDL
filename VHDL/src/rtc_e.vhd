LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;

ENTITY rtc_e is
PORT(
  rb_i  : IN  std_logic;
  cp_i  : IN  std_logic;
  rb_o  : OUT std_logic;
  sec_o : OUT std_logic;
  sdi_o : OUT std_logic;
  sdv_o : OUT std_logic;
  stx_o : OUT std_logic
  );
END rtc_e;

