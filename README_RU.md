# ASM Calculator BIOS

<p align="center">

<img src="https://img.shields.io/badge/Assembly-x86-blue">
<img src="https://img.shields.io/badge/NASM-2.x-success">
<img src="https://img.shields.io/badge/16--bit-Real%20Mode-orange">
<img src="https://img.shields.io/badge/BIOS-INT%2010h%20%7C%20INT%2016h-red">
<img src="https://img.shields.io/badge/Bootloader-custom-black">
<img src="https://img.shields.io/badge/License-MIT-yellow">

</p>

🇷🇺 Русский | 🇬🇧 [English](README.md)

Простой калькулятор на 16-битном x86 Assembly, работающий напрямую через BIOS.

Проект содержит собственный bootloader и небольшой kernel, который выполняет арифметические операции без использования операционной системы.

## Возможности

- Сложение целых чисел
- Вычитание целых чисел
- Умножение целых чисел
- Деление целых чисел
- Поддержка знаковых 16-битных чисел
- Цветной вывод через VGA
- Проверка корректности ввода
- Поддержка клавиши Backspace
- Проверка переполнения
- Обработка деления на ноль
- Обработка неверной операции
- Собственный загрузчик (Bootloader)
- Модульная структура ядра
- Ввод с клавиатуры через BIOS
- Текстовый вывод через BIOS
- 16-битный Real Mode
- Синтаксис NASM

## Требования

- NASM
- QEMU
- x86 эмулятор или реальное устройство с поддержкой BIOS

## Сборка

```bash
make
```

Ручная сборка:

```bash
nasm -f bin src/boot/boot.asm -o bin/boot.bin
nasm -f bin src/kernel/main.asm -o bin/kernel.bin
```

Создание образа диска:

```bash
cat bin/boot.bin bin/kernel.bin > bin/disk.img
```

## Запуск

Через QEMU:

```bash
qemu-system-i386 -drive format=raw,file=bin/disk.img
```

## Пример

<p align="center">
  <img src="docs/example.png" width="800">
</p>

## Как это работает

Калькулятор запускается через собственный bootloader и работает в 16-битном Real Mode.

Операционная система не требуется.

Проект использует BIOS-прерывания:

- `INT 10h (0x10)` ─ видеосервисы для вывода текста
- `INT 16h (0x16)` ─ ввод с клавиатуры

Kernel реализует:

- ввод строки
- преобразование строки в число
- преобразование числа в строку
- арифметические операции
- вывод результата

## Ограничения

- Поддерживаются только знаковые 16-битные числа (-32768..32767)
- Работает только на BIOS-совместимых системах
- Арифметика с плавающей точкой не поддерживается

## Структура проекта

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

## Разработка

Ядро загружается собственным загрузчиком по адресу `0x7E00`.

Проект разделён на следующие модули:

- `boot.asm` — загрузчик
- `main.asm` — точка входа ядра
- `io.asm` — ввод с клавиатуры и вывод текста
- `math.asm` — арифметика и преобразование чисел
- `color.asm` — управление цветами VGA
- `data.asm` — строки, буферы и глобальные переменные

## О проекте

Этот проект — низкоуровневый эксперимент на x86 Assembly, направленный на изучение программирования через BIOS и запуска программ без операционной системы.

Цель проекта:

- изучение 16-битного x86 Assembly
- работа с BIOS-прерываниями
- изучение Real Mode
- разработка собственного bootloader
- низкоуровневый ввод и вывод
- работа с памятью и загрузкой бинарных файлов

## Завершено

- [x] Калькулятор на libc (System V ABI) - 🔗 *[asm-calc-libc](https://github.com/SDobyS/asm-calc-libc)*
- [x] Калькулятор на чистых syscall (без libc) - 🔗 *[asm-calc-syscall](https://github.com/SDobyS/asm-calc-syscall)*
- [x] 16-битный BIOS калькулятор с собственным bootloader - 🔗 *[asm-calc-bios](https://github.com/SDobyS/asm-calc-bios)*

## Лицензия

MIT

---

<p align="center">
  <img src="docs/cat.gif" width="800">
</p>