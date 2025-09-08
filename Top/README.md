# Mini_CPU
- **mini_cpu :** The main module that connects the **fetch**, **decode**, and **execute** units
- **fetch :** Responsible for fetching instructions from **cpu_memory** based on the Program Counter(PC)
- **decode :** Responsible for parsing the fetched instruction into int constituent parts (IDEN, OPCODE, ADDRESS)
- **execute :** The core operational unit that performs the arithmetic and logical operations as dictated bt the decoded instruction
 
 # cpu_memory
 - This module for a simple 256x16-bit memory.
