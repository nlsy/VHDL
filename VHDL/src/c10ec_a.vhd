-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF c10ec IS

  -- Internal Signals --------------------------------
  SIGNAL state_s : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN

  -- Counter Process ---------------------------------
  cntx : PROCESS (rb_i,cp_i)
  BEGIN
    IF (rb_i='0') THEN state_s <= "0000";
    ELSIF (cp_i='1' AND cp_i'EVENT) THEN
      CASE state_s IS
        WHEN "0000" => IF (en_i='1') THEN state_s<= "0001"; END IF;
        WHEN "0001" => IF (en_i='1') THEN state_s<= "0010"; END IF;
        WHEN "0010" => IF (en_i='1') THEN state_s<= "0011"; END IF;
        WHEN "0011" => IF (en_i='1') THEN state_s<= "0100"; END IF;
        WHEN "0100" => IF (en_i='1') THEN state_s<= "0101"; END IF;
        WHEN "0101" => IF (en_i='1') THEN state_s<= "0110"; END IF;
        WHEN "0110" => IF (en_i='1') THEN state_s<= "0111"; END IF;
        WHEN "0111" => IF (en_i='1') THEN state_s<= "1000"; END IF;
        WHEN "1000" => IF (en_i='1') THEN state_s<= "1001"; END IF;
        WHEN "1001" => IF (en_i='1') THEN state_s<= "0000"; END IF;
        WHEN OTHERS =>                    state_s<= "0000";
      END CASE;
    END IF;
  END PROCESS cntx;
  
  -- Counter Process ---------------------------------
  co_o <= en_i AND state_s(3) AND (NOT state_s(2)) AND (NOT state_s(1)) AND state_s(0); -- Cary Bit
  --co_o <= state_s(3) AND (NOT state_s(2)) AND (NOT state_s(1)) AND state_s(0); -- Cary Bit
  
END ar1;

-- ----------------------------------------------------------------------------