module PlanckDynamicQuantitiesExt
    import Planck

    using DynamicQuantities: UnionAbstractQuantity, Dimensions, dimension, uexpand
    using DynamicQuantities.Constants: h, c, k_B

    using TestItemRunner: @testitem

    isfreq(q::UnionAbstractQuantity) = (dimension ∘ uexpand)(q) == Dimensions(time=-1)
    islength(q::UnionAbstractQuantity) = (dimension ∘ uexpand)(q) == Dimensions(length=1)

    function Planck.blackbody(q::UnionAbstractQuantity, T)
        if isfreq(q)
            return 2 * h * q^3 / c^2 / expm1(h * q / (k_B * T))
        end
        if islength(q)
            return 2 * h * c^2 / q^5 / expm1(h * c / (q * k_B * T))
        end
    end

    @testitem "Consistent unit conversions" begin
        using Planck, DynamicQuantities

        @test (ustrip ∘ blackbody)(545us"nm", 6000u"K") ≈ blackbody(545e-9, 6000)
        @test (ustrip ∘ blackbody)(500_000us"GHz", 6000u"K") ≈ 3.441e-8 rtol=1e-3
    end

    @testitem "Known temperatures" begin
        using Planck, DynamicQuantities

        @test blackbody(545us"nm", 6000u"K") ≈ 3.079e13u"W/m^3" rtol=1e-3
        @test blackbody(500_000u"GHz", 6000u"K") ≈ 3.441e-8u"W/m^2/Hz" rtol=1e-3
    end
end # end
