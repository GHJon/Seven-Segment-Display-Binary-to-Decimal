library ieee;
use ieee.std_logic_1164.all;
 
entity RODR_8Bit_Shift_RegisterD IS
 port(	RODR_Clock : IN std_logic;
				  RODR_D: IN std_logic_vector(7 downto 0);
				  RODR_Q: OUT std_logic_vector(7 downto 0)
 );
END RODR_8Bit_Shift_RegisterD;
 
architecture LogicFunction of RODR_8Bit_Shift_RegisterD IS
BEGIN
	process (RODR_Clock)
	BEGIN
		if (rising_edge(RODR_Clock) and RODR_Clock='1') then
			RODR_Q <= RODR_D;
		end if;
	end process;
end LogicFunction;
