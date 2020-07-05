LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all;

	ENTITY RODR_BINARYBCD IS
	PORT(RODR_IN: IN STD_LOGIC_VECTOR (7 downto 0) ;
	     RODR_OUT : OUT STD_LOGIC_VECTOR (11 downto 0));
END RODR_BINARYBCD ;

ARCHITECTURE LogicFunction OF RODR_BINARYBCD IS
BEGIN
	 shift: process(RODR_IN)											--Called to create sequential logic, not concurrent
	 variable shiftedbits: STD_LOGIC_VECTOR (17 downto 0);
	 BEGIN
		for i in 0 to 17 loop	--Initializes all displays to 0
			shiftedbits(i) := '0';
		end loop;
		shiftedbits(10 downto 3) := RODR_IN;			--SHIFT 3 BITS from RODR_IN
		
		for i in 0 to 4 loop
			if shiftedbits(11 downto 8) > 4 then shiftedbits(11 downto 8) := shiftedbits(11 downto 8) + 3;
			end if;
			
			if shiftedbits(15 downto 12) > 4 then shiftedbits(15 downto 12) := shiftedbits(15 downto 12) + 3;
			end if;
			shiftedbits(17 downto 1) := shiftedbits(16 downto 0);
		end loop;
		
		RODR_OUT(9 downto 0) <= shiftedbits(17 downto 8);
	   RODR_OUT(10) <= '0';
	   RODR_OUT(11) <= '0';
		
	END process shift;
END LogicFunction ;