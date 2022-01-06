using EnergyTraits
using Planck
using Test
using Unitful

@testset "Planck.jl" begin
    @testset "Consistent unit conversions" begin
        @test ustrip(u"W/m^3", blackbody(545u"nm", 5002u"K")) ≈ blackbody(545e-9, 5002)
        @test ustrip(u"W/m^2/Hz", blackbody(500u"THz", 5002u"K")) ≈ blackbody(IsFrequency(), 5e14, 5002)
    end
    @testset "struct interface" begin
        bb = Blackbody(6000)
        @test bb(545e-9) ≈ 3.079e13 rtol=1e-3
        @test bb(Float32, 545e-9) ≈ 3.079f13 rtol=1f-3
        @test bb(IsFrequency(), 5e14) ≈ 3.441e-8 rtol=1e-3
        @test bb(Float32, IsFrequency(), 5e14) ≈ 3.441f-8 rtol=1f-3


        qbb = Blackbody(6000u"K")
        @test qbb(545u"nm") ≈ 3.079e13u"W/m^3" rtol=1e-3
        @test qbb(500u"THz") ≈ 3.441e-8u"W/m^2/Hz" rtol=1e-3
    end
end
