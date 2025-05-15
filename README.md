# A R32I Single Cycle RISC_V Model 

<br><br><br>

Top-level diagram:

![RISC-V diagram (self-draw)](https://github.com/user-attachments/assets/1c46f1ef-83d0-4dde-b162-200c80b9f5cb)

<br><br>

The project is successful build a RV32I with 34 integer instruction with all detail of it show as below: 

Instruction Set of RV32I:

![image](https://github.com/user-attachments/assets/da76d000-5565-44ef-a1ce-147f4818eae4)

<br><br>

To test the processor's functionality, we need to write instruction code that covers as many instructions as possible. The details are shown below:

Instruction for testing:

![image](https://github.com/user-attachments/assets/b8157543-bd6c-4870-9202-7b59beb37806)

<br>

Result Test:

![0s - 120ns](https://github.com/user-attachments/assets/d3eac833-d2e3-44db-a73b-29d98b741fdc)
![120ns - 240ns](https://github.com/user-attachments/assets/eca281e5-6e1c-47ab-ba8c-0a149723fb52)
![240ns - 360ns](https://github.com/user-attachments/assets/99759669-f6dc-4bc9-8945-ac67e525cce0)
![360ns - 480ns](https://github.com/user-attachments/assets/8e3da76b-e08c-4ccf-a428-11dce00fac6b)

<br><br><br><br>

## I/O for RISC-V 

After building a RISC-V processor, we need to establish methods for I/O communication with the PCU to ensure usability. This requires designing an I/O Addressing Map to facilitate effective interaction.

![Addressing IO Device](https://github.com/user-attachments/assets/3d175510-7d18-4fb1-86ca-8b521f737929)

<br>

Using the method described, we connect the I/O Block to Data Memory with a clear and detailed setup. Here's how we apply this connection to the CPU.

<br>

Data Memory connect to I/O Block:


![Memory_IO](https://github.com/user-attachments/assets/2a30570f-eb66-44ad-8435-04bf47f5ce17)

<br>

I/O Block placement in CPU:

![RISC-V diagram (self-draw)_with I_O](https://github.com/user-attachments/assets/1b59394e-8872-499d-ba03-bb76cf364ddd)

<br>

The instruction below is using for calculate FIBONNANCI, which i get value from SW input, the we will calculate result and decode it to display on 7SegLED.

![Fibonannci Test Result](https://github.com/user-attachments/assets/5b70253b-8be1-4654-b2f9-2821e97186ca)





