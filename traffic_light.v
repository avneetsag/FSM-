module traffic_light
(input clk,rst, 
output reg[5:0] z
);
reg[6:0] time_count; 
reg[1:0] state,next_state;
parameter s0=2'b00,s1=2'b01,s2=2'b11,
s3=2'b10;
parameter time_s1=7'd40, time_s2=7'd5,
time_s3=7'd20,time_s4=7'd5; 
parameter led1=6'b000001,led2=6'b000010,
led3=6'b000100,led4=6'b001000;

always@(posedge clk or posedge rst) 
begin if(rst) begin state<=s0; end
else state<=next_state;
end

always@(next_state or rst or time_count)
 
begin if(rst) next_state=s0;
else begin
 


case(state)
s0:begin if(time_count==0) next_state<=s1;
else next_state<=s0;
 
end
s1:begin if(time_count==0) next_state<=s2;
else next_state<=s1;
end
s2:begin if(time_count==0) next_state<=s3;
else next_state<=s2;
end
s3:begin if(time_count==0) next_state<=s0;
else next_state<=s3;
end
default:next_state<=s0;
endcase
end
 end

 
always@(posedge clk)
begin if(rst) time_count<=time_s1;
else begin
case(next_state)
s0:begin z=led1;
if(time_count==0) time_count=time_s1-1; else time_count=time_count-1;end
s1:begin z=led2; 
if(time_count==0) time_count=time_s2-1; else time_count=time_count-1;end
s2:begin z=led3; 
if(time_count==0) time_count=time_s3-1; else time_count=time_count-1;end
s3:begin z=led4;
if(time_count==0) time_count=time_s4-1; else time_count=time_count-1;end
endcase 
end
 
end 
endmodule
