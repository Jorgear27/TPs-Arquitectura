# Arquitectura de Computadoras - Trabajos Prácticos

Este repositorio contiene los **Trabajos Prácticos (TPs)** de la materia **Arquitectura de Computadoras**, realizados en **Verilog** e implementados con la placa **FPGA Basys3 (Artix-7)**.  

El objetivo es implementar diferentes diseños digitales, partiendo de una **ALU** básica hasta llegar a proyectos más complejos como **máquinas de estado** y otros sistemas secuenciales.

---

## 📂 Estructura del Repositorio

Cada TP tiene su propia carpeta con los módulos correspondientes:


Dentro de cada carpeta se incluyen:
- **Código fuente** en Verilog (`.v`).
- **Testbench** en Verilog (`.v`)
- **Constraints** de pines (`.xdc`) para la Basys3.
- **Informes** o reportes relevantes.
- Archivos de proyecto de Vivado (`.xpr`) están ignorados en el repositorio.

---

## 🧩 Trabajos Prácticos

### TP1 - ALU
Se implementó una **Unidad Aritmética-Lógica (ALU)** simple, organizada en tres módulos principales:

- `data_module.v` → Define la entrada de datos (operandos y opcode a utilizar).  
- `alu.v` → Contiene la lógica de operaciones (suma, resta, AND, OR, etc.).  
- `top_module.v` → Módulo global que integra la ALU y los datos.  

**Objetivo**: Comprender la separación modular de un diseño digital y la interacción entre módulos.

---

### TP2 - Máquinas de Estado y Control por UART
Se implementó una interfaz UART que permite controlar la ALU (reutilizada desde TP1) por puerto serie. El diseño incluye un receptor y transmisor UART, un generador de baudios y la lógica de interfaz (máquina de estados) que parsea comandos, invoca la ALU y devuelve resultados por UART.

**Archivos principales (TP2):**
- `uart_alu_top.v`  → Módulo top que integra UART, la interfaz FSM y la ALU.  
- `uart_rx.v`       → Receptor UART (parsing de bytes).  
- `uart_tx.v`       → Transmisor UART (envío de respuestas).  
- `baud_gen.v`      → Generador de baudios (configurable).  
- `interface.v`     → Lógica de control / máquina de estados que interpreta comandos y conecta con la ALU.  
- `alu.v`           → ALU reutilizada/adaptada desde TP1.
- `scripts/serial_script.py` → Script Python de ejemplo para interactuar por UART con la FPGA (envía operandos/opcode y muestra resultado).

**Objetivo:**
Permitir enviar comandos desde un terminal serie (por ejemplo PuTTY o mediante un script) hacia la FPGA para:
- Seleccionar la operación de la ALU y enviar operandos.
- Ejecutar la operación en la ALU dentro de la FPGA.
- Recibir el resultado por UART (y/o visualizarlo en recursos del tablero según constraints).

---

### TP3
En progreso.  

---

## ⚙️ Uso del Proyecto en Vivado

Para simular o sintetizar cualquier TP en **Vivado**:

1. Abrir Vivado y crear un **nuevo proyecto** (`File > Project > New`).  
2. Seleccionar el **board Basys3** (Artix-7 XC7A35T-1CPG236C).  
3. Importar los archivos fuente (`.v`), el archivo de constraints (`.xdc`) y opcionalmente el archivo de testbench (`.v`).  
4. Para **simulación**:
   - Ir a la vista *Simulation*.  
   - Ejecutar `Run Simulation > Run Behavioral Simulation`.  
5. Para **síntesis e implementación**:
   - Click en `Run Synthesis`.  
   - Luego `Run Implementation`.  
   - Finalmente, generar el bitstream (`Generate Bitstream`).  
6. Programar la FPGA con `Open Hardware Manager` → `Program Device`.

---

## 🛠️ Requisitos

- [Xilinx Vivado Design Suite](https://www.xilinx.com/support/download.html)  
- FPGA **Basys3 (Artix-7)**  

---

## 📌 Notas

- Los archivos de compilación automática de Vivado (`.cache`, `.runs`, `.sim`, etc.) no se incluyen en este repositorio.  
- Cada TP está documentado en su propia carpeta.  
- Este repositorio se irá actualizando a medida que avancemos con los TPs de la materia.  

---
