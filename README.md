# Network and Scheduling Co-Design for TSN

MATLAB code for the research 'Network and Control Co-Scheduling for IEEE Time-Sensitive Networking.'



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