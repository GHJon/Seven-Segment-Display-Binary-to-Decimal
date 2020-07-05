LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE IEEE.numeric_std.all;

	ENTITY RODR_UnsignedSigned IS
	PORT(RODR_SIGBIT : IN STD_LOGIC;									-- Switch for Unsigned/Signed
		  RODR_IN   : IN STD_LOGIC_VECTOR (7 downto 0) ;		-- Switch Inputs
	     RODR_OUT  : OUT STD_LOGIC_VECTOR (7 downto 0);		-- Signed or Unsigned Output
		  RODR_LEDS : OUT STD_LOGIC_VECTOR (8 downto 0));		-- LED On/Off
END RODR_UnsignedSigned ;

ARCHITECTURE LogicFunction OF RODR_UnsignedSigned IS

	signal IN_FLIP : STD_LOGIC_VECTOR (7 downto 0);							--Functionality to Flip all Bits from switch
	signal ADD_ONE : STD_LOGIC_VECTOR (7 downto 0) := "00000001";		-- Add one to Complete "Two's Complement"
	signal SIGNED_OUT : STD_LOGIC_VECTOR (7 downto 0);						-- Temporary signal to store end result	
	
	BEGIN
			IN_FLIP <= NOT RODR_IN;

	
	SIGNED_OR_UNSIGNED: process(RODR_IN, IN_FLIP, ADD_ONE, SIGNED_OUT, RODR_SIGBIT)	-- Create a process for sequential logic reading, not concurrent
	
	variable carry : STD_LOGIC;						-- Initialized to one to add 1 bit to Bit flipped RODR_IN
	BEGIN
		for LEDNUM in 0 to 7 loop						-- Assignment for switches based on 
			RODR_LEDS(LEDNUM) <= RODR_IN(LEDNUM);
		end loop;
		RODR_LEDS(8) <= RODR_SIGBIT;					-- Assigned RODR_SIGBIT to the 8th LED (from the right)
	
		case RODR_SIGBIT is								-- Checks if Unsigned/Signed Switch is On/Off
		
		when '0' => 										--CASE 1: UNSIGNED
			RODR_OUT <= RODR_IN;
		
		when '1' =>										--CASE 2: SIGNED
			if((RODR_IN(7) = '0')) then			-- 0 to 127
				RODR_OUT <= RODR_IN;
			else
				if (IN_FLIP(0) = '0') then 				--	Checks to see if IN_FLIP's first bit 0 or 1 and add accordingly
					SIGNED_OUT <= IN_FLIP XOR ADD_ONE;
					carry := '0';
				elsif (IN_FLIP(0) = '1') Then
					SIGNED_OUT <= IN_FLIP XOR ADD_ONE;
					carry := '1';
				end if; 	
				for i in 1 to 7 loop					--CHECK THROUGH REST OF IN_FLIP ARRAY checking each bit using the carry
					if (IN_FLIP(i) = '0') then 
						SIGNED_OUT(i) <= IN_FLIP(i) XOR carry;
						carry := '0';
					elsif ((carry = '1') AND (IN_FLIP(i) xor carry) = '0') Then
						SIGNED_OUT(i) <= IN_FLIP(i) XOR carry;
						carry := '1';
					end if ;
				end loop ;
			RODR_OUT <= SIGNED_OUT;				-- Put temporary array of bits into RODR_OUT
			end if;
			
		end case;
			
	END process Signed_OR_Unsigned ;

END LogicFunction ;