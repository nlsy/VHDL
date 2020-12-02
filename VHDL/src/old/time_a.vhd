-- ----------------------------------------------------------------------------
-- hc_a.vhd
-- ARCHITECTURE for the HC
-- 
-- Author: Nils Schlegel, 32067
--         Tara Jaishi, 32289
-- Last edited: 2020-11-13
-- ----------------------------------------------------------------------------
-- FPGA-chip: 10M16SAU169C8G (most likely)
-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF time IS

  SIGNAL tim_s : std_logic(254 DOWNTO 0);

BEGIN
  
  ru_n: PROCESS (cp_i, rb_i)
  BEGIN
    IF (rb_i = '0' OR clr_i = '1') THEN tim_s = '0';
    ELSIF (cp_i'EVENT AND cp_i = '1' AND sec_i = '1')
      CASE tim_s IS
        WHEN tim_s'HIGH => tim_s <= 0;
        WHEN OTHERS => tim_s <= tim_s + 1;
      END CASE;
    END IF;
  END PROCESS ru_n;

  tim_o <= tim_s;

END ar1;
