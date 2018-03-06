function install_envs()
    cd("gym")
    if haskey(ENV, "GYM_ENVS")
        envs = split(ENV["GYM_ENVS"], ":")
        for env in envs
            run(`pip install -e .[$env]`)
            info("$env environment has been installed")
        end
    else
        run(`pip install -e .`)
        info("Minimal installation has been performed")
        info("To install everything, set ENV[\"GYM_ENVS\"]=all")
        info("Then build the package again, Pkg.build(\"Gym\")")
    end
end

try
    using PyCall
    PyCall.pyimport("gym")
    install_envs()
catch
    info("OpenAi gym will be installed")
    run(`git clone https://github.com/openai/gym.git`)
    install_envs()
end
