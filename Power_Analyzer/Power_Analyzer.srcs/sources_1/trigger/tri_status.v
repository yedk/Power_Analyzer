module tri_status(
	clk,
	reset,
	ready,
	auto,
	trigged,
	single,
	scan,
		
	ready_dsp,
	auto_dsp,
	trigged_dsp	
	);
input	clk;
input	reset;
input	ready;
input	auto;
input	trigged;
input	single;
input	scan;

output	ready_dsp;
output	auto_dsp;
output	trigged_dsp;

(*KEEP="TRUE"*)reg		ready_dsp;
(*KEEP="TRUE"*)reg		auto_dsp;
(*KEEP="TRUE"*)reg		trigged_dsp;
reg		ready_a,ready_b;
reg		auto_a,auto_b;
reg		trigged_a,trigged_b;

always @ (posedge clk)
begin
	ready_a <= ready;
	ready_b <= ready_a;
	auto_a <= auto;
	auto_b <= auto_a;
	trigged_a <= trigged;
	trigged_b <= trigged_a;	
end

always @ (posedge clk)
begin
	if (!reset)
		ready_dsp <= 1'b0;
	else if (ready_a == 1'b1 && ready_b == 1'b0)
		ready_dsp <= 1'b1;
end

always @ (posedge clk)
begin
	if (!reset)
		auto_dsp <= 1'b0;
	else if (single | scan)
		auto_dsp <= 1'b0;
	else if (auto_a == 1'b1 && auto_b == 1'b0)
		auto_dsp <= 1'b1;
end

always @ (posedge clk)
begin
	if (!reset)
		trigged_dsp <= 1'b0;
	else if (trigged_a == 1'b1 && trigged_b == 1'b0)
		trigged_dsp <= 1'b1;
end

endmodule
