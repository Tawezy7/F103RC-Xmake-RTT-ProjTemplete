toolchain("arm-none-eabi")
    set_kind("standalone")
    set_sdkdir("D:/Env/gcc-arm-none-eabi-10.3-2021.10")
toolchain_end()

includes("rt-thread")

target("main")
    add_files(
        "./Application/*.c"
    )
    add_includedirs(
        "./Application/include"
    )
target_end()

target("main")
    set_kind("binary")
    set_toolchains("arm-none-eabi")
    add_files(
		"./Core/Src/*.c",
        --"./Core/Src/*.cpp",
        "./startup_stm32f103xe.s",
        "./Drivers/STM32F1xx_HAL_Driver/Src/*.c"
        )
    add_includedirs(
        "./Core/Inc",
        "./Drivers/CMSIS/Include",
        "./Drivers/CMSIS/Device/ST/STM32F1xx/Include",
        "./Drivers/STM32F1xx_HAL_Driver/Inc",
        "./Drivers/STM32F1xx_HAL_Driver/Inc/Legacy"
        )
    add_defines(
        "USE_HAL_DRIVER",
        "STM32F103xE"
    )
    
    add_cxflags(
        "-Og",
        "-mcpu=cortex-m3",
        "-mthumb",
        "-Wall -fdata-sections -ffunction-sections",
        "-g -gdwarf-2",{force = true}
        )

    add_asflags(
        "-Og",
        "-mcpu=cortex-m3",
        "-mthumb",
        "-x assembler-with-cpp",
        "-Wall -fdata-sections -ffunction-sections",
        "-g -gdwarf-2",{force = true}
        )

    add_ldflags(
        "-Og",
        "-mcpu=cortex-m3",
        "-mthumb",
        "-L./",
        "-specs=nano.specs",
        "-specs=nosys.specs",
        "-TSTM32F103RCTx_FLASH.ld",
        "-Wl,--gc-sections",
        "-lc -lm -lnosys",{force = true}
        )

    remove_files("Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_timebase_rtc_alarm_template.c")
    remove_files("Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_timebase_tim_template.c")
    remove_files("Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_msp_template.c")

    set_targetdir("build")
    set_filename("output.elf")

    after_build(function()
        os.exec("arm-none-eabi-objcopy -O ihex ./build//output.elf ./build//output.hex")
        os.exec("arm-none-eabi-objcopy -O binary ./build//output.elf ./build//output.bin")
        os.exec("arm-none-eabi-size --format=berkeley ./build/output.elf")
    end)
target_end()
