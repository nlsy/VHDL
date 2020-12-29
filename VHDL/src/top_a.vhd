-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF top IS

  -- Pin Connections ---------------------------------
  ATTRIBUTE chip_pin : string;
  ATTRIBUTE chip_pin of rst_n_i : SIGNAL IS "E6";  -- S2_USR_BTN_akt_low
  ATTRIBUTE chip_pin of clk_i   : SIGNAL IS "H6";  -- CLK_12MHz

  ATTRIBUTE chip_pin of s1_i    : SIGNAL IS "L12"; -- Digital in (1)
  ATTRIBUTE chip_pin of s2_i    : SIGNAL IS "J12"; -- Digital in (2)
  ATTRIBUTE chip_pin of s3_i    : SIGNAL IS "J13"; -- Digital in (3)

  ATTRIBUTE chip_pin of rst_n_o : SIGNAL IS "A8";  -- Digital out LED
  ATTRIBUTE chip_pin of sec_o   : SIGNAL IS "A9";  -- Digital out LED
  ATTRIBUTE chip_pin of grn_o   : SIGNAL IS "A11"; -- Digital out LED
  ATTRIBUTE chip_pin of red_o   : SIGNAL IS "A10"; -- Digital out LED
  ATTRIBUTE chip_pin of tled_o  : SIGNAL IS "B10"; -- Digital out LED
  
  ATTRIBUTE chip_pin of txd_o   : SIGNAL IS "K11"; -- Digital out (4)
  ATTRIBUTE chip_pin of sdi_o   : SIGNAL IS "K12"; -- Digital out (5)
  ATTRIBUTE chip_pin of sdv_o   : SIGNAL IS "J10"; -- Digital out (6)
  ATTRIBUTE chip_pin of stx_o   : SIGNAL IS "H10"; -- Digital out (7)

  -- Internal Signals --------------------------------
  SIGNAL br_s : std_logic; -- baud rate signal
  SIGNAL hz_s : std_logic; -- 1 hz signal

  SIGNAL add_s : std_logic;	-- trigger signal that someone entered
  SIGNAL sub_s : std_logic;	-- trigger signal that someone left
  SIGNAL inc_s : std_logic;	-- increment counter signal
  SIGNAL dec_s : std_logic;	-- decrement counter signal
  SIGNAL dv_s : std_logic;	-- submit serial (data valid)
  SIGNAL num_s : std_logic_vector(num_width_const-1 DOWNTO 0);
  -- head count number
  SIGNAL evt_s : std_logic_vector(evt_width_const-1 DOWNTO 0);
  -- occured event char

  SIGNAL min_s : std_logic; -- is headcount min
  SIGNAL max_s : std_logic; -- is headcount max
  SIGNAL txd_s : std_logic; -- serial transmission
  SIGNAL sdi_s : std_logic; -- S3 data value
  SIGNAL sdv_s : std_logic; -- S3 data valid
  SIGNAL stx_s : std_logic; -- S3 transmission active

  SIGNAL pls_s : std_logic; -- active pulse

  SIGNAL s1_s : std_logic;    -- debounced sensor 1 signal
  SIGNAL s2_s : std_logic;    -- debounced sensor 2 signal
  SIGNAL s3_s : std_logic;    -- debounced sensor 3 signal

BEGIN

  -- Modules -----------------------------------------
  -- Debouncing the input
  deb : debnc
    PORT    MAP (rst_n_i,clk_i, s1_i, s2_i, s3_i, s1_s, s2_s, s3_s);
  -- Rates generator
  rts : clkrt
    PORT    MAP (rst_n_i,clk_i, br_s, hz_s);
  -- HeadCount
  hdc : hdcnt
    GENERIC MAP (8, 3)
    PORT    MAP (rst_n_i,clk_i,inc_s,dec_s,min_s,max_s,num_s);
  -- EventHandler
  tri : trigr
    PORT    MAP (rst_n_i,clk_i, s1_s, s2_s, s3_s,add_s,sub_s);
  -- UniqueTime
  con : cntrl
    PORT    MAP (rst_n_i,clk_i,add_s,sub_s,min_s,max_s,inc_s,dec_s,evt_s,dv_s);
  -- UART
  uar : uatpc
    PORT 	  MAP (rst_n_i,clk_i, br_s, dv_s,num_s,txd_s);
  -- S3 Interface
  inf : infs3
    PORT    MAP (rst_n_i,clk_i, dv_s,evt_s,num_s,sdi_s,sdv_s,stx_s);
  -- Pulse LED toggle
  tgl : toggl
    PORT 	  MAP (rst_n_i,clk_i, hz_s,pls_s);

  -- Outputs -----------------------------------------
  rst_n_o <= rst_n_i;   -- reset indication
  grn_o   <= NOT max_s; -- green LED
  red_o   <= max_s;     -- red LED
  tled_o  <= txd_s;     -- data transmission indication
  txd_o   <= txd_s;     -- data transmission
  sdi_o   <= sdi_s;     -- ic3 interface
  sdv_o   <= sdv_s;     -- ic3 interface
  stx_o   <= stx_s;     -- ic3 interface
  sec_o   <= pls_s;     -- device alive

END ar1;

-- ----------------------------------------------------------------------------