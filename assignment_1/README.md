# README

## Setup

This assignment has two URDF files for describing two manipulators:
- `arm_edit.urdf`
- `arm_13dof.urdf`

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
include("start_new.jl")
```

To change the configuration of the manipulator, change the desired coordinates in the `start_new.jl` in this line:
:


```sh
desired_tip_location = Point3D(root_frame(mechanism), 0.2, 1, 0.1)
```
By setting the desired tip location, the end effectors (here: the tip of the last link) goes to the same following inverse kinematics.

#### With branching

The `arm_13dof.urdf` has two branches that are attached to the base frame. The manipulator can be visualized by following the commands:

```sh
julia
include("startup_new.jl")
```
To change the configuration of the manipulator, change the desired coordinates in the `startup_new.jl` in this line:

```sh
desired_tip_location_two = Point3D(root_frame(mechanism), 0.1, 0, 0)
```

By setting the desired tip location, the end effector (here: the tips of the last links of the both the branches) follow inverse kinematics to reach to the goal point.




## References
- [Robotics Modeling and Control ME699 repository](https://github.com/hpoonawala/rmc-s21)
- [Jacobian IK and Control](https://juliarobotics.org/RigidBodyDynamics.jl/dev/generated/4.%20Jacobian%20IK%20and%20Control/4.%20Jacobian%20IK%20and%20Control/)

## Authors  
- Ruchik Mishra : ruchikofficial@gmail.com
- Samrat Pravin Patel: sppa242@uky.edu

## Acknowledgement
- Dr. Hasan Poonawala
- Keith Russell
