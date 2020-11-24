-- ----------------------------------------------------------------------------
-- hc_fsm_e.vhd
-- ENTITIE for the HC_FSM
-- 
-- Author: Nils Schlegel, 32067
--         Tara Jaishi, 32289
-- Last edited: 2020-11-13
-- ----------------------------------------------------------------------------
-- FPGA-chip: 10M16SAU169C8G (most likely)
-- ----------------------------------------------------------------------------

LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;

-- ----------------------------------------------------------------------------

ENTITY hc_fsm is
PORT(
  rb_i : IN STD_LOGIC;                     -- Reset, active low
  cp_i : IN STD_LOGIC;                     -- Syscp, @ 12MHz
  dv_i : IN STD_LOGIC;                     -- Have new RTC or GPS-Data
  br_i : IN STD_LOGIC;                     -- Baud-Rate to ena Counter
  dne_i : IN STD_LOGIC;                     -- Last Bit transmitted
  sto_o : OUT STD_LOGIC;                     -- enable register load
  clr_o : OUT STD_LOGIC;                     -- clear Bit-Counters
  nxt_o : OUT STD_LOGIC                      -- next Bit, inc count
  );
END hc_fsm;

