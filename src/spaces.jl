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

sample(s::BoxS) = rand(s.low:s.high, shape...)

mutable struct TupleS <: absSpace
    spaces
end
sample(s::TupleS) = map(sample, s.spaces)

function julia_space(ps)
    class_name = ps[:__class__][:__name__]
    if class_name == "Discrete"
        return DiscreteS(ps[:n])
    elseif class_name == "Box"
        return BoxS(ps[:low], ps[:high], ps[:shape])
    elseif class_name == "Tuple"
        spaces = map(julia_space, ps[:spaces])
        return TupleS(spaces)
    else
        error("$class_name has not been supported yet")
    end
end
