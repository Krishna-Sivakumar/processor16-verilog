`timescale 1ns / 1ps

module TestPCUpdate;

    reg [15:0] pc;
    reg [15:0] instruction;
    reg branch_taken;
    wire [15:0] pc_next;

    ProgramCounterUpdate pcu (
        .pc(pc),
        .instruction(instruction),
        .branch_zero(branch_taken),
        .pc_next(pc_next)
    );
    
    wire [11:0] jump_immediate = instruction[11:0];
    wire [3:0] branch_immediate = instruction[3:0];

    initial begin
        $display("Jump Test Begin");
        
        // JMP
        instruction = 16'h6003; pc = 16'd20; branch_taken = 0; // JMP 1+3 Words
        #10;
        $display("JMP: pc=%4d, offset=%4d → pc_next=%4d     (Expected: 28)", pc, jump_immediate, pc_next);
        
        instruction = 16'h6ffe; pc = 16'd20; branch_taken = 0; // JMP 1-2 Words
        #10;
        $display("JMP: pc=%4d, offset=%4d → pc_next=%4d     (Expected: 18)", pc, jump_immediate, pc_next);
        
        instruction = 16'h0000; pc = 16'd20; branch_taken = 0; // Add; regular PC incrementation
        #10;
        $display("JMP: pc=%4d, pc_next=%4d                  (Expected: 22)", pc, pc_next);
        
        // BNE
        instruction = 16'h5004; pc = 16'd20; branch_taken = 0; // BNE but NEQ == 0; must advance to next instruction
        #10;
        $display("BNE: pc=%4d, offset=%4d → pc_next=%4d     (Expected: 22)", pc, branch_immediate, pc_next);
        
        instruction = 16'h5004; pc = 16'd20; branch_taken = 1; // BNE but NEQ == 1; Jump 1 + 4 words
        #10;
        $display("BNE: pc=%4d, offset=%4d → pc_next=%4d     (Expected: 30)", pc, branch_immediate, pc_next);
        
        instruction = 16'h500d; pc = 16'd20; branch_taken = 1; // BNE but NEQ == 1; Jump 1 - 3 words
        #10;
        $display("BNE: pc=%4d, offset=%4d → pc_next=%4d     (Expected: 16)", pc, branch_immediate, pc_next);
      
        // BEQ  
        instruction = 16'h4004; pc = 16'd20; branch_taken = 1; // BEQ but NEQ == 1; must advance to next instruction
        #10;
        $display("BEQ: pc=%4d, offset=%4d → pc_next=%4d     (Expected: 22)", pc, branch_immediate, pc_next);
        
        instruction = 16'h4004; pc = 16'd20; branch_taken = 0; // BEQ but NEQ == 0; Jump 1 + 4 words
        #10;
        $display("BEQ: pc=%4d, offset=%4d → pc_next=%4d     (Expected: 30)", pc, branch_immediate, pc_next);
        
        instruction = 16'h400d; pc = 16'd20; branch_taken = 0; // BEQ but NEQ == 0; Jump 1 - 3 words
        #10;
        $display("BEQ: pc=%4d, offset=%4d → pc_next=%4d     (Expected: 16)", pc, branch_immediate, pc_next);
        
        #10;
        $display("Jump Test Done");
        $stop;
    end
endmodule
