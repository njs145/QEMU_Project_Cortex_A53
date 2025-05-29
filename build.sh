#!/bin/bash
set -e
mkdir -p build

# Compile
armclang -target=aarch64-arm-none-eabi -mcpu=cortex-a53 -c -g -O0 -Wall -ffreestanding startup.S -o build/startup.o
armclang -target=aarch64-arm-none-eabi -mcpu=cortex-a53 -c -g -O0 -Wall -ffreestanding main.c -o build/main.o

# Link
ld.lld -T linker.ld -nostdlib -o build/app.elf build/startup.o build/main.o

# Convert to raw binary
llvm-objcopy -O binary build/app.elf build/app.bin

# Convert to raw binary
llvm-objdump -d -C build/app.elf > build/app.s