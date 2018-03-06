module Gym

using PyCall

global const gym = PyCall.pywrap(PyCall.pyimport("gym"))
# package code goes here

include("env.jl")

"""
Shows available environments
"""
function show_available_envs()
    println(gym.envs[:registry][:all]())
end

export GymEnv, reset!, step!, render
export sample, DiscreteS, BoxS, TupleS
export show_available_envs

end # module
