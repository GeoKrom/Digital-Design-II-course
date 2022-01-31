LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.all;

ENTITY Counter_256bit IS
	PORT
	(
		aclr		: IN STD_LOGIC ;
		aset		: IN STD_LOGIC ;
		clock		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (255 DOWNTO 0)
	);
END Counter_256bit;


ARCHITECTURE SYN OF Counter_256bit IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (255 DOWNTO 0);



	COMPONENT lpm_counter
	GENERIC (
		lpm_direction		: STRING;
		lpm_port_updown		: STRING;
		lpm_type		: STRING;
		lpm_width		: NATURAL
	);
	PORT (
			aclr	: IN STD_LOGIC ;
			clock	: IN STD_LOGIC ;
			q	: OUT STD_LOGIC_VECTOR (255 DOWNTO 0);
			aset	: IN STD_LOGIC 
	);
	END COMPONENT;

BEGIN
	q    <= sub_wire0(255 DOWNTO 0);

	lpm_counter_component : lpm_counter
	GENERIC MAP (
		lpm_direction => "UP",
		lpm_port_updown => "PORT_UNUSED",
		lpm_type => "LPM_COUNTER",
		lpm_width => 256
	)
	PORT MAP (
		aclr => aclr,
		clock => clock,
		aset => aset,
		q => sub_wire0
	);



END SYN;
