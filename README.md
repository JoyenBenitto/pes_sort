# pes_sort

Systolic Array Matrix Multiplier implementation for ASIC Course by [Kunal Ghosh](https://github.com/kunalg123/) of the [VSD Group](https://www.vlsisystemdesign.com/).

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

## RTL
![Rtl diag](image-1.png)

## Stats
![Alt text](image-2.png)

> all the relevant files for replicating this design are available in this repo and the synthesis was carried our using Yosys design suite and skywater130
