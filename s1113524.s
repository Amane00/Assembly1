###########################################################################
# Title: Computing n! with RISC-V ISA
# Name: Amane Nakano
# Student ID Number: s1113524
# (a). How many hours did you spend for this homework?
# ANS: 29 hours
# (b). Who has helped you solve the coding problems?
# ANS: None
# (c). Do you copy someone’s code?
# ANS: None
###########################################################################

.globl __start
.rodata #read only data, can't be changed during execution this code
# in c++ like
#string msg1="Please enter your name (in English): ";
#string msg2= ...
msg1: .string "Please enter your name (in English): "
msg2: .string "My name is: "
msg3: .string "Please enter your student ID number: "
msg4: .string "My student ID number is: "
msg5: .string "Please enter a non-negative number (a negative for exit): "
msg6: .string "The result of "
msg7: .string "!"
msg8: .string " is " #strings we need to output in this hw

.data #the values might be changed while the code is running(such as variables,arrays,global data)
# using for like cin >> name
#instruction to allocate 64 byte(max) memory
name: .space 64   
id: .space 64
#can store the data such as strings

.text #Instruction sequence to be executed(like 'int main()'in c++)
__start:
######## Name
li a0, 4 #li stands for Load immediate
#a0: Function arguments / Return values
#a0 used to pass arguments to system call
#the immediate value 4 into register a0
#4 means next operation is print a string
la a1, msg1 #la stand for load absolute address
#a1: Function arguments / Return values
#the address of the string msg1 into register a1
ecall #call a system call (4: write system call)
#Execute a write system call to out put the msg1
#ex) li a0, 4 
#The OS write system call corresponding to system call number 4 is called
li a0, 8 #similar code with line 37, but system call num is different
#8: system call for reading strings
la a1, name #Loads the address defined by the name label into the a1 register
li a2, 64 #let the  maximum size of string to read as 64 bytes
#a2:Function arguments
ecall#Execute a write system call to out put the msg1
#ex) li a0, 4 
#The OS write system call corresponding to system call number 4 is called
li a0, 4 #same code with line 37 so we need to call write system call again to print msg2
la a1, msg2 #the address of the string msg2 into register a1
ecall
li a0, 4 #write system call 
# works like cout in c++(?)
la a1, name       
ecall # print the string value in name which inputted

######## Student ID
# almost same code what i used in above(name) 
#print msg3
li a0, 4 
la a1, msg3 
ecall #
#get student id(inputted)
li a0, 8         
la a1, id     
li a2, 64         
ecall
# print msg4
li a0, 4
la a1, msg4
ecall
#print the string value in id(inputed)
li a0, 4
la a1, id      
ecall

######## get n
getN:
#print msg5
li a0, 4
la a1, msg5
ecall
#get a non negative num
li a0, 5 #5: system call for reading integers
# get n (use to calculate n!)
ecall
mv t3, a0 # Move the input to t3, ex)t3=a0=n
#refers to the example code that prof gave
j calculate #go to calculate

######## n! caluculate
#in c++ code
#while(n > 0)
# int sum = 1;
# if (2>n) sum = sum;
# else for(int i = n; i > 0; i--)
#  sum = sum * i;
# cout << sum;
calculate: #label name
bltz t3, exit #bltz: branch if the value of the register is negative
#t3==n, if n is a negative integer jump to exit
#differences with j exit is j doesn't check condition
# here i need the condition that n is negative
li t1, 1 # load 1 into register t1
# initialization that t1=sum=1
mv t2, t3# copy the value of register t3 to register t2

loop: #loop lavel
beq t2, x0, printresult #beq :Branch on Equal
#if t2 ==0, then jump to printresult
mul t1, t1, t2 # mul;Multiply
# t1 = ti*t2 (sum = sum*i)
addi t2, t2, -1 #Add Immediate 
#t2 = t2-i (i=i-1)
# i represents n, but i(t2) is subtracted 1 in each loop
#so that why copied t3 to t2 in line 114
j loop #continue to do this loop until i reach to 0(i > 0)
     
###### print result              
printresult: #cout << sum
# prints msg6
li a0, 4
la a1, msg6
ecall
# print the int value in t3
li a0, 1 #1: system call for print integers
mv a1, t3 # Move the n(inputted num) to a1, a1=t3
#Prepare arguments to pass to system call
ecall
#print msg7
li a0, 4
la a1, msg7
ecall
# prints msg8
li a0, 4
la a1, msg8
ecall
# prints the result in t1 sum
li a0, 1# print integer system call
mv a1, t1 #move the valur of t1(sum) into a1 to print
ecall 
#new line '\n'
li a0, 11
li a1, '\n'
ecall 
#while(n>0)
j getN # Jump to getN
#continue n!calculation until negative integer is entered

# ends the program with status code 0
exit: #come to here (exit lavel) when negative integer was enteerd
li a0, 10
ecall