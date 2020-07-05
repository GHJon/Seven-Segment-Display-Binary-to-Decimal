LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY RODR_BinaryToBCD IS
	PORT(RODR_IN      : IN STD_LOGIC_VECTOR (7 downto 0) ;
	     RODR_OUT     : OUT STD_LOGIC_VECTOR (9 downto 0) ;
END RODR_BinaryToBCD;

ARCHITECTURE Logic OF RODR_BinaryToBCD IS
BEGIN
	shift: process(RODR_IN)
	variable shiftedbits: STD_LOGIC_VECTOR (17 downto 0);
	BEGIN
		for i in 0 to 17 loop	--sets all displays to 0
			shiftedbits(i) := 0;
		end loop;
		shiftedbits(10 downto 3) := RODR_IN;
		
		for i in 0 to 4 loop
			if shiftedbits(11 down to 8) > 4 then shiftedbits(11 down to 8) := shiftedbits(11 down to 8) + 3;
			end if;
			
			if shiftedbits(15 down to 12) > 4 then shiftedbits(15 down to 12) := shiftedbits(15 down to 12) + 3;
			end if;
			shiftedbits(17 downto 1) := shiftedbits(16 downto 0);
		end loop;
		
		RODR_OUT <= shiftedbits(17 downto 8);
	END process shift;
END Logic;