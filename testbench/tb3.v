`timescale 1ns/1ps

module tb3;

    //=========================================================
    // Testbench 3
    //
    // Compared to TB1:
    // - TB1 verifies the basic functionality of all 16 ALU
    //   operations using one representative test case each.
    //
    // Compared to TB2:
    // - TB2 introduces additional corner-case testing such as
    //   divide-by-zero, parity, sign detection, equality, and
    //   multiple average test cases.
    //
    // TB3 Enhancements:
    // - Includes multiple multiplication test cases to verify
    //   the multiplier with different operand combinations.
    // - Repeats the addition operation at the end to ensure
    //   the ALU continues to operate correctly after executing
    //   all test vectors.
    //=========================================================

    //=========================
    // Testbench signals
    //=========================
    reg clk, rst;
    reg [3:0] sel;
    reg [7:0] in1, in2;

    // Outputs from ALU
    wire [7:0] Out1;
    wire [7:0] Out2;

    //=========================
    // Instantiate the ALU
    //=========================
    ALU t3 (
        .in1(in1),
        .in2(in2),
        .sel(sel),
        .clk(clk),
        .rst(rst),
        .out1(Out1),
        .out2(Out2)
    );

    //=========================
    // Clock generation
    //=========================
    initial begin

        // Create waveform file
        $dumpfile("tb3.vcd");

        // Dump all signals
        $dumpvars(0, tb3);

        // Initialize clock
        clk = 1'b0;

        // Generate 10 ns period clock
        forever
            #5 clk = ~clk;

    end

    //=========================
    // Apply test vectors
    //=========================
    initial begin

        // Reset sequence
        rst = 1'b0;
        #5  rst = 1'b1;
        #5  rst = 1'b0;
        #5  rst = 1'b1;
        #5  rst = 1'b0;

        //-------------------------
        // Test 1 : Addition
        //-------------------------
        #20;
        in1 = 8'b00100101;
        in2 = 8'b10110000;
        sel = 4'b0000;     // Addition
        #20;

        //-------------------------
        // Test 2 : Subtraction
        //-------------------------
        in1 = 8'b10101101;
        in2 = 8'b11111010;
        sel = 4'b0001;     // Subtraction
        #40;

        //-------------------------
        // Test 3 : Multiplication
        // Test case 1
        //-------------------------
        in1 = 8'b00000111;
        in2 = 8'b00000010;
        sel = 4'b0010;     // Multiplication
        #20;

        //-------------------------
        // Test 3 : Multiplication
        // Test case 2 : Maximum operands
        //-------------------------
        in1 = 8'b11111111;
        in2 = 8'b11111111;
        sel = 4'b0010;     // Multiplication
        #20;

        //-------------------------
        // Test 3 : Multiplication
        // Test case 3 : Multiply by zero
        //-------------------------
        in1 = 8'b11111111;
        in2 = 8'b00000000;
        sel = 4'b0010;     // Multiplication
        #20;

        //-------------------------
        // Test 3 : Multiplication
        // Test case 4 : Larger operands
        //-------------------------
        in1 = 8'b00111111;
        in2 = 8'b00011111;
        sel = 4'b0010;     // Multiplication
        #20;

        //-------------------------
        // Test 4 : Division
        //-------------------------
        in1 = 8'b00001100;
        in2 = 8'b00000100;
        sel = 4'b0011;     // Division
        #40;

        //-------------------------
        // Test 5 : Modulo Function
        // Test case 1 : Dividend = 0
        //-------------------------
        in1 = 8'b00000000;
        sel = 4'b0100;
        in2 = 8'b00000011;
        sel = 4'b0100;
        #20;

        //-------------------------
        // Test 5 : Modulo Function
        // Test case 2 : Divisor = 0
        //-------------------------
        in1 = 8'b00001010;
        in2 = 8'b00000000;
        sel = 4'b0100;
        #20;

        //-------------------------
        // Test 6 : Bitwise AND
        //-------------------------
        in1 = 8'b11001100;
        in2 = 8'b10101010;
        sel = 4'b0101;
        #20;

        //-------------------------
        // Test 7 : Bitwise NAND
        //-------------------------
        in1 = 8'b11001100;
        in2 = 8'b10101010;
        sel = 4'b0110;
        #20;

        //-------------------------
        // Test 8 : Bitwise OR
        //-------------------------
        in1 = 8'b11001100;
        in2 = 8'b10101010;
        sel = 4'b0111;
        #20;

        //-------------------------
        // Test 9 : Bitwise NOR
        //-------------------------
        in1 = 8'b11001100;
        in2 = 8'b10101010;
        sel = 4'b1000;
        #20;

        //-------------------------
        // Test 10 : Bitwise XOR
        //-------------------------
        in1 = 8'b11001100;
        in2 = 8'b10101010;
        sel = 4'b1001;
        #20;

        //-------------------------
        // Test 11 : Bitwise XNOR
        //-------------------------
        in1 = 8'b11001100;
        in2 = 8'b10101010;
        sel = 4'b1010;
        #20;

        //-------------------------
        // Test 12 : Vector Reversal
        //-------------------------
        in1 = 8'b11001010;
        in2 = 8'b10100101;
        sel = 4'b1011;
        #20;

        //-------------------------
        // Test 13 : Parity Checker
        // Test case 1 : Even number of 1s (Output = 0)
        //-------------------------
        in1 = 8'b11001010;
        sel = 4'b1100;
        #20;

        //-------------------------
        // Test 13 : Parity Checker
        // Test case 2 : Even number of 1s (Output = 0)
        //-------------------------
        in1 = 8'b10101010;
        sel = 4'b1100;
        #20;

        in1 = 8'b11111111;
        in2 = 8'b11111111;

        //-------------------------
        // Test 14 : Sign Detection
        // Test case 1 : Negative number (MSB = 1)
        //-------------------------
        in1 = 8'b10000000;
        sel = 4'b1101;
        #20;

        //-------------------------
        // Test 14 : Sign Detection
        // Test case 2 : Positive number (MSB = 0)
        //-------------------------
        in1 = 8'b01111111;
        sel = 4'b1101;
        #20;

        //-------------------------
        // Test 15 : Bitwise Equality
        // Test case 1 : Equal operands
        //-------------------------
        in1 = 8'b00000000;
        in2 = 8'b00000000;
        sel = 4'b1110;
        #20;

        //-------------------------
        // Test 15 : Bitwise Equality
        // Test case 2 : Unequal operands
        //-------------------------
        in1 = 8'b11111111;
        in2 = 8'b00000001;
        sel = 4'b1110;
        #20;

        //-------------------------
        // Test 16 : Average of Two Numbers
        // Test case 1
        //-------------------------
        in1 = 8'b00001000;
        in2 = 8'b00000010;
        sel = 4'b1111;
        #20;

        //-------------------------
        // Test 16 : Average of Two Numbers
        // Test case 2
        //-------------------------
        in1 = 8'b00000100;
        in2 = 8'b00001000;
        sel = 4'b1111;
        #20;

        //-------------------------
        // Test 16 : Average of Two Numbers
        // Test case 3 : Both numbers are equal
        //-------------------------
        in1 = 8'b00000101;
        in2 = 8'b00000101;
        sel = 4'b1111;
        #20;

        //-------------------------
        // Test 17 : Re-run Addition
        // Post Verification
        //-------------------------
        in1 = 8'b00100101;
        in2 = 8'b10110000;
        sel = 4'b0000;     // Addition

        // Wait before ending simulation
        #100;

        // Stop simulation
        $finish;

    end

endmodule
