#
BASE_DIR = ..
SRC_DIR = $(BASE_DIR)/src
VSRC_DIR = $(SRC_DIR)/vsrc

OUPUTLOGDIR = $(BASE_DIR)/build/output_log

VSRC = $(VSRC_DIR)/state_machine.v \
       $(VSRC_DIR)/state_tb.v

VCS = vcs -full64
VCS_OPTS = -cc gcc-4.8 -cpp g++-4.8 \
		-timescale=1ns/10ps \
		-LDFLAGS -Wl,--no-as-needed \
		-debug_pp +vcd+vcdpluson \

OUTPUT = state_tb.vsim

all: $(OUTPUT)

%.vsim: $(VSRC)
	$(VCS) $(VCS_OPTS) $^ -o $@

.PHONY: run

run:
	mkdir -p $(OUPUTLOGDIR)
	$(OUTPUT) > $(OUPUTLOGDIR)/run_`date +%y%m%d%02k%M`.log

.PHONY: clean
clean:
	rm -rf $(OUTPUT) $(OUTPUT).daidir csrc/ ucli.key $(OUPUTLOGDIR)