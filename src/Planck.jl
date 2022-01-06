module Planck

using EnergyTraits
using Unitful
using Unitful: AbstractQuantity
using Unitful: h, c0, k

export Blackbody, blackbody

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


blackbody(x::AbstractQuantity, T::AbstractQuantity) = Blackbody(T)(x)
blackbody(OT, x::AbstractQuantity, T::AbstractQuantity) = Blackbody(T)(OT, x)

end
