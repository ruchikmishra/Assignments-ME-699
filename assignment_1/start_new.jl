using RigidBodyDynamics
using StaticArrays
using MeshCat, MeshCatMechanisms, Blink

using Random
Random.seed!(42);

urdf = ("arm_edit.urdf")
mechanism = parse_urdf(urdf)
state = MechanismState(mechanism)
mechanism

body = findbody(mechanism, "Link twelve")
point = Point3D(default_frame(body), 0., 0, 0.57)



# Create the visualizer
vis = MechanismVisualizer(mechanism, URDFVisuals(urdf))

# Render our target point attached to the robot as a sphere with radius 0.07
setelement!(vis, point, 0.07)


open(vis, Window());
mvis = MechanismVisualizer(mechanism, URDFVisuals(urdf));


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
        point_in_world = transform(state, point, world)
        # Update the point's jacobian
        point_jacobian!(Jp, state, p, point_in_world)
        # Compute an update in joint coordinates using the jacobian transpose
        Δq = α * Array(Jp)' * (transform(state, desired, world) - point_in_world).v
        # Apply the update
        q .= configuration(state) .+ Δq
        set_configuration!(state, q)
    end
    state
end




rand!(state)
set_configuration!(vis, configuration(state))

desired_tip_location = Point3D(root_frame(mechanism), 0.2, 1, 0.1)

jacobian_transpose_ik!(state, body, point, desired_tip_location)
set_configuration!(vis, configuration(state))


transform(state, point, root_frame(mechanism))

qs = typeof(configuration(state))[]


for x in range(-1, stop=1, length=100)
    desired = Point3D(root_frame(mechanism), x, 0, 2)
    jacobian_transpose_ik!(state, body, point, desired)
    push!(qs, copy(configuration(state)))
end
ts = collect(range(0, stop=1, length=length(qs)))
setanimation!(vis, Animation(vis, ts, qs))
