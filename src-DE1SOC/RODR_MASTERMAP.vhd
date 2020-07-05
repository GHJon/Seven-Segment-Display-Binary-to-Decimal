LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

Entity RODR_MASTERMAP IS
	PORT(RODR_SIGBIT      : IN STD_LOGIC;								-- Signed or Unsigned Switch
			  RODR_IN       : IN STD_LOGIC_VECTOR (7 downto 0) ;	-- Input from Switches 
			  RODR_ONES     : OUT STD_LOGIC_VECTOR (6 downto 0);	-- Output to Rightmost 7 Seg Display
			  RODR_TENS     : OUT STD_LOGIC_VECTOR (6 downto 0);	-- Output to 2nd 7 Seg Display
			  RODR_HUNDREDS : OUT STD_LOGIC_VECTOR (6 downto 0);	-- Output to 3rd 7 Seg Display
			  RODR_SIGN		 : OUT STD_LOGIC_VECTOR (6 downto 0);	-- Output to 4th 7 Seg Display
			  RODR_LEDONOFF : OUT STD_LOGIC_VECTOR (8 downto 0));	-- LED ON/OFF determined by Switches

END RODR_MASTERMAP;

ARCHITECTURE CONNECTIONS of RODR_MASTERMAP IS			
	Component RODR_UnsignedSigned IS										--Signed Decoder & LED Control
		PORT(RODR_SIGBIT : IN STD_LOGIC;
			RODR_IN   : IN STD_LOGIC_VECTOR (7 downto 0) ;
			RODR_OUT  : OUT STD_LOGIC_VECTOR (7 downto 0);
			RODR_LEDS : OUT STD_LOGIC_VECTOR (8 downto 0));		
	END Component;

	Component RODR_BINARYBCD									-- Binary (from signed Decoder) to BCD Decoder
		PORT(RODR_IN: IN STD_LOGIC_VECTOR (7 downto 0) ;
		   RODR_OUT : OUT STD_LOGIC_VECTOR (11 downto 0));
	END Component ;

	Component RODR_BCDDecoder										-- BCD (from BCD Decoder) to 7 Seg Display
		PORT(RODR_IN: IN STD_LOGIC_VECTOR (3 downto 0) ;
	      RODR_OUT : OUT STD_LOGIC_VECTOR (6 downto 0));
	END Component ;
	
	Component RODR_PlusMinus										-- Displays + or - in Signed Mode
	PORT(RODR_SIGBIT : IN STD_LOGIC;
		  RODR_IN: IN STD_LOGIC_VECTOR (7 downto 0);
	     RODR_OUT : OUT STD_LOGIC_VECTOR (6 downto 0));
	END Component;
	
signal RODR_TCO : STD_LOGIC_VECTOR (7 downto 0);		--TCO = TWo's Complement Output
signal RODR_BCD : STD_LOGIC_VECTOR (11 downto 0);		-- Takes in Output from BCD
signal RODR_BCD_ONE : STD_LOGIC_VECTOR (3 downto 0);
signal RODR_BCD_TEN : STD_LOGIC_VECTOR (3 downto 0);
signal RODR_BCD_HUNDRED : STD_LOGIC_VECTOR (3 downto 0);

BEGIN
-- CONNECTIONS BETWEEN THE VHDL FILES AND DECODERS
	
	RODR_TWOSCOMPLEMENT   : RODR_UnsignedSigned  PORT MAP(RODR_SIGBIT, RODR_IN, RODR_TCO, RODR_LEDONOFF);
	RODR_BINARYTOBCD      : RODR_BINARYBCD 		PORT MAP(RODR_TCO, RODR_BCD);

	RODR_BCD_ONE <= STD_LOGIC_VECTOR (RODR_BCD(3 downto 0));			-- Parsing of RODR_BCD Output to three 7 Seg Displays
	RODR_BCD_TEN <= STD_LOGIC_VECTOR (RODR_BCD(7 downto 4));
	RODR_BCD_HUNDRED <= STD_LOGIC_VECTOR (RODR_BCD(11 downto 8));
	
	
	RODR_DecoderONES 		 : RODR_BCDDecoder 		PORT MAP(RODR_BCD_ONE, RODR_ONES);
	RODR_DecoderTENS		 : RODR_BCDDecoder 		PORT MAP(RODR_BCD_TEN, RODR_TENS);
	RODR_DecoderHUNDREDS  : RODR_BCDDecoder 		PORT MAP(RODR_BCD_HUNDRED, RODR_HUNDREDS);
	RODR_POSNEG				 : RODR_PlusMinus			PORT MAP (RODR_SIGBIT, RODR_IN, RODR_SIGN);

END CONNECTIONS;