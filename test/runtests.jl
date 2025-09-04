using TestItemRunner

@run_package_tests filter=ti -> occursin("Planck", ti.filename) verbose=true
