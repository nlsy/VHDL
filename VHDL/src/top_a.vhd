-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF top IS

  -- Pin Connections ---------------------------------
  ATTRIBUTE chip_pin : string;
  ATTRIBUTE chip_pin of rb_i : SIGNAL IS "E6"; -- S2_USR_BTN_akt_low
  ATTRIBUTE chip_pin of cp_i : SIGNAL IS "H6"; -- CLK_12MHz

  --ATTRIBUTE chip_pin of cl_i : SIGNAL IS "H8"; -- Digital in (0)
  ATTRIBUTE chip_pin of s1_i : SIGNAL IS "L12"; -- Digital in (1)
  ATTRIBUTE chip_pin of s2_i : SIGNAL IS "J12"; -- Digital in (2)
  ATTRIBUTE chip_pin of s3_i : SIGNAL IS "J13"; -- Digital in (3)

  ATTRIBUTE chip_pin of rb_o : SIGNAL IS "A8"; -- Digital out LED
  ATTRIBUTE chip_pin of sec_o : SIGNAL IS "A9"; -- Digital out LED
  ATTRIBUTE chip_pin of grn_o : SIGNAL IS "A11"; -- Digital out LED
  ATTRIBUTE chip_pin of red_o : SIGNAL IS "A10"; -- Digital out LED
  ATTRIBUTE chip_pin of tled_o : SIGNAL IS "B10"; -- Digital out LED
  
  ATTRIBUTE chip_pin of txd_o : SIGNAL IS "K11"; -- Digital out
  ATTRIBUTE chip_pin of sdi_o : SIGNAL IS "K12"; -- Digital out
  ATTRIBUTE chip_pin of sdv_o : SIGNAL IS "J10"; -- Digital out
  ATTRIBUTE chip_pin of stx_o : SIGNAL IS "H10"; -- Digital out

  -- Internal Signals --------------------------------
  SIGNAL br_s : std_logic;
  SIGNAL hz_s : std_logic;

  SIGNAL s1_s : std_logic;
  SIGNAL s2_s : std_logic;
  SIGNAL s3_s : std_logic;

  SIGNAL evt_s : std_logic_vector(7 DOWNTO 0);
  SIGNAL entr_s : std_logic;	-- trigger signal
  SIGNAL leav_s : std_logic;	-- trigger signal
  SIGNAL inc_s : std_logic;	-- increment counter
  SIGNAL dec_s : std_logic;	-- decrement counter
  SIGNAL dv_s : std_logic;	-- submit serial (data valid)
  SIGNAL num_s : std_logic_vector(7 DOWNTO 0);	-- head count number

  SIGNAL min_s : std_logic;
  SIGNAL max_s : std_logic;
  SIGNAL txd_s : std_logic;
  SIGNAL sdi_s : std_logic;
  SIGNAL sdv_s : std_logic;
  SIGNAL stx_s : std_logic;

  SIGNAL blnk_s : std_logic;

BEGIN

  -- Modules -----------------------------------------
  db1 : debnc PORT MAP (rb_i,cp_i,s1_i,s1_s);
  db2 : debnc PORT MAP (rb_i,cp_i,s2_i,s2_s);
  db3 : debnc PORT MAP (rb_i,cp_i,s3_i,s3_s);

  rat : rate PORT MAP (rb_i,cp_i,br_s,hz_s); -- Boad Rate
  cou1 : count PORT MAP (rb_i, cp_i, inc_s, dec_s, min_s, max_s, num_s); -- HeadCount
  tri : trigger PORT MAP (rb_i, cp_i, s1_s, s2_s, s3_s, entr_s, leav_s); -- EventHandler
  con : control PORT MAP (rb_i, cp_i, entr_s, leav_s, min_s, max_s, inc_s, dec_s, evt_s, dv_s); -- UniqueTime
  uar1 : uat PORT MAP (rb_i, cp_i, br_s, dv_s, num_s, txd_s); -- UART
  int1 : interface PORT MAP (rb_i, cp_i, dv_s, evt_s, num_s, sdi_s, sdv_s, stx_s); -- 3WireInterface
  tgl : toggl PORT MAP (rb_i, cp_i, hz_s, blnk_s);

  -- Outputs -----------------------------------------
  rb_o <= rb_i;       -- reset indication
  grn_o <= NOT max_s; -- green LED
  red_o <= max_s;     -- red LED
  tled_o <= txd_s;    -- data transmission indication
  txd_o <= txd_s;     -- data transmission
  sdi_o <= sdi_s;     -- ic3 interface
  sdv_o <= sdv_s;     -- ic3 interface
  stx_o <= stx_s;     -- ic3 interface
  --sec_o <= hz_s;      -- device alive
  
  sec_o <= blnk_s;      -- device alive

END ar1;

-- ----------------------------------------------------------------------------