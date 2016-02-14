cmake_minimum_required (VERSION 3.1)
project (YAAGC)

set (yaAGC_SOURCES main.c
                   agc_cli.c
                   agc_simulator.c
                   agc_debugger.c
                   agc_gdbmi.c
                   agc_disassembler.c
                   agc_help.c
                   nbfgets.c
                   agc_symtab.c
                   NormalizeSourceName.c
                   checkdec.c)
set (yaAGC_LIBSOURCES agc_engine_init.c
                      agc_engine.c
                      agc_utilities.c
                      rfopen.c
                      Backtrace.c
                      SocketAPI.c
                      DecodeDigitalDownlink.c)
add_library(libyaAGC_static STATIC ${yaAGC_LIBSOURCES})
target_compile_definitions(libyaAGC_static PUBLIC -DGDBMI)
add_executable(yaAGC ${yaAGC_SOURCES})
target_link_libraries(yaAGC libyaAGC_static)
target_compile_definitions(yaAGC PRIVATE -DNVER=\"Walt\")
