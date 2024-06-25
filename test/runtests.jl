using Planck
using Test
using Unitful

@testset "Planck.jl" begin
    @testset "Consistent unit conversions" begin
        @test ustrip(u"W/m^3", blackbody(545u"nm", 6000u"K")) ≈ blackbody(545e-9, 6000)
        @test ustrip(u"W/m^2/Hz", blackbody(500u"THz", 6000u"K")) ≈ 3.441e-8 rtol=1e-3
    end
    @testset "Known temperatures" begin
        @test blackbody(545e-9, 6000) ≈ 3.079e13 rtol=1e-3
        @test blackbody(Float32, 545e-9, 6000) ≈ 3.079f13 rtol=1f-3

        @test blackbody(545u"nm", 6000u"K") ≈ 3.079e13u"W/m^3" rtol=1e-3
        @test blackbody(500u"THz", 6000u"K") ≈ 3.441e-8u"W/m^2/Hz" rtol=1e-3
    end
end
