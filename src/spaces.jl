const _gym_spaces = ["Box", "Discrete", "MultiDiscrete", "MultiBinary", "Tuple", "Dict"]

abstract type absSpace end
sample(space::absSpace) = error("sample function for $(typeof(space)) is missing")

mutable struct DiscreteS <: absSpace 
    n
end
sample(s::DiscreteS) = rand(0:(s.n-1))

mutable struct BoxS <: absSpace
    low
    high
    shape
end

function sample(s::BoxS)
    if !isa(s.low, Array{Float32})#Float?
        r = rand() * (s.high - s.low) - s.low
        return r
    elseif length(s.low) == 1
        r = rand(s.shape...) * (s.high[1] - s.low[1]) .+ s.low[1]
        return r
    elseif size(s.low) == size(s.high)
        r = rand(s.shape...) .* (s.high - s.low) .+ s.low
        return r
    else
        error("Dimension mismatch")
    end
end

mutable struct TupleS <: absSpace
    spaces
end
sample(s::TupleS) = map(sample, s.spaces)

function julia_space(ps)
    class_name = ps.__class__.__name__
    if class_name == "Discrete"
        return DiscreteS(ps.n)
    elseif class_name == "Box"
        return BoxS(ps.low, ps.high, ps.shape)
    elseif class_name == "Tuple"
        spaces = [julia_space(s) for s in ps.spaces]
        return TupleS((spaces...,))
    else
        error("$class_name has not been supported yet")
    end
end
