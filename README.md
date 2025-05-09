# Single Cycle RISC_V
A R32I Single Cycle RISC_V Model

<br><br><br>

Top-level diagram:

![RISC-V diagram (self-draw)](https://github.com/user-attachments/assets/1c46f1ef-83d0-4dde-b162-200c80b9f5cb)

<br><br><br>

Diagram of ALU:

![ALU](https://github.com/user-attachments/assets/843fe05d-143c-45b6-910a-b81a2dd1e75a)

<br><br><br>

  -In ALU, the design uses the model of Kooge Stone ADDER, which is commonly used most of CPU nowadays.
  
![KSA_32bits](https://github.com/user-attachments/assets/c677dcf5-0598-477d-b879-dbd33156e9d1)

<br><br><br>

  -Comparator using for Branch Compare Unit also put outside of the ALU, which can increase amount of instruction that the system can handle if it's built in Pipeline model 
  
2-bit Comparator

![2-Bits Comparator](https://github.com/user-attachments/assets/7c17ed2e-3682-40a7-ae36-fa6075a2d1b1)

4-bit Comparator

![4-Bits Comparator](https://github.com/user-attachments/assets/df7517f6-4fb2-4413-a553-0a5af74d41e6)

10-bit Comparator

![10-Bits Comparator](https://github.com/user-attachments/assets/872d7692-3909-4d0d-a3d1-35ed78c7c662)

32-bit Comparator

![32-Bits Comparator](https://github.com/user-attachments/assets/afcef684-4537-4b47-a614-9daa413f6972)

Branch Compare Unit

![Branch Comparator](https://github.com/user-attachments/assets/10548fad-4e6f-42ae-ad46-41122a48d585)

<br><br><br>

  -For the instruction lb, lh, lbu, lhu, sb, sh; the Data Memory Unit would be modified for able to to run these instruction. The finnally design of this:
  
![DataMemory](https://github.com/user-attachments/assets/b4d5966c-6018-43ab-9eec-b554afb4076c)

<br><br><br>

Instruction Set of RV32I:

![image](https://github.com/user-attachments/assets/da76d000-5565-44ef-a1ce-147f4818eae4)

<br><br><br>

Instruction for testing:

![image](https://github.com/user-attachments/assets/b8157543-bd6c-4870-9202-7b59beb37806)

<br><br><br>

Result Test:

![0s - 120ns](https://github.com/user-attachments/assets/d3eac833-d2e3-44db-a73b-29d98b741fdc)
![120ns - 240ns](https://github.com/user-attachments/assets/eca281e5-6e1c-47ab-ba8c-0a149723fb52)
![240ns - 360ns](https://github.com/user-attachments/assets/99759669-f6dc-4bc9-8945-ac67e525cce0)
![360ns - 480ns](https://github.com/user-attachments/assets/8e3da76b-e08c-4ccf-a428-11dce00fac6b)
