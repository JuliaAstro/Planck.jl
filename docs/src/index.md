```@meta
CurrentModule = Planck
```

# Planck.jl

[![Code](https://img.shields.io/badge/Code-GitHub-black.svg)](https://github.com/JuliaAstro/Planck.jl)
[![Build Status](https://github.com/JuliaAstro/Planck.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/JuliaAstro/Planck.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![PkgEval](https://juliaci.github.io/NanosoldierReports/pkgeval_badges/B/Planck.svg)](https://juliaci.github.io/NanosoldierReports/pkgeval_badges/report.html)
[![Coverage](https://codecov.io/gh/JuliaAstro/Planck.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/JuliaAstro/Planck.jl)
[![License](https://img.shields.io/github/license/JuliaAstro/Planck.jl?color=yellow)](https://github.com/JuliaAstro/Planck.jl/blob/main/LICENSE)

Planck radiation curves, with support for Unitful.jl.

## Installation

Planck.jl has not yet been added to the Julia general repository and cannot be
installed using by using default options on Julia's built-in package manager `Pkg`.
To install from the development repository, you can supply the URL of the
repository to `]add` like so:
```julia-repl
julia> ] # pressing ']' should drop you into pkg mode

pkg> add https://github.com/JuliaAstro/Planck.jl
```
Or using `Pkg.add(url=...)` from the main REPL like so:
```julia-repl
julia> import Pkg; Pkg.add(url="https://github.com/JuliaAstro/Planck.jl")
```

## Usage

## API/Reference

```@index
```

```@autodocs
Modules = [Planck]
```

## Contributing and Support

If you would like to contribute, feel free to open a [pull request](https://github.com/JuliaAstro/Planck.jl/pulls). If you want to discuss something before contributing, head over to [discussions](https://github.com/JuliaAstro/Planck.jl/discussions) and join or open a new topic. If you're having problems with something, please open an [issue](https://github.com/JuliaAstro/Planck.jl/issues).
