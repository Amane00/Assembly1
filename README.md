# Assembly1
Assembly language and computer organization

## Computing n! with RISC-V ISA

🧩 Project Overview
This assembly program (written in RISC-V) simulates basic input/output and control flow operations, similar to a simple C++ console application.
It interacts with the user by prompting for personal information and repeatedly calculating factorials (n!) until a negative number is entered.

⚙️ Program Purpose
The purpose of this program is to demonstrate basic system calls (ecall) in RISC-V assembly for:
- String and integer I/O
- Looping and branching
- Arithmetic operations (factorial calculation)

By using different system call numbers (1, 4, 5, 8, 10, etc.), this code shows how to:
- Display messages on the console
- Read user input (both strings and integers)
- Perform arithmetic using registers
- Implement loops and conditional branching
- Terminate the program cleanly

🧠 Program Flow
1. Prompt the user to enter their name and student ID, then print them back.
2. Ask the user to input a non-negative integer.
3. Compute and display the factorial (n!) of the input number.
4. Repeat step 2–3 until the user enters a negative number, then exit.

💻 Example Interaction
```
Please enter your name (in English): Name
My name is: Name
Please enter your student ID number: 123456
My student ID number is: 123456
Please enter a non-negative number (a negative for exit): 4
The result of 4! is 24
Please enter a non-negative number (a negative for exit): -1
```

🧩 Key Concepts Demonstrated
- ecall for system-level I/O
- Register operations (mv, mul, addi, etc.)
- Looping with labels and beq/bltz
- Conditional branching and program termination
