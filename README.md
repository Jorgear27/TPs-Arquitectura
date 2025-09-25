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

### TP2 - Máquinas de Estado
En progreso.  

**Objetivo**: Interactuar con la placa, prefereblemente con la ALU realizada en el TP1, por medio de **UART**. Se busca mandar por puerto serial algún comando a la ALU y que esta realize la operacion requerida, la devuelva y se pueda visualizar el resultado del procesamiento en pantalla.

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
