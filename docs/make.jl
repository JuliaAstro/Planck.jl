using Blackbody
using Documenter

DocMeta.setdocmeta!(Blackbody, :DocTestSetup, :(using Blackbody); recursive=true)

makedocs(;
    modules=[Blackbody],
    authors="Miles Lucas <mdlucas@hawaii.edu> and contributors",
    repo="https://github.com/JuliaAstro/Blackbody.jl/blob/{commit}{path}#{line}",
    sitename="Blackbody.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuliaAstro.github.io/Blackbody.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaAstro/Blackbody.jl",
    devbranch="main",
)
