#=
# A small exercise to experiment with Julia's type system, as well as its
# multiple-dispatch feature.
# Decided to throw in a little randomness and get acquainted with the 
# Distributions package.
=#

using Distributions

abstract type choice end
# `rock`, `paper`, `scissors` are singleton types. There can only be one 
# instance of such types.
struct rock <: choice end
struct paper <: choice end
struct scissors <: choice end

r = rock(); p = paper(); s = scissors()

struct player
    # `stats` is a representation of the pmf over the 3 possible choices 
    stats::Vector{Float64, 1}
end

# Some of Julia's syntactical sugar for making objects callable by adding methods
# to its type
function (p::player)()
    # Randomly pick a choice, considering the player's propensities
    [r, p, s][rand(Categorical(p.stats), 1)]
end

result(::rock, ::scissors) = 1
result(::paper, ::rock) = 1
result(::scissors, ::paper) = 1
# Dispatch can lead to meaningfully-succinct code
result(::T, ::T) where T<:choice = 0
result(::choice, ::choice) = -1
