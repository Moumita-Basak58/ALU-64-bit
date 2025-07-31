// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps 

module projecttb;
    reg [63:0] a_tb;       // Testbench register for input A (64-bit)
    reg [63:0] b_tb;       // Testbench register for input B (64-bit)
    reg [4:0]  sel_tb;     // Testbench register for select signal (5-bit)

  wire [127:0] result_tb;     // Testbench wire to capture the ALU result (64-bit)


    parameter DELAY = 10; // Define a delay of 10 time units (10ns based on timescale)
    project UUT (
        .a(a_tb),               // Connect testbench's a_tb to ALU's A input
        .b(b_tb),               // Connect testbench's b_tb to ALU's B input
        .sel(sel_tb),           // Connect testbench's sel_tb to ALU's sel input
      .c(result_tb)     // Connect ALU's result output to testbench's result_tb
    );
    project project1(a_tb,b_tb,sel_tb,result_tb);

    `ifdef SDF_TEST
     initial
     begin
     $sdf_annotate("delay.sdf",projecttb.project1,,"sdf.log","MAXIMUM");
     end
     `endif
    
    initial begin
        // 1. Initialize all inputs to a known state at time 0
        a_tb = 64'b0;
        b_tb = 64'b0;
        sel_tb = 5'b0;
        #DELAY; // Wait for DELAY time units for initial setup

        //add
        $display("\n--- Test Case 1: Addition ---");
        a_tb = 64'd100;
        b_tb = 64'd50;
        sel_tb = 5'b00000; // Assuming 00000 is ADD
        #DELAY; // Wait for DELAY time units for ALU to compute
        $display("Time=%0t | A=%d | B=%d | Sel=%b (ADD) | Result=%d ",
                 $time, a_tb, b_tb, sel_tb, result_tb);

        //sub
        $display("\n--- Test Case 2: Subtraction ---");
        a_tb = 64'd200;
        b_tb = 64'd75;
        sel_tb = 5'b00001; // Assuming 00001 is SUB
        #DELAY;
        $display("Time=%0t | A=%d | B=%d | Sel=%b (SUB) | Result=%d ",
                 $time, a_tb, b_tb, sel_tb, result_tb);

        //mul
      $display("\n--- Test Case 3: Multiplication ---");
        a_tb = 64'hFFFF0000FFFF0000;
        b_tb = 64'h0000FFFF0000FFFF;
        sel_tb = 5'b00010; // Assuming 00010 is AND
        #DELAY;
        $display("Time=%0t | A=%h | B=%h | Sel=%b (AND) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);

        // div
      $display("\n--- Test Case 4:Division ---");
        a_tb = 64'h123456789ABCDEF0;
        b_tb = 64'h0FEDCBA987654321;
        sel_tb = 5'b00011; // Assuming 00011 is OR
        #DELAY;
        $display("Time=%0t | A=%h | B=%h | Sel=%b (OR) | Result=%h ",
                 $time, a_tb, b_tb, sel_tb, result_tb);

        // modulo
      $display("\n--- Test Case 5: Modulus---");
        a_tb = 64'd500;
        b_tb = 64'd500;
        sel_tb = 5'b00100; 
        #DELAY;
        $display("Time=%0t | A=%d | B=%d | Sel=%b (SUB) | Result=%d",
                 $time, a_tb, b_tb, sel_tb, result_tb);

        // Logical OR
        $display("\n--- Test Case 6: Carry Flag Test (Overflow) ---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b00101; 
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      // Logical AND
      $display("\n--- Test Case 7:Logical AND ---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b00110; // Assuming 00000 is ADD
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      // Invert a
      $display("\n--- Test Case 8: Invert a");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b00111; // Assuming 00000 is ADD
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      // invert b
      $display("\n--- Test Case 9: Invert b ---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b01000; // Assuming 00000 is ADD
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      // Logical OR
      $display("\n--- Test Case 10: Logical OR---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b00101; // Assuming 00000 is ADD
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      // xor
      $display("\n--- Test Case 11: XOR---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b01001; // Assuming 00000 is ADD
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      // xnor
      $display("\n--- Test Case 12:XNOR ---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b01010;
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      // nand
      $display("\n--- Test Case 13: NAND ---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b01011; // Assuming 00000 is ADD
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      // nor
      $display("\n--- Test Case 14: NOR ---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b01100; // Assuming 00000 is ADD
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      // rotate a left
      $display("\n--- Test Case 15:rotate left a by 1 ---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b01101; // Assuming 00000 is ADD
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      // rotate a right
      $display("\n--- Test Case 16: rotate right a by 1 ---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b01110; // Assuming 00000 is ADD
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      // rotate b left
      $display("\n--- Test Case 17: rotate b left ---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b01111; // Assuming 00000 is ADDte
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      //rotate b right
      $display("\n--- Test Case 18: rotate b right ---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b10000; // Assuming 00000 is ADDte
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      
      //logical left a 
      $display("\n--- Test Case 19: logical left a ---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b10001; // Assuming 00000 is ADDte
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      //logical right a 
      $display("\n--- Test Case 19: logical right a ---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b10010; // Assuming 00000 is ADDte
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      //logical left b 
      $display("\n--- Test Case 20: logical left b ---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b10011; // Assuming 00000 is ADDte
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      //logical right b 
      $display("\n--- Test Case 19: logical right b---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b10100; // Assuming 00000 is ADDte
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      //greater than 
      $display("\n--- Test Case 20: greater than---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b10101; // Assuming 00000 is ADDte
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
      //eual than
      $display("\n--- Test Case 21: equal than ---");
        a_tb = 64'hFFFFFFFFFFFFFFFF; // Max 64-bit unsigned value
        b_tb = 64'd1;
        sel_tb = 5'b10100; // Assuming 00000 is ADDte
        #DELAY;
        $display("Time=%0t | A=%h | B=%d | Sel=%b (ADD) | Result=%h",
                 $time, a_tb, b_tb, sel_tb, result_tb);
        #DELAY; // Final delay to ensure all events settle
        $display("\n--- Simulation Finished ---");
        $finish; // Terminates the simulation
    end

    
endmodule


