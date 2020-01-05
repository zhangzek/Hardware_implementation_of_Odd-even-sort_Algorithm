/*compare big and small module using only combinatorial logic*/

module sort2 #(
	parameter DATAWIDTH = 8
)
(
   input  [ DATAWIDTH - 1 : 0 ] a,  //input data1
   input  [ DATAWIDTH - 1 : 0 ] b,  //input data2
   output [ DATAWIDTH - 1 : 0 ] big,//big
   output [ DATAWIDTH - 1 : 0 ] sme //small
  );

wire a_is_bigger;

   assign a_is_bigger = a>b;
   assign big= a_is_bigger ? a : b;
   assign sme= a_is_bigger ? b : a;
   
   //also:
   // assign {big,sme} = a>b ? {a,b} : {b,a};

endmodule   
   
   