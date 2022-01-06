module Planck

using EnergyTraits
using EnergyTraits: EnergyType
using Unitful
using Unitful: AbstractQuantity
using Unitful: h, c0, k

export Blackbody, blackbody

const _h = ustrip(u"J*s", h)
const _c0 = ustrip(u"m/s", c0)
const _k = ustrip(u"J/K", k)

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
(bb::QBlackbody)(OT, x::ET) where {ET} = OT(bb(x))

function (bb::QBlackbody)(::IsFrequency, ν)
    2 * h * ν^3 / c0^2 / expm1(h * ν / (k * bb.temp))
end

function (bb::QBlackbody)(::IsWavelength, λ)
    2 * h * c0^2 / λ^5 / expm1(h * c0 / (λ * k * bb.temp))
end

# assume wavelength by default
(bb::Blackbody)(x) = bb(IsWavelength(), x)
(bb::Blackbody)(OT, x) = OT(bb(IsWavelength(), x))
(bb::Blackbody)(OT, ET::EnergyType, x) = OT(bb(ET, x))

# SI (Hertz, Kelvin)
function (bb::Blackbody)(::IsFrequency, ν)
    2 * _h * ν^3 / _c0^2 / expm1(_h * ν / (_k * bb.temp)) # W / m^2 / Hz
end

# SI (meters, Kelvin)
function (bb::Blackbody)(::IsWavelength, λ)
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

julia> blackbody(u"erg/s/cm^2/nm", 600u"nm", 5850u"K")
2.5836166476179734e7 erg nm⁻¹ cm⁻² s⁻¹
```

# See also
[`Blackbody`](@ref)
"""
blackbody(x, T) = Blackbody(T)(x)
blackbody(OT, x, T) = Blackbody(T)(OT, x)

"""
    blackbody([OT], EType, x, T)

Evaluate a blackbody at `x`, which is either Hertz, if `EType isa IsFrequency`, or meters, if `EType isa IsWavelength`. If `OT` is given, the output will be converted to that type, which is convenient for unit conversions. Temperature is assumed to be Kelvin.

# Examples

```jldoctest
julia> using EnergyTraits

julia> blackbody(IsWavelength(), 6e-7, 5850) # W m⁻¹ m⁻²
2.583616647617973e13

julia> blackbody(IsFrequency(), 5e14, 5850) # W Hz⁻¹ m⁻²
3.099976184463854e-8

julia> blackbody(u"erg/s/cm^2/nm", 600u"nm", 5850u"K")
2.5836166476179734e7 erg nm⁻¹ cm⁻² s⁻¹
```

# See also
[`Blackbody`](@ref)
"""
blackbody(ET::EnergyType, x, T) = Blackbody(T)(ET, x)
blackbody(OT, ET::EnergyType, x, T) = Blackbody(T)(OT, ET, x)

end
