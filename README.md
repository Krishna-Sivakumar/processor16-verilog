## 16 bit Processor

### For Instructors:

Hello Instructors!

1. You can load a program within `CPU16.srcs/sources1/InstructionMemory.v`.
2. To run the processor, please run the simulation `Complete.v`. We've labelled the wires so that you can monitor the output.
3. The resulting register and DMU values can be checked under Scope > (reg_file (or) dmu) > Objects > (file (for registers) (or) mem (for the dmu)).
4. We've provided some test programs too. Once you've loaded your program, please adjust the timestamp in the initial block within Complete.v so that the program runs to completion.
5. There are unfortunately no other test benches due to a lack of time to implement them.

### File Structure

The code is stored in CPU16.srcs:
```
CPU16.srcs/
├── sim_1
│   └── new
│       ├── ALU_Test.v
│       └── Complete.v
├── sources_1
│   └── new
│       ├── 16bit_adder.v
│       ├── ALU.v
│       ├── ALUControl.v
│       ├── ALURegisterMux.v
│       ├── Control.v
│       ├── DataMemory.v
│       ├── InstructionMemory.v
│       ├── PCUpdate.v
│       ├── ProgramCounter.v
│       ├── RegisterDmuMux.v
│       ├── adder_16bit_test.v
│       ├── and_16bit.v
│       ├── register_file.v
│       ├── sll.v
│       └── sub_16bit.v
└── utils_1
    └── imports
        └── synth_1
            └── sub_16bit_test.dcp
```

