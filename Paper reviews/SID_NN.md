@def class = "Journal"
@def authors = "Norouzi, Ramin; Kosari, Amirreza;Hossein,Sabour, Mohammad,"
@def title = "Real-time estimation of impaired aircraft flight envelop using feedforward neural networks"
@def venue = "Aerospace Science and Technology"
@def year = "2019"
@def hasmath = true
@def review = true
@def tags = ["System identification, Neural networks"]
@def reviewers = ["Ruchik Mishra"]

\toc

### Broad area/overview
For, a loss of control scenario, it becomes essential for an unammned aerial vehicle, to compute it's flight envelop in real-time scenarios, This paper discusses a neural network based approach that uses premeditated failure scenarios and trains the network based on these scenarios to estimate the flight envelop of a fixed wing UAV.

### Notation

- $V$: aircraft total speed.
- $\alpha$: angle of attack.
- $\beta$: sideslip angle.
- $p,q,r$: roll,pitch, yaw rate.
- $\phi,\theta,\psi, \gamma$: roll, pitch, yaw and flight angles respectively.
- $\delta_{th}, \delta_{a},\delta_{e},\delta_{r}$: engine throttle setting and the deflections in elevator, aileron and rudder respectively.
- $f$: vector of non-linear functions
- $x$: state vector.
- $u$: control vector.




### Specific problem
In this paper, a feed forward neural network is used for estimating the flight envelop of a fixed wing UAV for any degree of loss of flight scenario. It accounts for both single or compound failures that involve structural, control surface, energy, aileron and sensor failure. This is done using decomposing each subsystem into a number of neural networks of the same structure.  



### Solution ideas

- Due to the infeasibility of fitting a 3D envelop to the manuevering flight, the flight path is taken as one of the inputs of the system.
- In addition to it, the flight altitude is also taken as the input along with the parameters that are lost due to the different types of failure that can occur (structural, energy, actuator, sensor).
-   The following equation shows the longitudinal body axis force coefficient:

  $C_{x} = C_{x_{0}} + C_{X_{\alpha}}\alpha+C_{X_{\alpha^{2}}}\alpha^{2}/2+ C_{X_{\beta}}\beta+C_{X_{\beta^{2}}}\beta^{2}/2+C_{X_{\hat{p}}}\hat{p}+C_{X_{\hat{p}^{2}}}\hat{p}^{2}/2+C_{X_{\hat{q}}}\hat{q}+C_{X_{\hat{q}^{2}}}\hat{q}^{2}/2+C_{X_{\hat{r}}}\hat{r}+C_{X_{\hat{r}^{2}}}\hat{r}^{2}/2+C_{X_{\delta_{a}}}\delta_{a}+C_{X_{\delta_{a}^{2}}}\delta_{a}^{2}/2+C_{X_{\delta_{e}}}\delta_{e}+C_{X_{\delta_{e}^{2}}}\delta_{e}^{2}/2+C_{X_{\delta_{r}}}\delta_{r}+C_{X_{\delta_{r}^{2}}}\delta_{r}^{2}/2$

The above equation holds true for each of $C_{x},C_{y},C_{z},C_{l},C_{m},C_{n}$ used in this paper which gives rise to a total of 102 derivatives characterizing the aircraft aerodynamics. Number of inputs related to each failure types as discussed int he work are:
- Structural failure: 102
- Left engine failure: 1
- Right engine failure: 1
- Rudder failure: 2
- Aileron failure: 2
- Elevator failure: 2

- Further, the system is comprised of 63 subsystems to address a nunmber of single or compound failures. Each of these subsystems has a neural netwrok trained to overcome the impairment of the corresponding subsystem. the training dat is generated offline.
- A cubic Hermit interpolating polynomial is fitted to the data points with the condition that the derivative of the polynomial is continuous and the cubic interpolant is shape-preserving. The polynomial is given by:

  $f(x) = a(x-x_{1})^{2}+b(x-x_{1})^{2}+c(x-x_{1})^{2}+d$

- To reduce the computational load and to maintain the consistency of the network used, the system is designed containing 50 neural networks, each of which corresponds to the boundary point related to each failure.

- The network architecture that is used in this work is a two-layer neural network including a hidden layer with a nonlinear digmoid function and one output layer with a linear transfer function.
- The paper uses Bayesian regularization as the training algorithm with multiple-neural-networks training technique where each neural network is trained 10 times.
- At each of the training processes starts with a different initial weights and biases and with different divisions of data intio training and test data set.
- To validate the proposed method:
  - The dynamic model was validated using the wind tunnel test.
  - Controllale trim conditions(if the perturbation system about this trim state has a full rnak matrix) are used to implement each triplet $(V^{*},\gamma^{*},\psi^{*})$. The intiial condition to the optimization problem is set equal to the sucessful solution of the previous triplet.


### Comments
- The paper proposes a good neural network based method for the estimation of the flight envelop in real time loss of control cases.
- But, the network still heavily relies on the offline training of the pre-meditated failure scenarios.
