using Planck
using Documenter

DocMeta.setdocmeta!(Planck, :DocTestSetup, :(using Planck); recursive=true)

makedocs(;
    modules=[Planck],
    authors="Miles Lucas <mdlucas@hawaii.edu> and contributors",
    repo="https://github.com/JuliaAstro/Planck.jl/blob/{commit}{path}#{line}",
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
)
