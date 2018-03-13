# Gym

This package provides a julia interface for [OpenAi gym](https://github.com/openai/gym).

### Installation
In Julia repl,
```julia
Pkg.clone("https://github.com/ozanarkancan/Gym.jl")
```

If you do not have a gym installation. The package will install it for you with the following command:
```
Pkg.build("Gym")
```
This makes a minimal installation of the gym. If you want to install free environments, 
you should set the `GYM_ENVS` environment variable as following:

```julia
ENV["GYM_ENVS"]="atari:algorithmic:box2d:classic_control"
```
Then call the `Pkg.build("Gym")`.

### Usage

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
        done && break
    end
    println("episode $i total Rewards: $total")
end
```
