# A R32I PIPELINE Single Cycle RISC_V Model 

<br><br><br>

Top-level diagram:

![RISC-V diagram (self-draw)](https://github.com/user-attachments/assets/1c46f1ef-83d0-4dde-b162-200c80b9f5cb)

<br><br>

The project is successful build a RV32I with 37 integer instruction with all detail of it show as below: 

Instruction Set of RV32I:

![image](https://github.com/user-attachments/assets/da76d000-5565-44ef-a1ce-147f4818eae4)

<br><br>

To test the processor's functionality, we need to write instruction code that covers as many instructions as possible. The details are shown below:

Instruction for testing:

![image](https://github.com/user-attachments/assets/b8157543-bd6c-4870-9202-7b59beb37806)

<br>

Result Test:

<img width="1920" height="1080" alt="Pipeline 0ns - 240ns" src="https://github.com/user-attachments/assets/0ddb239b-d0fe-4b44-998c-611f728d0b79" />
<img width="1920" height="1080" alt="Pipeline 240ns - 480ns" src="https://github.com/user-attachments/assets/6d85634d-ea06-456e-8f52-cc4ce0b671d8" />
<img width="1920" height="1080" alt="Pipeline 480ns - 720ns" src="https://github.com/user-attachments/assets/84adf2d2-6d98-4745-b3b9-65bc24cc99dd" />
<img width="1920" height="1080" alt="Pipeline 720ns - 960ns" src="https://github.com/user-attachments/assets/73e8664d-6456-45d6-853b-1e8c7b3e6415" />

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

![RISC-V diagram (self-draw)](https://github.com/user-attachments/assets/c8b40177-279e-4c05-b71b-ff8d6822870c)

<br>

The instruction below is using for calculate FIBONNANCI, which i get value from SW input, the we will calculate result and decode it to display on 7SegLED.

![Fibonannci Test Result](https://github.com/user-attachments/assets/5b70253b-8be1-4654-b2f9-2821e97186ca)

<br>

Video using DE10-Standard for testing the real application by calculating Fibonannci: 



https://github.com/user-attachments/assets/3db09aaf-2cc8-4f75-a8eb-dbdb35399a21





