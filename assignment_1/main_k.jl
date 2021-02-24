import Pkg;
Pkg.activate(@__DIR__);
Pkg.instantiate();
using RigidBodyDynamics
using StaticArrays
using MeshCat, MeshCatMechanisms, Blink


urdf = "assignment_one_draft.urdf"
mechanism = parse_urdf(urdf)
state = MechanismState(mechanism)


function jacobian_transpose_ik!(state::MechanismState,
                               body::RigidBody,
                               point::Point3D,
                               desired::Point3D;
                               α=0.1,
                               iterations=100)
    mechanism = state.mechanism
    world = root_frame(mechanism)

    # Compute the joint path from world to our target body
    p = path(mechanism, root_body(mechanism), body)

    # Allocate the point jacobian (we'll update this in-place later)
    Jp = point_jacobian(state, p, transform(state, point, world))


    q = copy(configuration(state))


    for i in 1:iterations
        # Update the position of the point
        point_in_world1 = transform(state, point, world)

        # Update the point's jacobian
        point_jacobian!(Jp, state, p, point_in_world1)

        # Compute an update in joint coordinates using the jacobian transpose
        Δq = α * Array(Jp)' * (transform(state, desired, world) - point_in_world1).v

        # Apply the update
        q .= configuration(state) .+ Δq

        set_configuration!(state, q)

    end
    state
end



vis = MechanismVisualizer(mechanism, URDFVisuals(urdf))


effector = "link thirteen"
body = findbody(mechanism, effector)
point = Point3D(default_frame(body), 1.0, 0, 0)
setelement!(vis, point, 0.07)


open(vis, Window());

q = [1,1,1]
desired_tip_location = Point3D(root_frame(mechanism), q)
jacobian_transpose_ik!(state, body, point, desired_tip_location)
set_configuration!(vis, configuration(state))



qs = typeof(configuration(state))[]


function animator(x,y,z)

  for x1 = configuration(state)[1]:.01:x , y1 = configuration(state)[2]:.01:y , z1 = configuration(state)[3]:.01:z
      desired = Point3D(root_frame(mechanism), x1, y1, z1)
      jacobian_transpose_ik!(state, body, point, desired)

      push!(qs, copy(configuration(state)))
      end


  ts = collect(range(0, stop=3, length=length(qs)))
  setanimation!(vis, Animation(vis, ts, qs))

end
