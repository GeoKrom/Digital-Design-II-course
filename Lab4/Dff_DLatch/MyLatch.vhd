library IEEE;
use IEEE.std_logic_1164.all;

entity MyLatch is 
	port( Rst,Set,LE,D:in std_logic;
		  Q,Qn: out std_logic);
end MyLatch;

architecture RTL of MyLatch is 
	signal FF: std_logic;
begin 
	seq0: process(Rst,Set,LE,D)
	begin
		if Rst='1' then FF<='0';
		elsif Set='1' then FF<='1';
		elsif LE='1' then FF<=D;
		end if;
	end process;
	Q<=FF;
	Qn<= not FF;
end RTL;