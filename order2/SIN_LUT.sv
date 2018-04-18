module SIN_LUT(x_msb,c0,c1,c2,a);
input logic [11:0] x_msb;
output logic signed [28:0] c0;
output logic signed [24:0] c1;
output logic signed [16:0] c2;
output logic signed [13:0] a;


always_comb begin
	case(x_msb) inside
	[ 0:19 ]:begin
		c0=29'sb 00000000010010111111111110111;
		c1=25'sb 0011111111111111000111101;
		c2=17'sb 11111111011010000;
		a=14'sb 00000000010011;
	end 
	[ 20:38 ]:begin
		c0=29'sb 00000000111000111111100001111;
		c1=25'sb 0011111111111001011110101;
		c2=17'sb 11111110001110000;
		a=14'sb 00000000111001;
	end 
	[ 39:57 ]:begin
		c0=29'sb 00000001011110111101110100100;
		c1=25'sb 0011111111101110001100110;
		c2=17'sb 11111101000010001;
		a=14'sb 00000001011111;
	end 
	[ 58:76 ]:begin
		c0=29'sb 00000010000100111010000001001;
		c1=25'sb 0011111111011101010010011;
		c2=17'sb 11111011110110010;
		a=14'sb 00000010000101;
	end 
	[ 77:95 ]:begin
		c0=29'sb 00000010101010110011010010100;
		c1=25'sb 0011111111000110101111110;
		c2=17'sb 11111010101010011;
		a=14'sb 00000010101011;
	end 
	[ 96:114 ]:begin
		c0=29'sb 00000011010000101000110010111;
		c1=25'sb 0011111110101010100101011;
		c2=17'sb 11111001011110110;
		a=14'sb 00000011010001;
	end 
	[ 115:133 ]:begin
		c0=29'sb 00000011110110011001101101001;
		c1=25'sb 0011111110001000110011111;
		c2=17'sb 11111000010011010;
		a=14'sb 00000011110111;
	end 
	[ 134:152 ]:begin
		c0=29'sb 00000100011100000101001011111;
		c1=25'sb 0011111101100001011100001;
		c2=17'sb 11110111000111111;
		a=14'sb 00000100011101;
	end 
	[ 153:171 ]:begin
		c0=29'sb 00000101000001101010011010001;
		c1=25'sb 0011111100110100011110110;
		c2=17'sb 11110101111100101;
		a=14'sb 00000101000011;
	end 
	[ 172:190 ]:begin
		c0=29'sb 00000101100111001000100010101;
		c1=25'sb 0011111100000001111100111;
		c2=17'sb 11110100110001110;
		a=14'sb 00000101101001;
	end 
	[ 191:209 ]:begin
		c0=29'sb 00000110001100011110110000111;
		c1=25'sb 0011111011001001110111101;
		c2=17'sb 11110011100111000;
		a=14'sb 00000110001111;
	end 
	[ 210:228 ]:begin
		c0=29'sb 00000110110001101100010000000;
		c1=25'sb 0011111010001100010000010;
		c2=17'sb 11110010011100101;
		a=14'sb 00000110110101;
	end 
	[ 229:247 ]:begin
		c0=29'sb 00000111010110110000001011100;
		c1=25'sb 0011111001001001001000001;
		c2=17'sb 11110001010010100;
		a=14'sb 00000111011011;
	end 
	[ 248:266 ]:begin
		c0=29'sb 00000111111011101001101111010;
		c1=25'sb 0011111000000000100000101;
		c2=17'sb 11110000001000110;
		a=14'sb 00001000000001;
	end 
	[ 267:285 ]:begin
		c0=29'sb 00001000100000011000000111001;
		c1=25'sb 0011110110110010011011011;
		c2=17'sb 11101110111111010;
		a=14'sb 00001000100111;
	end 
	[ 286:304 ]:begin
		c0=29'sb 00001001000100111010011111011;
		c1=25'sb 0011110101011110111010001;
		c2=17'sb 11101101110110001;
		a=14'sb 00001001001101;
	end 
	[ 305:323 ]:begin
		c0=29'sb 00001001101001010000000100100;
		c1=25'sb 0011110100000101111110110;
		c2=17'sb 11101100101101100;
		a=14'sb 00001001110011;
	end 
	[ 324:342 ]:begin
		c0=29'sb 00001010001101011000000011001;
		c1=25'sb 0011110010100111101011001;
		c2=17'sb 11101011100101010;
		a=14'sb 00001010011001;
	end 
	[ 343:361 ]:begin
		c0=29'sb 00001010110001010001101000100;
		c1=25'sb 0011110001000100000001100;
		c2=17'sb 11101010011101100;
		a=14'sb 00001010111111;
	end 
	[ 362:380 ]:begin
		c0=29'sb 00001011010100111100000010000;
		c1=25'sb 0011101111011011000011111;
		c2=17'sb 11101001010110001;
		a=14'sb 00001011100101;
	end 
	[ 381:399 ]:begin
		c0=29'sb 00001011111000010110011101001;
		c1=25'sb 0011101101101100110100101;
		c2=17'sb 11101000001111010;
		a=14'sb 00001100001011;
	end 
	[ 400:418 ]:begin
		c0=29'sb 00001100011011100000001000001;
		c1=25'sb 0011101011111001010110001;
		c2=17'sb 11100111001001000;
		a=14'sb 00001100110001;
	end 
	[ 419:437 ]:begin
		c0=29'sb 00001100111110011000010001010;
		c1=25'sb 0011101010000000101011001;
		c2=17'sb 11100110000011010;
		a=14'sb 00001101010111;
	end 
	[ 438:456 ]:begin
		c0=29'sb 00001101100000111110000111101;
		c1=25'sb 0011101000000010110110000;
		c2=17'sb 11100100111110001;
		a=14'sb 00001101111101;
	end 
	[ 457:475 ]:begin
		c0=29'sb 00001110000011010000111010001;
		c1=25'sb 0011100101111111111001110;
		c2=17'sb 11100011111001100;
		a=14'sb 00001110100011;
	end 
	[ 476:495 ]:begin
		c0=29'sb 00001110100110001000110110010;
		c1=25'sb 0011100011110100001110101;
		c2=17'sb 11100010110011110;
		a=14'sb 00001111001010;
	end 
	[ 496:515 ]:begin
		c0=29'sb 00001111001001100011011111010;
		c1=25'sb 0011100001011111100000000;
		c2=17'sb 11100001101100111;
		a=14'sb 00001111110010;
	end 
	[ 516:535 ]:begin
		c0=29'sb 00001111101100100110011101011;
		c1=25'sb 0011011111000101010001000;
		c2=17'sb 11100000100110111;
		a=14'sb 00010000011010;
	end 
	[ 536:555 ]:begin
		c0=29'sb 00010000001111010000111001110;
		c1=25'sb 0011011100100101100101100;
		c2=17'sb 11011111100001100;
		a=14'sb 00010001000010;
	end 
	[ 556:575 ]:begin
		c0=29'sb 00010000110001100001111110100;
		c1=25'sb 0011011010000000100001010;
		c2=17'sb 11011110011101000;
		a=14'sb 00010001101010;
	end 
	[ 576:595 ]:begin
		c0=29'sb 00010001010011011000110101110;
		c1=25'sb 0011010111010110001000100;
		c2=17'sb 11011101011001010;
		a=14'sb 00010010010010;
	end 
	[ 596:615 ]:begin
		c0=29'sb 00010001110100110100101010111;
		c1=25'sb 0011010100100110011111010;
		c2=17'sb 11011100010110011;
		a=14'sb 00010010111010;
	end 
	[ 616:635 ]:begin
		c0=29'sb 00010010010101110100101001100;
		c1=25'sb 0011010001110001101001110;
		c2=17'sb 11011011010100011;
		a=14'sb 00010011100010;
	end 
	[ 636:655 ]:begin
		c0=29'sb 00010010110110010111111110001;
		c1=25'sb 0011001110110111101100100;
		c2=17'sb 11011010010011010;
		a=14'sb 00010100001010;
	end 
	[ 656:675 ]:begin
		c0=29'sb 00010011010110011101110101110;
		c1=25'sb 0011001011111000101100001;
		c2=17'sb 11011001010011001;
		a=14'sb 00010100110010;
	end 
	[ 676:695 ]:begin
		c0=29'sb 00010011110110000101011110011;
		c1=25'sb 0011001000110100101101001;
		c2=17'sb 11011000010011111;
		a=14'sb 00010101011010;
	end 
	[ 696:715 ]:begin
		c0=29'sb 00010100010101001110000110100;
		c1=25'sb 0011000101101011110100010;
		c2=17'sb 11010111010101101;
		a=14'sb 00010110000010;
	end 
	[ 716:736 ]:begin
		c0=29'sb 00010100110100100111100100100;
		c1=25'sb 0011000010011000111000101;
		c2=17'sb 11010110010110110;
		a=14'sb 00010110101011;
	end 
	[ 737:757 ]:begin
		c0=29'sb 00010101010100001110100110101;
		c1=25'sb 0010111110111011101001111;
		c2=17'sb 11010101010111101;
		a=14'sb 00010111010101;
	end 
	[ 758:778 ]:begin
		c0=29'sb 00010101110011010000111010101;
		c1=25'sb 0010111011011001010010010;
		c2=17'sb 11010100011001100;
		a=14'sb 00010111111111;
	end 
	[ 779:799 ]:begin
		c0=29'sb 00010110010001101101101011010;
		c1=25'sb 0010110111110001110111110;
		c2=17'sb 11010011011100101;
		a=14'sb 00011000101001;
	end 
	[ 800:820 ]:begin
		c0=29'sb 00010110101111100100000011111;
		c1=25'sb 0010110100000101100000110;
		c2=17'sb 11010010100000111;
		a=14'sb 00011001010011;
	end 
	[ 821:841 ]:begin
		c0=29'sb 00010111001100110011010001010;
		c1=25'sb 0010110000010100010011100;
		c2=17'sb 11010001100110011;
		a=14'sb 00011001111101;
	end 
	[ 842:862 ]:begin
		c0=29'sb 00010111101001011010100000110;
		c1=25'sb 0010101100011110010110100;
		c2=17'sb 11010000101101010;
		a=14'sb 00011010100111;
	end 
	[ 863:884 ]:begin
		c0=29'sb 00011000000110000011001001101;
		c1=25'sb 0010101000011101101110001;
		c2=17'sb 11001111110100000;
		a=14'sb 00011011010010;
	end 
	[ 885:906 ]:begin
		c0=29'sb 00011000100010101001010111100;
		c1=25'sb 0010100100010010001101111;
		c2=17'sb 11001110111010110;
		a=14'sb 00011011111110;
	end 
	[ 907:928 ]:begin
		c0=29'sb 00011000111110100001001011111;
		c1=25'sb 0010100000000001110111000;
		c2=17'sb 11001110000011000;
		a=14'sb 00011100101010;
	end 
	[ 929:950 ]:begin
		c0=29'sb 00011001011001101001110010010;
		c1=25'sb 0010011011101100110001101;
		c2=17'sb 11001101001100110;
		a=14'sb 00011101010110;
	end 
	[ 951:972 ]:begin
		c0=29'sb 00011001110100000010010111010;
		c1=25'sb 0010010111010011000101111;
		c2=17'sb 11001100011000000;
		a=14'sb 00011110000010;
	end 
	[ 973:995 ]:begin
		c0=29'sb 00011010001110001110110101100;
		c1=25'sb 0010010010101110010111111;
		c2=17'sb 11001011100011101;
		a=14'sb 00011110101111;
	end 
	[ 996:1018 ]:begin
		c0=29'sb 00011010101000001010111101100;
		c1=25'sb 0010001101111110011110100;
		c2=17'sb 11001010101111110;
		a=14'sb 00011111011101;
	end 
	[ 1019:1041 ]:begin
		c0=29'sb 00011011000001010000000100001;
		c1=25'sb 0010001001001001111111111;
		c2=17'sb 11001001111101100;
		a=14'sb 00100000001011;
	end 
	[ 1042:1064 ]:begin
		c0=29'sb 00011011011001011101010101101;
		c1=25'sb 0010000100010001000101110;
		c2=17'sb 11001001001101001;
		a=14'sb 00100000111001;
	end 
	[ 1065:1088 ]:begin
		c0=29'sb 00011011110001010001110100001;
		c1=25'sb 0001111111001100111101011;
		c2=17'sb 11001000011101100;
		a=14'sb 00100001101000;
	end 
	[ 1089:1112 ]:begin
		c0=29'sb 00011100001000101000111001000;
		c1=25'sb 0001111001111101100001010;
		c2=17'sb 11000111101110110;
		a=14'sb 00100010011000;
	end 
	[ 1113:1136 ]:begin
		c0=29'sb 00011100011111000000101010101;
		c1=25'sb 0001110100101001110010110;
		c2=17'sb 11000111000010000;
		a=14'sb 00100011001000;
	end 
	[ 1137:1161 ]:begin
		c0=29'sb 00011100110100110100001010010;
		c1=25'sb 0001101111001010110000000;
		c2=17'sb 11000110010110011;
		a=14'sb 00100011111001;
	end 
	[ 1162:1186 ]:begin
		c0=29'sb 00011101001001111110011101101;
		c1=25'sb 0001101001100000010110110;
		c2=17'sb 11000101101100001;
		a=14'sb 00100100101011;
	end 
	[ 1187:1212 ]:begin
		c0=29'sb 00011101011110011010100001001;
		c1=25'sb 0001100011101010100011111;
		c2=17'sb 11000101000011010;
		a=14'sb 00100101011110;
	end 
	[ 1213:1238 ]:begin
		c0=29'sb 00011101110010000011001000101;
		c1=25'sb 0001011101101001011000000;
		c2=17'sb 11000100011100000;
		a=14'sb 00100110010010;
	end 
	[ 1239:1265 ]:begin
		c0=29'sb 00011110000100110010111111100;
		c1=25'sb 0001010111011100110011010;
		c2=17'sb 11000011110110100;
		a=14'sb 00100111000111;
	end 
	[ 1266:1292 ]:begin
		c0=29'sb 00011110010110100100101000110;
		c1=25'sb 0001010001000100111001100;
		c2=17'sb 11000011010010111;
		a=14'sb 00100111111101;
	end 
	[ 1293:1320 ]:begin
		c0=29'sb 00011110100111010010100000000;
		c1=25'sb 0001001010100001101110110;
		c2=17'sb 11000010110001100;
		a=14'sb 00101000110100;
	end 
	[ 1321:1349 ]:begin
		c0=29'sb 00011110110111000111110101011;
		c1=25'sb 0001000011101011101100011;
		c2=17'sb 11000010010001111;
		a=14'sb 00101001101101;
	end 
	[ 1350:1379 ]:begin
		c0=29'sb 00011111000101111001100101110;
		c1=25'sb 0000111100100010110000101;
		c2=17'sb 11000001110100010;
		a=14'sb 00101010101000;
	end 
	[ 1380:1410 ]:begin
		c0=29'sb 00011111010011011100010001100;
		c1=25'sb 0000110101000110111101101;
		c2=17'sb 11000001011001010;
		a=14'sb 00101011100101;
	end 
	[ 1411:1443 ]:begin
		c0=29'sb 00011111011111101111010011000;
		c1=25'sb 0000101101010000100001110;
		c2=17'sb 11000001000000101;
		a=14'sb 00101100100101;
	end 
	[ 1444:1478 ]:begin
		c0=29'sb 00011111101010101001011101110;
		c1=25'sb 0000100100110111100110110;
		c2=17'sb 11000000101010111;
		a=14'sb 00101101101001;
	end 
	[ 1479:1517 ]:begin
		c0=29'sb 00011111110011111110110000010;
		c1=25'sb 0000011011101100010111110;
		c2=17'sb 11000000011000010;
		a=14'sb 00101110110011;
	end 
	[ 1518:1562 ]:begin
		c0=29'sb 00011111111011010110100101110;
		c1=25'sb 0000010001001111000001101;
		c2=17'sb 11000000001001100;
		a=14'sb 00110000000111;
	end 
	[ 1563:1608 ]:begin
		c0=29'sb 00011111111111011101011111111;
		c1=25'sb 0000000101110111110111110;
		c2=17'sb 11000000000001010;
		a=14'sb 00110001100010;
	end 
	default:begin
		c0=29'sb 00011111111111011101011111111;
		c1=25'sb 0000000101110111110111110;
		c2=17'sb 11000000000001010;
		a=14'sb 00110001100010;
	end 
	
	endcase
	end
endmodule