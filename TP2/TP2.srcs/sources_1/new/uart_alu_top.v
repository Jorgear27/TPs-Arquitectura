`timescale 1ns / 1ps
module uart_alu_top (
    input wire clk,      // FPGA clock
    input wire rst,      // Reset
    input wire rx,       // UART RX line
    output wire tx       // UART TX line
);

    // Parameters
    parameter CLK_FREQ = 100_000_000;  // 100MHz
    parameter BAUD_RATE = 9600;        // 9600 baud
    parameter DATA_WIDTH = 8;          // 8 data bits
    parameter OP_WIDTH = 6;            // 6 bits for ALU operation code

    // Internal signals
    wire tick;                // Baud rate tick
    wire rx_done;             // RX complete signal
    wire [DATA_WIDTH-1:0] rx_data;  // Received data
    wire tx_start;            // TX start signal
    wire [DATA_WIDTH-1:0] tx_data;  // Data to transmit
    wire tx_done;             // TX complete signal
    
    wire [DATA_WIDTH-1:0] alu_a;    // ALU operand A
    wire [DATA_WIDTH-1:0] alu_b;    // ALU operand B
    wire [OP_WIDTH-1:0] alu_opcode; // ALU operation code
    wire [DATA_WIDTH-1:0] alu_result; // ALU result
    wire alu_carry, alu_zero;  // ALU flags
    
    // Instantiate the baud rate generator
    baud_gen #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE),
        .OVERSAMPLING(16)
    ) baud_gen_inst (
        .clk(clk),
        .rst(rst),
        .tick(tick)
    );
    
    // Instantiate the UART receiver
    uart_rx #(
        .DATA_BITS(DATA_WIDTH),
        .OVERSAMPLING(16)
    ) uart_rx_inst (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .tick(tick),
        .rx_done(rx_done),
        .data_out(rx_data)
    );
    
    // Instantiate the UART transmitter
    uart_tx #(
        .DATA_BITS(DATA_WIDTH),
        .OVERSAMPLING(16)
    ) uart_tx_inst (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .data_in(tx_data),
        .tick(tick),
        .tx(tx),
        .tx_done(tx_done)
    );
    
    // Instantiate the ALU
    alu #(
        .N_data(DATA_WIDTH),
        .N_op(OP_WIDTH)
    ) alu_inst (
        .A(alu_a),
        .B(alu_b),
        .OpCode(alu_opcode),
        .S(alu_result),
        .carry(alu_carry),
        .zero(alu_zero)
    );
    
    // Instantiate the interface controller
    interface interface_inst (
        .clk(clk),
        .rst(rst),
        // UART RX interface
        .rx_done(rx_done),
        .rx_data(rx_data),
        // UART TX interface
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx_done(tx_done),
        // ALU interface
        .alu_a(alu_a),
        .alu_b(alu_b),
        .alu_opcode(alu_opcode),
        .alu_result(alu_result),
        .alu_carry(alu_carry),
        .alu_zero(alu_zero)
    );

endmodule
