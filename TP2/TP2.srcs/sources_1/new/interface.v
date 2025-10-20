`timescale 1ns / 1ps
module interface (
    input wire clk,
    input wire rst,
    // UART RX interface
    input wire rx_done,
    input wire [7:0] rx_data,
    // UART TX interface
    output reg tx_start,
    output reg [7:0] tx_data,
    input wire tx_done,
    // ALU interface
    output reg [7:0] alu_a,
    output reg [7:0] alu_b,
    output reg [5:0] alu_opcode,
    input wire [7:0] alu_result,
    input wire alu_carry,
    input wire alu_zero
);

    // FSM States
    localparam [2:0] 
        S_GET_A = 0,
        S_GET_B = 1,
        S_GET_OP = 2,
        S_SEND_RESULT = 3,
        S_WAIT_RESULT = 4,
        S_SEND_FLAGS = 5,
        S_WAIT_FLAGS = 6;
    
    reg [2:0] state;
    
    always @(posedge clk) begin
        if (rst) begin
            state <= S_GET_A;
            tx_start <= 1'b0;
            tx_data <= 8'b0;
            alu_a <= 8'b0;
            alu_b <= 8'b0;
            alu_opcode <= 6'b0;
        end else begin
            // Default: tx_start only pulses for one cycle
            tx_start <= 1'b0;
            
            case (state)
                S_GET_A: begin
                    if (rx_done) begin
                        alu_a <= rx_data;
                        state <= S_GET_B;
                    end
                end
                
                S_GET_B: begin
                    if (rx_done) begin
                        alu_b <= rx_data;
                        state <= S_GET_OP;
                    end
                end
                
                S_GET_OP: begin
                    if (rx_done) begin
                        alu_opcode <= rx_data[5:0];
                        // Since ALU is combinational, prepare to send result
                        state <= S_SEND_RESULT;
                    end
                end
                
                S_SEND_RESULT: begin
                    tx_data <= alu_result;
                    tx_start <= 1'b1;
                    state <= S_WAIT_RESULT;
                end
                
                S_WAIT_RESULT: begin
                    if (tx_done) begin
                        state <= S_SEND_FLAGS;
                    end
                end
                
                S_SEND_FLAGS: begin
                    tx_data <= {6'b000000, alu_carry, alu_zero};
                    tx_start <= 1'b1;
                    state <= S_WAIT_FLAGS;
                end
                
                S_WAIT_FLAGS: begin
                    if (tx_done) begin
                        state <= S_GET_A;
                    end
                end
                
                default:
                    state <= S_GET_A;
            endcase
        end
    end

endmodule
