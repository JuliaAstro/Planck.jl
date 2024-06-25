using Planck
using Documenter
using Documenter.Remotes: GitHub

DocMeta.setdocmeta!(Planck, :DocTestSetup, :(using Planck); recursive=true)

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
)
