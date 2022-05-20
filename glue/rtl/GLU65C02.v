module GLU65C02(
    input PHI2,
    input RESETn,
    input [15:0] ADDR,
    input RWn,
    input WSn,
    output IOSEL0,
    output IOSEL1,
    output IOSEL2,
    output IOSEL3,
    output RDYn,
    output MRDn,
    output MWRn,
    output RAMCS1,
    output RAMCS2,
    output ROMCS
  );

reg WAIT;
reg OVERLAY;

wire BANK0 = ADDR[15:14] == 2'b00;   // $0000-3FFF RAM1
wire BANK1 = ADDR[15:14] == 2'b01;   // $4000-7FFF OVERLAY=0 : RAM1 - OVERLAY=1 : RAM2
wire BANK2 = ADDR[15:14] == 2'b10;   // $8000-BFFF RAM2
wire BANK3 = ADDR[15:12] == 4'b1100; // $C000-CFFF OVERLAY=0 : RAM2 - OVERLAY=1 : RAM1
wire IO    = ADDR[15:12] == 4'b1101; // $D000-DFFF
wire ROM   = ADDR[15:13] == 3'b111;  // $E000-FFFF OVERLAY=0 : ROM - OVERLAY=1 : RAM1

// MRDn / MWRn held through waitstates
assign MRDn = ~(RWn && (PHI2 || WAIT));
assign MWRn = ~(!RWn && (PHI2 || WAIT));

assign RAMCS1 = !(BANK0 || BANK1 && !OVERLAY || BANK3 && OVERLAY || ROM && OVERLAY && RWn);
assign RAMCS2 = !(BANK2 || BANK3 && !OVERLAY || BANK1 && OVERLAY);

assign IOSEL0 = !(IO && ADDR[11:8] == 4'h0 && PHI2); // DUART
assign IOSEL1 = !(IO && ADDR[11:8] == 4'h1);         // VIA
assign IOSEL2 = !(IO && ADDR[11:8] == 4'h2);
assign IOSEL3 = !(IO && ADDR[11:8] == 4'h3);

assign ROMCS = !(ROM && !OVERLAY);

reg [1:0] reg_knock;

// Swap RAM BANK1 with ROM after a magic sequence of writes to ROM addresses
// $FXDE, $FXAD, $FXBE, $FXEF
always @(negedge MWRn or negedge RESETn)
begin
  if (!RESETn) begin
    OVERLAY <= 1'b0;
    reg_knock <= 2'b00;
  end else begin
    if (ROM) begin
      case (reg_knock)
        2'b00:
          begin
            if (ADDR[7:0] == 8'hDE)
              reg_knock <= reg_knock + 1;
            else
              reg_knock <= 0;
          end
        2'b01:
          begin
            if (ADDR[7:0] == 8'hAD)
              reg_knock <= reg_knock + 1;
            else
              reg_knock <= 0;
          end
        2'b10:
          begin
            if (ADDR[7:0] == 8'hBE)
              reg_knock <= reg_knock + 1;
            else
              reg_knock <= 0;
          end
        2'b11:
          begin
            if (ADDR[7:0] == 8'hEF)
              OVERLAY <= 1'b1;
            else
              reg_knock <= 0;
          end
      endcase
    end
  end
end

// Add Wait states when ROM selected or WSn asserted
always @(posedge PHI2 or negedge RESETn)
begin
  if (!RESETn) begin
    WAIT <= 1'b0;
  end else begin
    if (!WAIT) begin
      WAIT <= !ROMCS || !WSn;
    end else begin
      WAIT <= 1'b0;
    end
  end
end

assign RDYn = (WAIT) ? 1'b0 : 1'bZ;

endmodule
