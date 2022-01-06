module Planck

using EnergyTraits
using Unitful
using Unitful: AbstractQuantity
using Unitful: h, c0, k

export Blackbody, blackbody

# commit piracy 
using Unitful: 𝐋, 𝐓, 𝐌
# define traits for Unitful (until Unitful.jl PR is made and merged TODO)
EnergyTraits.EType(::Type{<:AbstractQuantity{T,𝐋}}) where {T} = IsWavelength()
EnergyTraits.EType(::Type{<:AbstractQuantity{T,inv(𝐓)}}) where {T} = IsFrequency()
EnergyTraits.EType(::Type{<:AbstractQuantity{T,𝐋*𝐌/𝐓^2}}) where {T} = IsEnergy()

"""
    Blackbody(temp)
"""
struct Blackbody{TT} <: Function
    temp::TT
end

const QBlackbody = Blackbody{<:AbstractQuantity}

(bb::QBlackbody)(x::ET) where {ET} = bb(EType(ET), x)
(bb::QBlackbody)(OT, x::ET) where {ET} = OT(bb(EType(ET), x))

function (bb::QBlackbody)(::IsFrequency, ν)
    2 * h * ν^3 / c0^2 / expm1(h * ν / (k * bb.temp))
end

function (bb::QBlackbody)(::IsWavelength, λ)
    2 * h * c0^2 / λ^5 / expm1(h * c0 / (λ * k * bb.temp))
end

"""
    blackbody([OT], x, T)

Evaluate a blackbody at `x`, which is in meters by default. If `OT` is given, the output will be converted to that type, which is convenient for unit conversions.

# Examples

```jldoctest
julia> using Unitful

julia> blackbody(6e-7, 5850)
2.583616647617973e13

julia> blackbody(u"erg/s/cm^2/nm", 600u"nm", 5850u"K")
2.5836166476179734e7 erg nm⁻¹ cm⁻² s⁻¹
```

# See also
[`Blackbody`](@ref)
"""
blackbody(x::AbstractQuantity, T::AbstractQuantity) = Blackbody(T)(x)
blackbody(OT, x::AbstractQuantity, T::AbstractQuantity) = Blackbody(T)(OT, x)

end
