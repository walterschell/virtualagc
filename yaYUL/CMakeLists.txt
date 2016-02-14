cmake_minimum_required (VERSION 3.1)
project (YAYUL)

file (GLOB yaYUL_SOURCES *.c)
add_executable(yaYUL ${yaYUL_SOURCES})
target_compile_definitions(yaYUL PRIVATE -DNVER=\"Walt\")
