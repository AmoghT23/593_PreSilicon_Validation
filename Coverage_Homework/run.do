vlog -sv -cover bcesft code_cov.sv code_cv_tb.sv
vsim -coverage code_cov_tb
run -all
coverage report -details
coverage report -nocvgbin
