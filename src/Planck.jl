module Planck

using Unitful
using Unitful: AbstractQuantity
using Unitful: h, c0, k

export Blackbody, blackbody

# constants in SI units
const _h = ustrip(u"J*s", h)
const _c0 = ustrip(u"m/s", c0)
const _k = ustrip(u"J/K", k)

using Unitful: 𝐋, 𝐓
# define traits for Unitful (until Unitful.jl PR is made and merged TODO)
# const WAVELIKE = Type{<:} where {T}
# const FREQLIKE = Type{<:} where {T}

"""
    Blackbody(temp)
"""
struct Blackbody{TT} <: Function
    temp::TT
end

(bb::Blackbody)(OT, x) = OT(bb(x))

function (bb::Blackbody)(ν::AbstractQuantity{T,inv(𝐓)}) where T
    2 * h * ν^3 / c0^2 / expm1(h * ν / (k * bb.temp))
end

function (bb::Blackbody)(λ::AbstractQuantity{T,𝐋}) where T
    2 * h * c0^2 / λ^5 / expm1(h * c0 / (λ * k * bb.temp))
end

# SI (meters, Kelvin)
function (bb::Blackbody)(λ)
    2 * _h * _c0^2 / λ^5 / expm1(_h * _c0 / (λ * _k * bb.temp)) # W / m^3
end

"""
    blackbody([OT], x, T)

Evaluate a blackbody at `x`, which is in meters by default. If `OT` is given, the output will be converted to that type, which is convenient for unit conversions. Temperature is assumed to be Kelvin.

# Examples

```jldoctest
julia> using Unitful

julia> blackbody(6e-7, 5850)
2.583616647617973e13
    
julia> blackbody(Float32, 6e-7, 5850)
2.5836166f13

julia> blackbody(u"erg/s/cm^2/nm", 600u"nm", 5850u"K")
2.5836166476179734e7 erg nm⁻¹ cm⁻² s⁻¹
```

# See also
[`Blackbody`](@ref)
"""
blackbody(x, T) = Blackbody(T)(x)
blackbody(OT, x, T) = Blackbody(T)(OT, x)


end
