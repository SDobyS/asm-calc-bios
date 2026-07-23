# ASM Calculator BIOS

<p align="center">

<img src="https://img.shields.io/badge/Assembly-x86-blue">
<img src="https://img.shields.io/badge/NASM-2.x-success">
<img src="https://img.shields.io/badge/16--bit-Real%20Mode-orange">
<img src="https://img.shields.io/badge/BIOS-INT%2010h%20%7C%20INT%2016h-red">
<img src="https://img.shields.io/badge/Bootloader-custom-black">
<img src="https://img.shields.io/badge/License-MIT-yellow">

</p>

🇬🇧 English | 🇷🇺 [Русский](README_RU.md)

A simple calculator written in 16-bit x86 Assembly running directly on BIOS.

The project contains a custom bootloader and a small kernel that performs arithmetic operations without using any operating system.

## Features

- Integer addition
- Integer subtraction
- Integer multiplication
- Integer division
- Signed 16-bit integer support
- Colored VGA text output
- Input validation
- Backspace support
- Overflow detection
- Division-by-zero handling
- Invalid operation handling
- Custom bootloader
- Modular kernel structure
- BIOS keyboard input
- BIOS text output
- 16-bit Real Mode
- NASM syntax

## Requirements

- NASM
- QEMU
- x86 emulator or real hardware with BIOS support

## Build

```bash
make
```

Manual build:

```bash
nasm -f bin src/boot/boot.asm -o bin/boot.bin
nasm -f bin src/kernel/main.asm -o bin/kernel.bin
```

Create disk image:

```bash
cat bin/boot.bin bin/kernel.bin > bin/disk.img
```

## Run

Using QEMU:

```bash
qemu-system-i386 -drive format=raw,file=bin/disk.img
```

## Example

<p align="center">
  <img src="docs/example.png" width="800">
</p>

## How it works

The calculator starts from a custom bootloader and runs in 16-bit Real Mode.

No operating system is required.

The project uses BIOS interrupts:

- `INT 10h (0x10)` — video services for text output
- `INT 16h (0x16)` — keyboard input

The kernel implements:

- string input
- string-to-integer conversion
- integer-to-string conversion
- arithmetic operations
- result printing

## Limitations

- Supports only signed 16-bit integers (-32768..32767)
- BIOS systems only
- Floating-point arithmetic is not supported

## Project Structure

```text
.
├── src/
│   ├── boot/
│   │   └── boot.asm
│   └── kernel/
│       ├── color.asm
│       ├── data.asm
│       ├── io.asm
│       ├── math.asm
│       └── main.asm
├── bin/
│   ├── boot.bin
│   ├── kernel.bin
│   └── disk.img
├── docs/
│   └── cat.gif
├── Makefile
├── LICENSE
├── README.md
└── README_RU.md
```

## Development

The kernel is loaded by the custom bootloader at address `0x7E00`.

The project is split into the following modules:

- `boot.asm` — bootloader
- `main.asm` — kernel entry point
- `io.asm` — keyboard input and text output
- `math.asm` — arithmetic and number conversion
- `color.asm` — VGA color management
- `data.asm` — strings, buffers and global variables

## About

This project is a low-level x86 Assembly experiment focused on BIOS programming and operating system independent execution.

The goal was to practice:

- 16-bit x86 Assembly
- BIOS interrupts
- Real Mode programming
- Bootloader development
- Low-level input/output
- Memory layout and binary loading

## Completed

- [x] Calculator on libc (System V ABI) - 🔗 *[asm-calc-libc](https://github.com/SDobyS/asm-calc-libc)*
- [x] Calculator using raw syscalls (no libc) - 🔗 *[asm-calc-syscall](https://github.com/SDobyS/asm-calc-syscall)*
- [x] 16-bit BIOS calculator with custom bootloader - 🔗 *[asm-calc-bios](https://github.com/SDobyS/asm-calc-bios)*

## License

MIT

---

<p align="center">
  <img src="docs/cat.gif" width="800">
</p>