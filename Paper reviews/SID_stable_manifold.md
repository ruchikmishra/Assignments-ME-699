@def class = "Journal"
@def authors = "Yuan, Guoqiang; Li, Yinghui"
@def title = "Determination of the flight dynamic envelop via stable manifold"
@def venue = "Measurement and Control"
@def year = "2019"
@def hasmath = true
@def review = true
@def tags = ["System identification, stable manifold"]
@def reviewers = ["Ruchik Mishra"]

\toc

### Broad area/overview
The determination of flight envelop for a UAV is of paramount importance. A stable manifold approach is used to determining the flight envelop as a region of interest.

### Notation
- $W^{s}(\hat{x})$ : Stable manifold.
- $W^{u}(\hat{x})$ : Ustable manifold.
- ${\partial A}(s)$ : boundary of the region of attraction.
- $a$ : angle of attack.
- $q$ : pitch rate.
- $\rho$ : air density.
- $\delta_{e}$: elevator deflections
- $(a_{s},q_{s},\theta_{s})$ : trim point where ROA is to be determined.
- $x_{s}$: asymptotically stable equillibrium point

### Specific problem
The flight envelop estimation problem has been approached from the perspective of a stable manifold on a F-16 aircraft. It is used to explicitely represent the flight dynamic envelop. In addition to it, the computation is done only on the envelop and not on the entire state space.


### Solution ideas
- The stable manifold is used to construct the the region of attraction that represents the dynamic fight envelop.
- The region of attraction is defined in the paper as:
  - $A(x_{s}) = \left\{x \epsilon \mathbb{R}^{n}|\lim_{t \rightarrow \infty}\xi_{f}(t;x,t_{0})=x_{s} \right\}$
- The boundary region of the region of attraction is defined by:
  - ${\partial A}(x_{s}) = \bigcup_iW^{s}(x_{i})$

and for an equillibrium point $\hat{x}$, $\hat{x}\epsilon {\partial A}(x_{s})$ iff $W^{u}(\hat{x})\cap A(x_{s})\neq \phi$

where $\xi_{f}(t;x_{0},t_{0})$ is a solution to the ordinary differential equation:
  $\dot{x}= f(x)$, where $x\epsilon\mathbb{R}^{n}$ is the state variable and the vector field $f:\mathbb{R}^{n}\rightarrow\mathbb{R}^{n}$ is Lipschitz stable.

- Further,the stable and the unstable manifold have been defined in the paper as:
  - $W^{s}(\hat{x})=\left\{x \epsilon \mathbb{R}^{n}|\lim_{t \rightarrow \infty}\xi_{f}(t;x,t_{0})=x_{s} \right\}$
  - $W^{s}(\hat{x})=\left\{x \epsilon \mathbb{R}^{n}|\lim_{t \rightarrow - \infty}\xi_{f}(t;x,t_{0})=x_{s} \right\}$
- Only the longitudinal dynamics of the F-16 aircraft is used as the computation of the flight envelop in higher dimension can be complex. Th dynamic model can be described as follows:

  - $\dot{a} = q-\frac{1}{mV}(T\sin{a}+L-mg\cos{\theta-a})$
  - $\dot{q} = \frac{M}{I_{y}}$
  - $\dot{\theta} =q$

  where

  - $L=1/2\rho V^{2}C\overline{c}(C_{X_{T}}\sin{a}-C_{Z_{T}}\cos{a})$
  - $M = \frac{1}{2}\rho V^{2}S\overline{c}C_{m_{T}}+\frac{1}{2}\rho V^{2}S\overline{c}C_{Z_{T}}(x_{cgref}-x_{cg})-mgx_{cg}$

- Th calculation accuracy is compromised by reducing removing the altitude and the speed which is gives a 3-dimensional system in place of 5 which reduces the time to compute the stability region.
- Thus, only the pitch angle, pitch rate and angle of attack in the longitudinal dynamics.
- To check the feasibility of the proposed method, a proportional controller that takes the actuator saturation into account is used:
  - $\delta_{e} = sat(k_{a}(a-a_{s})+k_{q}(q-q_{s}))$
- The time domain results in the paper show that the unstable manifold of the Unstable equillibrium points converges to the stable equillibrium points (SEP).
- The paper concludes that the flight dynamic envelop can be obtained from the two-dimensional stable manifold of the unstable equillibrium points. Also, if a trajectory converges to SEP, then the corresponding grid point is in the dynamic envelope.
- Also, a comparison with the level-test method is drawn and has been shown that the former is computationally more expensive than the stable manifold method as it requires an additional dimesnion of iteration ($\phi(x,t)$) is defined in the n-dimensional space whereas the proposed method iterates over (n-1) dimensional manifold).

  ### Comments
- The complexity of the algorithm has not been explicitely mentioned. Also, the latency of the algorithm is not evaluated.
- Also, there is no mention of how the manifold method can be scaled to higher dimensions since the altitude and the speed of the aircraft have not been included in the calculation of the stable manifold.
