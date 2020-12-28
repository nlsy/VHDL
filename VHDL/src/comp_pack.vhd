-- --------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- --------------------------------------------------------------------

PACKAGE comp_pack IS

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- Constants
-- --------------------------------------------------------------------

CONSTANT num_width_const : integer := 8;
CONSTANT evt_width_const : integer := 8;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- TOP
-- --------------------------------------------------------------------

COMPONENT top IS
PORT (
  rst_n_i   : IN  std_logic;
  clk_i     : IN  std_logic;
  s1_i      : IN  std_logic;
  s2_i      : IN  std_logic;
  s3_i      : IN  std_logic;
  cl_i      : IN  std_logic;
  rst_n_o   : OUT std_logic;
  sec_o     : OUT std_logic;
  grn_o     : OUT std_logic;
  red_o     : OUT std_logic;
  tled_o    : OUT std_logic;
  txd_o     : OUT std_logic;
  sdi_o     : OUT std_logic;
  sdv_o     : OUT std_logic;
  stx_o     : OUT std_logic
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT debnc IS  -- Debouncer
PORT (
  rst_n_i : IN std_logic;
  clk_i   : IN std_logic;
  unb_i   : IN std_logic;
  deb_o   : OUT std_logic
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT toggl IS  -- Signal Toggle
PORT (
  rst_n_i : IN std_logic;
  clk_i   : IN std_logic;
  sig_i   : IN std_logic;
  res_o   : OUT std_logic
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT clkrt IS
PORT (
  rst_n_i : IN std_logic;
  clk_i   : IN std_logic;
  br_o    : OUT std_logic;
  hz_o    : OUT std_logic
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT hdcnt IS
GENERIC (
  cnt_width : integer;
  max_cnt : integer
  );
PORT (
  rst_n_i  : IN  std_logic;
  clk_i   : IN  std_logic;
  inc_i   : IN  std_logic;
  dec_i   : IN  std_logic;
  min_o   : OUT std_logic;
  max_o   : OUT std_logic;
  num_o   : OUT std_logic_vector(cnt_width-1 DOWNTO 0)
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT cntrl IS  --controll
PORT (
  rst_n_i : IN  std_logic;
  clk_i   : IN  std_logic;
  enter_i : IN  std_logic;
  leave_i : IN  std_logic;
  min_i   : IN  std_logic;
  max_i   : IN  std_logic;
  inc_o   : OUT std_logic;
  dec_o   : OUT std_logic;
  evt_o   : OUT std_logic_vector(evt_width_const-1 DOWNTO 0);
  sub_o   : OUT std_logic
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT trigr IS  --enter/leave tigger
PORT (
  rst_n_i : IN  std_logic;
  clk_i   : IN  std_logic;
  s1_i    : IN  std_logic;
  s2_i    : IN  std_logic;
  s3_i    : IN  std_logic;
  enter_o : OUT std_logic;
  leave_o : OUT std_logic
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT uatpc IS  --
PORT (
  rst_n_i  : IN  std_logic;
  clk_i   : IN  std_logic;
  br_i    : IN  std_logic;  -- baud rate
  dv_i    : IN  std_logic;  -- data valid
  num_i   : IN std_logic_vector(num_width_const-1 DOWNTO 0); -- data (number)
  txd_o   : OUT std_logic -- serial output
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT infs3 IS  --interface to sem3
PORT (
  rst_n_i : IN  std_logic;
  clk_i   : IN  std_logic;
  sub_i   : IN  std_logic;
  evt_i   : IN  std_logic_vector(evt_width_const-1 DOWNTO 0);
  num_i   : IN  std_logic_vector(num_width_const-1 DOWNTO 0);
  sdi_o   : OUT std_logic;
  sdv_o   : OUT std_logic;
  stx_o   : OUT std_logic
  );
END COMPONENT;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- BAUD RATE GENERATOR
-- --------------------------------------------------------------------

COMPONENT clkgn IS  --clock generator
GENERIC (
  cnt_width : integer;
  div_cnt : integer
  );
PORT (
  rst_n_i : IN  std_logic;
  clk_i   : IN  std_logic;
  tk_o    : OUT std_logic
  );
END COMPONENT;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- UART
-- --------------------------------------------------------------------

COMPONENT utfsm IS
PORT (
  rst_n_i : IN  std_logic;                     -- Reset, active low
  clk_i   : IN  std_logic;                     -- Syscp, @ 12MHz
  dv_i    : IN  std_logic;                     -- Have new RTC or GPS-Data
  br_i    : IN  std_logic;                     -- Baud-Rate to ena Counter
  dne_i   : IN  std_logic;                     -- Last Bit transmitted
  sto_o   : OUT std_logic;                     -- enable register load
  clr_o   : OUT std_logic;                     -- clear Bit-Counters
  nxt_o   : OUT std_logic                      -- next Bit, inc count
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT regsr IS  --register
GENERIC (
  dta_width : integer
  );
PORT (
  rst_n_i : IN  std_logic;
  clk_i   : IN  std_logic;
  en_i    : IN  std_logic;
  d_i     : IN  std_logic_vector(dta_width-1 DOWNTO 0);
  q_o     : OUT std_logic_vector(dta_width-1 DOWNTO 0)
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT ctbin IS
GENERIC (
  cnt_width : integer;
  cnt_max : integer
  );
PORT (
  rst_n_i : IN  std_logic;                     -- Reset, active low
  clk_i   : IN  std_logic;                     -- Syscp, @ 12MHz
  en_i    : IN  std_logic;                     -- Enable Count
  cl_i    : IN  std_logic;                     -- Clear Counter
  co_o    : OUT std_logic;                     -- Carry Out
  q_o     : OUT std_logic_vector(cnt_width-1 DOWNTO 0)   -- Counter Value
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT mxtxd IS
PORT (
  s_i   : IN  std_logic_vector(  3 DOWNTO 0);  -- get bits
  d_i   : IN  std_logic_vector(  7 DOWNTO 0);  -- BYTE
  txd_o : OUT std_logic                      -- txd, Serial Output
  );
END COMPONENT;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- INTERFACE TO S3
-- --------------------------------------------------------------------

COMPONENT iffsm IS
PORT (
  rst_n_i : IN std_logic;                     -- Reset, active low
  clk_i   : IN std_logic;                     -- Syscp, @ 12MHz
  dv_i    : IN std_logic;                     -- Have new RTC or GPS-Data
  dne_i   : IN std_logic;                     -- Last Bit transmitted
  ldr_o   : OUT std_logic;                     -- enable register load
  act_o   : OUT std_logic;
  vld_o   : OUT std_logic;
  clr_o   : OUT std_logic;                     -- clear Bit-Counters
  nxt_o   : OUT std_logic                      -- next Bit, inc count
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT mxsnd IS
PORT (
  s_i   : IN  std_logic_vector( 4 DOWNTO 0);  -- get bits
  d_i   : IN  std_logic_vector(15 DOWNTO 0);  -- BYTE
  txd_o : OUT std_logic                      -- txd, Serial Output
  );
END COMPONENT;

-- --------------------------------------------------------------------

END comp_pack;

-- --------------------------------------------------------------------