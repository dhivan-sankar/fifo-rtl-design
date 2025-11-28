module fifo_tb();
   //inputs
   reg clk,rst,write_en, read_en;
   reg [7:0] data_in;
   //outputs
   wire [7:0] data_out;
   wire empty;
   wire full;
   //Instantiate
   fifo DUT(clk,rst, write_en, read_en, data_in, data_out, empty, full);

   always #10 clk=-clk;

   task initialize;
      begin
         {clk,rst,write_en, read_en, data_in}=0;
      end
   endtask

   task reset;
      begin
         @(negedge clk) rst=1'b1;
         @(negedge clk) rst=1'b0;
      end
   endtask

   task write_data;
   input [7:0] data;
      begin
         write_en=1'b1;
	 @(negedge clk) data_in=data;
      end
   endtask

   task read_data;
      begin
         @(negedge clk) read_en = 1'b1 ;
      end
   endtask

   integer i;

   initial
      begin
         //Initialize Inputs
	 clk=0;
	 rst=0;
	 write_en = 0;
	 read_en = 0;
	 data_in=0;
	 initialize;
	 reset;
	 for(i=0;i<16;i=i+1)
	   begin
	      write_data(($random)%256);
 	   end
	   repeat(10)
           @(negedge clk);
	   read_data;
	end

endmodule







