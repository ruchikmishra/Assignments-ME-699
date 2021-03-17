@def class = "Journal"
@def authors = "Mellinger, Daniel; Michael, Nathan;Kumar Vijay"
@def title = "Trajectory Generation and Control for preceise aggressive maneuvers with quadrotors"
@def venue = "The International Journal of Robotics Research"
@def year = "2012"
@def hasmath = true
@def review = true
@def tags = ["trajectory generation"]
@def reviewers = ["Ruchik Mishra"]

\toc


### Broad area/overview
The paper talks about dynamic trajectory generation using the concept of a family of trajectories and using a controller that has been parametrized by the goal of the quadrotor.


### Notation
- $\phi, \theta,\psi$: roll, pitch and yaw angles
- $W$: world frame
- $B$: body frame.


### Specific problem
The papers tests the famliy of trajectories concept that it proposes by using a goal parametrized controller on test scenarios that involve aggressive maneuvers. This family of trajectories has been developed using a sequence of control segments each of which has been derived by the dynamic model of the quadrotor.

### Solution ideas
- A dynamic model of the quadrotor and the motor has been derived first.
- The control of the robot has been used to control the:
  - desired attitude
  - hover in place,
  - control along a three-dimensional trajectory with a specified position and linear velocity.
- A sequence of the above controllers is defined for developing a family of trajectories. These are defined in segments of the following 5 phases:
  - Hover control to a desired position: This is to reach the desired positon and yaw angle with zero linear and angular velocities. The desired roll, pitch and yaw angles are given by:
    - $\phi_{des} =\frac{1}{g}(\ddot{r_{1}})\sin{\psi_{T}}-\ddot{r_{2}}\cos{\psi_{T}}$
    - $\theta_{des} =\frac{1}{g}(\ddot{r_{1}})\cos{\psi_{T}}+\ddot{r_{2}}\sin{\psi_{T}}$
    - $\triangle\omega_{F} =\frac{m}{8k_{f}\omega_{h}}\ddot{r_{3}}^{des}$
  - Control to desired velocity vector: the error is given by-
    - $e_{v} = \dot{r}_{T}-\dot{r}$

    where $\dot{r}_{T}$ represents the closest point in the trajectory and $\dot{r}$ represents the current position.
  - Control to desired pitch angle: The goal is to reach the desired attitude with a specified angular velocity. The proportional derivative contol law is used with the desired angular velocities of the rotors.
  - Control to zero pitch angle:
    - hover control to a desired position.
- An inital parameter selection is done by analytically calculating the positon of the launch point and the velocity at that point. But as the actual quadrotor has errors and does not exactly reach the launch point with the desired velocity, an iterative apporoach is used to update the  pitch angle at any time $t$, which is given by:
    - $\theta^{k+1}_{C}=\theta^{k}_{C}+\gamma_{\theta}(\theta_{G}-\theta^{k}_{act})$

    Also, the command velocity is updated iteratively using the following:
      - $\upsilon^{k+1}_{C}=\upsilon^{k}_{C}+\gamma_{\upsilon}(\theta_{G}-\upsilon^{k}_{act})$
- The testing step includes 4 scenarios that include 15 trials each. These four test scenarios are:
  - Flying through vertical opening at varying angles.
  - flying downward through a horizontal opening.
  - flying upwards through a horizontal opening.
  - perching on a target with varying angles.
- The paper claims to  attain precise control and repeatability along the trajectories obtained ensuring the desired velocities and accelerations.


  ### Comments
- The paper has described good test results for their proposed method.
- Howeverm there is no comparison made with the proposed method to the exisitng methods in the literature.
