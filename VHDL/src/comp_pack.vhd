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

CONSTANT num_width_const : integer :=  8;
CONSTANT evt_width_const : integer :=  8;
CONSTANT debounce_const  : integer := 19;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- TopLevel Modules
-- --------------------------------------------------------------------

COMPONENT top IS  -- TopLevel
PORT (
  rst_n_i : IN  std_logic;                      -- Reset, active low
  clk_i   : IN  std_logic;                      -- Syscp, @ 12MHz
  s1_i    : IN  std_logic;                      -- Sensor 1
  s2_i    : IN  std_logic;                      -- Sensor 2
  s3_i    : IN  std_logic;                      -- Sensor 3
  rst_n_o : OUT std_logic;                      -- Reset state LED
  sec_o   : OUT std_logic;                      -- Pulse LED
  grn_o   : OUT std_logic;                      -- Green LED
  red_o   : OUT std_logic;                      -- Red LED
  tled_o  : OUT std_logic;                      -- Transmission LED
  txd_o   : OUT std_logic;                      -- Transmission
  sdi_o   : OUT std_logic;                      -- S3 data value
  sdv_o   : OUT std_logic;                      -- S3 data valid
  stx_o   : OUT std_logic                       -- S3 transmission active
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT toggl IS  -- Signal Toggle
PORT (
  rst_n_i : IN  std_logic;                      -- Reset, active low
  clk_i   : IN  std_logic;                      -- Syscp, @ 12MHz
  sig_i   : IN  std_logic;                      -- Pulseing signal
  res_o   : OUT std_logic                       -- Toggeled output
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT clkrt IS  -- Generates Clock Rates
PORT (
  rst_n_i : IN  std_logic;                      -- Reset, active low
  clk_i   : IN  std_logic;                      -- Syscp, @ 12MHz
  br_o    : OUT std_logic;                      -- Baud Rate @9600Hz
  hz_o    : OUT std_logic                       -- Alive Pulse @1Hz
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT trigr IS  -- Sensor Handling
PORT (
  rst_n_i : IN  std_logic;                      -- Reset, active low
  clk_i   : IN  std_logic;                      -- Syscp, @ 12MHz
  s1_i    : IN  std_logic;                      -- Sensor 1
  s2_i    : IN  std_logic;                      -- Sensor 2
  s3_i    : IN  std_logic;                      -- Sensor 3
  add_o   : OUT std_logic;                      -- Person entered
  sub_o   : OUT std_logic                       -- Person left
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT hdcnt IS  -- HeadCounter
GENERIC (
  cnt_width : integer;
  max_cnt : integer
  );
PORT (
  rst_n_i : IN  std_logic;                      -- Reset, active low
  clk_i   : IN  std_logic;                      -- Syscp, @ 12MHz
  inc_i   : IN  std_logic;                      -- Increment Counter Signal
  dec_i   : IN  std_logic;                      -- Decrement Counter Signal
  min_o   : OUT std_logic;                      -- Min persons in room
  max_o   : OUT std_logic;                      -- Max persons in room
  num_o   : OUT std_logic_vector(cnt_width-1 DOWNTO 0)
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT cntrl IS  -- ControllFSM
PORT (
  rst_n_i : IN  std_logic;                      -- Reset, active low
  clk_i   : IN  std_logic;                      -- Syscp, @ 12MHz
  add_i   : IN  std_logic;                      -- Person entered
  sub_i   : IN  std_logic;                      -- Person left
  min_i   : IN  std_logic;                      -- Min persons in room
  max_i   : IN  std_logic;                      -- Max persons in room
  inc_o   : OUT std_logic;                      -- Increment Counter Signal
  dec_o   : OUT std_logic;                      -- Decrement Counter Signal
  evt_o   : OUT std_logic_vector(evt_width_const-1 DOWNTO 0); -- Happened event char
  sub_o   : OUT std_logic                       -- Submitt/Send Data
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT uatpc IS  -- UART to PC
PORT (
  rst_n_i : IN  std_logic;                      -- Reset, active low
  clk_i   : IN  std_logic;                      -- Syscp, @ 12MHz
  br_i    : IN  std_logic;                      -- Baud rate
  sub_i   : IN  std_logic;                      -- Submitt/Send Data
  num_i   : IN std_logic_vector(num_width_const-1 DOWNTO 0); -- Head count number
  txd_o   : OUT std_logic                       -- Serial output
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT infs3 IS  -- Interface to S3
PORT (
  rst_n_i : IN  std_logic;                      -- Reset, active low
  clk_i   : IN  std_logic;                      -- Syscp, @ 12MHz
  sub_i   : IN  std_logic;                      -- Submitt/Send Data
  evt_i   : IN  std_logic_vector(evt_width_const-1 DOWNTO 0); -- Occured event char
  num_i   : IN  std_logic_vector(num_width_const-1 DOWNTO 0); -- Head count number
  sdi_o   : OUT std_logic;                      -- S3 data value
  sdv_o   : OUT std_logic;                      -- S3 data valid
  stx_o   : OUT std_logic                       -- S3 transmission active
  );
END COMPONENT;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- LowerLevel Modules
-- --------------------------------------------------------------------

COMPONENT debnc IS  -- Debouncer
GENERIC (
  debounce_width : integer
  );
PORT (
  rst_n_i : IN  std_logic;                      -- Reset, active low
  clk_i   : IN  std_logic;                      -- Syscp, @ 12MHz
  unb_i   : IN  std_logic;                      -- Unbounced Input
  deb_o   : OUT std_logic                       -- Debounced Output
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT clkgn IS  -- Clock Generator
GENERIC (
  cnt_width : integer;
  div_cnt : integer
  );
PORT (
  rst_n_i : IN  std_logic;                      -- Reset, active low
  clk_i   : IN  std_logic;                      -- Syscp, @ 12MHz
  res_o   : OUT std_logic                       -- Resulting Ticks
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT utfsm IS  -- FiniteStateMachine for UART
PORT (
  rst_n_i : IN  std_logic;                      -- Reset, active low
  clk_i   : IN  std_logic;                      -- Syscp, @ 12MHz
  dv_i    : IN  std_logic;                      -- Have new RTC or GPS-Data
  br_i    : IN  std_logic;                      -- Baud-Rate to ena Counter
  dne_i   : IN  std_logic;                      -- Last Bit transmitted
  sto_o   : OUT std_logic;                      -- enable register load
  clr_o   : OUT std_logic;                      -- clear Bit-Counters
  nxt_o   : OUT std_logic                       -- next Bit, inc count
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT regsr IS  -- Register to store bits
GENERIC (
  dta_width : integer
  );
PORT (
  rst_n_i : IN  std_logic;                      -- Reset, active low
  clk_i   : IN  std_logic;                      -- Syscp, @ 12MHz
  en_i    : IN  std_logic;                      -- Store Data
  d_i     : IN  std_logic_vector(dta_width-1 DOWNTO 0); -- Input Data
  q_o     : OUT std_logic_vector(dta_width-1 DOWNTO 0)  -- Stored Data
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT ctbin IS  -- Binary Counter
GENERIC (
  cnt_width : integer;
  cnt_max : integer
  );
PORT (
  rst_n_i : IN  std_logic;                      -- Reset, active low
  clk_i   : IN  std_logic;                      -- Syscp, @ 12MHz
  en_i    : IN  std_logic;                      -- Enable Count
  cl_i    : IN  std_logic;                      -- Clear Counter
  co_o    : OUT std_logic;                      -- Carry Out
  q_o     : OUT std_logic_vector(cnt_width-1 DOWNTO 0)  -- Counter Value
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT mxtxd IS  -- Multiplexer for TXD
PORT (
  s_i   : IN  std_logic_vector(3 DOWNTO 0);     -- Bit position
  d_i   : IN  std_logic_vector(7 DOWNTO 0);     -- Bit vector
  txd_o : OUT std_logic                         -- Txd, Serial Output
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT iffsm IS  -- FiniteStateMachine for Interface to S3
PORT (
  rst_n_i : IN  std_logic;                      -- Reset, active low
  clk_i   : IN  std_logic;                      -- Syscp, @ 12MHz
  dv_i    : IN  std_logic;                      -- Have new RTC or GPS-Data
  dne_i   : IN  std_logic;                      -- Last Bit transmitted
  ldr_o   : OUT std_logic;                      -- Enable register load
  act_o   : OUT std_logic;                      -- Transmission active
  vld_o   : OUT std_logic;                      -- Data Bit valid
  clr_o   : OUT std_logic;                      -- Clear Bit-Counters
  nxt_o   : OUT std_logic                       -- Next Bit, inc count
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT mxsnd IS  -- Multiplexer for Interface to S3
PORT (
  s_i   : IN  std_logic_vector( 4 DOWNTO 0);    -- Bit position
  d_i   : IN  std_logic_vector(15 DOWNTO 0);    -- Bit vector
  txd_o : OUT std_logic                         -- txd, Serial Output
  );
END COMPONENT;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

END comp_pack;

-- --------------------------------------------------------------------