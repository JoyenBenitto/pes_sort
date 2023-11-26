# pes_sort

Bubble sort for ASIC Course by [Kunal Ghosh](https://github.com/kunalg123/) of the [VSD Group](https://www.vlsisystemdesign.com/).

This projest is a bubble sort accelerator which can be tightly coupled in the SoC for enhancing performance in big data and DBMS related workload.

### Understanding hardware accelerators
Hardware accelerators are purpose-built designs that accompany a processor for accelerating a specific function or workload (also sometimes called “co-processors”). Since processors are designed to handle a wide range of workloads, processor architectures are rarely the most optimal for specific functions or workloads.
having a custom hardware as the sorter we have built in this repo can significanly bring down the cycle count as sorting involves a lot of branch instruction which involves lot of load store (45% of the algo was load store) analyzed using <u>_codasip instruction profiler_</u>.

![image](https://github.com/JoyenBenitto/pes_sort/assets/75515758/6211063d-bcac-4856-bd6f-5ac32e0cb6b8)


## Synthesis on Yosys for Gate level simulation (GLS)
```bash
read_liberty -lib ../sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog mkPes_Sort.v
read_verilog mkBubblesort.v
synth -top mkPes_Sort
abc -liberty ../sky130_fd_sc_hd__tt_025C_1v80.lib
show
write_verilog -noattr sort.v
iverilog ../verilog_model/primitives.v ../verilog_model/sky130_fd_sc_hd.v sort.v syst mkTestbench.v
./a.out
gtkwave dump.vcd
```
## Waveforms
![Waveform](image.png)
![image](https://github.com/JoyenBenitto/pes_sort/assets/75515758/d8c3d1c8-c8ea-41e4-a3bf-16501652f895)

> Open Testbech.v to get more info on the vectors used in the test

## RTL
![Rtl diag](image-1.png)

## Stats
![image](https://github.com/JoyenBenitto/pes_sort/assets/75515758/a6c35be0-04dd-4254-b79f-5299f644babf)

![Alt text](image-2.png)

> all the relevant files for replicating this design are available in this repo and the synthesis was carried our using Yosys design suite and skywater130

## Floorplan
![image](https://github.com/JoyenBenitto/pes_sort/assets/75515758/c6cd4cb0-083d-4b1c-8bcb-1759a4d37a89)

#TDI
![image](https://github.com/JoyenBenitto/pes_sort/assets/75515758/fff39046-94d7-437d-906f-5da1adb12a6d)

#io
![image](https://github.com/JoyenBenitto/pes_sort/assets/75515758/e2822364-f077-44c3-966e-8f0fdbafa542)

#idn
![image](https://github.com/JoyenBenitto/pes_sort/assets/75515758/d5d3ce46-9b56-44dc-9d74-efca35895147)

#gpl
![image](https://github.com/JoyenBenitto/pes_sort/assets/75515758/d047939e-0f43-4f9e-aa47-a8a2461ddf2a)

#dpl
![image](https://github.com/JoyenBenitto/pes_sort/assets/75515758/9e13831d-e786-4eb4-ae2e-a85261513d18)

#cts
![image](https://github.com/JoyenBenitto/pes_sort/assets/75515758/9844dca4-fa08-4947-b799-984fd624fb7d)

#crt
![image](https://github.com/JoyenBenitto/pes_sort/assets/75515758/9f4c268e-9bca-4669-b014-3fad361a3971)

The above are some of the intermediate files generated

## Detailed Routing

