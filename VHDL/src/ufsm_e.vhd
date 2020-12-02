-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- ---------------------------------------------------------------------------

ENTITY uat_fsm IS
PORT (rb_i   :  IN std_logic;                     -- Reset, active low
      cp_i   :  IN std_logic;                     -- Syscp, @ 12MHz
      dv_i   :  IN std_logic;                     -- Have new RTC or GPS-Data
      br_i   :  IN std_logic;                     -- Baud-Rate to ena Counter
     dne_i   :  IN std_logic;                     -- Last Bit transmitted
     sto_o   : OUT std_logic;                     -- enable register load
     clr_o   : OUT std_logic;                     -- clear Bit-Counters
     nxt_o   : OUT std_logic                      -- next Bit, inc count
     );
END uat_fsm;

-- ----------------------------------------------------------------------------