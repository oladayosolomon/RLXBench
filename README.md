# RLXBench
Requires python 3.9 and PlatEMO v4.2 (https://github.com/BIMK/PlatEMO). <br />
Clone this repository and install the packages specified in requirements.txt <br />
```
git clone https://github.com/oladayosolomon/RLXBench/
cd RLXBench
pip install -r requirements.txt
```
you should then copy the RL folder to the PlatEMO multi-objective problem directory and the mat_eval_env.py to the main PlatEMO directory (the one with the platemo.m file)

Path related information

```
pyExec = 'C:\Users\ecis\anaconda3\envs\RL_Bench\python.exe';

pyRoot = fileparts(pyExec);
p = getenv('PATH');
p = strsplit(p, ';');
addToPath = {
pyRoot
fullfile(pyRoot, 'Library', 'mingw-w64', 'bin')
fullfile(pyRoot, 'Library', 'usr', 'bin')
fullfile(pyRoot, 'Library', 'bin')
fullfile(pyRoot, 'Scripts')
fullfile(pyRoot, 'bin')
};
p = [addToPath(:); p(:)];
p = unique(p, 'stable');
p = strjoin(p, ';');
setenv('PATH', p);
```
