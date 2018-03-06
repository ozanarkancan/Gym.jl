ENV["GYM_ENVS"] = "atari:algorithmic:box2d:classic_control"
for p in ("Gym","ArgParse")
    Pkg.installed(p) == nothing && Pkg.add(p)
end

using Gym, ArgParse

struct RandomAgent
    action_space
end

function act!(agent::RandomAgent, observation, reward, done)
    return sample(agent.action_space)
end

function main(ARGS)
    s = ArgParseSettings()
    s.description="(c) Ozan Arkan Can, 2018. Demonstration of simple usage of Gym and the implementation of a random agent."
    s.exc_handler=ArgParse.debug_handler
    @add_arg_table s begin
        ("--env_id"; default="CartPole-v0"; help="environment name")
        ("--episode_count"; arg_type=Int; default=20; help="number of episodes")
        ("--render"; help = "render the environment"; action = :store_true)
    end

    o = parse_args(s)

    env = GymEnv(o["env_id"])
    agent = RandomAgent(env.action_space)

    reward = 0
    done = false

    for i=1:o["episode_count"]
        total = 0
        ob = reset!(env)
        while true
            action = act!(agent, ob, reward, done)
            ob, reward, done, information = step!(env, action)
            total += reward
            
            if o["render"]
                render(env)
            end

            if done
                break
            end
        end
        println("Epoch $i Total Rewards: $total")
    end
end

main(ARGS)
