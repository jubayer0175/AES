

//Version 2.0--By Jubayer,09/08/2018

module controller (clk, rst, aes_en, uart_txd, uart_rxd);

input clk, rst;
input aes_en;
input uart_rxd;
output uart_txd;

// State machine states
localparam IDLE = 2'b00, RECEIVING = 2'b01, TRANSMITTING = 2'b10;

// AES
reg [127:0] aes_data_in;
wire [127:0] aes_data_out;
reg aes_input_data_valid;
wire aes_output_data_valid;
reg [127:0] aes_temp_out;

// UART
reg [7:0] uart_tx_data;
reg uart_tx_data_valid;
wire uart_tx_data_ack;
wire uart_txd, uart_rxd;
wire [7:0] uart_rx_data;
wire uart_rx_data_fresh;

// State machine
reg [1:0] state, next_state;
reg [4:0] uart_byte_counter;

uart u (.clk(clk),
		.rst(rst),
		.tx_data(uart_tx_data),
		.tx_data_valid(uart_tx_data_valid),
		.tx_data_ack(uart_tx_data_ack),
		.txd(uart_txd),
		.rx_data(uart_rx_data),
		.rx_data_fresh(uart_rx_data_fresh),
		.rxd(uart_rxd));

defparam u .CLK_HZ = 100_000_000;
defparam u .BAUD = 115200;

AES aes (.clk(clk),
		 .rst(rst),
		 .en(aes_en),
		 .Din_valid(aes_input_data_valid),
		 .Dout_valid(aes_output_data_valid),
		 .Din(aes_data_in),
		 .Dout(aes_data_out));

always @(posedge clk or posedge rst)
begin
	if (rst) begin
		uart_byte_counter <= 5'b00000;
		state <= IDLE;
		next_state <= IDLE;
		uart_tx_data <= 8'h00;
		uart_tx_data_valid <= 1'b0;
		aes_input_data_valid <= 1'b0;
		aes_data_in<=127'd0;
	end
	else begin
		state = next_state;
		case(state)
			IDLE: begin
				aes_input_data_valid <= 1'b0;
				uart_byte_counter <= 5'b00000;
				if (uart_rx_data_fresh == 1'b1) begin
					next_state <= RECEIVING;
					
					aes_data_in[7:0]<=uart_rx_data;
					uart_byte_counter <= 1;
					
				end
				else if (aes_output_data_valid == 1'b1) begin
					next_state <= TRANSMITTING;
					aes_temp_out <= aes_data_out;
				end
				else begin
					next_state <= IDLE;
				end
			end
			RECEIVING: begin
				if (uart_byte_counter <= 4'hF)begin
					next_state <= RECEIVING;
					if (uart_rx_data_fresh == 1'b1) begin
						uart_byte_counter = uart_byte_counter + 1'b1;
						aes_data_in = (aes_data_in << 4'h8) | uart_rx_data;
						// this block makes the thing of "enter"
					                  if(uart_rx_data==8'h0D) begin
					                 
                                      next_state <= IDLE;
                                      aes_input_data_valid <= 1'b1;
                                      end	
						
					end
				end
				
				
				else  begin
                    next_state <= IDLE;
                    aes_input_data_valid <= 1'b1;
                    end
                    
                    
				 
				
				
			end
			TRANSMITTING: begin
			
				if (uart_byte_counter <= 4'hF) begin
					next_state <= TRANSMITTING;
					if (uart_tx_data_ack == 1'b1) begin
						uart_tx_data_valid <= 1'b0;
						uart_byte_counter <= uart_byte_counter + 1'b1;
					end
					else if (uart_tx_data_valid == 1'b0) begin
					    aes_temp_out = {aes_temp_out[119:0], aes_temp_out[127:120]};
					    uart_tx_data = aes_temp_out[7:0]; // this is not updating in the same clock. so i removed the non blocking
					    //part
						uart_tx_data_valid <= 1'b1;
					end
				end
				else begin
					next_state <= IDLE;
					aes_data_in<=128'd0;// new
					
				end
			end
		endcase
	end
end

endmodule
