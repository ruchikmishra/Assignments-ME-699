@def class = "Journal"
@def authors = "Seo, Gwang-gyo; Kim, Yoonsoo; Saderla Subrahmanyam"
@def title = "Kalman-filter based online system identification fo fixed-wing aircraft in upset condition"
@def venue = "Aerospace Science and Technology"
@def year = "2019"
@def hasmath = true
@def review = true
@def tags = ["System identification, Fixed wing UAV"]
@def reviewers = ["Ruchik Mishra"]

\toc

### Broad area/overview
Owing to the infeasibility of performing wing tunnel test during an ongoing flight, this paper addresses the issues of online system identification (SID) for fixed wing UAVs. This is an important step in estimating the flight envelop. The paper specifically discusses two online SID methods for a fixed wing UAV in upset conditions (example stall), one of which involves the use of kalman filters.

### Notation

- $C_{L}, C_{D}$: Lift and drag coefficients.
- $C_{m}$: Pitching moment coefficient.
- $C_{X}, C_{Y}, C_{Z}$: Force coefficient components along the x,y and z directions.
- $J_{x}, J_{y}, J_{z}$: Moments of inertia about x, y and z aes in $kg/m^{2}$
- $S$: reference wing area.
- $U_{0}$: Trim speed.
- $V$: Airspeed.
- $X,Y,Z$: Force components along x,y,z axis.
- $a_{x}, a_{y}$: Air acceleration components along x and z axis.
- $\overline{c}$: Mean aerodynamic chord.
- $p,q,r$ roll, pitch and yaw rates.
- $\overline{q}$: Dynamic pressure.
- $u,v,w$: Air velocity components alongx,y and z directions.
- $\hat{x}, \hat{\theta}$: Estimated state and unknown parametrs vector.
-   $\alpha$: angle of attack
- $\delta_{a},\delta_{e},\delta_{r}$: aileron, elevator and rudder deflections.
- $\gamma$: Flight path angle.
- $\theta$: vector of unknown parametrs.
- $\xi$: Flow separation point.
- $\rho$: Air density.


### Specific problem

This paper propoese two different approaches for estimation of online flight dynamics of a fixed wing aircraft in upset consitions (for example stall). These methods are:
- Least squares and Kalman filter approach. This method is used in conditions where the stall behaviour is accomodated in a linear fashion (the aerodynamic coefficient $C_{L}$ is a function of $\dot{\alpha}$).
- Kirchoff's method is used when the stall behaviour is used in a non-linear fashion.


### Solution ideas

- The flight dynamical model is take to be that of a typical aircraft which is represented by:

    $\begin{bmatrix}\dot{u}\\ \dot{\alpha}\\ \dot{q} \\ \dot{\theta}\end{bmatrix}$ = $F\begin{bmatrix}u\\ \alpha\\ q \\ \theta\end{bmatrix}$ + $G\delta_{e}$

- The aerodynamic coefficients of this model are described by the following equations:
  - $C_{L} = C_{L_{0}}+C_{L_{\alpha}}+C_{L_{q}}\frac{\overline{c}}{2U_{0}q}+C_{L_{\delta_{e}}}\delta_{e}$
  - $C_{m} = C_{m_{0}}+C_{m_{\alpha}}+C_{m_{q}}\frac{\overline{c}}{2U_{0}q}+C_{L_{\delta_{e}}}\delta_{e}$
- Further, the hysteresis behaviour (a phenomena in which the a system's behaviour also depends on the history of the system's state and not just on the current state of the system)is accomodated in the above equations by:
    - $C_{L} = C_{L_{0}}+C_{L_{\alpha}}+C_{L_{q}}\frac{\overline{c}}{2U_{0}q}+C_{L_{\delta_{e}}}\delta_{e}+ C_{L_{\dot{\alpha}}}\frac{\overline{c}}{2U_{0}q}\dot{\alpha}$
    - $C_{m} = C_{L_{0}}+C_{L_{\alpha}}+C_{L_{q}}\frac{\overline{c}}{2U_{0}q}+C_{L_{\delta_{e}}}\delta_{e}+ C_{m_{\dot{\alpha}}}\frac{\overline{c}}{2U_{0}q}\dot{\alpha}$

- Least squares is used as an iterative approach that can minimize the error between the input and the output data:

    $z = X\theta + v$

    where $z$ is the output, $X$ is the input and $\theta$ is the unknown to be determined.
- So, these aerodynamic coefficients, $C_{l}$ and $C_{m}$ are estimated using a combined the Kalman filter and the least squares approach. The least square solution for these coefficients is given by:

    $\widehat{\theta}^{k}$ = $\begin{bmatrix}C_{L_{\alpha}}^{(k)} &C_{m_{\alpha}}^{(k)}\\C_{L_{q}}^{(k)} &C_{q}^{(k)} \\C_{L_{\delta_{e}}}^{(k)}& C_{m_{\delta_{e}}}^{(k)}\\C_{L_{\dot{\alpha}}}^{(k)} & C_{m_{\dot{\alpha}}}^{(k)} \end{bmatrix}$

    where $(k)$ is the time instant. The flight dynamic equation containing all the aerodynamic paramters are then replaced by the estimated value from the least square solution. This is then expressed as the discrete version as in the prediction step of the Kalman filter as shown in the following equation:

    $\hat{x}_{k}^{-}$ = $A\hat{x}_{k-1} +Bu_{k-1}$
- The prediction step only contains $\alpha, q$ and $\dot{\alpha}$ as the aerodynamic coefficients are explicitely dependent only on them.
- Further, the non-linear relation between the aerodynamic coefficents and $\alpha$ is described using the Kirchoff' theory to represenrt he hysterisis by the following expression:

  $\xi = \frac{1}{2}\left\{1-\tanh[a_{1}(\alpha - \tau_{2}\dot{\alpha}-\alpha^{*}]\right\}$

  where $a_{1},\alpha^{*}$ and $\tau_{2}$ are additional paramteres to be determined.
- The expression for determining the aerodynamic coefficients then becomes:
  - $C_{L} = C_{L_{0}}+C_{L_{\alpha}} (\frac{1+\surd\xi}{2})^{2}+C_{L_{q}}\frac{\overline{c}}{2U_{0}}+C_{L_{\delta_{e}}}\delta_{e}$
  - $C_{D} = C_{D_{0}} + \kappa C_{L}^{2}+C_{D_{\xi}}(1-\xi)$
  - $C_{m} = C_{m_{0}}+C_{m_{\alpha}} (\frac{1+\surd\xi}{2})^{2}+C_{m_{q}}\frac{\overline{c}}{2U_{0}}+C_{m_{\delta_{e}}}\delta_{e}+C_{m_{\xi}}(1-\xi)$
- The non-linearity arising in the the above equations for finding the aerodynamic coefficients has been solved using Unscented Kalman filter instead of just KF.
- The size of the moving window for calculating the solution of the least squares ($\widehat{\theta}^{k}$), estimation errors corrsponsing to each n (size of the moving window) is calculated using the following equations:
  - $\parallel e_{C_{L}}\parallel$ = $\sqrt{\int_{0}^{t_{f}}\left\{ C_{L}\left(t\right)-\widehat{C_{L}}\left(t\right)\right\}^{2}dt}$
  - $\parallel e_{C_{m}}\parallel$ = $\sqrt{\int_{0}^{t_{f}}\left\{ C_{m}\left(t\right)-\widehat{C_{m}}\left(t\right)\right\}^{2}dt}$

where $\widehat{C_{L}}$ and $\widehat{C_{m}}$ are dependent on $n$ and are calculated by the LS-KF method.

  ### Comments
- The paper successfully demonstrates how online SID can be done using LS-KF methods and Kirchoff's theory (for the non-linear case).
- However, the paper does not mention what type of flight data is being used for the finding out the aerodynamic coefficients $C_{L}$ and $C_{m}$.
- Also, the paper does not talk about overcoming loss of control at different stages of the flight.
