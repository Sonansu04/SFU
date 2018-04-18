`include "pre_processor.sv"
`include "Approximate.sv"
`include "post_processor.sv"

module SFU_top(precision,opcode,single_x,single_y,single_z,single_result);

input logic precision;
input logic [3:0] opcode;	
input logic [31:0] single_x;
input logic [31:0] single_y;
input logic [31:0] single_z;

output logic [31:0] single_result;

logic signed [2:-26] c0;
logic signed [1:-23] c1;
logic signed [0:-16] c2;
logic signed [1:-23] y;

logic signed [3:-46] result;

logic signed [2:-46] c0_temp;
logic signed [2:-46] c1y_temp;
logic signed [2:-46] c2y_temp;





logic [7:0] exponent;
logic signed [8:0] exponent_diff;



logic sign;
logic skip;








pre_processor p1(
.precision(precision),
.opcode(opcode),
.single_x(single_x),
.single_y(single_y),
.single_z(single_z),
.sign(sign),
.exponent(exponent),
.exponent_diff(exponent_diff),
.skip(skip),
.c0(c0),
.c1(c1),
.c2(c2),
.y(y)
);
 


Approximate a1(
.precision(precision),
.skip(skip),
.opcode(opcode),
.result(result),
.c0(c0),
.c1(c1),
.c2(c2),
.y(y),
.exponent_diff(exponent_diff)
);





post_processor p2(
.precision(precision),
.single_x(single_x),
.skip(skip),
.opcode(opcode),
.sign(sign),
.exponent(exponent),
.approximate_result(result),
.single_y(single_result)
);




endmodule




