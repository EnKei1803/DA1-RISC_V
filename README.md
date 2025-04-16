# Single Cycle RISC_V
A R32I RISC_V Model


Top-level diagram:

![RISC-V diagram (self-draw)](https://github.com/user-attachments/assets/1c46f1ef-83d0-4dde-b162-200c80b9f5cb)




Diagram of ALU:

![ALU](https://github.com/user-attachments/assets/843fe05d-143c-45b6-910a-b81a2dd1e75a)




  -In ALU, the design uses the model of Kooge Stone ADDER, which is commonly used most of CPU nowadays.
  
![KSA_32bits](https://github.com/user-attachments/assets/c677dcf5-0598-477d-b879-dbd33156e9d1)




  -Comparator using for Branch Compare Unit also put outside of the ALU, which can increase amount of instruction that the system can handle if it's built in Pipeline model 
  
2-bit Comparator

![image](https://github.com/user-attachments/assets/57a44429-d9a0-4299-ad39-d32560ba773a)

4-bit Comparator

![image](https://github.com/user-attachments/assets/1997fee9-e7f5-4b18-aed6-64dbed0b9cc0)

10-bit Comparator

![image](https://github.com/user-attachments/assets/dcfff53b-b79a-4bd3-99b3-57df8c60b3b9)

32-bit Comparator

![image](https://github.com/user-attachments/assets/fa3f99ac-8181-44e6-8e25-058a1ea56fc3)

Branch Compare Unit

![Branch Comparator](https://github.com/user-attachments/assets/10548fad-4e6f-42ae-ad46-41122a48d585)




  -For the instruction lb, lh, lbu, lhu, sb, sh; the Data Memory Unit would be modified for able to to run these instruction. The finnally design of this:
  
![DataMemory](https://github.com/user-attachments/assets/b4d5966c-6018-43ab-9eec-b554afb4076c)




Instruction Set of RV32I:

![image](https://github.com/user-attachments/assets/da76d000-5565-44ef-a1ce-147f4818eae4)



Instruction for testing:

![image](https://github.com/user-attachments/assets/b8157543-bd6c-4870-9202-7b59beb37806)



Result Test:

![0s - 120ns](https://github.com/user-attachments/assets/d3eac833-d2e3-44db-a73b-29d98b741fdc)
![120ns - 240ns](https://github.com/user-attachments/assets/eca281e5-6e1c-47ab-ba8c-0a149723fb52)
![240ns - 360ns](https://github.com/user-attachments/assets/99759669-f6dc-4bc9-8945-ac67e525cce0)
![360ns - 480ns](https://github.com/user-attachments/assets/8e3da76b-e08c-4ccf-a428-11dce00fac6b)
