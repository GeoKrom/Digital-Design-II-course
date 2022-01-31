lpm_counter0_inst : lpm_counter0 PORT MAP (
		aclr	 => aclr_sig,
		clock	 => clock_sig,
		cnt_en	 => cnt_en_sig,
		q	 => q_sig
	);
