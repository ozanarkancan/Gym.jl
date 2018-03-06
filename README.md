# Gym

This package provides a julia interface for the [OpenAi gym](https://github.com/openai/gym).

Here is an example usage:
```julia
using Gym

env = GymEnv("CartPole-v0")
reward = 0
episode_count = 10

for i=1:episode_count
    total = 0
    ob = reset!(env)
    render(env)#comment out this line if you do not want to visualize the environment
    while true
        action = sample(env.action_space)
        ob, reward, done, information = step!(env, action)
        total += reward
        render(env)#comment out this line if you do not want to visualize the environment
        if done
            break
        end
    end
    println("Epoch $i Total Rewards: $total")
end
```
