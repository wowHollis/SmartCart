   1              		.syntax unified
   2              		.cpu cortex-m0
   3              		.fpu softvfp
   4              		.eabi_attribute 20, 1
   5              		.eabi_attribute 21, 1
   6              		.eabi_attribute 23, 3
   7              		.eabi_attribute 24, 1
   8              		.eabi_attribute 25, 1
   9              		.eabi_attribute 26, 1
  10              		.eabi_attribute 30, 6
  11              		.eabi_attribute 34, 0
  12              		.eabi_attribute 18, 4
  13              		.thumb
  14              		.syntax unified
  15              		.file	"rls_m0.c"
  16              		.text
  17              	.Ltext0:
  18              		.cfi_sections	.debug_frame
  19              		.global	g_logLut
  20              		.section	.bss.g_logLut,"aw",%nobits
  21              		.align	2
  24              	g_logLut:
  25 0000 00000000 		.space	4
  26              		.section	.text.lineProcessedRL0A,"ax",%progbits
  27              		.align	2
  28              		.global	lineProcessedRL0A
  29              		.code	16
  30              		.thumb_func
  32              	lineProcessedRL0A:
  33              	.LFB32:
  34              		.file 1 "../src/rls_m0.c"
   1:../src/rls_m0.c **** //
   2:../src/rls_m0.c **** // begin license header
   3:../src/rls_m0.c **** //
   4:../src/rls_m0.c **** // This file is part of Pixy CMUcam5 or "Pixy" for short
   5:../src/rls_m0.c **** //
   6:../src/rls_m0.c **** // All Pixy source code is provided under the terms of the
   7:../src/rls_m0.c **** // GNU General Public License v2 (http://www.gnu.org/licenses/gpl-2.0.html).
   8:../src/rls_m0.c **** // Those wishing to use Pixy source code, software and/or
   9:../src/rls_m0.c **** // technologies under different licensing terms should contact us at
  10:../src/rls_m0.c **** // cmucam@cs.cmu.edu. Such licensing terms are available for
  11:../src/rls_m0.c **** // all portions of the Pixy codebase presented here.
  12:../src/rls_m0.c **** //
  13:../src/rls_m0.c **** // end license header
  14:../src/rls_m0.c **** //
  15:../src/rls_m0.c **** 
  16:../src/rls_m0.c **** #include "rls_m0.h"
  17:../src/rls_m0.c **** #include "frame_m0.h"
  18:../src/rls_m0.c **** #include "chirp.h"
  19:../src/rls_m0.c **** #include "qqueue.h"
  20:../src/rls_m0.c **** 
  21:../src/rls_m0.c **** 
  22:../src/rls_m0.c **** //#define RLTEST
  23:../src/rls_m0.c **** #define MAX_QVALS_PER_LINE 	CAM_RES2_WIDTH/5	 // width/5 because that's the worst case with noise f
  24:../src/rls_m0.c **** 
  25:../src/rls_m0.c **** uint8_t *g_logLut = NULL;
  26:../src/rls_m0.c **** 
  27:../src/rls_m0.c **** #if 0 // this is the old method, might have use down the road....
  28:../src/rls_m0.c **** // assemble blue-green words to look like this
  29:../src/rls_m0.c **** // 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
  30:../src/rls_m0.c **** //                                                  B  B  B  B  B  G G G G G
  31:../src/rls_m0.c **** __asm void lineProcessedRL0(uint32_t *gpio, uint16_t *memory, uint32_t width)
  32:../src/rls_m0.c **** { 
  33:../src/rls_m0.c **** 		PRESERVE8
  34:../src/rls_m0.c **** 		IMPORT 	callSyncM1
  35:../src/rls_m0.c **** 
  36:../src/rls_m0.c **** 		PUSH	{r4-r5, lr}
  37:../src/rls_m0.c **** 
  38:../src/rls_m0.c **** 		// add width to memory pointer so we can compare
  39:../src/rls_m0.c **** 		ADDS	r2, r1
  40:../src/rls_m0.c **** 		// generate hsync bit
  41:../src/rls_m0.c **** 	  	MOVS	r5, #0x1
  42:../src/rls_m0.c **** 		LSLS	r5, #11
  43:../src/rls_m0.c **** 
  44:../src/rls_m0.c **** 		PUSH	{r0-r3} // save args
  45:../src/rls_m0.c **** 		BL.W	callSyncM1 // get pixel sync
  46:../src/rls_m0.c **** 		POP		{r0-r3}	// restore args
  47:../src/rls_m0.c **** 	   
  48:../src/rls_m0.c **** 	   	// pixel sync starts here
  49:../src/rls_m0.c **** 
  50:../src/rls_m0.c **** 		// wait for hsync to go high
  51:../src/rls_m0.c **** dest10	LDR 	r3, [r0] 	// 2
  52:../src/rls_m0.c **** 		TST		r3, r5		// 1
  53:../src/rls_m0.c **** 		BEQ		dest10		// 3
  54:../src/rls_m0.c **** 
  55:../src/rls_m0.c **** 		// variable delay --- get correct phase for sampling
  56:../src/rls_m0.c **** 		asm("NOP");
  57:../src/rls_m0.c **** 		asm("NOP");
  58:../src/rls_m0.c **** 
  59:../src/rls_m0.c **** #if 0
  60:../src/rls_m0.c **** loop5
  61:../src/rls_m0.c **** 		LDRB 	r3, [r0] 	  
  62:../src/rls_m0.c **** 		STRB 	r3, [r1]
  63:../src/rls_m0.c **** 		asm("NOP");
  64:../src/rls_m0.c **** 		asm("NOP");
  65:../src/rls_m0.c **** 		asm("NOP");
  66:../src/rls_m0.c **** 		ADDS	r1, #0x01
  67:../src/rls_m0.c **** 		CMP		r1, r2
  68:../src/rls_m0.c **** 		BLT		loop5
  69:../src/rls_m0.c **** #else
  70:../src/rls_m0.c **** loop5
  71:../src/rls_m0.c **** 		LDRB 	r3, [r0] // blue
  72:../src/rls_m0.c **** 		LSRS    r3, #3
  73:../src/rls_m0.c **** 		LSLS    r3, #10
  74:../src/rls_m0.c **** 		asm("NOP");
  75:../src/rls_m0.c **** 		asm("NOP");
  76:../src/rls_m0.c **** 		asm("NOP");
  77:../src/rls_m0.c **** 		asm("NOP");
  78:../src/rls_m0.c **** 		asm("NOP");
  79:../src/rls_m0.c **** 		asm("NOP");
  80:../src/rls_m0.c **** 		asm("NOP");
  81:../src/rls_m0.c **** 		asm("NOP");
  82:../src/rls_m0.c **** 
  83:../src/rls_m0.c **** 		LDRB 	r4, [r0] // green 	  
  84:../src/rls_m0.c **** 		LSRS    r4, #3
  85:../src/rls_m0.c **** 		LSLS    r4, #5
  86:../src/rls_m0.c **** 		ORRS	r3, r4
  87:../src/rls_m0.c **** 		STRH    r3,	[r1] // store blue/green
  88:../src/rls_m0.c **** 		ADDS    r1, #0x02
  89:../src/rls_m0.c **** 		CMP		r1, r2
  90:../src/rls_m0.c **** 		BLT		loop5
  91:../src/rls_m0.c **** 
  92:../src/rls_m0.c **** #endif
  93:../src/rls_m0.c **** 		// wait for hsync to go low (end of line)
  94:../src/rls_m0.c **** dest11	LDR 	r3, [r0] 	// 2
  95:../src/rls_m0.c **** 		TST		r3, r5		// 1
  96:../src/rls_m0.c **** 		BNE		dest11		// 3
  97:../src/rls_m0.c **** 
  98:../src/rls_m0.c **** 		POP		{r4-r5, pc}
  99:../src/rls_m0.c **** }
 100:../src/rls_m0.c **** 
 101:../src/rls_m0.c **** __asm uint16_t *lineProcessedRL1(uint32_t *gpio, uint16_t *memory, uint8_t *lut, uint16_t *linestor
 102:../src/rls_m0.c **** {
 103:../src/rls_m0.c **** // r0: gpio
 104:../src/rls_m0.c **** // r1: q memory
 105:../src/rls_m0.c **** // r2: lut
 106:../src/rls_m0.c **** // r3: prev line
 107:../src/rls_m0.c **** // r4: col 
 108:../src/rls_m0.c **** // r5: scratch
 109:../src/rls_m0.c **** // r6: scratch
 110:../src/rls_m0.c **** // r7: prev m val
 111:../src/rls_m0.c **** 		PRESERVE8
 112:../src/rls_m0.c **** 		IMPORT 	callSyncM1
 113:../src/rls_m0.c **** 
 114:../src/rls_m0.c **** 		PUSH	{r4-r7, lr}
 115:../src/rls_m0.c **** 		LDR		r4, [sp, #0x14]
 116:../src/rls_m0.c **** 
 117:../src/rls_m0.c **** 		// add width to memory pointer so we can compare
 118:../src/rls_m0.c **** 		ADDS	r4, r3
 119:../src/rls_m0.c **** 	   	MOV		r8, r4
 120:../src/rls_m0.c **** 		// generate hsync bit
 121:../src/rls_m0.c **** 	  	MOVS	r5, #0x1
 122:../src/rls_m0.c **** 		LSLS	r5, #11
 123:../src/rls_m0.c **** 
 124:../src/rls_m0.c **** 		PUSH	{r0-r3} // save args
 125:../src/rls_m0.c **** 		BL.W	callSyncM1 // get pixel sync
 126:../src/rls_m0.c **** 		POP		{r0-r3}	// restore args
 127:../src/rls_m0.c **** 	   
 128:../src/rls_m0.c **** 	   	// pixel sync starts here
 129:../src/rls_m0.c **** 		
 130:../src/rls_m0.c **** 		// wait for hsync to go high
 131:../src/rls_m0.c **** dest12	LDR 	r6, [r0] 	// 2
 132:../src/rls_m0.c **** 		TST		r6, r5		// 1
 133:../src/rls_m0.c **** 		BEQ		dest12		// 3
 134:../src/rls_m0.c **** 
 135:../src/rls_m0.c **** 		// variable delay --- get correct phase for sampling
 136:../src/rls_m0.c **** 	    asm("NOP");
 137:../src/rls_m0.c **** 		//(borrow asm("NOP"); below)
 138:../src/rls_m0.c **** 		// skip green pixel
 139:../src/rls_m0.c **** 		MOVS    r5, #0x00 // clear r5 (which will be copied to r7) This will force a write of a q val 
 140:../src/rls_m0.c **** 		MOVS	r4, #0x00 // clear col (col is numbered 1 to 320)
 141:../src/rls_m0.c **** // 2
 142:../src/rls_m0.c **** loop6	MOV		r7, r5 // copy lut val (lutPrev)
 143:../src/rls_m0.c **** 		MOV		r5, r8
 144:../src/rls_m0.c **** 		CMP		r3, r5
 145:../src/rls_m0.c **** 		BGE		dest30
 146:../src/rls_m0.c **** 		asm("NOP");
 147:../src/rls_m0.c **** 		asm("NOP");
 148:../src/rls_m0.c **** 		asm("NOP");
 149:../src/rls_m0.c **** 		asm("NOP");
 150:../src/rls_m0.c **** 		asm("NOP");
 151:../src/rls_m0.c **** // 9
 152:../src/rls_m0.c **** loop7	
 153:../src/rls_m0.c **** 		LDRH	r5, [r3] // load blue green val
 154:../src/rls_m0.c **** // 2
 155:../src/rls_m0.c **** 		LDRB 	r6, [r0] // load red pixel
 156:../src/rls_m0.c **** 		LSRS    r6, #3	 // shift into place (5 bits of red)
 157:../src/rls_m0.c **** 		ORRS	r5, r6 // form 15-bit lut index
 158:../src/rls_m0.c **** 		ADDS    r3, #0x02 // inc prev line pointer
 159:../src/rls_m0.c **** 		ADDS	r4, #0x01 // inc col
 160:../src/rls_m0.c **** 		asm("NOP");
 161:../src/rls_m0.c **** 		LDRB	r5, [r2, r5] // load lut val
 162:../src/rls_m0.c **** 		EORS  	r7, r5 // compare with previous	lut val
 163:../src/rls_m0.c **** // 10
 164:../src/rls_m0.c **** 		BEQ	   	loop6 // if lut vals have haven't changed proceed (else store q val)
 165:../src/rls_m0.c **** // 1, 3
 166:../src/rls_m0.c **** 		// calc, store q val
 167:../src/rls_m0.c **** 		LSLS	r5, #0x09
 168:../src/rls_m0.c **** 		ORRS	r5, r4 // make q val
 169:../src/rls_m0.c **** 		STRH	r5, [r1] // write q val
 170:../src/rls_m0.c **** 		ADDS	r1, #0x02 // inc q mem
 171:../src/rls_m0.c **** 		MOV		r7, r5 // copy lut val (qPrev)
 172:../src/rls_m0.c **** // 6
 173:../src/rls_m0.c **** 
 174:../src/rls_m0.c **** 		MOV 	r5, r8 // bring in end of row compare val
 175:../src/rls_m0.c **** 		CMP		r3, r5
 176:../src/rls_m0.c **** 		BLT		loop7
 177:../src/rls_m0.c **** // 5
 178:../src/rls_m0.c **** dest30
 179:../src/rls_m0.c **** 	  	MOVS	r5, #0x1
 180:../src/rls_m0.c **** 		LSLS	r5, #11
 181:../src/rls_m0.c **** dest20	LDR 	r6, [r0] 	// 2
 182:../src/rls_m0.c **** 		TST		r6, r5		// 1
 183:../src/rls_m0.c **** 		BNE		dest20		// 3
 184:../src/rls_m0.c **** 
 185:../src/rls_m0.c **** 		MOV     r0, r1 // move result
 186:../src/rls_m0.c **** 		POP		{r4-r7, pc}
 187:../src/rls_m0.c **** } 
 188:../src/rls_m0.c **** #endif
 189:../src/rls_m0.c **** 
 190:../src/rls_m0.c **** void lineProcessedRL0A(uint32_t *gpio, uint8_t *memory, uint32_t width) // width in bytes
 191:../src/rls_m0.c **** { 
  35              		.loc 1 191 0
  36              		.cfi_startproc
  37 0000 80B5     		push	{r7, lr}
  38              		.cfi_def_cfa_offset 8
  39              		.cfi_offset 7, -8
  40              		.cfi_offset 14, -4
  41 0002 84B0     		sub	sp, sp, #16
  42              		.cfi_def_cfa_offset 24
  43 0004 00AF     		add	r7, sp, #0
  44              		.cfi_def_cfa_register 7
  45 0006 F860     		str	r0, [r7, #12]
  46 0008 B960     		str	r1, [r7, #8]
  47 000a 7A60     		str	r2, [r7, #4]
 192:../src/rls_m0.c **** //		PRESERVE8
 193:../src/rls_m0.c **** 
 194:../src/rls_m0.c **** 	asm(".syntax unified");
  48              		.loc 1 194 0
  49              		.syntax divided
  50              	@ 194 "../src/rls_m0.c" 1
  51              		.syntax unified
  52              	@ 0 "" 2
 195:../src/rls_m0.c **** 
 196:../src/rls_m0.c **** 		asm("PUSH	{r4-r5}");
  53              		.loc 1 196 0
  54              	@ 196 "../src/rls_m0.c" 1
  55 000c 30B4     		PUSH	{r4-r5}
  56              	@ 0 "" 2
 197:../src/rls_m0.c **** 
 198:../src/rls_m0.c **** 		// add width to memory pointer so we can compare
 199:../src/rls_m0.c **** 		asm("ADDS	r2, r1");
  57              		.loc 1 199 0
  58              	@ 199 "../src/rls_m0.c" 1
  59 000e 5218     		ADDS	r2, r1
  60              	@ 0 "" 2
 200:../src/rls_m0.c **** 		// generate hsync bit
 201:../src/rls_m0.c **** 		asm("MOVS	r5, #0x1");
  61              		.loc 1 201 0
  62              	@ 201 "../src/rls_m0.c" 1
  63 0010 0125     		MOVS	r5, #0x1
  64              	@ 0 "" 2
 202:../src/rls_m0.c **** 		asm("LSLS	r5, #11");
  65              		.loc 1 202 0
  66              	@ 202 "../src/rls_m0.c" 1
  67 0012 ED02     		LSLS	r5, #11
  68              	@ 0 "" 2
 203:../src/rls_m0.c **** 
 204:../src/rls_m0.c **** 		asm("PUSH	{r0-r3}"); // save args
  69              		.loc 1 204 0
  70              	@ 204 "../src/rls_m0.c" 1
  71 0014 0FB4     		PUSH	{r0-r3}
  72              	@ 0 "" 2
 205:../src/rls_m0.c **** 		asm("BL.W	callSyncM1"); // get pixel sync
  73              		.loc 1 205 0
  74              	@ 205 "../src/rls_m0.c" 1
  75 0016 FFF7FEFF 		BL.W	callSyncM1
  76              	@ 0 "" 2
 206:../src/rls_m0.c **** 		asm("POP	{r0-r3}");	// restore args
  77              		.loc 1 206 0
  78              	@ 206 "../src/rls_m0.c" 1
  79 001a 0FBC     		POP	{r0-r3}
  80              	@ 0 "" 2
 207:../src/rls_m0.c **** 	   
 208:../src/rls_m0.c **** 	   	// pixel sync starts here
 209:../src/rls_m0.c **** 
 210:../src/rls_m0.c **** 		// wait for hsync to go high
 211:../src/rls_m0.c **** asm("dest10A:");
  81              		.loc 1 211 0
  82              	@ 211 "../src/rls_m0.c" 1
  83              		dest10A:
  84              	@ 0 "" 2
 212:../src/rls_m0.c **** 		asm("LDR 	r3, [r0]"); 	// 2
  85              		.loc 1 212 0
  86              	@ 212 "../src/rls_m0.c" 1
  87 001c 0368     		LDR 	r3, [r0]
  88              	@ 0 "" 2
 213:../src/rls_m0.c **** 		asm("TST	r3, r5");		// 1
  89              		.loc 1 213 0
  90              	@ 213 "../src/rls_m0.c" 1
  91 001e 2B42     		TST	r3, r5
  92              	@ 0 "" 2
 214:../src/rls_m0.c **** 		asm("BEQ	dest10A");		// 3
  93              		.loc 1 214 0
  94              	@ 214 "../src/rls_m0.c" 1
  95 0020 FCD0     		BEQ	dest10A
  96              	@ 0 "" 2
 215:../src/rls_m0.c **** 
 216:../src/rls_m0.c **** 		// variable delay --- get correct phase for sampling
 217:../src/rls_m0.c **** 		asm("NOP");
  97              		.loc 1 217 0
  98              	@ 217 "../src/rls_m0.c" 1
  99 0022 C046     		NOP
 100              	@ 0 "" 2
 218:../src/rls_m0.c **** 		asm("NOP");
 101              		.loc 1 218 0
 102              	@ 218 "../src/rls_m0.c" 1
 103 0024 C046     		NOP
 104              	@ 0 "" 2
 219:../src/rls_m0.c **** 
 220:../src/rls_m0.c **** asm("loop5A:");
 105              		.loc 1 220 0
 106              	@ 220 "../src/rls_m0.c" 1
 107              		loop5A:
 108              	@ 0 "" 2
 221:../src/rls_m0.c **** 		asm("LDRB 	r3, [r0]"); // blue
 109              		.loc 1 221 0
 110              	@ 221 "../src/rls_m0.c" 1
 111 0026 0378     		LDRB 	r3, [r0]
 112              	@ 0 "" 2
 222:../src/rls_m0.c **** 		// cycle
 223:../src/rls_m0.c **** 		asm("NOP");
 113              		.loc 1 223 0
 114              	@ 223 "../src/rls_m0.c" 1
 115 0028 C046     		NOP
 116              	@ 0 "" 2
 224:../src/rls_m0.c **** 		asm("NOP");
 117              		.loc 1 224 0
 118              	@ 224 "../src/rls_m0.c" 1
 119 002a C046     		NOP
 120              	@ 0 "" 2
 225:../src/rls_m0.c **** 		asm("NOP");
 121              		.loc 1 225 0
 122              	@ 225 "../src/rls_m0.c" 1
 123 002c C046     		NOP
 124              	@ 0 "" 2
 226:../src/rls_m0.c **** 		asm("NOP");
 125              		.loc 1 226 0
 126              	@ 226 "../src/rls_m0.c" 1
 127 002e C046     		NOP
 128              	@ 0 "" 2
 227:../src/rls_m0.c **** 		asm("NOP");
 129              		.loc 1 227 0
 130              	@ 227 "../src/rls_m0.c" 1
 131 0030 C046     		NOP
 132              	@ 0 "" 2
 228:../src/rls_m0.c **** 		asm("NOP");
 133              		.loc 1 228 0
 134              	@ 228 "../src/rls_m0.c" 1
 135 0032 C046     		NOP
 136              	@ 0 "" 2
 229:../src/rls_m0.c **** 		asm("NOP");
 137              		.loc 1 229 0
 138              	@ 229 "../src/rls_m0.c" 1
 139 0034 C046     		NOP
 140              	@ 0 "" 2
 230:../src/rls_m0.c **** 		asm("NOP");
 141              		.loc 1 230 0
 142              	@ 230 "../src/rls_m0.c" 1
 143 0036 C046     		NOP
 144              	@ 0 "" 2
 231:../src/rls_m0.c **** 		asm("NOP");
 145              		.loc 1 231 0
 146              	@ 231 "../src/rls_m0.c" 1
 147 0038 C046     		NOP
 148              	@ 0 "" 2
 232:../src/rls_m0.c **** 		asm("NOP");
 149              		.loc 1 232 0
 150              	@ 232 "../src/rls_m0.c" 1
 151 003a C046     		NOP
 152              	@ 0 "" 2
 233:../src/rls_m0.c **** 
 234:../src/rls_m0.c **** 		asm("LDRB 	r4, [r0]"); // green
 153              		.loc 1 234 0
 154              	@ 234 "../src/rls_m0.c" 1
 155 003c 0478     		LDRB 	r4, [r0]
 156              	@ 0 "" 2
 235:../src/rls_m0.c **** 		// cycle 
 236:../src/rls_m0.c **** 		asm("SUBS	r3, r4");   // blue-green
 157              		.loc 1 236 0
 158              	@ 236 "../src/rls_m0.c" 1
 159 003e 1B1B     		SUBS	r3, r4
 160              	@ 0 "" 2
 237:../src/rls_m0.c **** 		asm("ASRS   r3, #1");
 161              		.loc 1 237 0
 162              	@ 237 "../src/rls_m0.c" 1
 163 0040 5B10     		ASRS   r3, #1
 164              	@ 0 "" 2
 238:../src/rls_m0.c **** 		asm("STRB   r3, [r1]"); // store blue-green
 165              		.loc 1 238 0
 166              	@ 238 "../src/rls_m0.c" 1
 167 0042 0B70     		STRB   r3, [r1]
 168              	@ 0 "" 2
 239:../src/rls_m0.c **** 		// cycle 
 240:../src/rls_m0.c **** 		asm("ADDS   r1, #0x01");
 169              		.loc 1 240 0
 170              	@ 240 "../src/rls_m0.c" 1
 171 0044 0131     		ADDS   r1, #0x01
 172              	@ 0 "" 2
 241:../src/rls_m0.c **** 		asm("CMP	r1, r2");
 173              		.loc 1 241 0
 174              	@ 241 "../src/rls_m0.c" 1
 175 0046 9142     		CMP	r1, r2
 176              	@ 0 "" 2
 242:../src/rls_m0.c **** 		asm("NOP");
 177              		.loc 1 242 0
 178              	@ 242 "../src/rls_m0.c" 1
 179 0048 C046     		NOP
 180              	@ 0 "" 2
 243:../src/rls_m0.c **** 		asm("BLT	loop5A");
 181              		.loc 1 243 0
 182              	@ 243 "../src/rls_m0.c" 1
 183 004a ECDB     		BLT	loop5A
 184              	@ 0 "" 2
 244:../src/rls_m0.c **** 
 245:../src/rls_m0.c **** 		// wait for hsync to go low (end of line)
 246:../src/rls_m0.c **** asm("dest11A:");
 185              		.loc 1 246 0
 186              	@ 246 "../src/rls_m0.c" 1
 187              		dest11A:
 188              	@ 0 "" 2
 247:../src/rls_m0.c **** 		asm("LDR 	r3, [r0]"); 	// 2
 189              		.loc 1 247 0
 190              	@ 247 "../src/rls_m0.c" 1
 191 004c 0368     		LDR 	r3, [r0]
 192              	@ 0 "" 2
 248:../src/rls_m0.c **** 		asm("TST	r3, r5");		// 1
 193              		.loc 1 248 0
 194              	@ 248 "../src/rls_m0.c" 1
 195 004e 2B42     		TST	r3, r5
 196              	@ 0 "" 2
 249:../src/rls_m0.c **** 		asm("BNE	dest11A");		// 3
 197              		.loc 1 249 0
 198              	@ 249 "../src/rls_m0.c" 1
 199 0050 FCD1     		BNE	dest11A
 200              	@ 0 "" 2
 250:../src/rls_m0.c **** 
 251:../src/rls_m0.c **** 		asm("POP	{r4-r5}");
 201              		.loc 1 251 0
 202              	@ 251 "../src/rls_m0.c" 1
 203 0052 30BC     		POP	{r4-r5}
 204              	@ 0 "" 2
 252:../src/rls_m0.c **** 
 253:../src/rls_m0.c **** 		asm(".syntax divided");
 205              		.loc 1 253 0
 206              	@ 253 "../src/rls_m0.c" 1
 207              		.syntax divided
 208              	@ 0 "" 2
 254:../src/rls_m0.c **** }
 209              		.loc 1 254 0
 210              		.thumb
 211              		.syntax unified
 212 0054 C046     		nop
 213 0056 BD46     		mov	sp, r7
 214 0058 04B0     		add	sp, sp, #16
 215              		@ sp needed
 216 005a 80BD     		pop	{r7, pc}
 217              		.cfi_endproc
 218              	.LFE32:
 220              		.section	.text.lineProcessedRL1A,"ax",%progbits
 221              		.align	2
 222              		.global	lineProcessedRL1A
 223              		.code	16
 224              		.thumb_func
 226              	lineProcessedRL1A:
 227              	.LFB33:
 255:../src/rls_m0.c **** 
 256:../src/rls_m0.c **** 
 257:../src/rls_m0.c **** uint32_t lineProcessedRL1A(uint32_t *gpio, Qval *memory, uint8_t *lut, uint8_t *linestore, uint32_t
 258:../src/rls_m0.c **** 	Qval *qqMem, uint32_t qqIndex, uint32_t qqSize) // width in bytes
 259:../src/rls_m0.c **** {
 228              		.loc 1 259 0
 229              		.cfi_startproc
 230 0000 80B5     		push	{r7, lr}
 231              		.cfi_def_cfa_offset 8
 232              		.cfi_offset 7, -8
 233              		.cfi_offset 14, -4
 234 0002 84B0     		sub	sp, sp, #16
 235              		.cfi_def_cfa_offset 24
 236 0004 00AF     		add	r7, sp, #0
 237              		.cfi_def_cfa_register 7
 238 0006 F860     		str	r0, [r7, #12]
 239 0008 B960     		str	r1, [r7, #8]
 240 000a 7A60     		str	r2, [r7, #4]
 241 000c 3B60     		str	r3, [r7]
 260:../src/rls_m0.c **** // The code below does the following---
 261:../src/rls_m0.c **** // -- maintain pixel sync, read red and green pixels
 262:../src/rls_m0.c **** // -- create r-g, b-g index and look up value in lut
 263:../src/rls_m0.c **** // -- filter out noise within the line.  An on pixel surrounded by off pixels will be ignored.
 264:../src/rls_m0.c **** //    An off pixel surrounded by on pixels will be ignored.
 265:../src/rls_m0.c **** // -- generate hue line sum	and pseudo average
 266:../src/rls_m0.c **** // -- generate run-length segments
 267:../src/rls_m0.c **** // 
 268:../src/rls_m0.c **** // Notes:
 269:../src/rls_m0.c **** // Run-length segments are 1 pixel larger than actual, and the last hue line value is added twice i
 270:../src/rls_m0.c **** // Spurious noise pixels within a run-length segment present a problem.  When this happens the last
 271:../src/rls_m0.c **** // is added to the sum to keep things unbiased.  ie, think of the case where a run-length consists 
 272:../src/rls_m0.c **** // spurious noise pixels.  We don't want the noise to affect the average--- only the pixels that ag
 273:../src/rls_m0.c **** // the model number for that run-length.
 274:../src/rls_m0.c **** // All pixels are read and used--- the opponent color space (r-g, b-g) works well with the bayer pa
 275:../src/rls_m0.c **** // After the red pixel is read, about 12 cycles are used to create the index and look it up.  When 
 276:../src/rls_m0.c **** // created and written it takes about 24 cycles, so a green/red pixel pair is skipped, but the gree
 277:../src/rls_m0.c **** // grabbed and put in r5 so that it can be used when we resume. 
 278:../src/rls_m0.c **** // A shift lut is provided-- it's 321 entries containing the log2 of the index, so it's basically a
 279:../src/rls_m0.c **** // that helps us fit the hue line sum in the q value.  This value indicates how many bits to shift 
 280:../src/rls_m0.c **** // the right to reduce the size of the sum.  That number is also stored in the q val so that it can
 281:../src/rls_m0.c **** // reversed on the m4 side and a real division can take place.   
 282:../src/rls_m0.c **** //
 283:../src/rls_m0.c **** // r0: gpio	register
 284:../src/rls_m0.c **** // r1: scratch 
 285:../src/rls_m0.c **** // r2: lut
 286:../src/rls_m0.c **** // r3: prev line
 287:../src/rls_m0.c **** // r4: column 
 288:../src/rls_m0.c **** // r5: scratch
 289:../src/rls_m0.c **** // r6: scratch
 290:../src/rls_m0.c **** // r7: prev model
 291:../src/rls_m0.c **** // r8: sum
 292:../src/rls_m0.c **** // r9: ending column
 293:../src/rls_m0.c **** // r10: beginning column of run-length
 294:../src/rls_m0.c **** // r11: last lut val
 295:../src/rls_m0.c **** // r12:	q memory
 296:../src/rls_m0.c **** 
 297:../src/rls_m0.c **** //		PRESERVE8
 298:../src/rls_m0.c **** 
 299:../src/rls_m0.c **** asm(".syntax unified");
 242              		.loc 1 299 0
 243              		.syntax divided
 244              	@ 299 "../src/rls_m0.c" 1
 245              		.syntax unified
 246              	@ 0 "" 2
 300:../src/rls_m0.c **** 	asm("PUSH	{r1-r7}");
 247              		.loc 1 300 0
 248              	@ 300 "../src/rls_m0.c" 1
 249 000e FEB4     		PUSH	{r1-r7}
 250              	@ 0 "" 2
 301:../src/rls_m0.c **** 	// bring in ending column
 302:../src/rls_m0.c **** 	asm("LDR	r4, [sp, #0x20]");
 251              		.loc 1 302 0
 252              	@ 302 "../src/rls_m0.c" 1
 253 0010 089C     		LDR	r4, [sp, #0x20]
 254              	@ 0 "" 2
 303:../src/rls_m0.c **** 	asm("MOV	r9, r4");
 255              		.loc 1 303 0
 256              	@ 303 "../src/rls_m0.c" 1
 257 0012 A146     		MOV	r9, r4
 258              	@ 0 "" 2
 304:../src/rls_m0.c **** 	asm("MOVS	r5, #0x1");
 259              		.loc 1 304 0
 260              	@ 304 "../src/rls_m0.c" 1
 261 0014 0125     		MOVS	r5, #0x1
 262              	@ 0 "" 2
 305:../src/rls_m0.c **** 	asm("LSLS	r5, #11");
 263              		.loc 1 305 0
 264              	@ 305 "../src/rls_m0.c" 1
 265 0016 ED02     		LSLS	r5, #11
 266              	@ 0 "" 2
 306:../src/rls_m0.c **** 
 307:../src/rls_m0.c **** 	asm("PUSH	{r0-r3}"); // save args
 267              		.loc 1 307 0
 268              	@ 307 "../src/rls_m0.c" 1
 269 0018 0FB4     		PUSH	{r0-r3}
 270              	@ 0 "" 2
 308:../src/rls_m0.c **** 	asm("BL.W	callSyncM1"); // get pixel sync
 271              		.loc 1 308 0
 272              	@ 308 "../src/rls_m0.c" 1
 273 001a FFF7FEFF 		BL.W	callSyncM1
 274              	@ 0 "" 2
 309:../src/rls_m0.c **** 	asm("POP	{r0-r3}");	// restore args
 275              		.loc 1 309 0
 276              	@ 309 "../src/rls_m0.c" 1
 277 001e 0FBC     		POP	{r0-r3}
 278              	@ 0 "" 2
 310:../src/rls_m0.c **** 
 311:../src/rls_m0.c **** 	// pixel sync starts here
 312:../src/rls_m0.c **** 
 313:../src/rls_m0.c **** 	// wait for hsync to go high
 314:../src/rls_m0.c **** asm("dest12A:");
 279              		.loc 1 314 0
 280              	@ 314 "../src/rls_m0.c" 1
 281              		dest12A:
 282              	@ 0 "" 2
 315:../src/rls_m0.c **** 	asm("LDR 	r6, [r0]"); 	// 2
 283              		.loc 1 315 0
 284              	@ 315 "../src/rls_m0.c" 1
 285 0020 0668     		LDR 	r6, [r0]
 286              	@ 0 "" 2
 316:../src/rls_m0.c **** 	asm("TST	r6, r5");		// 1
 287              		.loc 1 316 0
 288              	@ 316 "../src/rls_m0.c" 1
 289 0022 2E42     		TST	r6, r5
 290              	@ 0 "" 2
 317:../src/rls_m0.c **** 	asm("BEQ	dest12A");	// 3
 291              		.loc 1 317 0
 292              	@ 317 "../src/rls_m0.c" 1
 293 0024 FCD0     		BEQ	dest12A
 294              	@ 0 "" 2
 318:../src/rls_m0.c **** 
 319:../src/rls_m0.c **** 	// variable delay --- get correct phase for sampling
 320:../src/rls_m0.c **** 	asm("MOV	r12, r1"); // save q memory
 295              		.loc 1 320 0
 296              	@ 320 "../src/rls_m0.c" 1
 297 0026 8C46     		MOV	r12, r1
 298              	@ 0 "" 2
 321:../src/rls_m0.c **** 	asm("MOVS	r4, #0"); // clear column value
 299              		.loc 1 321 0
 300              	@ 321 "../src/rls_m0.c" 1
 301 0028 0024     		MOVS	r4, #0
 302              	@ 0 "" 2
 322:../src/rls_m0.c **** 
 323:../src/rls_m0.c **** 	// *** PIXEL SYNC (start reading pixels)
 324:../src/rls_m0.c **** 	asm(GREEN);
 303              		.loc 1 324 0
 304              	@ 324 "../src/rls_m0.c" 1
 305 002a 0578     		LDRB   r5, [r0]
 306              	@ 0 "" 2
 325:../src/rls_m0.c **** 	// cycle
 326:../src/rls_m0.c **** 	asm("NOP");
 307              		.loc 1 326 0
 308              	@ 326 "../src/rls_m0.c" 1
 309 002c C046     		NOP
 310              	@ 0 "" 2
 327:../src/rls_m0.c **** 	asm("NOP");
 311              		.loc 1 327 0
 312              	@ 327 "../src/rls_m0.c" 1
 313 002e C046     		NOP
 314              	@ 0 "" 2
 328:../src/rls_m0.c **** 	asm("NOP");
 315              		.loc 1 328 0
 316              	@ 328 "../src/rls_m0.c" 1
 317 0030 C046     		NOP
 318              	@ 0 "" 2
 329:../src/rls_m0.c **** 	asm("NOP");
 319              		.loc 1 329 0
 320              	@ 329 "../src/rls_m0.c" 1
 321 0032 C046     		NOP
 322              	@ 0 "" 2
 330:../src/rls_m0.c **** 	asm("NOP");
 323              		.loc 1 330 0
 324              	@ 330 "../src/rls_m0.c" 1
 325 0034 C046     		NOP
 326              	@ 0 "" 2
 331:../src/rls_m0.c **** 	asm("NOP");
 327              		.loc 1 331 0
 328              	@ 331 "../src/rls_m0.c" 1
 329 0036 C046     		NOP
 330              	@ 0 "" 2
 332:../src/rls_m0.c **** 
 333:../src/rls_m0.c **** asm("zero0:");
 331              		.loc 1 333 0
 332              	@ 333 "../src/rls_m0.c" 1
 333              		zero0:
 334              	@ 0 "" 2
 334:../src/rls_m0.c **** 	asm("MOVS	r6, #0");
 335              		.loc 1 334 0
 336              	@ 334 "../src/rls_m0.c" 1
 337 0038 0026     		MOVS	r6, #0
 338              	@ 0 "" 2
 335:../src/rls_m0.c **** 	asm("MOV	r8, r6");	// clear sum (so we don't think we have an outstanding segment)
 339              		.loc 1 335 0
 340              	@ 335 "../src/rls_m0.c" 1
 341 003a B046     		MOV	r8, r6
 342              	@ 0 "" 2
 336:../src/rls_m0.c **** 	EOL_CHECK;
 343              		.loc 1 336 0
 344              	@ 336 "../src/rls_m0.c" 1
 345 003c 4C45     		CMP r4, r9 
 346 003e 61DA     		BGE eol
 347              	@ 0 "" 2
 337:../src/rls_m0.c **** 	// cycle
 338:../src/rls_m0.c **** 	// *** PIXEL SYNC (check for nonzero lut value)
 339:../src/rls_m0.c **** asm("zero1:");
 348              		.loc 1 339 0
 349              	@ 339 "../src/rls_m0.c" 1
 350              		zero1:
 351              	@ 0 "" 2
 340:../src/rls_m0.c **** 	//LEXT r7
 341:../src/rls_m0.c **** //	MACRO // create index, lookup, inc col, extract model
 342:../src/rls_m0.c **** //	$lx		LEXT	$rx
 343:../src/rls_m0.c **** 	asm(RED);
 352              		.loc 1 343 0
 353              	@ 343 "../src/rls_m0.c" 1
 354 0040 0678     		LDRB   r6, [r0]
 355              	@ 0 "" 2
 344:../src/rls_m0.c **** 	// cycle
 345:../src/rls_m0.c **** 	asm("SUBS	r6, r5");   // red-green
 356              		.loc 1 345 0
 357              	@ 345 "../src/rls_m0.c" 1
 358 0042 761B     		SUBS	r6, r5
 359              	@ 0 "" 2
 346:../src/rls_m0.c **** 	asm("ASRS	r6, #1");	 // reduce 9 to 8 bits arithmetically
 360              		.loc 1 346 0
 361              	@ 346 "../src/rls_m0.c" 1
 362 0044 7610     		ASRS	r6, #1
 363              	@ 0 "" 2
 347:../src/rls_m0.c **** 	asm("LSLS	r6, #24");  // shift red-green and get rid of higher-order bits
 364              		.loc 1 347 0
 365              	@ 347 "../src/rls_m0.c" 1
 366 0046 3606     		LSLS	r6, #24
 367              	@ 0 "" 2
 348:../src/rls_m0.c **** 	asm("LSRS	r6, #16");  // shift red-green back, make it the higher 8 bits of the index
 368              		.loc 1 348 0
 369              	@ 348 "../src/rls_m0.c" 1
 370 0048 360C     		LSRS	r6, #16
 371              	@ 0 "" 2
 349:../src/rls_m0.c **** 	asm("LDRB	r5, [r3, r4]"); // load blue-green val
 372              		.loc 1 349 0
 373              	@ 349 "../src/rls_m0.c" 1
 374 004a 1D5D     		LDRB	r5, [r3, r4]
 375              	@ 0 "" 2
 350:../src/rls_m0.c **** 	// cycle
 351:../src/rls_m0.c **** 	asm("ORRS	r5, r6");   // form 16-bit index
 376              		.loc 1 351 0
 377              	@ 351 "../src/rls_m0.c" 1
 378 004c 3543     		ORRS	r5, r6
 379              	@ 0 "" 2
 352:../src/rls_m0.c **** 	asm("LDRB	r1, [r2, r5]"); // load lut val
 380              		.loc 1 352 0
 381              	@ 352 "../src/rls_m0.c" 1
 382 004e 515D     		LDRB	r1, [r2, r5]
 383              	@ 0 "" 2
 353:../src/rls_m0.c **** 	// cycle
 354:../src/rls_m0.c **** 	asm("ADDS 	r4, #1"); // inc col
 384              		.loc 1 354 0
 385              	@ 354 "../src/rls_m0.c" 1
 386 0050 0134     		ADDS 	r4, #1
 387              	@ 0 "" 2
 355:../src/rls_m0.c **** 	// *** PIXEL SYNC
 356:../src/rls_m0.c **** 	asm(GREEN);
 388              		.loc 1 356 0
 389              	@ 356 "../src/rls_m0.c" 1
 390 0052 0578     		LDRB   r5, [r0]
 391              	@ 0 "" 2
 357:../src/rls_m0.c **** 	// cycle
 358:../src/rls_m0.c **** 	asm("LSLS	r7, r1, #29"); // knock off msb's
 392              		.loc 1 358 0
 393              	@ 358 "../src/rls_m0.c" 1
 394 0054 4F07     		LSLS	r7, r1, #29
 395              	@ 0 "" 2
 359:../src/rls_m0.c **** 	asm("LSRS	r7, #29"); // extract model, put in rx
 396              		.loc 1 359 0
 397              	@ 359 "../src/rls_m0.c" 1
 398 0056 7F0F     		LSRS	r7, #29
 399              	@ 0 "" 2
 360:../src/rls_m0.c **** 	//MEND
 361:../src/rls_m0.c **** 
 362:../src/rls_m0.c **** 	// cycle
 363:../src/rls_m0.c **** 	// cycle
 364:../src/rls_m0.c **** 	// cycle
 365:../src/rls_m0.c **** 	asm("CMP 	r7, #0");
 400              		.loc 1 365 0
 401              	@ 365 "../src/rls_m0.c" 1
 402 0058 002F     		CMP 	r7, #0
 403              	@ 0 "" 2
 366:../src/rls_m0.c **** 	asm("BEQ 	zero0");
 404              		.loc 1 366 0
 405              	@ 366 "../src/rls_m0.c" 1
 406 005a EDD0     		BEQ 	zero0
 407              	@ 0 "" 2
 367:../src/rls_m0.c **** 	asm("MOV	r10, r4"); // save start column
 408              		.loc 1 367 0
 409              	@ 367 "../src/rls_m0.c" 1
 410 005c A246     		MOV	r10, r4
 411              	@ 0 "" 2
 368:../src/rls_m0.c **** 	asm("ADD	r8, r1"); // add to sum
 412              		.loc 1 368 0
 413              	@ 368 "../src/rls_m0.c" 1
 414 005e 8844     		ADD	r8, r1
 415              	@ 0 "" 2
 369:../src/rls_m0.c **** 	EOL_CHECK;
 416              		.loc 1 369 0
 417              	@ 369 "../src/rls_m0.c" 1
 418 0060 4C45     		CMP r4, r9 
 419 0062 4FDA     		BGE eol
 420              	@ 0 "" 2
 370:../src/rls_m0.c **** 	// cycle
 371:../src/rls_m0.c **** 	asm("NOP");
 421              		.loc 1 371 0
 422              	@ 371 "../src/rls_m0.c" 1
 423 0064 C046     		NOP
 424              	@ 0 "" 2
 372:../src/rls_m0.c **** 	asm("NOP");
 425              		.loc 1 372 0
 426              	@ 372 "../src/rls_m0.c" 1
 427 0066 C046     		NOP
 428              	@ 0 "" 2
 373:../src/rls_m0.c **** 	// *** PIXEL SYNC (check nonzero value for consistency)
 374:../src/rls_m0.c **** //	LEXT r6;
 375:../src/rls_m0.c **** 	asm(RED);
 429              		.loc 1 375 0
 430              	@ 375 "../src/rls_m0.c" 1
 431 0068 0678     		LDRB   r6, [r0]
 432              	@ 0 "" 2
 376:../src/rls_m0.c **** 	asm("SUBS	r6, r5");   // red-green
 433              		.loc 1 376 0
 434              	@ 376 "../src/rls_m0.c" 1
 435 006a 761B     		SUBS	r6, r5
 436              	@ 0 "" 2
 377:../src/rls_m0.c **** 	asm("ASRS	r6, #1");	 // reduce 9 to 8 bits arithmetically
 437              		.loc 1 377 0
 438              	@ 377 "../src/rls_m0.c" 1
 439 006c 7610     		ASRS	r6, #1
 440              	@ 0 "" 2
 378:../src/rls_m0.c **** 	asm("LSLS	r6, #24");  // shift red-green and get rid of higher-order bits
 441              		.loc 1 378 0
 442              	@ 378 "../src/rls_m0.c" 1
 443 006e 3606     		LSLS	r6, #24
 444              	@ 0 "" 2
 379:../src/rls_m0.c **** 	asm("LSRS	r6, #16");  // shift red-green back, make it the higher 8 bits of the index
 445              		.loc 1 379 0
 446              	@ 379 "../src/rls_m0.c" 1
 447 0070 360C     		LSRS	r6, #16
 448              	@ 0 "" 2
 380:../src/rls_m0.c **** 	asm("LDRB	r5, [r3, r4]"); // load blue-green val
 449              		.loc 1 380 0
 450              	@ 380 "../src/rls_m0.c" 1
 451 0072 1D5D     		LDRB	r5, [r3, r4]
 452              	@ 0 "" 2
 381:../src/rls_m0.c **** 	asm("ORRS	r5, r6");   // form 16-bit index
 453              		.loc 1 381 0
 454              	@ 381 "../src/rls_m0.c" 1
 455 0074 3543     		ORRS	r5, r6
 456              	@ 0 "" 2
 382:../src/rls_m0.c **** 	asm("LDRB	r1, [r2, r5]"); // load lut val
 457              		.loc 1 382 0
 458              	@ 382 "../src/rls_m0.c" 1
 459 0076 515D     		LDRB	r1, [r2, r5]
 460              	@ 0 "" 2
 383:../src/rls_m0.c **** 	asm("ADDS 	r4, #1"); // inc col
 461              		.loc 1 383 0
 462              	@ 383 "../src/rls_m0.c" 1
 463 0078 0134     		ADDS 	r4, #1
 464              	@ 0 "" 2
 384:../src/rls_m0.c **** 	// *** PIXEL SYNC
 385:../src/rls_m0.c **** 	asm(GREEN);
 465              		.loc 1 385 0
 466              	@ 385 "../src/rls_m0.c" 1
 467 007a 0578     		LDRB   r5, [r0]
 468              	@ 0 "" 2
 386:../src/rls_m0.c **** 	// cycle
 387:../src/rls_m0.c **** 	asm("LSLS	r6, r1, #29"); // knock off msb's
 469              		.loc 1 387 0
 470              	@ 387 "../src/rls_m0.c" 1
 471 007c 4E07     		LSLS	r6, r1, #29
 472              	@ 0 "" 2
 388:../src/rls_m0.c **** 	asm("LSRS	r6, #29"); // extract model, put in rx
 473              		.loc 1 388 0
 474              	@ 388 "../src/rls_m0.c" 1
 475 007e 760F     		LSRS	r6, #29
 476              	@ 0 "" 2
 389:../src/rls_m0.c **** // end of LEXT r6
 390:../src/rls_m0.c **** 
 391:../src/rls_m0.c **** 	// cycle
 392:../src/rls_m0.c **** 	// cycle
 393:../src/rls_m0.c **** 	// cycle
 394:../src/rls_m0.c **** 	asm("CMP	r6, r7");
 477              		.loc 1 394 0
 478              	@ 394 "../src/rls_m0.c" 1
 479 0080 BE42     		CMP	r6, r7
 480              	@ 0 "" 2
 395:../src/rls_m0.c **** 	asm("BNE	zero0");
 481              		.loc 1 395 0
 482              	@ 395 "../src/rls_m0.c" 1
 483 0082 D9D1     		BNE	zero0
 484              	@ 0 "" 2
 396:../src/rls_m0.c **** 	asm("NOP");
 485              		.loc 1 396 0
 486              	@ 396 "../src/rls_m0.c" 1
 487 0084 C046     		NOP
 488              	@ 0 "" 2
 397:../src/rls_m0.c **** 	asm("NOP");
 489              		.loc 1 397 0
 490              	@ 397 "../src/rls_m0.c" 1
 491 0086 C046     		NOP
 492              	@ 0 "" 2
 398:../src/rls_m0.c **** asm("one:");
 493              		.loc 1 398 0
 494              	@ 398 "../src/rls_m0.c" 1
 495              		one:
 496              	@ 0 "" 2
 399:../src/rls_m0.c **** 	asm("MOV	r11, r1");	// save last lut val
 497              		.loc 1 399 0
 498              	@ 399 "../src/rls_m0.c" 1
 499 0088 8B46     		MOV	r11, r1
 500              	@ 0 "" 2
 400:../src/rls_m0.c **** 	asm("ADD	r8, r1"); // add to sum
 501              		.loc 1 400 0
 502              	@ 400 "../src/rls_m0.c" 1
 503 008a 8844     		ADD	r8, r1
 504              	@ 0 "" 2
 401:../src/rls_m0.c **** 	EOL_CHECK;
 505              		.loc 1 401 0
 506              	@ 401 "../src/rls_m0.c" 1
 507 008c 4C45     		CMP r4, r9 
 508 008e 39DA     		BGE eol
 509              	@ 0 "" 2
 402:../src/rls_m0.c **** 	// cycle
 403:../src/rls_m0.c **** 	// *** PIXEL SYNC (run-length segment)
 404:../src/rls_m0.c **** 
 405:../src/rls_m0.c **** //	LEXT r6
 406:../src/rls_m0.c **** 	asm(RED);
 510              		.loc 1 406 0
 511              	@ 406 "../src/rls_m0.c" 1
 512 0090 0678     		LDRB   r6, [r0]
 513              	@ 0 "" 2
 407:../src/rls_m0.c **** 	// cycle
 408:../src/rls_m0.c **** 	asm("SUBS	r6, r5");   // red-green
 514              		.loc 1 408 0
 515              	@ 408 "../src/rls_m0.c" 1
 516 0092 761B     		SUBS	r6, r5
 517              	@ 0 "" 2
 409:../src/rls_m0.c **** 	asm("ASRS	r6, #1");	 // reduce 9 to 8 bits arithmetically
 518              		.loc 1 409 0
 519              	@ 409 "../src/rls_m0.c" 1
 520 0094 7610     		ASRS	r6, #1
 521              	@ 0 "" 2
 410:../src/rls_m0.c **** 	asm("LSLS	r6, #24");  // shift red-green and get rid of higher-order bits
 522              		.loc 1 410 0
 523              	@ 410 "../src/rls_m0.c" 1
 524 0096 3606     		LSLS	r6, #24
 525              	@ 0 "" 2
 411:../src/rls_m0.c **** 	asm("LSRS	r6, #16");  // shift red-green back, make it the higher 8 bits of the index
 526              		.loc 1 411 0
 527              	@ 411 "../src/rls_m0.c" 1
 528 0098 360C     		LSRS	r6, #16
 529              	@ 0 "" 2
 412:../src/rls_m0.c **** 	asm("LDRB	r5, [r3, r4]"); // load blue-green val
 530              		.loc 1 412 0
 531              	@ 412 "../src/rls_m0.c" 1
 532 009a 1D5D     		LDRB	r5, [r3, r4]
 533              	@ 0 "" 2
 413:../src/rls_m0.c **** 	// cycle
 414:../src/rls_m0.c **** 	asm("ORRS	r5, r6");   // form 16-bit index
 534              		.loc 1 414 0
 535              	@ 414 "../src/rls_m0.c" 1
 536 009c 3543     		ORRS	r5, r6
 537              	@ 0 "" 2
 415:../src/rls_m0.c **** 	asm("LDRB	r1, [r2, r5]"); // load lut val
 538              		.loc 1 415 0
 539              	@ 415 "../src/rls_m0.c" 1
 540 009e 515D     		LDRB	r1, [r2, r5]
 541              	@ 0 "" 2
 416:../src/rls_m0.c **** 	// cycle
 417:../src/rls_m0.c **** 	asm("ADDS 	r4, #1"); // inc col
 542              		.loc 1 417 0
 543              	@ 417 "../src/rls_m0.c" 1
 544 00a0 0134     		ADDS 	r4, #1
 545              	@ 0 "" 2
 418:../src/rls_m0.c **** 	// *** PIXEL SYNC
 419:../src/rls_m0.c **** 	asm(GREEN);
 546              		.loc 1 419 0
 547              	@ 419 "../src/rls_m0.c" 1
 548 00a2 0578     		LDRB   r5, [r0]
 549              	@ 0 "" 2
 420:../src/rls_m0.c **** 	// cycle
 421:../src/rls_m0.c **** 	asm("LSLS	r6, r1, #29"); // knock off msb's
 550              		.loc 1 421 0
 551              	@ 421 "../src/rls_m0.c" 1
 552 00a4 4E07     		LSLS	r6, r1, #29
 553              	@ 0 "" 2
 422:../src/rls_m0.c **** 	asm("LSRS	r6, #29"); // extract model, put in rx
 554              		.loc 1 422 0
 555              	@ 422 "../src/rls_m0.c" 1
 556 00a6 760F     		LSRS	r6, #29
 557              	@ 0 "" 2
 423:../src/rls_m0.c **** // end of LEXT
 424:../src/rls_m0.c **** 
 425:../src/rls_m0.c **** 	// cycle
 426:../src/rls_m0.c **** 	// cycle
 427:../src/rls_m0.c **** 	// cycle
 428:../src/rls_m0.c **** 	asm("CMP	r6, r7");
 558              		.loc 1 428 0
 559              	@ 428 "../src/rls_m0.c" 1
 560 00a8 BE42     		CMP	r6, r7
 561              	@ 0 "" 2
 429:../src/rls_m0.c **** 	asm("BEQ	one");
 562              		.loc 1 429 0
 563              	@ 429 "../src/rls_m0.c" 1
 564 00aa EDD0     		BEQ	one
 565              	@ 0 "" 2
 430:../src/rls_m0.c **** 	asm("ADD	r8, r11"); // need to add something-- use last lut val
 566              		.loc 1 430 0
 567              	@ 430 "../src/rls_m0.c" 1
 568 00ac D844     		ADD	r8, r11
 569              	@ 0 "" 2
 431:../src/rls_m0.c **** 	EOL_CHECK;
 570              		.loc 1 431 0
 571              	@ 431 "../src/rls_m0.c" 1
 572 00ae 4C45     		CMP r4, r9 
 573 00b0 28DA     		BGE eol
 574              	@ 0 "" 2
 432:../src/rls_m0.c **** 	// cycle
 433:../src/rls_m0.c **** 	asm("NOP");
 575              		.loc 1 433 0
 576              	@ 433 "../src/rls_m0.c" 1
 577 00b2 C046     		NOP
 578              	@ 0 "" 2
 434:../src/rls_m0.c **** 	asm("NOP");
 579              		.loc 1 434 0
 580              	@ 434 "../src/rls_m0.c" 1
 581 00b4 C046     		NOP
 582              	@ 0 "" 2
 435:../src/rls_m0.c **** 	asm("NOP");
 583              		.loc 1 435 0
 584              	@ 435 "../src/rls_m0.c" 1
 585 00b6 C046     		NOP
 586              	@ 0 "" 2
 436:../src/rls_m0.c **** 	// *** PIXEL SYNC (1st pixel not equal)
 437:../src/rls_m0.c **** 
 438:../src/rls_m0.c **** //	LEXT r6
 439:../src/rls_m0.c **** 	asm(RED);
 587              		.loc 1 439 0
 588              	@ 439 "../src/rls_m0.c" 1
 589 00b8 0678     		LDRB   r6, [r0]
 590              	@ 0 "" 2
 440:../src/rls_m0.c **** 	// cycle
 441:../src/rls_m0.c **** 	asm("SUBS	r6, r5");   // red-green
 591              		.loc 1 441 0
 592              	@ 441 "../src/rls_m0.c" 1
 593 00ba 761B     		SUBS	r6, r5
 594              	@ 0 "" 2
 442:../src/rls_m0.c **** 	asm("ASRS	r6, #1");	 // reduce 9 to 8 bits arithmetically
 595              		.loc 1 442 0
 596              	@ 442 "../src/rls_m0.c" 1
 597 00bc 7610     		ASRS	r6, #1
 598              	@ 0 "" 2
 443:../src/rls_m0.c **** 	asm("LSLS	r6, #24");  // shift red-green and get rid of higher-order bits
 599              		.loc 1 443 0
 600              	@ 443 "../src/rls_m0.c" 1
 601 00be 3606     		LSLS	r6, #24
 602              	@ 0 "" 2
 444:../src/rls_m0.c **** 	asm("LSRS	r6, #16");  // shift red-green back, make it the higher 8 bits of the index
 603              		.loc 1 444 0
 604              	@ 444 "../src/rls_m0.c" 1
 605 00c0 360C     		LSRS	r6, #16
 606              	@ 0 "" 2
 445:../src/rls_m0.c **** 	asm("LDRB	r5, [r3, r4]"); // load blue-green val
 607              		.loc 1 445 0
 608              	@ 445 "../src/rls_m0.c" 1
 609 00c2 1D5D     		LDRB	r5, [r3, r4]
 610              	@ 0 "" 2
 446:../src/rls_m0.c **** 	// cycle
 447:../src/rls_m0.c **** 	asm("ORRS	r5, r6");   // form 16-bit index
 611              		.loc 1 447 0
 612              	@ 447 "../src/rls_m0.c" 1
 613 00c4 3543     		ORRS	r5, r6
 614              	@ 0 "" 2
 448:../src/rls_m0.c **** 	asm("LDRB	r1, [r2, r5]"); // load lut val
 615              		.loc 1 448 0
 616              	@ 448 "../src/rls_m0.c" 1
 617 00c6 515D     		LDRB	r1, [r2, r5]
 618              	@ 0 "" 2
 449:../src/rls_m0.c **** 	// cycle
 450:../src/rls_m0.c **** 	asm("ADDS 	r4, #1"); // inc col
 619              		.loc 1 450 0
 620              	@ 450 "../src/rls_m0.c" 1
 621 00c8 0134     		ADDS 	r4, #1
 622              	@ 0 "" 2
 451:../src/rls_m0.c **** 	// *** PIXEL SYNC
 452:../src/rls_m0.c **** 	asm(GREEN);
 623              		.loc 1 452 0
 624              	@ 452 "../src/rls_m0.c" 1
 625 00ca 0578     		LDRB   r5, [r0]
 626              	@ 0 "" 2
 453:../src/rls_m0.c **** 	// cycle
 454:../src/rls_m0.c **** 	asm("LSLS	r6, r1, #29"); // knock off msb's
 627              		.loc 1 454 0
 628              	@ 454 "../src/rls_m0.c" 1
 629 00cc 4E07     		LSLS	r6, r1, #29
 630              	@ 0 "" 2
 455:../src/rls_m0.c **** 	asm("LSRS	r6, #29"); // extract model, put in rx
 631              		.loc 1 455 0
 632              	@ 455 "../src/rls_m0.c" 1
 633 00ce 760F     		LSRS	r6, #29
 634              	@ 0 "" 2
 456:../src/rls_m0.c **** // end of LEXT
 457:../src/rls_m0.c **** 
 458:../src/rls_m0.c **** 	// cycle
 459:../src/rls_m0.c **** 	// cycle
 460:../src/rls_m0.c **** 	// cycle
 461:../src/rls_m0.c **** 	asm("CMP	r6, r7");
 635              		.loc 1 461 0
 636              	@ 461 "../src/rls_m0.c" 1
 637 00d0 BE42     		CMP	r6, r7
 638              	@ 0 "" 2
 462:../src/rls_m0.c **** 	asm("BEQ	one");
 639              		.loc 1 462 0
 640              	@ 462 "../src/rls_m0.c" 1
 641 00d2 D9D0     		BEQ	one
 642              	@ 0 "" 2
 463:../src/rls_m0.c **** 	// 2nd pixel not equal--- run length is done
 464:../src/rls_m0.c **** 	QVAL;
 643              		.loc 1 464 0
 644              	@ 464 "../src/rls_m0.c" 1
 645 00d4 5546     		MOV 	r5, r10
 646              	@ 0 "" 2
 647              	@ 464 "../src/rls_m0.c" 1
 648 00d6 EE00     		LSLS 	r6, r5, #3
 649              	@ 0 "" 2
 650              	@ 464 "../src/rls_m0.c" 1
 651 00d8 3E43     		ORRS	r6, r7
 652              	@ 0 "" 2
 653              	@ 464 "../src/rls_m0.c" 1
 654 00da 611B     		SUBS  	r1, r4, r5
 655              	@ 0 "" 2
 656              	@ 464 "../src/rls_m0.c" 1
 657 00dc 0D03     		LSLS 	r5, r1, #12
 658              	@ 0 "" 2
 659              	@ 464 "../src/rls_m0.c" 1
 660 00de 2E43     		ORRS 	r6, r5
 661              	@ 0 "" 2
 662              	@ 464 "../src/rls_m0.c" 1
 663 00e0 099D     		LDR	r5, [sp, #0x24]
 664              	@ 0 "" 2
 665              	@ 464 "../src/rls_m0.c" 1
 666 00e2 495D     		LDRB 	r1, [r1, r5]
 667              	@ 0 "" 2
 668              	@ 464 "../src/rls_m0.c" 1
 669 00e4 4546     		MOV 	r5, r8
 670              	@ 0 "" 2
 671              	@ 464 "../src/rls_m0.c" 1
 672 00e6 CD40     		LSRS 	r5, r1
 673              	@ 0 "" 2
 674              	@ 464 "../src/rls_m0.c" 1
 675 00e8 6D05     		LSLS	r5, #21
 676              	@ 0 "" 2
 677              	@ 464 "../src/rls_m0.c" 1
 678 00ea 2E43     		ORRS 	r6, r5
 679              	@ 0 "" 2
 680              	@ 464 "../src/rls_m0.c" 1
 681 00ec 0907     		LSLS 	r1, #28
 682              	@ 0 "" 2
 683              	@ 464 "../src/rls_m0.c" 1
 684 00ee 0E43     		ORRS	r6, r1
 685              	@ 0 "" 2
 686              	@ 464 "../src/rls_m0.c" 1
 687 00f0 6146     		MOV 	r1, r12
 688              	@ 0 "" 2
 689              	@ 464 "../src/rls_m0.c" 1
 690 00f2 0427     		MOVS 	r7, #4
 691              	@ 0 "" 2
 692              	@ 464 "../src/rls_m0.c" 1
 693 00f4 0578     		LDRB   r5, [r0]
 694              	@ 0 "" 2
 695              	@ 464 "../src/rls_m0.c" 1
 696 00f6 0E60     		STR 	r6, [r1]
 697              	@ 0 "" 2
 698              	@ 464 "../src/rls_m0.c" 1
 699 00f8 BC44     		ADD  	r12, r7
 700              	@ 0 "" 2
 465:../src/rls_m0.c **** 	asm("MOVS	r6, #0");
 701              		.loc 1 465 0
 702              	@ 465 "../src/rls_m0.c" 1
 703 00fa 0026     		MOVS	r6, #0
 704              	@ 0 "" 2
 466:../src/rls_m0.c **** 	asm("MOV	r8, r6"); // clear sum
 705              		.loc 1 466 0
 706              	@ 466 "../src/rls_m0.c" 1
 707 00fc B046     		MOV	r8, r6
 708              	@ 0 "" 2
 467:../src/rls_m0.c **** 	asm("ADDS	r4, #1"); // add column
 709              		.loc 1 467 0
 710              	@ 467 "../src/rls_m0.c" 1
 711 00fe 0134     		ADDS	r4, #1
 712              	@ 0 "" 2
 468:../src/rls_m0.c **** 	asm("NOP");
 713              		.loc 1 468 0
 714              	@ 468 "../src/rls_m0.c" 1
 715 0100 C046     		NOP
 716              	@ 0 "" 2
 469:../src/rls_m0.c **** 	asm("B 		zero1");
 717              		.loc 1 469 0
 718              	@ 469 "../src/rls_m0.c" 1
 719 0102 9DE7     		B 		zero1
 720              	@ 0 "" 2
 470:../src/rls_m0.c **** 
 471:../src/rls_m0.c **** asm("eol:");
 721              		.loc 1 471 0
 722              	@ 471 "../src/rls_m0.c" 1
 723              		eol:
 724              	@ 0 "" 2
 472:../src/rls_m0.c **** 	// check r8 for unfinished q val
 473:../src/rls_m0.c **** 	asm("MOVS	r6, #0");
 725              		.loc 1 473 0
 726              	@ 473 "../src/rls_m0.c" 1
 727 0104 0026     		MOVS	r6, #0
 728              	@ 0 "" 2
 474:../src/rls_m0.c **** 	asm("CMP	r8, r6");
 729              		.loc 1 474 0
 730              	@ 474 "../src/rls_m0.c" 1
 731 0106 B045     		CMP	r8, r6
 732              	@ 0 "" 2
 475:../src/rls_m0.c **** 	asm("BEQ	eol0");
 733              		.loc 1 475 0
 734              	@ 475 "../src/rls_m0.c" 1
 735 0108 12D0     		BEQ	eol0
 736              	@ 0 "" 2
 476:../src/rls_m0.c **** 	QVAL;
 737              		.loc 1 476 0
 738              	@ 476 "../src/rls_m0.c" 1
 739 010a 5546     		MOV 	r5, r10
 740              	@ 0 "" 2
 741              	@ 476 "../src/rls_m0.c" 1
 742 010c EE00     		LSLS 	r6, r5, #3
 743              	@ 0 "" 2
 744              	@ 476 "../src/rls_m0.c" 1
 745 010e 3E43     		ORRS	r6, r7
 746              	@ 0 "" 2
 747              	@ 476 "../src/rls_m0.c" 1
 748 0110 611B     		SUBS  	r1, r4, r5
 749              	@ 0 "" 2
 750              	@ 476 "../src/rls_m0.c" 1
 751 0112 0D03     		LSLS 	r5, r1, #12
 752              	@ 0 "" 2
 753              	@ 476 "../src/rls_m0.c" 1
 754 0114 2E43     		ORRS 	r6, r5
 755              	@ 0 "" 2
 756              	@ 476 "../src/rls_m0.c" 1
 757 0116 099D     		LDR	r5, [sp, #0x24]
 758              	@ 0 "" 2
 759              	@ 476 "../src/rls_m0.c" 1
 760 0118 495D     		LDRB 	r1, [r1, r5]
 761              	@ 0 "" 2
 762              	@ 476 "../src/rls_m0.c" 1
 763 011a 4546     		MOV 	r5, r8
 764              	@ 0 "" 2
 765              	@ 476 "../src/rls_m0.c" 1
 766 011c CD40     		LSRS 	r5, r1
 767              	@ 0 "" 2
 768              	@ 476 "../src/rls_m0.c" 1
 769 011e 6D05     		LSLS	r5, #21
 770              	@ 0 "" 2
 771              	@ 476 "../src/rls_m0.c" 1
 772 0120 2E43     		ORRS 	r6, r5
 773              	@ 0 "" 2
 774              	@ 476 "../src/rls_m0.c" 1
 775 0122 0907     		LSLS 	r1, #28
 776              	@ 0 "" 2
 777              	@ 476 "../src/rls_m0.c" 1
 778 0124 0E43     		ORRS	r6, r1
 779              	@ 0 "" 2
 780              	@ 476 "../src/rls_m0.c" 1
 781 0126 6146     		MOV 	r1, r12
 782              	@ 0 "" 2
 783              	@ 476 "../src/rls_m0.c" 1
 784 0128 0427     		MOVS 	r7, #4
 785              	@ 0 "" 2
 786              	@ 476 "../src/rls_m0.c" 1
 787 012a 0578     		LDRB   r5, [r0]
 788              	@ 0 "" 2
 789              	@ 476 "../src/rls_m0.c" 1
 790 012c 0E60     		STR 	r6, [r1]
 791              	@ 0 "" 2
 792              	@ 476 "../src/rls_m0.c" 1
 793 012e BC44     		ADD  	r12, r7
 794              	@ 0 "" 2
 477:../src/rls_m0.c **** 
 478:../src/rls_m0.c **** 	// wait for hsync to go low
 479:../src/rls_m0.c **** asm("eol0:");
 795              		.loc 1 479 0
 796              	@ 479 "../src/rls_m0.c" 1
 797              		eol0:
 798              	@ 0 "" 2
 480:../src/rls_m0.c **** 	asm("MOVS	r5, #0x1");
 799              		.loc 1 480 0
 800              	@ 480 "../src/rls_m0.c" 1
 801 0130 0125     		MOVS	r5, #0x1
 802              	@ 0 "" 2
 481:../src/rls_m0.c **** 	asm("LSLS	r5, #11");
 803              		.loc 1 481 0
 804              	@ 481 "../src/rls_m0.c" 1
 805 0132 ED02     		LSLS	r5, #11
 806              	@ 0 "" 2
 482:../src/rls_m0.c **** 
 483:../src/rls_m0.c **** asm("dest20A:");
 807              		.loc 1 483 0
 808              	@ 483 "../src/rls_m0.c" 1
 809              		dest20A:
 810              	@ 0 "" 2
 484:../src/rls_m0.c **** 	asm("LDR 	r6, [r0]"); 	// 2
 811              		.loc 1 484 0
 812              	@ 484 "../src/rls_m0.c" 1
 813 0134 0668     		LDR 	r6, [r0]
 814              	@ 0 "" 2
 485:../src/rls_m0.c **** 	asm("TST	r6, r5");		// 1
 815              		.loc 1 485 0
 816              	@ 485 "../src/rls_m0.c" 1
 817 0136 2E42     		TST	r6, r5
 818              	@ 0 "" 2
 486:../src/rls_m0.c **** 	asm("BNE	dest20A");	// 3
 819              		.loc 1 486 0
 820              	@ 486 "../src/rls_m0.c" 1
 821 0138 FCD1     		BNE	dest20A
 822              	@ 0 "" 2
 487:../src/rls_m0.c **** 
 488:../src/rls_m0.c **** // we have approx 1800 cycles to do something here
 489:../src/rls_m0.c **** // which is enough time to copy 64 qvals (256 bytes), maximum qvals/line = 320/5
 490:../src/rls_m0.c **** // (this has been verified/tested)
 491:../src/rls_m0.c **** // The advantage of doing this is that we don't need to buffer much data
 492:../src/rls_m0.c **** // and it reduces the latency-- we can start processing qvals immediately
 493:../src/rls_m0.c **** // We need to copy these because the memory the qvals comes from must not be
 494:../src/rls_m0.c **** // accessed by the M4, or wait states will be thrown in and we'll lose pixel sync for that line
 495:../src/rls_m0.c **** 	asm("MOV	r0, r12");  // qval pointer
 823              		.loc 1 495 0
 824              	@ 495 "../src/rls_m0.c" 1
 825 013a 6046     		MOV	r0, r12
 826              	@ 0 "" 2
 496:../src/rls_m0.c **** 	asm("LDR	r1, [sp]"); // bring in original q memory location
 827              		.loc 1 496 0
 828              	@ 496 "../src/rls_m0.c" 1
 829 013c 0099     		LDR	r1, [sp]
 830              	@ 0 "" 2
 497:../src/rls_m0.c **** 	asm("SUBS	r0, r1"); // get number of qvals*4
 831              		.loc 1 497 0
 832              	@ 497 "../src/rls_m0.c" 1
 833 013e 401A     		SUBS	r0, r1
 834              	@ 0 "" 2
 498:../src/rls_m0.c **** 
 499:../src/rls_m0.c **** 	asm("LDR	r2, [sp, #0x28]"); // bring in qq memory pointer
 835              		.loc 1 499 0
 836              	@ 499 "../src/rls_m0.c" 1
 837 0140 0A9A     		LDR	r2, [sp, #0x28]
 838              	@ 0 "" 2
 500:../src/rls_m0.c **** 	asm("LDR	r3, [sp, #0x2c]"); // bring in qq index
 839              		.loc 1 500 0
 840              	@ 500 "../src/rls_m0.c" 1
 841 0142 0B9B     		LDR	r3, [sp, #0x2c]
 842              	@ 0 "" 2
 501:../src/rls_m0.c **** 	asm("LSLS 	r3, #2"); // qq index in bytes (4 bytes/qval)
 843              		.loc 1 501 0
 844              	@ 501 "../src/rls_m0.c" 1
 845 0144 9B00     		LSLS 	r3, #2
 846              	@ 0 "" 2
 502:../src/rls_m0.c **** 	asm("LDR	r4, [sp, #0x30]");; // bring in qq size
 847              		.loc 1 502 0
 848              	@ 502 "../src/rls_m0.c" 1
 849 0146 0C9C     		LDR	r4, [sp, #0x30]
 850              	@ 0 "" 2
 503:../src/rls_m0.c **** 	asm("LSLS 	r4, #2"); // qq size in bytes (4 bytes/qval)
 851              		.loc 1 503 0
 852              	@ 503 "../src/rls_m0.c" 1
 853 0148 A400     		LSLS 	r4, #2
 854              	@ 0 "" 2
 504:../src/rls_m0.c **** 
 505:../src/rls_m0.c **** 	asm("MOVS	r5, #0");
 855              		.loc 1 505 0
 856              	@ 505 "../src/rls_m0.c" 1
 857 014a 0025     		MOVS	r5, #0
 858              	@ 0 "" 2
 506:../src/rls_m0.c **** 
 507:../src/rls_m0.c **** asm("lcpy:");
 859              		.loc 1 507 0
 860              	@ 507 "../src/rls_m0.c" 1
 861              		lcpy:
 862              	@ 0 "" 2
 508:../src/rls_m0.c **** 	asm("CMP	r0, r5");	  // 1 end condition
 863              		.loc 1 508 0
 864              	@ 508 "../src/rls_m0.c" 1
 865 014c A842     		CMP	r0, r5
 866              	@ 0 "" 2
 509:../src/rls_m0.c **** 	asm("BEQ	ecpy");	  // 1 exit
 867              		.loc 1 509 0
 868              	@ 509 "../src/rls_m0.c" 1
 869 014e 08D0     		BEQ	ecpy
 870              	@ 0 "" 2
 510:../src/rls_m0.c **** 
 511:../src/rls_m0.c **** 	asm("LDR	r6, [r1, r5]");  // 2 copy (read)
 871              		.loc 1 511 0
 872              	@ 511 "../src/rls_m0.c" 1
 873 0150 4E59     		LDR	r6, [r1, r5]
 874              	@ 0 "" 2
 512:../src/rls_m0.c **** 	asm("STR	r6, [r2, r3]");  // 2 copy (write)
 875              		.loc 1 512 0
 876              	@ 512 "../src/rls_m0.c" 1
 877 0152 D650     		STR	r6, [r2, r3]
 878              	@ 0 "" 2
 513:../src/rls_m0.c **** 
 514:../src/rls_m0.c **** 	asm("ADDS	r3, #4");	  // 1 inc qq index
 879              		.loc 1 514 0
 880              	@ 514 "../src/rls_m0.c" 1
 881 0154 0433     		ADDS	r3, #4
 882              	@ 0 "" 2
 515:../src/rls_m0.c **** 	asm("ADDS	r5, #4");	  // 1 inc counter
 883              		.loc 1 515 0
 884              	@ 515 "../src/rls_m0.c" 1
 885 0156 0435     		ADDS	r5, #4
 886              	@ 0 "" 2
 516:../src/rls_m0.c **** 
 517:../src/rls_m0.c **** 	asm("CMP	r4, r3");    // 1 check for qq index wrap
 887              		.loc 1 517 0
 888              	@ 517 "../src/rls_m0.c" 1
 889 0158 9C42     		CMP	r4, r3
 890              	@ 0 "" 2
 518:../src/rls_m0.c **** 	asm("BEQ	wrap");	  // 1
 891              		.loc 1 518 0
 892              	@ 518 "../src/rls_m0.c" 1
 893 015a 00D0     		BEQ	wrap
 894              	@ 0 "" 2
 519:../src/rls_m0.c **** 	asm("B		lcpy");	  // 3
 895              		.loc 1 519 0
 896              	@ 519 "../src/rls_m0.c" 1
 897 015c F6E7     		B		lcpy
 898              	@ 0 "" 2
 520:../src/rls_m0.c **** 
 521:../src/rls_m0.c **** asm("wrap:");
 899              		.loc 1 521 0
 900              	@ 521 "../src/rls_m0.c" 1
 901              		wrap:
 902              	@ 0 "" 2
 522:../src/rls_m0.c **** 	asm("MOVS	r3, #0");    // reset qq index
 903              		.loc 1 522 0
 904              	@ 522 "../src/rls_m0.c" 1
 905 015e 0023     		MOVS	r3, #0
 906              	@ 0 "" 2
 523:../src/rls_m0.c **** 	asm("B 		lcpy");
 907              		.loc 1 523 0
 908              	@ 523 "../src/rls_m0.c" 1
 909 0160 F4E7     		B 		lcpy
 910              	@ 0 "" 2
 524:../src/rls_m0.c **** 
 525:../src/rls_m0.c **** asm("ecpy:");
 911              		.loc 1 525 0
 912              	@ 525 "../src/rls_m0.c" 1
 913              		ecpy:
 914              	@ 0 "" 2
 526:../src/rls_m0.c **** 	asm("LSRS   r0, #2"); // return number of qvals
 915              		.loc 1 526 0
 916              	@ 526 "../src/rls_m0.c" 1
 917 0162 8008     		LSRS   r0, #2
 918              	@ 0 "" 2
 527:../src/rls_m0.c **** 	asm("POP	{r1-r7}");
 919              		.loc 1 527 0
 920              	@ 527 "../src/rls_m0.c" 1
 921 0164 FEBC     		POP	{r1-r7}
 922              	@ 0 "" 2
 528:../src/rls_m0.c **** 
 529:../src/rls_m0.c **** 	asm(".syntax divided");
 923              		.loc 1 529 0
 924              	@ 529 "../src/rls_m0.c" 1
 925              		.syntax divided
 926              	@ 0 "" 2
 530:../src/rls_m0.c **** 
 531:../src/rls_m0.c **** }
 927              		.loc 1 531 0
 928              		.thumb
 929              		.syntax unified
 930 0166 C046     		nop
 931 0168 1800     		movs	r0, r3
 932 016a BD46     		mov	sp, r7
 933 016c 04B0     		add	sp, sp, #16
 934              		@ sp needed
 935 016e 80BD     		pop	{r7, pc}
 936              		.cfi_endproc
 937              	.LFE33:
 939              		.section	.text.intLog,"ax",%progbits
 940              		.align	2
 941              		.global	intLog
 942              		.code	16
 943              		.thumb_func
 945              	intLog:
 946              	.LFB34:
 532:../src/rls_m0.c **** 
 533:../src/rls_m0.c **** 
 534:../src/rls_m0.c **** uint8_t intLog(int i)
 535:../src/rls_m0.c **** {
 947              		.loc 1 535 0
 948              		.cfi_startproc
 949 0000 80B5     		push	{r7, lr}
 950              		.cfi_def_cfa_offset 8
 951              		.cfi_offset 7, -8
 952              		.cfi_offset 14, -4
 953 0002 82B0     		sub	sp, sp, #8
 954              		.cfi_def_cfa_offset 16
 955 0004 00AF     		add	r7, sp, #0
 956              		.cfi_def_cfa_register 7
 957 0006 7860     		str	r0, [r7, #4]
 536:../src/rls_m0.c **** 	return 0;
 958              		.loc 1 536 0
 959 0008 0023     		movs	r3, #0
 537:../src/rls_m0.c **** }
 960              		.loc 1 537 0
 961 000a 1800     		movs	r0, r3
 962 000c BD46     		mov	sp, r7
 963 000e 02B0     		add	sp, sp, #8
 964              		@ sp needed
 965 0010 80BD     		pop	{r7, pc}
 966              		.cfi_endproc
 967              	.LFE34:
 969 0012 C046     		.section	.text.createLogLut,"ax",%progbits
 970              		.align	2
 971              		.global	createLogLut
 972              		.code	16
 973              		.thumb_func
 975              	createLogLut:
 976              	.LFB35:
 538:../src/rls_m0.c **** 
 539:../src/rls_m0.c **** 
 540:../src/rls_m0.c **** void createLogLut(void)
 541:../src/rls_m0.c **** {
 977              		.loc 1 541 0
 978              		.cfi_startproc
 979 0000 90B5     		push	{r4, r7, lr}
 980              		.cfi_def_cfa_offset 12
 981              		.cfi_offset 4, -12
 982              		.cfi_offset 7, -8
 983              		.cfi_offset 14, -4
 984 0002 83B0     		sub	sp, sp, #12
 985              		.cfi_def_cfa_offset 24
 986 0004 00AF     		add	r7, sp, #0
 987              		.cfi_def_cfa_register 7
 542:../src/rls_m0.c **** 	int i;
 543:../src/rls_m0.c **** 	
 544:../src/rls_m0.c **** 	for (i=0; i<CAM_RES2_WIDTH; i++)
 988              		.loc 1 544 0
 989 0006 0023     		movs	r3, #0
 990 0008 7B60     		str	r3, [r7, #4]
 991 000a 0EE0     		b	.L6
 992              	.L7:
 545:../src/rls_m0.c **** 		g_logLut[i] = intLog(i) + 3;
 993              		.loc 1 545 0 discriminator 3
 994 000c 0B4B     		ldr	r3, .L8
 995 000e 1A68     		ldr	r2, [r3]
 996 0010 7B68     		ldr	r3, [r7, #4]
 997 0012 D418     		adds	r4, r2, r3
 998 0014 7B68     		ldr	r3, [r7, #4]
 999 0016 1800     		movs	r0, r3
 1000 0018 FFF7FEFF 		bl	intLog
 1001 001c 0300     		movs	r3, r0
 1002 001e 0333     		adds	r3, r3, #3
 1003 0020 DBB2     		uxtb	r3, r3
 1004 0022 2370     		strb	r3, [r4]
 544:../src/rls_m0.c **** 		g_logLut[i] = intLog(i) + 3;
 1005              		.loc 1 544 0 discriminator 3
 1006 0024 7B68     		ldr	r3, [r7, #4]
 1007 0026 0133     		adds	r3, r3, #1
 1008 0028 7B60     		str	r3, [r7, #4]
 1009              	.L6:
 544:../src/rls_m0.c **** 		g_logLut[i] = intLog(i) + 3;
 1010              		.loc 1 544 0 is_stmt 0 discriminator 1
 1011 002a 7A68     		ldr	r2, [r7, #4]
 1012 002c 4023     		movs	r3, #64
 1013 002e FF33     		adds	r3, r3, #255
 1014 0030 9A42     		cmp	r2, r3
 1015 0032 EBDD     		ble	.L7
 546:../src/rls_m0.c **** }
 1016              		.loc 1 546 0 is_stmt 1
 1017 0034 C046     		nop
 1018 0036 BD46     		mov	sp, r7
 1019 0038 03B0     		add	sp, sp, #12
 1020              		@ sp needed
 1021 003a 90BD     		pop	{r4, r7, pc}
 1022              	.L9:
 1023              		.align	2
 1024              	.L8:
 1025 003c 00000000 		.word	g_logLut
 1026              		.cfi_endproc
 1027              	.LFE35:
 1029              		.section	.text.getRLSFrame,"ax",%progbits
 1030              		.align	2
 1031              		.global	getRLSFrame
 1032              		.code	16
 1033              		.thumb_func
 1035              	getRLSFrame:
 1036              	.LFB36:
 547:../src/rls_m0.c **** 
 548:../src/rls_m0.c **** #ifdef RLTEST
 549:../src/rls_m0.c **** uint8_t bgData[] = 
 550:../src/rls_m0.c **** {
 551:../src/rls_m0.c **** 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12 
 552:../src/rls_m0.c **** };
 553:../src/rls_m0.c **** 
 554:../src/rls_m0.c **** uint32_t rgData[] = 
 555:../src/rls_m0.c **** {
 556:../src/rls_m0.c **** 0x08a008a0, 0x08a008a0, 0x08a008a0, 0x08a008a0, 0x08a008a0, 0x08a008a0
 557:../src/rls_m0.c **** };
 558:../src/rls_m0.c **** #endif
 559:../src/rls_m0.c **** 
 560:../src/rls_m0.c **** 
 561:../src/rls_m0.c **** int32_t getRLSFrame(uint32_t *m0Mem, uint32_t *lut)
 562:../src/rls_m0.c **** {
 1037              		.loc 1 562 0
 1038              		.cfi_startproc
 1039 0000 F0B5     		push	{r4, r5, r6, r7, lr}
 1040              		.cfi_def_cfa_offset 20
 1041              		.cfi_offset 4, -20
 1042              		.cfi_offset 5, -16
 1043              		.cfi_offset 6, -12
 1044              		.cfi_offset 7, -8
 1045              		.cfi_offset 14, -4
 1046 0002 93B0     		sub	sp, sp, #76
 1047              		.cfi_def_cfa_offset 96
 1048 0004 06AF     		add	r7, sp, #24
 1049              		.cfi_def_cfa 7, 72
 1050 0006 F860     		str	r0, [r7, #12]
 1051 0008 B960     		str	r1, [r7, #8]
 563:../src/rls_m0.c **** 	uint8_t *lut2 = (uint8_t *)*lut;
 1052              		.loc 1 563 0
 1053 000a BB68     		ldr	r3, [r7, #8]
 1054 000c 1B68     		ldr	r3, [r3]
 1055 000e 7B62     		str	r3, [r7, #36]
 564:../src/rls_m0.c **** 	Qval *qvalStore = (Qval *)*m0Mem;
 1056              		.loc 1 564 0
 1057 0010 FB68     		ldr	r3, [r7, #12]
 1058 0012 1B68     		ldr	r3, [r3]
 1059 0014 3B62     		str	r3, [r7, #32]
 565:../src/rls_m0.c **** 	uint32_t line;
 566:../src/rls_m0.c **** 	uint32_t numQvals;
 567:../src/rls_m0.c **** 	uint32_t totalQvals;
 568:../src/rls_m0.c **** 	uint8_t *lineStore;
 569:../src/rls_m0.c **** 	uint8_t *logLut;
 570:../src/rls_m0.c **** 
 571:../src/rls_m0.c **** 	lineStore = (uint8_t *)(qvalStore + MAX_QVALS_PER_LINE);
 1060              		.loc 1 571 0
 1061 0016 3B6A     		ldr	r3, [r7, #32]
 1062 0018 0133     		adds	r3, r3, #1
 1063 001a FF33     		adds	r3, r3, #255
 1064 001c FB61     		str	r3, [r7, #28]
 572:../src/rls_m0.c **** 	logLut = lineStore + CAM_RES2_WIDTH + 4;
 1065              		.loc 1 572 0
 1066 001e FB69     		ldr	r3, [r7, #28]
 1067 0020 4533     		adds	r3, r3, #69
 1068 0022 FF33     		adds	r3, r3, #255
 1069 0024 BB61     		str	r3, [r7, #24]
 573:../src/rls_m0.c **** 	// m0mem needs to be at least 64*4 + CAM_RES2_WIDTH*2 + 4 =	900 ~ 1024
 574:../src/rls_m0.c **** 
 575:../src/rls_m0.c **** 	if (g_logLut!=logLut)
 1070              		.loc 1 575 0
 1071 0026 444B     		ldr	r3, .L18
 1072 0028 1A68     		ldr	r2, [r3]
 1073 002a BB69     		ldr	r3, [r7, #24]
 1074 002c 9A42     		cmp	r2, r3
 1075 002e 04D0     		beq	.L11
 576:../src/rls_m0.c **** 	{
 577:../src/rls_m0.c **** 		g_logLut = logLut; 
 1076              		.loc 1 577 0
 1077 0030 414B     		ldr	r3, .L18
 1078 0032 BA69     		ldr	r2, [r7, #24]
 1079 0034 1A60     		str	r2, [r3]
 578:../src/rls_m0.c **** 	 	createLogLut();
 1080              		.loc 1 578 0
 1081 0036 FFF7FEFF 		bl	createLogLut
 1082              	.L11:
 579:../src/rls_m0.c **** 	}
 580:../src/rls_m0.c **** 
 581:../src/rls_m0.c **** 	// don't even attempt to grab lines if we're lacking space...
 582:../src/rls_m0.c **** 	if (qq_free()<MAX_QVALS_PER_LINE)
 1083              		.loc 1 582 0
 1084 003a FFF7FEFF 		bl	qq_free
 1085 003e 031E     		subs	r3, r0, #0
 1086 0040 3F2B     		cmp	r3, #63
 1087 0042 02D8     		bhi	.L12
 583:../src/rls_m0.c **** 		return -1; 
 1088              		.loc 1 583 0
 1089 0044 0123     		movs	r3, #1
 1090 0046 5B42     		rsbs	r3, r3, #0
 1091 0048 72E0     		b	.L13
 1092              	.L12:
 584:../src/rls_m0.c **** 
 585:../src/rls_m0.c **** 	// indicate start of frame
 586:../src/rls_m0.c **** 	qq_enqueue(0xffffffff); 
 1093              		.loc 1 586 0
 1094 004a 0123     		movs	r3, #1
 1095 004c 5B42     		rsbs	r3, r3, #0
 1096 004e 1800     		movs	r0, r3
 1097 0050 FFF7FEFF 		bl	qq_enqueue
 587:../src/rls_m0.c **** 	skipLines(0);
 1098              		.loc 1 587 0
 1099 0054 0020     		movs	r0, #0
 1100 0056 FFF7FEFF 		bl	skipLines
 588:../src/rls_m0.c **** 	for (line=0, totalQvals=1; line<CAM_RES2_HEIGHT; line++)  // start totalQvals at 1 because of star
 1101              		.loc 1 588 0
 1102 005a 0023     		movs	r3, #0
 1103 005c FB62     		str	r3, [r7, #44]
 1104 005e 0123     		movs	r3, #1
 1105 0060 BB62     		str	r3, [r7, #40]
 1106 0062 61E0     		b	.L14
 1107              	.L17:
 589:../src/rls_m0.c **** 	{
 590:../src/rls_m0.c **** 		// not enough space--- return error
 591:../src/rls_m0.c **** 		if (qq_free()<MAX_QVALS_PER_LINE)
 1108              		.loc 1 591 0
 1109 0064 FFF7FEFF 		bl	qq_free
 1110 0068 031E     		subs	r3, r0, #0
 1111 006a 3F2B     		cmp	r3, #63
 1112 006c 02D8     		bhi	.L15
 592:../src/rls_m0.c **** 			return -1; 
 1113              		.loc 1 592 0
 1114 006e 0123     		movs	r3, #1
 1115 0070 5B42     		rsbs	r3, r3, #0
 1116 0072 5DE0     		b	.L13
 1117              	.L15:
 593:../src/rls_m0.c **** 		// mark beginning of this row (column 0 = 0)
 594:../src/rls_m0.c **** 		// column 1 is the first real column of pixels
 595:../src/rls_m0.c **** 		qq_enqueue(0); 
 1118              		.loc 1 595 0
 1119 0074 0020     		movs	r0, #0
 1120 0076 FFF7FEFF 		bl	qq_enqueue
 596:../src/rls_m0.c **** 		lineProcessedRL0A((uint32_t *)&CAM_PORT, lineStore, CAM_RES2_WIDTH); 
 1121              		.loc 1 596 0
 1122 007a A023     		movs	r3, #160
 1123 007c 5A00     		lsls	r2, r3, #1
 1124 007e FB69     		ldr	r3, [r7, #28]
 1125 0080 2E48     		ldr	r0, .L18+4
 1126 0082 1900     		movs	r1, r3
 1127 0084 FFF7FEFF 		bl	lineProcessedRL0A
 597:../src/rls_m0.c **** 		numQvals = lineProcessedRL1A((uint32_t *)&CAM_PORT, qvalStore, lut2, lineStore, CAM_RES2_WIDTH, g
 1128              		.loc 1 597 0
 1129 0088 2B4B     		ldr	r3, .L18
 1130 008a 1A68     		ldr	r2, [r3]
 1131 008c 2C4B     		ldr	r3, .L18+8
 1132 008e 1B68     		ldr	r3, [r3]
 1133 0090 0833     		adds	r3, r3, #8
 1134 0092 1900     		movs	r1, r3
 1135 0094 2A4B     		ldr	r3, .L18+8
 1136 0096 1B68     		ldr	r3, [r3]
 1137 0098 5B88     		ldrh	r3, [r3, #2]
 1138 009a 9BB2     		uxth	r3, r3
 1139 009c 1E00     		movs	r6, r3
 1140 009e FD69     		ldr	r5, [r7, #28]
 1141 00a0 7C6A     		ldr	r4, [r7, #36]
 1142 00a2 386A     		ldr	r0, [r7, #32]
 1143 00a4 254B     		ldr	r3, .L18+4
 1144 00a6 7B60     		str	r3, [r7, #4]
 1145 00a8 264B     		ldr	r3, .L18+12
 1146 00aa 0493     		str	r3, [sp, #16]
 1147 00ac 0396     		str	r6, [sp, #12]
 1148 00ae 0291     		str	r1, [sp, #8]
 1149 00b0 0192     		str	r2, [sp, #4]
 1150 00b2 A023     		movs	r3, #160
 1151 00b4 5B00     		lsls	r3, r3, #1
 1152 00b6 0093     		str	r3, [sp]
 1153 00b8 2B00     		movs	r3, r5
 1154 00ba 2200     		movs	r2, r4
 1155 00bc 0100     		movs	r1, r0
 1156 00be 7868     		ldr	r0, [r7, #4]
 1157 00c0 FFF7FEFF 		bl	lineProcessedRL1A
 1158 00c4 0300     		movs	r3, r0
 1159 00c6 7B61     		str	r3, [r7, #20]
 598:../src/rls_m0.c **** 		// modify qq to reflect added data
 599:../src/rls_m0.c **** 		g_qqueue->writeIndex += numQvals;
 1160              		.loc 1 599 0
 1161 00c8 1D4B     		ldr	r3, .L18+8
 1162 00ca 1A68     		ldr	r2, [r3]
 1163 00cc 1C4B     		ldr	r3, .L18+8
 1164 00ce 1B68     		ldr	r3, [r3]
 1165 00d0 5B88     		ldrh	r3, [r3, #2]
 1166 00d2 99B2     		uxth	r1, r3
 1167 00d4 7B69     		ldr	r3, [r7, #20]
 1168 00d6 9BB2     		uxth	r3, r3
 1169 00d8 CB18     		adds	r3, r1, r3
 1170 00da 9BB2     		uxth	r3, r3
 1171 00dc 5380     		strh	r3, [r2, #2]
 600:../src/rls_m0.c **** 		if (g_qqueue->writeIndex>=QQ_MEM_SIZE)
 1172              		.loc 1 600 0
 1173 00de 184B     		ldr	r3, .L18+8
 1174 00e0 1B68     		ldr	r3, [r3]
 1175 00e2 5B88     		ldrh	r3, [r3, #2]
 1176 00e4 9BB2     		uxth	r3, r3
 1177 00e6 184A     		ldr	r2, .L18+16
 1178 00e8 9342     		cmp	r3, r2
 1179 00ea 0AD9     		bls	.L16
 601:../src/rls_m0.c **** 			g_qqueue->writeIndex -= QQ_MEM_SIZE;
 1180              		.loc 1 601 0
 1181 00ec 144B     		ldr	r3, .L18+8
 1182 00ee 1A68     		ldr	r2, [r3]
 1183 00f0 134B     		ldr	r3, .L18+8
 1184 00f2 1B68     		ldr	r3, [r3]
 1185 00f4 5B88     		ldrh	r3, [r3, #2]
 1186 00f6 9BB2     		uxth	r3, r3
 1187 00f8 1449     		ldr	r1, .L18+20
 1188 00fa 8C46     		mov	ip, r1
 1189 00fc 6344     		add	r3, r3, ip
 1190 00fe 9BB2     		uxth	r3, r3
 1191 0100 5380     		strh	r3, [r2, #2]
 1192              	.L16:
 602:../src/rls_m0.c **** 		g_qqueue->produced += numQvals;
 1193              		.loc 1 602 0 discriminator 2
 1194 0102 0F4B     		ldr	r3, .L18+8
 1195 0104 1A68     		ldr	r2, [r3]
 1196 0106 0E4B     		ldr	r3, .L18+8
 1197 0108 1B68     		ldr	r3, [r3]
 1198 010a 9B88     		ldrh	r3, [r3, #4]
 1199 010c 99B2     		uxth	r1, r3
 1200 010e 7B69     		ldr	r3, [r7, #20]
 1201 0110 9BB2     		uxth	r3, r3
 1202 0112 CB18     		adds	r3, r1, r3
 1203 0114 9BB2     		uxth	r3, r3
 1204 0116 9380     		strh	r3, [r2, #4]
 603:../src/rls_m0.c **** 		totalQvals += numQvals+1; // +1 because of beginning of line 
 1205              		.loc 1 603 0 discriminator 2
 1206 0118 7A69     		ldr	r2, [r7, #20]
 1207 011a BB6A     		ldr	r3, [r7, #40]
 1208 011c D318     		adds	r3, r2, r3
 1209 011e 0133     		adds	r3, r3, #1
 1210 0120 BB62     		str	r3, [r7, #40]
 588:../src/rls_m0.c **** 	{
 1211              		.loc 1 588 0 discriminator 2
 1212 0122 FB6A     		ldr	r3, [r7, #44]
 1213 0124 0133     		adds	r3, r3, #1
 1214 0126 FB62     		str	r3, [r7, #44]
 1215              	.L14:
 588:../src/rls_m0.c **** 	{
 1216              		.loc 1 588 0 is_stmt 0 discriminator 1
 1217 0128 FB6A     		ldr	r3, [r7, #44]
 1218 012a C72B     		cmp	r3, #199
 1219 012c 9AD9     		bls	.L17
 604:../src/rls_m0.c **** 	}
 605:../src/rls_m0.c **** 	return 0;
 1220              		.loc 1 605 0 is_stmt 1
 1221 012e 0023     		movs	r3, #0
 1222              	.L13:
 606:../src/rls_m0.c **** }
 1223              		.loc 1 606 0
 1224 0130 1800     		movs	r0, r3
 1225 0132 BD46     		mov	sp, r7
 1226 0134 0DB0     		add	sp, sp, #52
 1227              		@ sp needed
 1228 0136 F0BD     		pop	{r4, r5, r6, r7, pc}
 1229              	.L19:
 1230              		.align	2
 1231              	.L18:
 1232 0138 00000000 		.word	g_logLut
 1233 013c 04610F40 		.word	1074749700
 1234 0140 00000000 		.word	g_qqueue
 1235 0144 FE0B0000 		.word	3070
 1236 0148 FD0B0000 		.word	3069
 1237 014c 02F4FFFF 		.word	-3070
 1238              		.cfi_endproc
 1239              	.LFE36:
 1241              		.section	.rodata
 1242              		.align	2
 1243              	.LC4:
 1244 0000 67657452 		.ascii	"getRLSFrame\000"
 1244      4C534672 
 1244      616D6500 
 1245              		.section	.text.rls_init,"ax",%progbits
 1246              		.align	2
 1247              		.global	rls_init
 1248              		.code	16
 1249              		.thumb_func
 1251              	rls_init:
 1252              	.LFB37:
 607:../src/rls_m0.c **** 
 608:../src/rls_m0.c **** 
 609:../src/rls_m0.c **** int rls_init(void)
 610:../src/rls_m0.c **** {
 1253              		.loc 1 610 0
 1254              		.cfi_startproc
 1255 0000 80B5     		push	{r7, lr}
 1256              		.cfi_def_cfa_offset 8
 1257              		.cfi_offset 7, -8
 1258              		.cfi_offset 14, -4
 1259 0002 00AF     		add	r7, sp, #0
 1260              		.cfi_def_cfa_register 7
 611:../src/rls_m0.c **** 	chirpSetProc("getRLSFrame", (ProcPtr)getRLSFrame);
 1261              		.loc 1 611 0
 1262 0004 044A     		ldr	r2, .L22
 1263 0006 054B     		ldr	r3, .L22+4
 1264 0008 1100     		movs	r1, r2
 1265 000a 1800     		movs	r0, r3
 1266 000c FFF7FEFF 		bl	chirpSetProc
 612:../src/rls_m0.c **** 	return 0;
 1267              		.loc 1 612 0
 1268 0010 0023     		movs	r3, #0
 613:../src/rls_m0.c **** }
 1269              		.loc 1 613 0
 1270 0012 1800     		movs	r0, r3
 1271 0014 BD46     		mov	sp, r7
 1272              		@ sp needed
 1273 0016 80BD     		pop	{r7, pc}
 1274              	.L23:
 1275              		.align	2
 1276              	.L22:
 1277 0018 00000000 		.word	getRLSFrame
 1278 001c 00000000 		.word	.LC4
 1279              		.cfi_endproc
 1280              	.LFE37:
 1282              		.text
 1283              	.Letext0:
 1284              		.file 2 "/usr/local/lpcxpresso_8.1.4_606/lpcxpresso/tools/redlib/include/stdint.h"
 1285              		.file 3 "/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/misc/gcc/m0/inc/lpc43xx.h"
 1286              		.file 4 "/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/misc/gcc/m0/inc/chirp.h"
 1287              		.file 5 "/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/misc/gcc/m0/inc/qqueue.h"
DEFINED SYMBOLS
                            *ABS*:00000000 rls_m0.c
     /tmp/ccAP44Ld.s:24     .bss.g_logLut:00000000 g_logLut
     /tmp/ccAP44Ld.s:21     .bss.g_logLut:00000000 $d
     /tmp/ccAP44Ld.s:27     .text.lineProcessedRL0A:00000000 $t
     /tmp/ccAP44Ld.s:32     .text.lineProcessedRL0A:00000000 lineProcessedRL0A
     /tmp/ccAP44Ld.s:83     .text.lineProcessedRL0A:0000001c dest10A
     /tmp/ccAP44Ld.s:107    .text.lineProcessedRL0A:00000026 loop5A
     /tmp/ccAP44Ld.s:187    .text.lineProcessedRL0A:0000004c dest11A
     /tmp/ccAP44Ld.s:221    .text.lineProcessedRL1A:00000000 $t
     /tmp/ccAP44Ld.s:226    .text.lineProcessedRL1A:00000000 lineProcessedRL1A
     /tmp/ccAP44Ld.s:281    .text.lineProcessedRL1A:00000020 dest12A
     /tmp/ccAP44Ld.s:333    .text.lineProcessedRL1A:00000038 zero0
     /tmp/ccAP44Ld.s:723    .text.lineProcessedRL1A:00000104 eol
     /tmp/ccAP44Ld.s:350    .text.lineProcessedRL1A:00000040 zero1
     /tmp/ccAP44Ld.s:495    .text.lineProcessedRL1A:00000088 one
     /tmp/ccAP44Ld.s:797    .text.lineProcessedRL1A:00000130 eol0
     /tmp/ccAP44Ld.s:809    .text.lineProcessedRL1A:00000134 dest20A
     /tmp/ccAP44Ld.s:861    .text.lineProcessedRL1A:0000014c lcpy
     /tmp/ccAP44Ld.s:913    .text.lineProcessedRL1A:00000162 ecpy
     /tmp/ccAP44Ld.s:901    .text.lineProcessedRL1A:0000015e wrap
     /tmp/ccAP44Ld.s:940    .text.intLog:00000000 $t
     /tmp/ccAP44Ld.s:945    .text.intLog:00000000 intLog
     /tmp/ccAP44Ld.s:970    .text.createLogLut:00000000 $t
     /tmp/ccAP44Ld.s:975    .text.createLogLut:00000000 createLogLut
     /tmp/ccAP44Ld.s:1025   .text.createLogLut:0000003c $d
     /tmp/ccAP44Ld.s:1030   .text.getRLSFrame:00000000 $t
     /tmp/ccAP44Ld.s:1035   .text.getRLSFrame:00000000 getRLSFrame
     /tmp/ccAP44Ld.s:1232   .text.getRLSFrame:00000138 $d
     /tmp/ccAP44Ld.s:1242   .rodata:00000000 $d
     /tmp/ccAP44Ld.s:1246   .text.rls_init:00000000 $t
     /tmp/ccAP44Ld.s:1251   .text.rls_init:00000000 rls_init
     /tmp/ccAP44Ld.s:1277   .text.rls_init:00000018 $d
                     .debug_frame:00000010 $d

UNDEFINED SYMBOLS
callSyncM1
qq_free
qq_enqueue
skipLines
g_qqueue
chirpSetProc
