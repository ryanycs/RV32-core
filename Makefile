INCDIR = +incdir+include +incdir+src/rtl +incdir+src/rtl/core
DEF    = +define+DEBUG +define+FSDB +define+Zicsr_EXT

test_core:
	vcs -R -full64 -sverilog tests/test_core.sv \
	$(INCDIR) $(DEF) \
	-debug_access+all \
	+notimingcheck

test_imm_gen:
	vcs -R -full64 -sverilog tests/test_imm_gen.sv \
	$(INCDIR) $(DEF) \
	-debug_access+all \
	+notimingcheck

nwave:
	nWave >& /dev/null &
