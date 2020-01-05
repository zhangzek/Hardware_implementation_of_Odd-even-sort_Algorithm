//********************************************************************//
//************* Verilog parallel Odd-Even sort network****************//
//********************************************************************//

//***************************information******************************//
// for DATAWIDTH wide data and N inputs.
// For this module N must be a power of two.
//
// Sorts N input signals of DATAWIDTH bits wide
// using only combinatorial logic.
//********************************************************************//

module sort_N#( 
    parameter DATAWIDTH = 8, // Data width
    parameter N = 16   // Number of entries: power of two
)
(
    input          CLK,
    input          RSTn,
    output [DATAWIDTH-1:0] max,
    output [DATAWIDTH-1:0] min
    //also can input data
);   

wire [DATAWIDTH-1:0] w    [0:N*(N+1)-1];
reg  [DATAWIDTH-1:0] RAM1 [0:N-1]; //input data memory
wire [DATAWIDTH-1:0] RAM2 [0:N-1]; //output data memory


//*******************initialization RAM*******************//
integer k;
always @(posedge CLK or negedge RSTn) 
begin
    if (!RSTn) 
        begin
            for (k = 0;k < N;k = k + 1)
                RAM1[k] <= 0;
        end
    else  
        begin
            for (k = 0;k < N;k = k + 1)
                RAM1[k] <= $random();//you can input data
                                      //use some random data
       end
end

//*******************compare generate**********************//
genvar c,r,a;
generate
    for (c = 0;c < N;c = c + 1) //compare N times
    begin
        if (c[0] == 1'b0)
            begin // even
                for (r = 0;r < N;r = r + 2)
                    begin
                        sort2 sort2_i ( .a  (w[c*N + r          ]),
                                        .b  (w[c*N + r + 1      ]),
                                        .big(w[c*N + r + N      ]),
                                        .sme(w[c*N + r + N + 1  ]));
                    end            
            end
      else
        begin // odd
            assign w[c*N + N]=w[c*N];
            for (r = 1;r < N - 2;r = r + 2)
                begin
                    sort2 sort2_i ( .a  (w[c*N + r          ]),
                                    .b  (w[c*N + r + 1      ]),
                                    .big(w[c*N + r + N      ]),
                                    .sme(w[c*N + r+ N + 1   ]));
                end            
            assign w[c*N + N + N - 1]=w[c*N + N - 1];
        end
    end
   
   
    for (r = 0;r < N;r = r + 1)
        begin
            assign w[r] = RAM1[r];
            assign RAM2[r] = w[N*N + r];
        end

    assign max = w[N*N];
    assign min = w[N*N+N-1];
   
endgenerate  

endmodule



module sort_N#( 
    parameter W = 8, // Data width
    parameter N = 16   // Number of entries: power of two
)
(
    input          CLK,
    input          RSTn,
    output [W-1:0] max,
    output [W-1:0] min
    //also can input data
);   

wire [W-1:0] w    [0:N*(N+1)-1];
reg  [W-1:0] RAM1 [0:N-1]; //input data memory
wire [W-1:0] RAM2 [0:N-1]; //output data memory


//*******************initialization RAM*******************//
integer k;
always @(posedge CLK or negedge RSTn) 
begin
    if (!RSTn) 
        begin
            for (k = 0;k < N;k = k + 1)
                RAM1[k] <= 0;
        end
    else  
        begin
            for (k = 0;k < N;k = k + 1)
                RAM1[k] <= $random();//you can input data
                                      //use some random data
       end
end

//*******************compare generate**********************//
genvar c,r,a;
generate
    for (c = 0;c < N;c = c + 1) //compare N times
    begin
        if (c[0] == 1'b0)
            begin // even
                for (r = 0;r < N;r = r + 2)
                    begin
                        sort2 sort2_i ( .a  (w[c*N + r          ]),
                                        .b  (w[c*N + r + 1      ]),
                                        .big(w[c*N + r + N      ]),
                                        .sme(w[c*N + r + N + 1  ]));
                    end            
            end
      else
        begin // odd
            assign w[c*N + N]=w[c*N];
            for (r = 1;r < N - 2;r = r + 2)
                begin
                    sort2 sort2_i ( .a  (w[c*N + r          ]),
                                    .b  (w[c*N + r + 1      ]),
                                    .big(w[c*N + r + N      ]),
                                    .sme(w[c*N + r+ N + 1   ]));
                end            
            assign w[c*N + N + N - 1]=w[c*N + N - 1];
        end
    end
   
   
    for (r = 0;r < N;r = r + 1)
        begin
            assign w[r] = RAM1[r];
            assign RAM2[r] = w[N*N + r];
        end

    assign max = w[N*N];
    assign min = w[N*N+N-1];
   
endgenerate  

endmodule