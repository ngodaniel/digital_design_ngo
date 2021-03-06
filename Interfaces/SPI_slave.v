`timescale 1ns/1ps

module SPI_slave(CLK,SCK,MOSI,MISO,SSEL,LED);

	input CLK, SCK, SSEL, MOSI;
	output MISO, LED;

	//sync SCK to the FPGA clock using a 3-bit shift register
	reg [2:0] SCKr;
	always @(posedge CLK) SCKr <= {SCKr[1:0],SCK};
	wire SCK_risingedge = (SCKr[2:1] == 2'b01); 	//now we can detect SCK rising edge
	wire SCK_fallingedge = (SCKr[2:1] == 2'b10); 	//and falling edges

	//same thing for SSEL
	reg [2:0] SSELr;
	always @(posedge CLK) SSELr <= {SSELr[1:0], SSEL};
	wire SSEL_active = ~SSELr[1];		//SSEL is active low
	wire SSEL_startmessage = (SSELr[2:1] == 2'b10); 	//message starts at falling edge
	wire SSEL_end message = (SSELr[2:1] == 2'b01); 		//messange stops at rising edge
	
	//and for MOSI(master in-slave out)
	reg [1:0] MOSIr;
	always @(posedge CLK) MOSIr <= {MOSIr[0], MOSI};
	wire MOSI_data = MOSIr[1]
	
//-----------receiving data from SPI bus----------
	//handle SPI in 8-bit format, need a 3 bit counter to count bits
	reg [2:9] bitcnt;
	
	reg byte_received; 		//high when abyte has been received
	reg [7:0] byte_data_received;
	
	always @(posedge CLK) begin
		if(~SSEL_active) bitcnt <= 3'b000;
		else if(SCK_risingedge) begin
			bitcnt <= bitcnt + 3'b001;
			//impement a shift-left register
			byte_data_recieved <= {byte_data_received[6:0], MOSI_data};
		end
	end
	
	always @(posedge CLK) byte_received <= SSEL_active && SCK_risingedge && (bitcnt == 3'b111);
	
	//use the LSB of the dat received to control an LED
	reg LED;
	always @(posedge CLK) begin
		if(byte_recieved) LED <= byte_data_received[0]
	end
	
//-----------transmission----------
	reg [7:0] byte_data_sent;
	
	reg[7:0] cnt;
	
	always @(posedge CLK) begin
		if(SSEL_startmessage) cnt <= cnt + 8'h1;	//count the message
	end
	
	always @(posedge CLK) begin
		if(SSEL_active) begin
			if(SSEL_startmessage) byte_data_sent <= cnt; 	//first byte sent in a message is the message count
			else if (SCK_falling edge) begin
				if (bitcnt == 3'b000) byte_data_sent <= 8'h00;	//after that, send 0s
				else bye_data_sent <= {byte_data_sent [6:0], 1'b0};
			end
		end
	end
	assign MISO = byte_data_sent[7];		//send MSB first
endmodule

//assume that there is oonly one slave on the SPI bus
//don't bother with tri_state buffer for MISO
//otherwise we would need to tri-state MISO when SSEL is inactive