`timescale 1ns/1ps

module ALU (in1, in2, clk, rst, sel, out1, out2);

    //========================
    // Input declarations
    //========================
    input [7:0] in1, in2;      // Two 8-bit input operands
    input [3:0] sel;           // 4-bit operation select
    input clk;                 // Clock input
    input rst;                 // Active-high reset

    //========================
    // Output declarations
    //========================
    output reg [7:0] out1;     // Lower 8-bit result
    output reg [7:0] out2;     // Upper 8-bit result (used for overflow/products)

    //========================
    // Operation encoding
    //========================
    parameter ADD       = 4'b0000,
              SUB       = 4'b0001,
              MUL       = 4'b0010,
              DIV       = 4'b0011,
              MOD       = 4'b0100,
              AND       = 4'b0101,
              NAND      = 4'b0110,
              OR        = 4'b0111,
              NOR       = 4'b1000,
              XOR       = 4'b1001,
              XNOR      = 4'b1010,
              VEC_REV   = 4'b1011,
              PAR       = 4'b1100,
              SIGN      = 4'b1101,
              BIT_EQUAL = 4'b1110,
              AVERAGE   = 4'b1111;

    //========================
    // Internal registers
    //========================
    reg [7:0] X, Y;        // Registered versions of input operands
    reg [3:0] sel_ff;      // Registered version of select signal

    //========================
    // Sequential logic
    //========================
    always @(posedge clk)
    begin
        // Store the inputs into flip-flops
        X <= in1;
        Y <= in2;
        sel_ff <= sel;

        // Reset outputs
        if (rst) begin
            out1 <= 8'b00000000;
            out2 <= 8'b00000000;
        end
        else
            case (sel_ff)

                // Addition (16-bit result)
                ADD:
                begin
                    {out2, out1} <= X + Y;
                end

                // Subtraction (16-bit result)
                SUB:
                begin
                    {out2, out1} <= X - Y;
                end

                // Multiplication (16-bit result)
                MUL:
                begin
                    {out2, out1} <= X * Y;
                end

                // Division (Quotient only)
                DIV:
                begin
                    out1 <= X / Y;
                    out2 <= 8'b00000000;
                end

                // Modulus operation
                MOD:
                begin
                    if (Y == 8'b00000000) begin
                        out1 <= 8'b00000000;
                        out2 <= 8'b00000000;
                    end
                    else begin
                        out1 <= X % Y;
                        out2 <= 8'b00000000;
                    end
                end

                // Bitwise AND
                AND:
                begin
                    out1 <= X & Y;
                    out2 <= 8'b00000000;
                end

                // Bitwise NAND
                NAND:
                begin
                    out1 <= ~(X & Y);
                    out2 <= 8'b00000000;
                end

                // Bitwise OR
                OR:
                begin
                    out1 <= X | Y;
                    out2 <= 8'b00000000;
                end

                // Bitwise NOR
                NOR:
                begin
                    out1 <= ~(X | Y);
                    out2 <= 8'b00000000;
                end

                // Bitwise XOR
                XOR:
                begin
                    out1 <= X ^ Y;
                    out2 <= 8'b00000000;
                end

                // Bitwise XNOR
                XNOR:
                begin
                    out1 <= ~(X ^ Y);
                    out2 <= 8'b00000000;
                end

                // Reverse all bits of X and Y
                VEC_REV:
                begin
                    out1 <= {X[0], X[1], X[2], X[3], X[4], X[5], X[6], X[7]};
                    out2 <= {Y[0], Y[1], Y[2], Y[3], Y[4], Y[5], Y[6], Y[7]};
                end

                // Parity (Reduction XOR)
                PAR:
                begin
                    out1 <= ^X;
                    out2 <= 8'b00000000;
                end

                // Sign Detection (Checks MSB)
                SIGN:
                begin
                    if (X[7] == 1'b1)
                        out1 <= 8'b00000001;   // Negative
                    else
                        out1 <= 8'b00000000;   // Positive

                    out2 <= 8'b00000000;
                end

                // Equality comparison
                BIT_EQUAL:
                begin
                    out1 <= (X == Y);
                    out2 <= 8'b00000000;
                end

                // Average of two numbers
                AVERAGE:
                begin
                    out1 <= (X + Y) >> 1;
                    out2 <= 8'b00000000;
                end

            endcase
    end

endmodule

/* One subtle point to be aware of is that because X, Y, and sel_ff are updated with non-blocking assignments (<=), 
the case (sel_ff) uses the previous clock cycle's values of sel_ff, X, and Y. In other words, this ALU has a one-clock-cycle latency: 
the inputs are captured on one rising edge, and the corresponding operation is performed using those captured values on the next 
rising edge. This is a common interview question, so it's worth remembering.  */
