using Planck
using Documenter
using Documenter.Remotes: GitHub

doctest_setup = quote
    using Planck
    ENV["UNITFUL_FANCY_EXPONENTS"] = false
end
DocMeta.setdocmeta!(Planck, :DocTestSetup, doctest_setup; recursive=true)

makedocs(;
    modules=[Planck],
    authors="Miles Lucas <mdlucas@hawaii.edu> and contributors",
    repo=GitHub("JuliaAstro/Planck.jl"),
    sitename="Planck.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuliaAstro.github.io/Planck.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaAstro/Planck.jl",
    devbranch="main",
    push_preview=true,
)
