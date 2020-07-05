LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY RODR_PlusMinus IS
	PORT(RODR_SIGBIT : IN STD_LOGIC;								-- Input from Signed/Unsigned Switch
		  RODR_IN: IN STD_LOGIC_VECTOR (7 downto 0);			-- Input from Bit Switches
	     RODR_OUT : OUT STD_LOGIC_VECTOR (6 downto 0));	-- Output for 7 Segment Display
END RODR_PlusMinus ;

ARCHITECTURE LogicFunction OF RODR_PlusMinus IS
BEGIN
	plus_or_minus : process(RODR_SIGBIT, RODR_IN)
	BEGIN
	
		if   ((RODR_SIGBIT = '0') AND (RODR_IN(7) = '0')) then 		-- Display Nothing (Unsigned)
			RODR_OUT <= "1111111";
		elsif((RODR_SIGBIT = '0') AND (RODR_IN(7) = '1')) then		-- Display Nothing (Unsigned)
			RODR_OUT <= "1111111";
		elsif((RODR_SIGBIT = '1') AND (RODR_IN(7) = '1')) then		-- Display Minus (Signed)
			RODR_OUT <= "1111110";
		elsif((RODR_SIGBIT = '1') AND (RODR_IN(7) = '0')) then		-- Display Plus (Signed)
			RODR_OUT <= "1001110";
		end if;
	end process plus_or_minus;

END LogicFunction ;