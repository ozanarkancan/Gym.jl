include("spaces.jl")
include("spec.jl")

mutable struct GymEnv
    name
    spec
    action_space
    observation_space
    reward_range
    gymenv
end

function GymEnv(id::String)
    try
        gymenv = gym.make(id)
        spec = Spec(gymenv[:spec][:id],
                    gymenv[:spec][:trials],
                    gymenv[:spec][:reward_threshold],
                    gymenv[:spec][:nondeterministic],
                    gymenv[:spec][:tags],
                    gymenv[:spec][:max_episode_steps],
                    gymenv[:spec][:timestep_limit]
                   )
        action_space = julia_space(gymenv[:action_space])
        observation_space = julia_space(gymenv[:observation_space])

        env = GymEnv(id, spec, action_space,
                     observation_space, gymenv[:reward_range], gymenv)
        return env
    catch
        error("$id is missing")
    end
end

reset!(env::GymEnv) = env.gymenv[:reset]()
render(env::GymEnv) = env.gymenv[:render]()

function step!(env::GymEnv, action)
    ob, reward, done, information = env.gymenv[:step](action)
    return ob, reward, done, information
end

close!(env::GymEnv) = env.gymenv[:close]()
