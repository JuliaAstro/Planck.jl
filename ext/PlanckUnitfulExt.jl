module PlanckUnitfulExt
    import Planck

    using Unitful: AbstractQuantity
    using Unitful: 𝐋, 𝐓
    using Unitful: h, c0, k

    using TestItemRunner: @testitem

    function Planck.blackbody(ν::AbstractQuantity{V,inv(𝐓)}, T) where V
        2 * h * ν^3 / c0^2 / expm1(h * ν / (k * T))
    end

    function Planck.blackbody(λ::AbstractQuantity{V,𝐋}, T) where V
        2 * h * c0^2 / λ^5 / expm1(h * c0 / (λ * k * T))
    end

    @testitem "Consistent unit conversions" begin
        using Planck, Unitful

        @test ustrip(u"W/m^3", blackbody(545u"nm", 6000u"K")) ≈ blackbody(545e-9, 6000)
        @test ustrip(u"W/m^2/Hz", blackbody(500u"THz", 6000u"K")) ≈ 3.441e-8 rtol=1e-3
    end

    @testitem "Known temperatures" begin
        using Planck, Unitful

        @test blackbody(545u"nm", 6000u"K") ≈ 3.079e13u"W/m^3" rtol=1e-3
        @test blackbody(500u"THz", 6000u"K") ≈ 3.441e-8u"W/m^2/Hz" rtol=1e-3
    end
end # end
