using Distributions

abstract type choice end
struct rock <: choice end
struct paper <: choice end
struct scissors <: choice end

r = rock(); p = paper(); s = scissors()

struct player
    stats::Vector{Float64, 1}
end

function (p::player)()
    [r, p, s][rand(Categorical(p.stats), 1)]
end

result(::rock, ::scissors) = 1
result(::paper, ::rock) = 1
result(::scissors, ::paper) = 1
result(::T, ::T) where T<:choice = 0
result(::choice, ::choice) = -1
