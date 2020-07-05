LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all;

	ENTITY RODR_NOOUTPUT IS
	PORT(RODR_OUT : OUT STD_LOGIC_VECTOR (6 downto 0));
END RODR_NOOUTPUT ;

ARCHITECTURE LogicFunction OF RODR_NOOUTPUT IS
BEGIN
		RODR_OUT <= "1111111";
END LogicFunction ;