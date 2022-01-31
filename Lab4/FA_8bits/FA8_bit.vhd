library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity FA8_bit is
	port(A: in std_logic_vector (7 downto 0);
		 B: in std_logic_vector (7 downto 0);
		 cin: in std_logic;
		 Sum: out std_logic_vector (7 downto 0);
		 Cout: out std_logic);
end FA8_bit;

architecture RTL of FA8_bit is
	signal InternalSum: std_logic_vector (8 downto 0);
begin
	process(A,B,cin)
	begin
		InternalSum<=A+B+"00000000"&cin;
	end process;
	Sum <= InternalSum(7 downto 0);
	Cout <= InternalSum(8);
end RTL;