LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all;

	ENTITY RODR_BINARYBCD IS
	PORT(RODR_IN: IN STD_LOGIC_VECTOR (7 downto 0) ;			-- Input from Unsigned/Signed Decoder
	     RODR_OUT : OUT STD_LOGIC_VECTOR (11 downto 0));		-- Output as 12 bits (for three 7 Segment Display)
END RODR_BINARYBCD ;

ARCHITECTURE LogicFunction OF RODR_BINARYBCD IS
BEGIN
	 shift: process(RODR_IN)											
	 variable shiftedbits: STD_LOGIC_VECTOR (17 downto 0);	-- Needed to Make 255 
	 
	 BEGIN
		for BITNUM in 0 to 17 loop										-- Initializes all bits to 0
			shiftedbits(BITNUM) := '0';
		end loop;
		shiftedbits(10 downto 3) := RODR_IN;						-- Initial shift of 3 bits from RODR_IN
		
		for i in 0 to 4 loop												-- Need to shift 4 times to get numbers for the HUNDREDS place
		
			if shiftedbits(11 downto 8) > 4 then 					--  Checks if binary within the ONES place is > 4
				shiftedbits(11 downto 8) := shiftedbits(11 downto 8) + 3;
			end if;
			
			if shiftedbits(15 downto 12) > 4 then 					--  Checks if binary within the TENS place is > 4
				shiftedbits(15 downto 12) := shiftedbits(15 downto 12) + 3;
			end if;
			
		shiftedbits(17 downto 1) := shiftedbits(16 downto 0);	-- Shift all bits to the left by 1
		end loop;
		
		RODR_OUT(9 downto 0) <= shiftedbits(17 downto 8);
	   RODR_OUT(10) <= '0';													-- Set Bit 10 to 0
	   RODR_OUT(11) <= '0';													-- Set Bit 11 to 0
		
	END process shift;
END LogicFunction ;