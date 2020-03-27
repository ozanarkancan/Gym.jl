function run_env(env_id)
  try
    env = GymEnv(env_id)
    for i=1:3
      reset!(env)
      for j=1:20
        action = sample(env.action_space)
        ob, r, done, information = step!(env, action)
        if done
          break
        end
      end
    end

    return true
  catch y
    @info(y)
    return false
  end
end

algorithmic = ["Copy-v0", "DuplicatedInput-v0", "RepeatCopy-v0",
              "Reverse-v0", "ReversedAddition-v0", "ReversedAddition3-v0"]

atari = ["Alien-ram-v0", "Alien-v0", "Assault-ram-v0", "Assault-v0",
         "BankHeist-ram-v0", "BankHeist-v0", "BattleZone-ram-v0", "BattleZone-v0",
         "Breakout-ram-v0", "Breakout-v0", "Enduro-ram-v0", "Enduro-v0",
         "MontezumaRevenge-ram-v0", "MontezumaRevenge-v0",
         "Pong-ram-v0", "Pong-v0"]

box2d = ["BipedalWalker-v3", "BipedalWalkerHardcore-v3",# "CarRacing-v0", carracing is broken within gym
         "LunarLander-v2", "LunarLanderContinuous-v2"]

control = ["Acrobot-v1", "CartPole-v1", "MountainCar-v0",
           "MountainCarContinuous-v0", "Pendulum-v0"]

toytext = ["Blackjack-v0", "FrozenLake-v0", "FrozenLake8x8-v0",
           "GuessingGame-v0", "HotterColder-v0", "NChain-v0",
           "Roulette-v0", "Taxi-v3"]

@testset "Algorithmic" begin
  @testset for env in algorithmic
    result = run_env(env)
    @test result
  end
end

@testset "Atari" begin
  @testset for env in atari
    result = run_env(env)
    @test result
  end
end

@testset "Box2d" begin
  @testset for env in box2d
    result = run_env(env)
    @test result
  end
end

@testset "Classic Control" begin
  @testset for env in control
    result = run_env(env)
    @test result
  end
end

@testset "Toy Text" begin
  @testset for env in toytext
    result = run_env(env)
    @test result
  end
end
