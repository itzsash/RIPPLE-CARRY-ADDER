// Parameterized n-bit Ripple Carry Adder (RCA)
module ripple_carry_adder #(parameter N = 4) (
    input [N-1:0] A,   // n-bit input A
    input [N-1:0] B,   // n-bit input B
    input Cin,         // Carry input
    output [N-1:0] Sum, // n-bit Sum output
    output Cout        // Carry output
);
    wire [N-1:0] Carry; // Internal carry wires for intermediate carries

    // Generate Full Adders for each bit using a generate block
    genvar i; // Declare a variable for the loop index
    generate
        for (i = 0; i < N; i = i + 1) begin : full_adders
            if (i == 0) begin
                // For the first full adder, use Cin as carry-in
                full_adder FA (
                    .a(A[i]), .b(B[i]), .cin(Cin), 
                    .sum(Sum[i]), .cout(Carry[i]) // Output sum and carry
                );
            end
            else if (i == N-1) begin
                // For the last full adder, use the previous carry as carry-in
                full_adder FA (
                    .a(A[i]), .b(B[i]), .cin(Carry[i-1]), 
                    .sum(Sum[i]), .cout(Cout) // Output sum and carry-out
                );
            end
            else begin
                // For intermediate full adders, use the previous carry as carry-in
                full_adder FA (
                    .a(A[i]), .b(B[i]), .cin(Carry[i-1]), 
                    .sum(Sum[i]), .cout(Carry[i]) // Output sum and carry
                );
            end
        end
    endgenerate
endmodule

// Full Adder module
module full_adder (
    input a, b, cin,    // Inputs: a, b, and carry-in (cin)
    output sum, cout    // Outputs: sum and carry-out (cout)
);
    assign sum = a ^ b ^ cin;    // Calculate the sum (XOR of a, b, and cin)
    assign cout = (a & b) | (cin & (a ^ b)); // Calculate carry-out
endmodule