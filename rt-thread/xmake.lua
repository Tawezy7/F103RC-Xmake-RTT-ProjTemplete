target("main")
    add_files(
        "./libcpu/arm/cortex-m3/context_gcc.S",
        "./libcpu/arm/cortex-m3/*.c",
        "./src/*c",
        "./port/board.c"
    )
    add_includedirs(
        "./",
        "./include",
        "./port"
    )
    add_asflags(
        "-Xassembler -mimplicit-it=thumb"
    )
target_end()

--finsh
target("main")
    add_files(
    "./components/finsh/*.c"
    )
    add_includedirs(
    "./components/finsh"
    )
target_end()