__precompile__()

module Gym

using PyCall

const gym = PyNULL()

function __init__()
    copy!(gym, pyimport("gym"))
end

include("env.jl")

"""
Shows available environments
"""
function show_available_envs()
    println(map(x->x[:id], gym.envs[:registry][:all]()))
end

export GymEnv, reset!, step!, render, close, seed!
export sample, DiscreteS, BoxS, TupleS
export show_available_envs

end # module
