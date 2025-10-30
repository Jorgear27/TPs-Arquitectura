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

## 🧩 Trabajos Prácticos – Arquitectura de Computadoras

### 🧠 TP1 – Unidad Aritmético-Lógica (ALU)

#### 📋 Descripción General

En este primer trabajo se implementó una ALU modular, con capacidad para ejecutar diversas operaciones aritméticas y lógicas sobre operandos de tamaño parametrizable.
El diseño se organizó en distintos módulos Verilog para favorecer la modularidad, la reutilización de componentes y una mejor comprensión del hardware.

#### 🧩 Estructura de Módulos

* **`data_module.v`** → Define los operandos de entrada y el código de operación (opcode).
* **`alu.v`** → Implementa la lógica combinacional de la ALU, incluyendo las operaciones y señales de estado.
* **`top_module.v`** → Módulo superior que instancia los módulos anteriores e interconecta las señales.

#### ⚙️ Operaciones Soportadas

| Opcode | Operación | Descripción                         |
| :----: | :-------- | :---------------------------------- |
| 100000 | SUMA      | A + B                               |
| 100010 | RESTA     | A - B                               |
| 100100 | AND       | A & B                               |
| 100101 | OR        | A | B                               |
| 100110 | XOR       | A ^ B                               |
| 000011 | SRA       | Desplazamiento aritmético a derecha |
| 000010 | SRL       | Desplazamiento lógico a derecha     |
| 100111 | NOR       | NOT(A | B)                          |

#### ⚙️ Parámetros y Señales

* **Tamaño de operando:** parametrizable (por defecto 8 bits).
* **Opcode:** 6 bits.
* **Salidas:**

  * Resultado de la operación.
  * Señales de estado:

    * `zero` → Indica resultado nulo.
    * `carry_borrow` → Indica acarreo o bit prestado según la operación.

#### 🧪 Verificación y Pruebas

* **Simulación:** mediante `test_bench.v`, verificando todas las operaciones y funcionalidades.
* **Síntesis y validación:** el diseño fue sintetizado en la placa y verificado en hardware utilizando los switches y LEDs para operandos y resultados.

#### 🎯 Objetivo

Comprender la separación modular de un diseño digital, la implementación combinacional de operaciones aritméticas y lógicas, y la verificación por simulación y síntesis.

---

### 💡 TP2 – Control de ALU mediante UART y Máquinas de Estado

#### 📋 Descripción General

En el segundo trabajo se reutilizó la ALU del TP1, incorporando una interfaz UART para controlar sus operaciones desde un puerto serie.
El objetivo fue interactuar con la FPGA desde una PC, enviando operandos y código de operación, y recibiendo el resultado de vuelta.
El control del flujo de datos se realizó mediante una máquina de estados finitos (FSM) que coordina los módulos UART y la ALU.

#### 🧩 Estructura de Módulos Principales

| Archivo                    | Función                                                                                                 |
| -------------------------- | ------------------------------------------------------------------------------------------------------- |
| `uart_alu_top.v`           | Módulo superior que integra UART RX/TX, FSM de interfaz y ALU.                                          |
| `uart_rx.v`                | Receptor UART: captura bytes y genera señales de datos válidos.                                         |
| `uart_tx.v`                | Transmisor UART: envía bytes hacia la PC.                                                               |
| `baud_gen.v`               | Generador de baudios parametrizable (configurado a 9600 bps).                                           |
| `interface.v`              | Máquina de estados que coordina la recepción de datos, ejecución en la ALU y transmisión de resultados. |
| `alu.v`                    | Reutilizada del TP1.                                                                                  |
| `scripts/serial_script.py` | Script en Python para enviar/recibir datos por puerto serie.                                            |

#### 🔄 Flujo de Comunicación UART

La comunicación se realiza en paquetes de 3 bytes, enviados desde el PC hacia la FPGA:

1. **Byte 1:** Operando A
2. **Byte 2:** Operando B
3. **Byte 3:** Opcode

Una vez recibidos los tres bytes, la FSM de la interfaz carga los datos en la ALU, la cual ejecuta la operación, y envía de vuelta:

* 1 byte con el resultado.
* 1 byte adicional con las banderas (`zero`, `carry/borrow`).

#### 🧠 Máquinas de Estado

* **UART RX FSM:** controla la recepción bit a bit según el protocolo UART (inicio, datos, stop).
* **UART TX FSM:** administra el envío serializado del resultado.
* **Interfaz FSM:** secuencia principal que interactua con el receptor y transmisor UART y con la ALU:

  ```
  S_GET_A → S_GET_B → S_GET_OP → S_SEND_RESULT → S_WAIT_RESULT → S_SEND_FLAGS → S_WAIT_FLAGS
  ```

#### ⚙️ Parámetros Técnicos

* **Velocidad:** 9600 baudios
* **Formato de datos:** binario (8 bits por byte)
* **Conexión UART:** pines A18 (TX) y B18 (RX), vía USB-UART integrado

#### 🧪 Verificación

* **Simulación:** testbenches individuales para todos los módulos e integración final (`uart_alu_top`).
* **Hardware:** validado mediante conexión serial con la PC usando el script interactivo `serial_script.py`, confirmando la correcta ejecución de operaciones aritméticas y la recepción del resultado y las flags.

#### 🎯 Objetivo

Implementar un sistema digital con comunicación serie, que combine lógica secuencial (FSM), comunicación UART y procesamiento aritmético (ALU).
Se buscó reforzar conceptos de interfaz hardware/software, y control mediante máquinas de estado.

---

### 🛠️ TP3
En progreso.  

---

## ⚙️ Uso del Proyecto en Vivado

Para simular o sintetizar cualquier TP en **Vivado**:

1. Abrir Vivado y crear un **nuevo proyecto** (`File > Project > New`).  
2. Seleccionar el **board Basys3** (Artix-7 XC7A35T-1CPG236C).  
3. Importar los archivos fuente (`.v`), el archivo de constraints (`.xdc`) y opcionalmente los archivos de testbench (`.v`).  
4. Para **simulación**:
   - Ir a la vista *Simulation*.
   - Seleccionar archivo de testbench deseado.
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
