module BindsTo_0_InstructionMem(
  input         clock,
  input  [31:0] io_PC,
  output [31:0] io_Instr
);

initial begin
  $readmemh("res/test.txt", InstructionMem.memory);
end
                      endmodule

bind InstructionMem BindsTo_0_InstructionMem BindsTo_0_InstructionMem_Inst(.*);