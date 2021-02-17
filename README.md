# README

## Setup

This assignment helps to visualize a 12 Dof manipulator using Universal joints. In addition to it, animation of inverse kinematics of the manipulator can also be visualized using Julia.

To setup the environment for the code to run:

```sh
cd
git clone https://github.com/hpoonawala/rmc-s21.git
git clone https://github.com/ruchikmishra/Assignments-ME-699.git
include("startup.jl")
```
Copy the files from `/Assignment-ME-699/assignment_1`  to `/rmc-s21/julia/odes`.
To run the program and animate the 12 DoF robot, run the following in the `/rmc-s21/julia/odes` :


```sh
julia
include("startup.jl")
```

To change the configuration of the manipulator, change the desired coordinates in the `start_new.jl` in this line
:


```sh
desired_tip_location = Point3D(root_frame(mechanism), 0.2, 1, 0.1)
```
By setting the desired tip location, the end effector (here: the tip of the last link) goes to the same following inverse kinematics.

## References:
- [Github](https://github.com/hpoonawala/rmc-s21)
-[Jacobian IK and Control](https://juliarobotics.org/RigidBodyDynamics.jl/dev/generated/4.%20Jacobian%20IK%20and%20Control/4.%20Jacobian%20IK%20and%20Control/)

## Authors  
- Ruchik Mishra : ruchikofficial@gmail.com
- Samrat Pravin Patel: sppa242@uky.edu

## Acknowledgement
- Dr. Hasan Poonawala
- Keith Russell
