import Pkg;
Pkg.activate(@__DIR__);
Pkg.instantiate();
using RigidBodyDynamics, RigidBodySim
using StaticArrays, LinearAlgebra
using MeshCat, MeshCatMechanisms
using Gadfly, Cairo, Fontconfig


#............................. Defining some global variables....................

q_start = [0.01;-0.5;-0.0;-2.0;-0.3;1.5;-0.7;0.1;0.1]
q_end = [0.0;0.0;0.0;0.0;0.0;pi;0.01;0.01;0.01]
T = 10

#......................................Function Traj.............................

function Traj(t)

   q_of_t = q_start + ((3*t^2)/(T^2) - (2*t^3/T^3) )*(q_end - q_start)
   q_dot_of_t = ((6*t)/(T^2) - (6*t^2/T^3) )*(q_end - q_start)
   q_ddot_of_t = (6/(T^2) - (12*t)/(T^3) )*(q_end - q_start)


  return q_of_t, q_dot_of_t, q_ddot_of_t

end

#......................Function diplay urdf......................................

function display_urdf(urdfPath,vis)
    mechanism = parse_urdf(Float64,urdfPath)
    state = MechanismState(mechanism)
    zero_configuration!(state);
    mvis = MechanismVisualizer(mechanism, URDFVisuals(urdfPath),vis)
    manipulate!(state) do x
        set_configuration!(mvis, configuration(x))
    end
    for bd in bodies(mechanism)
        setelement!(mvis,default_frame(bd),0.5,"$bd")
    end
    return mvis, mechanism
end

#.......................Function PD................................................

function Control_PD!(τ, t, state)
q_start = [0.01;-0.5;-0.0;-2.0;-0.3;1.5;-0.7;0.1;0.1]
q_end = [0.0;0.0;0.0;0.0;0.0;pi;0.01;0.01;0.01]
T = 10
    kp = 600
    kd = 50
    q_of_t,q_dot_of_t,q_ddot_of_t =Traj(t)
    τ .= -diagm(kd*[1,1,1,1,1,1,1,1,1])*(velocity(state)-q_dot_of_t) - diagm(kp*[1,1,1,1,1,1,1,1,1])*(configuration(state) - q_of_t)
    act_sat = 50; # Actuator limits
    τ .= map( x -> x > act_sat ? act_sat : x,τ)
    τ .= map( x -> x < -act_sat ? -act_sat : x,τ)
end

#.............................Fucntion CTC......................................

function Control_CTC!(τ, t, state)
    T=10
    q_actual = configuration(state)
    kp = 0.5
    kd = 0.8

    M = mass_matrix(state)

    q_of_t,q_dot_of_t,q_ddot_of_t =Traj(t)

    q = configuration(state)
    q_dot = velocity(state)

    e = q_of_t-q
    e_dot = q_dot_of_t-q_dot
    τ .= M*(q_ddot_of_t + kp * e + kd * e_dot)+dynamics_bias(state)
    act_sat = 50; # Actuator limits
    τ .= map( x -> x > act_sat ? act_sat : x,τ)
    τ .= map( x -> x < -act_sat ? -act_sat : x,τ)
end


#..............................................................................

function Controller(i)
  if i==1
    system=Control_PD!
  end
  if i==2
    system=Control_CTC!
  end
  vis = Visualizer();open(vis)
  # Refresh visualization
  delete!(vis)

  #...........Mechanism information..........................................
  urdfPath = "panda.urdf"
  mvis, mechanism = display_urdf(urdfPath,vis)

  # Create state and set initial config and velocity
  state = MechanismState(mechanism)
  set_configuration!(state,[0.01;-0.5;-0.0;-2.0;-0.3;1.5;-0.7;0.1;0.1])
  zero_velocity!(state)

  # Update mechanism visual
  set_configuration!(mvis, configuration(state))

  problem = ODEProblem(Dynamics(mechanism,system), state, (0., 10.));

  sol = solve(problem, Tsit5(),reltol=1e-8,abstol=1e-8);

#..............Animation.........................................................
  setanimation!(mvis, sol; realtime_rate = 1.0);
  for i in 1:7
      println("final joint angle $i : $(sol[end][i])")
  end
  error=sol[end][1:7]-q_end[1:7]
  println("error is:$(error)")
  error_norm=norm(error,2)
  println("error_norm is:$(error_norm)")
end
