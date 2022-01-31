library IEEE;
use ieee.std_logic_1164.all;

ENTITY MUX16_1 is port(
	D: in std_logic_vector (0 to 15);
	SEL: in std_logic_vector (3 downto 0);
	F: out std_logic);
END MUX16_1;

ARCHITECTURE RTL OF MUX16_1 IS
COMPONENT MUX4_1
	port(
		D: in std_logic_vector (0 to 3);
		SEL: in std_logic_vector (1 downto 0);
		Y: out std_logic);
END COMPONENT;
	SIGNAL Y : STD_LOGIC_VECTOR(0 to 3);

BEGIN

u0: MUX4_1 port map(D=>D(0 to 3), SEL=>SEL(1 downto 0), Y=>Y(0));
u1: MUX4_1 port map(D=>D(4 to 7), SEL=>SEL(1 downto 0), Y=>Y(1));
u2: MUX4_1 port map(D=>D(8 to 11), SEL=>SEL(1 downto 0), Y=>Y(2));
u3: MUX4_1 port map(D=>D(12 to 15), SEL=>SEL(1 downto 0), Y=>Y(3));
u4: MUX4_1 port map(D=>Y, SEL=>SEL(3 downto 2), Y=>F);

END RTL;
