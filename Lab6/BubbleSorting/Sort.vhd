library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Sort is 
	port(
			clk, launch, reset : in std_logic;
			DataIn : in std_logic_vector (7 downto 0);
			Address, DataOut : out std_logic_vector (7 downto 0);
			Complete, WR : out std_logic
	);
end Sort;

architecture RTL of Sort is 
	type state_type is (Waiting, SendAddrA_r, GetA, SendAddrB_r, GetB, Compare, SendAddrA_w, WriteA, SendAddrB_w, WriteB, CheckLoop, CheckFlag);
	signal state: state_type := Waiting;
	signal count : std_logic_vector (7 downto 0);
	signal delay : std_logic;
	signal dataA, dataB : std_logic_vector (7 downto 0);
	signal Flag, Swap, CountEnd : std_logic;

BEGIN
	process (clk, reset)
	begin
		if ( reset = '1' ) then
			state <= Waiting;
		elsif ( clk'event and clk = '1' ) then
			case state is
				when Waiting => if ( launch = '1' ) then state <= SendAddrA_r; end if;
				when SendAddrA_r => state <= GetA; delay <= '0';
				when GetA => if ( delay = '1' ) then state <= SendAddrB_r; else delay <= '1'; end if;
				when SendAddrB_r => state <= GetB; delay <= '0';
				when GetB => if ( delay = '1' ) then state <= Compare; else delay <= '1'; end if;
				when Compare => if ( Swap = '1' ) then state <= SendAddrB_w; else state <= CheckLoop; end if;
				when SendAddrB_w => state <= WriteB;
				when WriteB => state <= SendAddrA_w;
				when SendAddrA_w => state <= WriteA;
				when WriteA => state <= CheckLoop;
				when CheckLoop => if ( CountEnd = '1' ) then state <= CheckFlag; else state <= SendAddrA_r; end if;
				when CheckFlag => if ( Flag = '0' ) then state <= Waiting; else state <= SendAddrA_r; end if;
			end case;
		end if;
	end process;
	
	process (clk)
	begin
		if (clk'event and clk = '1') then
			case state is 
				when Waiting => count <= "00000000"; Flag <= '0';
				when SendAddrA_r => Address <= count;
				when GetA => if ( delay = '1' ) then dataA <= DataIn; count<=count+1; end if;
				when SendAddrB_r => Address <= count;
				when GetB => if ( delay = '1' ) then dataB <= DataIn; end if;
				when Compare => if ( Swap = '1') then count <= count-1; Flag <= '1'; end if;
				when SendAddrB_w => Address <= count; DataOut <= dataB;
				when WriteB => count <= count+1;
				when SendAddrA_w => Address <= count; DataOut <= dataA;
				when WriteA => null;
				when CheckLoop => null;
				when CheckFlag => if ( Flag = '1' ) then Flag <= '0'; count <= "00000000"; end if;
			end case;
		end if;
	end process;
	
	WR <= '1' when state = WriteB or state = WriteA else '0';
	Swap <= '1' when dataA > dataB else '0';
	CountEnd <= '1' when count = "11111111" else '0';
	Complete <= '1' when state = Waiting else '0';
end RTL;  
				
				
				
				
				
				
				