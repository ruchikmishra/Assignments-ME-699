# Assignment 1 ME699

## Setup

This assignment has three URDF files for describing two manipulators:
- `arm_edit.urdf`
- `arm_13dof.urdf`
- `assignment_one_draft.urdf`

#### Without branching
The `arm_edit.urdf` has a 12 Dof manipulator with no branching. This manipulator can be visualized by following the setup steps:


```sh
cd
git clone https://github.com/hpoonawala/rmc-s21.git
git clone https://github.com/ruchikmishra/Assignments-ME-699.git
```
Copy the files from `/Assignment-ME-699/assignment_1`  to `/rmc-s21/julia/odes`.
To run the program to visualize and animate the 12 DoF robot, run the following in the `/rmc-s21/julia/odes` :


```sh
julia
include("startup_new.jl")
```

To change the configuration of the manipulator, change the desired coordinates from the terminal itself:
:


```sh
q = [x,y,z]
desired_tip_location = Point3D(root_frame(mechanism), q)
jacobian_transpose_ik!(state, body, point, desired_tip_location)
set_configuration!(vis, configuration(state))
```
By setting the desired tip location, the end effectors (here: the tip of the last link) goes to the same following inverse kinematics.

#### With branching

The `assignment_one_draft.urdf` has two branches that can be visualized by following the commands:

```sh
julia
include("main_k.jl")
```



## References
- [Robotics Modeling and Control ME699 repository](https://github.com/hpoonawala/rmc-s21)
- [Jacobian IK and Control](https://juliarobotics.org/RigidBodyDynamics.jl/dev/generated/4.%20Jacobian%20IK%20and%20Control/4.%20Jacobian%20IK%20and%20Control/)

## Authors  
- Ruchik Mishra : ruchikofficial@gmail.com
- Samrat Pravin Patel: sppa242@uky.edu

## Acknowledgement
- Dr. Hasan Poonawala for providing all the base codes for building up the urdf files.
- Keith Russell for helping with the main_k.jl file and for the base urdf code.
