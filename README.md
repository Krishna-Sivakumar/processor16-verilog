## 16 bit Processor
---

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

todos:
```grep -i -e "TODO" CPU16.srcs```
```
CPU16.srcs/sources_1/new/register_file.v:// TODO balance output
CPU16.srcs/sources_1/new/register_file.v:// TODO initialize all memory locations to 0
CPU16.srcs/sources_1/new/ALU.v:// TODO balance output
CPU16.srcs/sources_1/new/DataMemory.v:// TODO initialize all memory locations to 0
CPU16.srcs/sources_1/new/DataMemory.v:    // TODO memory should be byte addressable. Fix this.
```
