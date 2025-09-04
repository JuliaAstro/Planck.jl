module Planck

export blackbody

# constants in SI units
const _h = 6.62607015e-34
const _c0 = 299792458
const _k = 1.380649e-23

"""
    blackbody([OT], x, T)

Evaluate a blackbody[^1] at `x`, which is in meters by default. If `OT` is
given, the output will be converted to that type, which is convenient for unit
conversions. Temperature is assumed to be Kelvin.

# Arguments
- `OT`: units for intensity, defaulting to SI.
- `x`: color of light on which to get the intensity.
       `x` can be wavelength or frequency.
- `T`: temperature of the blackbody.

!!! warning "Units"

    If you do not use [Unitful.jl](https://github.com/PainterQubits/Unitful.jl),
    the defaults will be [SI](https://en.wikipedia.org/wiki/International_System_of_Units).

# Examples

```jldoctest
julia> using Unitful

julia> blackbody(6e-7, 5850)
2.583616647617974e13

julia> blackbody(Float32, 6e-7, 5850)
2.5836166f13

julia> blackbody(u"erg/s/cm^2/nm/sr", 600u"nm", 5850u"K")
2.5836166476179734e7 erg nm^-1 cm^-2 s^-1 sr^-1
```

# References
[^1]: [Blackbody radiation](https://en.wikipedia.org/wiki/Planck%27s_law)
"""
blackbody(OT, x, T) = OT(blackbody(x, T))


# SI (meters, Kelvin)
function blackbody(λ, T)
    2 * _h * _c0^2 / λ^5 / expm1(_h * _c0 / (λ * _k * T)) # W / m^3
end


end # end
