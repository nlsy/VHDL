-- ----------------------------------------------------------------------------

LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;

-- ----------------------------------------------------------------------------

ENTITY interface_fsm IS
PORT(
  rb_i : IN std_logic;                     -- Reset, active low
  cp_i : IN std_logic;                     -- Syscp, @ 12MHz
  dv_i : IN std_logic;                     -- Have new RTC or GPS-Data
  dne_i : IN std_logic;                     -- Last Bit transmitted
  ldr_o : OUT std_logic;                     -- enable register load
  act_o : OUT std_logic;
  vld_o: OUT std_logic;
  clr_o : OUT std_logic;                     -- clear Bit-Counters
  nxt_o : OUT std_logic                      -- next Bit, inc count
  );
END interface_fsm;
