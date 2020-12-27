-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF rate IS

  -- Internal Signals --------------------------------
  SIGNAL co_s    : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL br_s    : unsigned(10 DOWNTO 0);

BEGIN
  
  -- Calculation -------------------------------------
  rtcE6 : c10xc  PORT MAP (rb_i,cp_i,co_s(6));             -- co_s(6) : 1200kHz
  rtcE5 : c10ec  PORT MAP (rb_i,cp_i,co_s(6),co_s(5));     -- co_s(5) :  120kHz
  rtcE4 : c10ec  PORT MAP (rb_i,cp_i,co_s(5),co_s(4));     -- co_s(4) :   12kHz
  rtcE3 : c10ec  PORT MAP (rb_i,cp_i,co_s(4),co_s(3));     -- co_s(3) : 1k2Baud
  rtcE2 : c10ec  PORT MAP (rb_i,cp_i,co_s(3),co_s(2));     -- co_s(2) :   120Hz
  rtcE1 : c10ec  PORT MAP (rb_i,cp_i,co_s(2),co_s(1));     -- co_s(1) :    12Hz
  rtcE0 : c12ec  PORT MAP (rb_i,cp_i,co_s(1),co_s(0));     -- co_s(0) :     1Hz

  --rtc : c125ec PORT MAP (rb_i,cp_i,,); --2^11 >=1250
  --rtc : c125ec PORT MAP (rb_i,cp_i,,); --2^24 >=12000000


  -- Counter Process ---------------------------------
  cntx : PROCESS (rb_i,cp_i)
  BEGIN
    IF (rb_i='0') THEN br_s <= "00000000000";
    ELSIF (cp_i='1' AND cp_i'EVENT) THEN
      CASE br_s IS
        WHEN "10011100001" => br_s <= "00000000000";
        --WHEN "00000000100" => br_s <= "00000000000";
        WHEN OTHERS =>   br_s <= br_s + 1;
      END CASE;
    END IF;
  END PROCESS cntx;

  -- Output ------------------------------------------
  br_o <= '1' WHEN br_s = "10011100001" ELSE '0';      -- 1.2KHz, needed for baud-rate
  hz_o <= '1' WHEN br_s = "10011100001" ELSE '0';      -- 1Hz, from rtcE0, 80ns high, ca. 1sec low

END ar1;

-- ----------------------------------------------------------------------------