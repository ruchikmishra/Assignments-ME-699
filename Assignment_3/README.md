## Assignment 3

The repo contains the files required for Assignemnt 3 of the course ME 699. The steps to use this repo have been described.

### Step 1 Cloning the repo

Clone the repository. Use the following commands to do so:
```sh
cd
git clone https://github.com/ruchikmishra/Assignments-ME-699.git
```
This will clone the repository into your home folder.

### Step 2 running the julia file

In order to run the file, only the `runfile.jl` has to be used. It can be done by writing the following commands in the terminal.

```sh
cd /home/username/Assignments-ME-699/
julia
include("runfile.jl")
```
This code has all the three functions namely:
- Traj(t)
- Control_PD!
- Control_CTC!

### Step 3 calling the functions
- In order to first get the output of the Traj function, run:
```sh
Traj(t)
```
where t is time in seconds.
In this problem a cubic polynomial has been used.

- Further, to get the output of the control_PD! function, run the following:
```sh
Controller(1)
```
- To get the output of the control_PD! function, run the following:
```sh
Controller(2)
```
