// Testbench for n-bit Ripple Carry Adder
module ripple_carry_adder_tb;

    parameter N = 8; // Set the value of N (bit-width)
    reg [N-1:0] A, B;  // n-bit input A, B
    reg Cin;           // Carry input
    wire [N-1:0] Sum;  // n-bit sum output
    wire Cout;         // Carry output

    // Instantiate the ripple carry adder
    ripple_carry_adder #(N) uut (
        .A(A), .B(B), .Cin(Cin), 
        .Sum(Sum), .Cout(Cout)
    );

    initial begin
        // Monitor signal values
        $monitor("Time = %0d : A = %b, B = %b, Cin = %b, Sum = %b, Cout = %b", 
                  $time, A, B, Cin, Sum, Cout);

        // Test case 1: Simple addition
        A = 8'b00000001; B = 8'b00000010; Cin = 1'b0; #10; 

        // Test case 2: Alternating bits
        A = 8'b01010101; B = 8'b00110011; Cin = 1'b0; #10; 

        // Test case 3: Carry generated
        A = 8'b11110000; B = 8'b00001111; Cin = 1'b1; #10; 

        // Test case 4: Max values with carry
        A = 8'b11111111; B = 8'b11111111; Cin = 1'b1; #10; 

        // Additional test cases
        // Test case 5: Adding zero
        A = 8'b00000000; B = 8'b00000000; Cin = 1'b0; #10; // 0 + 0
        // Test case 6: Adding maximum to zero
        A = 8'b11111111; B = 8'b00000000; Cin = 1'b0; #10; // 255 + 0
        // Test case 7: Adding zero to maximum
        A = 8'b00000000; B = 8'b11111111; Cin = 1'b0; #10; // 0 + 255
        // Test case 8: One bit set
        A = 8'b00000001; B = 8'b00000001; Cin = 1'b0; #10; // 1 + 1
        // Test case 9: Mid-range values
        A = 8'b01000000; B = 8'b00111111; Cin = 1'b0; #10; // 64 + 63
        // Test case 10: Full addition with carry
        A = 8'b01111111; B = 8'b00000001; Cin = 1'b0; #10; // 127 + 1
        // Test case 11: Adding two random values
        A = 8'b11001100; B = 8'b00110011; Cin = 1'b1; #10; // 204 + 51 + 1
        // Test case 12: Maximum value
        A = 8'b11111111; B = 8'b11111111; Cin = 1'b0; #10; // 255 + 255
        // Test case 13: Carry out with max values
        A = 8'b01111111; B = 8'b10000000; Cin = 1'b0; #10; // 127 + 128

        $stop; // Stop the simulation
    end
endmodule
