# Fixed Priority Scheduling and Controller Co-Design for TSN

This repository contains the MATLAB code for the research 'Fixed-Priority Scheduling and Controller Co-Design for Time-Sensitive Networks' for ICCAD'2020.



## Requirements

- MATLAB 2019
- Jave JRE > 1.8



## Project Organization

- /data: folder to store experiment results.
- /rta: code for schedulability analysis (in Java).
- /taskset: generator for tasksets.
- /plants: generator for controlled plants.
- main_exp_*: the main file for experiments.
- pso and psoobj: functions related to pso.
- dcdesign: linear system performance analysis.
- ltisim: simulate continuous LTI system with control applied at discrete times.



## Known Issues

- The RTA implementation current support MTU but only with constrained deadlines.
- For RTA, the call & run time from MATLAB will be longer with larger hyper periods.

## Citation

```text
@inproceedings{dai2020fixed,
  title={Fixed-priority scheduling and controller co-design for time-sensitive networks},
  author={Dai, Xiaotian and Zhao, Shuai and Jiang, Yu and Jiao, Xun and Hu, Xiaobo Sharon and Chang, Wanli},
  booktitle={Proceedings of the 39th International Conference on Computer-Aided Design},
  pages={1--9},
  year={2020}
}
```
