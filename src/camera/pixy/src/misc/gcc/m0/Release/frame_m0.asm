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
  15              		.file	"frame_m0.c"
  16              		.text
  17              	.Ltext0:
  18              		.cfi_sections	.debug_frame
  19              		.section	.text.vsync,"ax",%progbits
  20              		.align	2
  21              		.global	vsync
  22              		.code	16
  23              		.thumb_func
  25              	vsync:
  26              	.LFB32:
  27              		.file 1 "../src/frame_m0.c"
   1:../src/frame_m0.c **** //
   2:../src/frame_m0.c **** // begin license header
   3:../src/frame_m0.c **** //
   4:../src/frame_m0.c **** // This file is part of Pixy CMUcam5 or "Pixy" for short
   5:../src/frame_m0.c **** //
   6:../src/frame_m0.c **** // All Pixy source code is provided under the terms of the
   7:../src/frame_m0.c **** // GNU General Public License v2 (http://www.gnu.org/licenses/gpl-2.0.html).
   8:../src/frame_m0.c **** // Those wishing to use Pixy source code, software and/or
   9:../src/frame_m0.c **** // technologies under different licensing terms should contact us at
  10:../src/frame_m0.c **** // cmucam@cs.cmu.edu. Such licensing terms are available for
  11:../src/frame_m0.c **** // all portions of the Pixy codebase presented here.
  12:../src/frame_m0.c **** //
  13:../src/frame_m0.c **** // end license header
  14:../src/frame_m0.c **** //
  15:../src/frame_m0.c **** 
  16:../src/frame_m0.c **** #include "debug_frmwrk.h"
  17:../src/frame_m0.c **** #include "chirp.h"
  18:../src/frame_m0.c **** #include "frame_m0.h"
  19:../src/frame_m0.c **** 
  20:../src/frame_m0.c **** #define CAM_PCLK_MASK   0x2000
  21:../src/frame_m0.c **** 
  22:../src/frame_m0.c **** #define ALIGN(v, n)  ((uint32_t)v&((n)-1) ? ((uint32_t)v&~((n)-1))+(n) : (uint32_t)v)
  23:../src/frame_m0.c **** 
  24:../src/frame_m0.c **** void vsync()
  25:../src/frame_m0.c **** {
  28              		.loc 1 25 0
  29              		.cfi_startproc
  30 0000 80B5     		push	{r7, lr}
  31              		.cfi_def_cfa_offset 8
  32              		.cfi_offset 7, -8
  33              		.cfi_offset 14, -4
  34 0002 82B0     		sub	sp, sp, #8
  35              		.cfi_def_cfa_offset 16
  36 0004 00AF     		add	r7, sp, #0
  37              		.cfi_def_cfa_register 7
  26:../src/frame_m0.c **** 	int v = 0, h = 0;
  38              		.loc 1 26 0
  39 0006 0023     		movs	r3, #0
  40 0008 7B60     		str	r3, [r7, #4]
  41 000a 0023     		movs	r3, #0
  42 000c 3B60     		str	r3, [r7]
  43              	.L8:
  27:../src/frame_m0.c **** 
  28:../src/frame_m0.c **** 	while(1)
  29:../src/frame_m0.c **** 	{
  30:../src/frame_m0.c **** 		h = 0;
  44              		.loc 1 30 0
  45 000e 0023     		movs	r3, #0
  46 0010 3B60     		str	r3, [r7]
  31:../src/frame_m0.c **** 		while(CAM_VSYNC()!=0);
  47              		.loc 1 31 0
  48 0012 C046     		nop
  49              	.L2:
  50              		.loc 1 31 0 is_stmt 0 discriminator 1
  51 0014 134A     		ldr	r2, .L11
  52 0016 144B     		ldr	r3, .L11+4
  53 0018 D258     		ldr	r2, [r2, r3]
  54 001a 8023     		movs	r3, #128
  55 001c 5B01     		lsls	r3, r3, #5
  56 001e 1340     		ands	r3, r2
  57 0020 F8D1     		bne	.L2
  58              	.L7:
  32:../src/frame_m0.c **** 		while(1) // vsync low
  33:../src/frame_m0.c **** 		{
  34:../src/frame_m0.c **** 			while(CAM_HSYNC()==0)
  59              		.loc 1 34 0 is_stmt 1
  60 0022 06E0     		b	.L3
  61              	.L5:
  35:../src/frame_m0.c **** 			{
  36:../src/frame_m0.c **** 			if (CAM_VSYNC()!=0)
  62              		.loc 1 36 0
  63 0024 0F4A     		ldr	r2, .L11
  64 0026 104B     		ldr	r3, .L11+4
  65 0028 D258     		ldr	r2, [r2, r3]
  66 002a 8023     		movs	r3, #128
  67 002c 5B01     		lsls	r3, r3, #5
  68 002e 1340     		ands	r3, r2
  69 0030 12D1     		bne	.L10
  70              	.L3:
  34:../src/frame_m0.c **** 			{
  71              		.loc 1 34 0
  72 0032 0C4A     		ldr	r2, .L11
  73 0034 0C4B     		ldr	r3, .L11+4
  74 0036 D258     		ldr	r2, [r2, r3]
  75 0038 8023     		movs	r3, #128
  76 003a 1B01     		lsls	r3, r3, #4
  77 003c 1340     		ands	r3, r2
  78 003e F1D0     		beq	.L5
  37:../src/frame_m0.c **** 				goto end;
  38:../src/frame_m0.c **** 			}
  39:../src/frame_m0.c **** 			while(CAM_HSYNC()!=0); //grab data
  79              		.loc 1 39 0
  80 0040 C046     		nop
  81              	.L6:
  82              		.loc 1 39 0 is_stmt 0 discriminator 1
  83 0042 084A     		ldr	r2, .L11
  84 0044 084B     		ldr	r3, .L11+4
  85 0046 D258     		ldr	r2, [r2, r3]
  86 0048 8023     		movs	r3, #128
  87 004a 1B01     		lsls	r3, r3, #4
  88 004c 1340     		ands	r3, r2
  89 004e F8D1     		bne	.L6
  40:../src/frame_m0.c **** 			h++;
  90              		.loc 1 40 0 is_stmt 1
  91 0050 3B68     		ldr	r3, [r7]
  92 0052 0133     		adds	r3, r3, #1
  93 0054 3B60     		str	r3, [r7]
  41:../src/frame_m0.c **** 		}
  94              		.loc 1 41 0
  95 0056 E4E7     		b	.L7
  96              	.L10:
  37:../src/frame_m0.c **** 				goto end;
  97              		.loc 1 37 0
  98 0058 C046     		nop
  99              	.L4:
  42:../src/frame_m0.c **** end:
  43:../src/frame_m0.c **** 		v++;
 100              		.loc 1 43 0
 101 005a 7B68     		ldr	r3, [r7, #4]
 102 005c 0133     		adds	r3, r3, #1
 103 005e 7B60     		str	r3, [r7, #4]
  44:../src/frame_m0.c **** 		//if (v%25==0)
  45:../src/frame_m0.c **** 			//printf("%d %d\n", v, h);
  46:../src/frame_m0.c **** 	}
 104              		.loc 1 46 0
 105 0060 D5E7     		b	.L8
 106              	.L12:
 107 0062 C046     		.align	2
 108              	.L11:
 109 0064 00400F40 		.word	1074741248
 110 0068 04210000 		.word	8452
 111              		.cfi_endproc
 112              	.LFE32:
 114              		.section	.text.syncM0,"ax",%progbits
 115              		.align	2
 116              		.global	syncM0
 117              		.code	16
 118              		.thumb_func
 120              	syncM0:
 121              	.LFB33:
  47:../src/frame_m0.c **** }
  48:../src/frame_m0.c **** 
  49:../src/frame_m0.c **** 
  50:../src/frame_m0.c **** void syncM0(uint32_t *gpioIn, uint32_t clkMask)
  51:../src/frame_m0.c **** {
 122              		.loc 1 51 0
 123              		.cfi_startproc
 124 0000 80B5     		push	{r7, lr}
 125              		.cfi_def_cfa_offset 8
 126              		.cfi_offset 7, -8
 127              		.cfi_offset 14, -4
 128 0002 82B0     		sub	sp, sp, #8
 129              		.cfi_def_cfa_offset 16
 130 0004 00AF     		add	r7, sp, #0
 131              		.cfi_def_cfa_register 7
 132 0006 7860     		str	r0, [r7, #4]
 133 0008 3960     		str	r1, [r7]
  52:../src/frame_m0.c **** asm(".syntax unified");
 134              		.loc 1 52 0
 135              		.syntax divided
 136              	@ 52 "../src/frame_m0.c" 1
 137              		.syntax unified
 138              	@ 0 "" 2
  53:../src/frame_m0.c **** 
  54:../src/frame_m0.c **** 	asm("PUSH	{r4}");
 139              		.loc 1 54 0
 140              	@ 54 "../src/frame_m0.c" 1
 141 000a 10B4     		PUSH	{r4}
 142              	@ 0 "" 2
  55:../src/frame_m0.c **** 
  56:../src/frame_m0.c **** asm("start:");
 143              		.loc 1 56 0
 144              	@ 56 "../src/frame_m0.c" 1
 145              		start:
 146              	@ 0 "" 2
  57:../src/frame_m0.c **** 	// This sequence can be extended to reduce probability of false phase detection.
  58:../src/frame_m0.c **** 	// This routine acts as a "sieve", only letting a specific phase through.  
  59:../src/frame_m0.c **** 	// In practice, 2 different phases separated by 1 clock are permitted through
  60:../src/frame_m0.c **** 	// which is acceptable-- 5ns in a 30ns period.  
  61:../src/frame_m0.c **** 	// If the pixel clock is shifted 1/2 a cpu clock period (or less), with respect to the CPU clock, 
  62:../src/frame_m0.c **** 	// If the pixel clock is perfectly in line with the cpu clock, 1 phase will match.  
  63:../src/frame_m0.c **** 	// Worst case will aways be 2 possible phases. 
  64:../src/frame_m0.c **** 	// It takes between 50 and 200 cpu clock cycles to complete.  	
  65:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // high
 147              		.loc 1 65 0
 148              	@ 65 "../src/frame_m0.c" 1
 149 000c 0268     		LDR 	r2, [r0]
 150              	@ 0 "" 2
  66:../src/frame_m0.c **** 	asm("NOP");
 151              		.loc 1 66 0
 152              	@ 66 "../src/frame_m0.c" 1
 153 000e C046     		NOP
 154              	@ 0 "" 2
  67:../src/frame_m0.c **** 	asm("LDR 	r3, [r0]"); // low
 155              		.loc 1 67 0
 156              	@ 67 "../src/frame_m0.c" 1
 157 0010 0368     		LDR 	r3, [r0]
 158              	@ 0 "" 2
  68:../src/frame_m0.c **** 	asm("BICS	r2, r3");
 159              		.loc 1 68 0
 160              	@ 68 "../src/frame_m0.c" 1
 161 0012 9A43     		BICS	r2, r3
 162              	@ 0 "" 2
  69:../src/frame_m0.c **** 	asm("LDR 	r3, [r0]"); // high
 163              		.loc 1 69 0
 164              	@ 69 "../src/frame_m0.c" 1
 165 0014 0368     		LDR 	r3, [r0]
 166              	@ 0 "" 2
  70:../src/frame_m0.c **** 	asm("ANDS	r3, r2");
 167              		.loc 1 70 0
 168              	@ 70 "../src/frame_m0.c" 1
 169 0016 1340     		ANDS	r3, r2
 170              	@ 0 "" 2
  71:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // low
 171              		.loc 1 71 0
 172              	@ 71 "../src/frame_m0.c" 1
 173 0018 0268     		LDR 	r2, [r0]
 174              	@ 0 "" 2
  72:../src/frame_m0.c **** 	asm("LDR 	r4, [r0]"); // high
 175              		.loc 1 72 0
 176              	@ 72 "../src/frame_m0.c" 1
 177 001a 0468     		LDR 	r4, [r0]
 178              	@ 0 "" 2
  73:../src/frame_m0.c **** 	asm("BICS 	r4, r2");
 179              		.loc 1 73 0
 180              	@ 73 "../src/frame_m0.c" 1
 181 001c 9443     		BICS 	r4, r2
 182              	@ 0 "" 2
  74:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // low
 183              		.loc 1 74 0
 184              	@ 74 "../src/frame_m0.c" 1
 185 001e 0268     		LDR 	r2, [r0]
 186              	@ 0 "" 2
  75:../src/frame_m0.c **** 	asm("BICS	r4, r2");
 187              		.loc 1 75 0
 188              	@ 75 "../src/frame_m0.c" 1
 189 0020 9443     		BICS	r4, r2
 190              	@ 0 "" 2
  76:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // high
 191              		.loc 1 76 0
 192              	@ 76 "../src/frame_m0.c" 1
 193 0022 0268     		LDR 	r2, [r0]
 194              	@ 0 "" 2
  77:../src/frame_m0.c **** 	asm("ANDS	r4, r2");
 195              		.loc 1 77 0
 196              	@ 77 "../src/frame_m0.c" 1
 197 0024 1440     		ANDS	r4, r2
 198              	@ 0 "" 2
  78:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // low
 199              		.loc 1 78 0
 200              	@ 78 "../src/frame_m0.c" 1
 201 0026 0268     		LDR 	r2, [r0]
 202              	@ 0 "" 2
  79:../src/frame_m0.c **** 	
  80:../src/frame_m0.c **** 	asm("BICS	r4, r2");
 203              		.loc 1 80 0
 204              	@ 80 "../src/frame_m0.c" 1
 205 0028 9443     		BICS	r4, r2
 206              	@ 0 "" 2
  81:../src/frame_m0.c **** 	asm("ANDS	r4, r3");
 207              		.loc 1 81 0
 208              	@ 81 "../src/frame_m0.c" 1
 209 002a 1C40     		ANDS	r4, r3
 210              	@ 0 "" 2
  82:../src/frame_m0.c **** 
  83:../src/frame_m0.c **** 	asm("TST	r4, r1");
 211              		.loc 1 83 0
 212              	@ 83 "../src/frame_m0.c" 1
 213 002c 0C42     		TST	r4, r1
 214              	@ 0 "" 2
  84:../src/frame_m0.c **** 	asm("BEQ	start");
 215              		.loc 1 84 0
 216              	@ 84 "../src/frame_m0.c" 1
 217 002e EDD0     		BEQ	start
 218              	@ 0 "" 2
  85:../src/frame_m0.c **** 
  86:../src/frame_m0.c **** 	// in-phase begins here
  87:../src/frame_m0.c **** 	asm("POP   	{r4}");
 219              		.loc 1 87 0
 220              	@ 87 "../src/frame_m0.c" 1
 221 0030 10BC     		POP   	{r4}
 222              	@ 0 "" 2
  88:../src/frame_m0.c **** 
  89:../src/frame_m0.c **** 	asm(".syntax divided");
 223              		.loc 1 89 0
 224              	@ 89 "../src/frame_m0.c" 1
 225              		.syntax divided
 226              	@ 0 "" 2
  90:../src/frame_m0.c **** }
 227              		.loc 1 90 0
 228              		.thumb
 229              		.syntax unified
 230 0032 C046     		nop
 231 0034 BD46     		mov	sp, r7
 232 0036 02B0     		add	sp, sp, #8
 233              		@ sp needed
 234 0038 80BD     		pop	{r7, pc}
 235              		.cfi_endproc
 236              	.LFE33:
 238 003a C046     		.section	.text.syncM1,"ax",%progbits
 239              		.align	2
 240              		.global	syncM1
 241              		.code	16
 242              		.thumb_func
 244              	syncM1:
 245              	.LFB34:
  91:../src/frame_m0.c **** 
  92:../src/frame_m0.c **** 
  93:../src/frame_m0.c **** void syncM1(uint32_t *gpioIn, uint32_t clkMask)
  94:../src/frame_m0.c **** {
 246              		.loc 1 94 0
 247              		.cfi_startproc
 248 0000 80B5     		push	{r7, lr}
 249              		.cfi_def_cfa_offset 8
 250              		.cfi_offset 7, -8
 251              		.cfi_offset 14, -4
 252 0002 82B0     		sub	sp, sp, #8
 253              		.cfi_def_cfa_offset 16
 254 0004 00AF     		add	r7, sp, #0
 255              		.cfi_def_cfa_register 7
 256 0006 7860     		str	r0, [r7, #4]
 257 0008 3960     		str	r1, [r7]
  95:../src/frame_m0.c **** asm(".syntax unified");
 258              		.loc 1 95 0
 259              		.syntax divided
 260              	@ 95 "../src/frame_m0.c" 1
 261              		.syntax unified
 262              	@ 0 "" 2
  96:../src/frame_m0.c **** 
  97:../src/frame_m0.c **** 	asm("PUSH	{r4}");
 263              		.loc 1 97 0
 264              	@ 97 "../src/frame_m0.c" 1
 265 000a 10B4     		PUSH	{r4}
 266              	@ 0 "" 2
  98:../src/frame_m0.c **** 
  99:../src/frame_m0.c **** asm("startSyncM1:");
 267              		.loc 1 99 0
 268              	@ 99 "../src/frame_m0.c" 1
 269              		startSyncM1:
 270              	@ 0 "" 2
 100:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // high
 271              		.loc 1 100 0
 272              	@ 100 "../src/frame_m0.c" 1
 273 000c 0268     		LDR 	r2, [r0]
 274              	@ 0 "" 2
 101:../src/frame_m0.c **** 	asm("NOP");
 275              		.loc 1 101 0
 276              	@ 101 "../src/frame_m0.c" 1
 277 000e C046     		NOP
 278              	@ 0 "" 2
 102:../src/frame_m0.c **** 	asm("NOP");
 279              		.loc 1 102 0
 280              	@ 102 "../src/frame_m0.c" 1
 281 0010 C046     		NOP
 282              	@ 0 "" 2
 103:../src/frame_m0.c **** 	asm("NOP");
 283              		.loc 1 103 0
 284              	@ 103 "../src/frame_m0.c" 1
 285 0012 C046     		NOP
 286              	@ 0 "" 2
 104:../src/frame_m0.c **** 	asm("NOP");
 287              		.loc 1 104 0
 288              	@ 104 "../src/frame_m0.c" 1
 289 0014 C046     		NOP
 290              	@ 0 "" 2
 105:../src/frame_m0.c **** 	asm("LDR 	r3, [r0]"); // low
 291              		.loc 1 105 0
 292              	@ 105 "../src/frame_m0.c" 1
 293 0016 0368     		LDR 	r3, [r0]
 294              	@ 0 "" 2
 106:../src/frame_m0.c **** 	asm("BICS	r2, r3");
 295              		.loc 1 106 0
 296              	@ 106 "../src/frame_m0.c" 1
 297 0018 9A43     		BICS	r2, r3
 298              	@ 0 "" 2
 107:../src/frame_m0.c **** 	asm("NOP");
 299              		.loc 1 107 0
 300              	@ 107 "../src/frame_m0.c" 1
 301 001a C046     		NOP
 302              	@ 0 "" 2
 108:../src/frame_m0.c **** 	asm("NOP");
 303              		.loc 1 108 0
 304              	@ 108 "../src/frame_m0.c" 1
 305 001c C046     		NOP
 306              	@ 0 "" 2
 109:../src/frame_m0.c **** 	asm("NOP");
 307              		.loc 1 109 0
 308              	@ 109 "../src/frame_m0.c" 1
 309 001e C046     		NOP
 310              	@ 0 "" 2
 110:../src/frame_m0.c **** 	asm("LDR 	r3, [r0]"); // high
 311              		.loc 1 110 0
 312              	@ 110 "../src/frame_m0.c" 1
 313 0020 0368     		LDR 	r3, [r0]
 314              	@ 0 "" 2
 111:../src/frame_m0.c **** 	asm("ANDS	r3, r2");
 315              		.loc 1 111 0
 316              	@ 111 "../src/frame_m0.c" 1
 317 0022 1340     		ANDS	r3, r2
 318              	@ 0 "" 2
 112:../src/frame_m0.c **** 	asm("NOP");
 319              		.loc 1 112 0
 320              	@ 112 "../src/frame_m0.c" 1
 321 0024 C046     		NOP
 322              	@ 0 "" 2
 113:../src/frame_m0.c **** 	asm("NOP");
 323              		.loc 1 113 0
 324              	@ 113 "../src/frame_m0.c" 1
 325 0026 C046     		NOP
 326              	@ 0 "" 2
 114:../src/frame_m0.c **** 	asm("NOP");
 327              		.loc 1 114 0
 328              	@ 114 "../src/frame_m0.c" 1
 329 0028 C046     		NOP
 330              	@ 0 "" 2
 115:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // low
 331              		.loc 1 115 0
 332              	@ 115 "../src/frame_m0.c" 1
 333 002a 0268     		LDR 	r2, [r0]
 334              	@ 0 "" 2
 116:../src/frame_m0.c **** 	asm("LDR 	r4, [r0]"); // high
 335              		.loc 1 116 0
 336              	@ 116 "../src/frame_m0.c" 1
 337 002c 0468     		LDR 	r4, [r0]
 338              	@ 0 "" 2
 117:../src/frame_m0.c **** 	asm("BICS 	r4, r2");
 339              		.loc 1 117 0
 340              	@ 117 "../src/frame_m0.c" 1
 341 002e 9443     		BICS 	r4, r2
 342              	@ 0 "" 2
 118:../src/frame_m0.c **** 	asm("NOP");
 343              		.loc 1 118 0
 344              	@ 118 "../src/frame_m0.c" 1
 345 0030 C046     		NOP
 346              	@ 0 "" 2
 119:../src/frame_m0.c **** 	asm("NOP");
 347              		.loc 1 119 0
 348              	@ 119 "../src/frame_m0.c" 1
 349 0032 C046     		NOP
 350              	@ 0 "" 2
 120:../src/frame_m0.c **** 	asm("NOP");
 351              		.loc 1 120 0
 352              	@ 120 "../src/frame_m0.c" 1
 353 0034 C046     		NOP
 354              	@ 0 "" 2
 121:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // low
 355              		.loc 1 121 0
 356              	@ 121 "../src/frame_m0.c" 1
 357 0036 0268     		LDR 	r2, [r0]
 358              	@ 0 "" 2
 122:../src/frame_m0.c **** 	asm("BICS	r4, r2");
 359              		.loc 1 122 0
 360              	@ 122 "../src/frame_m0.c" 1
 361 0038 9443     		BICS	r4, r2
 362              	@ 0 "" 2
 123:../src/frame_m0.c **** 	asm("NOP");
 363              		.loc 1 123 0
 364              	@ 123 "../src/frame_m0.c" 1
 365 003a C046     		NOP
 366              	@ 0 "" 2
 124:../src/frame_m0.c **** 	asm("NOP");
 367              		.loc 1 124 0
 368              	@ 124 "../src/frame_m0.c" 1
 369 003c C046     		NOP
 370              	@ 0 "" 2
 125:../src/frame_m0.c **** 	asm("NOP");
 371              		.loc 1 125 0
 372              	@ 125 "../src/frame_m0.c" 1
 373 003e C046     		NOP
 374              	@ 0 "" 2
 126:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // high
 375              		.loc 1 126 0
 376              	@ 126 "../src/frame_m0.c" 1
 377 0040 0268     		LDR 	r2, [r0]
 378              	@ 0 "" 2
 127:../src/frame_m0.c **** 	asm("ANDS	r4, r2");
 379              		.loc 1 127 0
 380              	@ 127 "../src/frame_m0.c" 1
 381 0042 1440     		ANDS	r4, r2
 382              	@ 0 "" 2
 128:../src/frame_m0.c **** 	asm("NOP");
 383              		.loc 1 128 0
 384              	@ 128 "../src/frame_m0.c" 1
 385 0044 C046     		NOP
 386              	@ 0 "" 2
 129:../src/frame_m0.c **** 	asm("NOP");
 387              		.loc 1 129 0
 388              	@ 129 "../src/frame_m0.c" 1
 389 0046 C046     		NOP
 390              	@ 0 "" 2
 130:../src/frame_m0.c **** 	asm("NOP");
 391              		.loc 1 130 0
 392              	@ 130 "../src/frame_m0.c" 1
 393 0048 C046     		NOP
 394              	@ 0 "" 2
 131:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // low
 395              		.loc 1 131 0
 396              	@ 131 "../src/frame_m0.c" 1
 397 004a 0268     		LDR 	r2, [r0]
 398              	@ 0 "" 2
 132:../src/frame_m0.c **** 	
 133:../src/frame_m0.c **** 	asm("BICS	r4, r2");
 399              		.loc 1 133 0
 400              	@ 133 "../src/frame_m0.c" 1
 401 004c 9443     		BICS	r4, r2
 402              	@ 0 "" 2
 134:../src/frame_m0.c **** 	asm("ANDS	r4, r3");
 403              		.loc 1 134 0
 404              	@ 134 "../src/frame_m0.c" 1
 405 004e 1C40     		ANDS	r4, r3
 406              	@ 0 "" 2
 135:../src/frame_m0.c **** 
 136:../src/frame_m0.c **** 	asm("TST		r4, r1");
 407              		.loc 1 136 0
 408              	@ 136 "../src/frame_m0.c" 1
 409 0050 0C42     		TST		r4, r1
 410              	@ 0 "" 2
 137:../src/frame_m0.c **** 	asm("NOP");		// an extra NOP makes us converge faster, worst case 400 cycles.
 411              		.loc 1 137 0
 412              	@ 137 "../src/frame_m0.c" 1
 413 0052 C046     		NOP
 414              	@ 0 "" 2
 138:../src/frame_m0.c **** 	asm("NOP");
 415              		.loc 1 138 0
 416              	@ 138 "../src/frame_m0.c" 1
 417 0054 C046     		NOP
 418              	@ 0 "" 2
 139:../src/frame_m0.c **** 	asm("NOP");
 419              		.loc 1 139 0
 420              	@ 139 "../src/frame_m0.c" 1
 421 0056 C046     		NOP
 422              	@ 0 "" 2
 140:../src/frame_m0.c **** 	asm("BEQ		startSyncM1");
 423              		.loc 1 140 0
 424              	@ 140 "../src/frame_m0.c" 1
 425 0058 D8D0     		BEQ		startSyncM1
 426              	@ 0 "" 2
 141:../src/frame_m0.c **** 
 142:../src/frame_m0.c **** 	// in-phase begins here
 143:../src/frame_m0.c **** 
 144:../src/frame_m0.c **** 
 145:../src/frame_m0.c **** 	asm("POP   	{r4}");
 427              		.loc 1 145 0
 428              	@ 145 "../src/frame_m0.c" 1
 429 005a 10BC     		POP   	{r4}
 430              	@ 0 "" 2
 146:../src/frame_m0.c **** 
 147:../src/frame_m0.c **** 	asm(".syntax divided");
 431              		.loc 1 147 0
 432              	@ 147 "../src/frame_m0.c" 1
 433              		.syntax divided
 434              	@ 0 "" 2
 148:../src/frame_m0.c **** }
 435              		.loc 1 148 0
 436              		.thumb
 437              		.syntax unified
 438 005c C046     		nop
 439 005e BD46     		mov	sp, r7
 440 0060 02B0     		add	sp, sp, #8
 441              		@ sp needed
 442 0062 80BD     		pop	{r7, pc}
 443              		.cfi_endproc
 444              	.LFE34:
 446              		.section	.text.lineM0,"ax",%progbits
 447              		.align	2
 448              		.global	lineM0
 449              		.code	16
 450              		.thumb_func
 452              	lineM0:
 453              	.LFB35:
 149:../src/frame_m0.c **** 
 150:../src/frame_m0.c **** 
 151:../src/frame_m0.c **** void lineM0(uint32_t *gpio, uint8_t *memory, uint32_t xoffset, uint32_t xwidth)
 152:../src/frame_m0.c **** {
 454              		.loc 1 152 0
 455              		.cfi_startproc
 456 0000 80B5     		push	{r7, lr}
 457              		.cfi_def_cfa_offset 8
 458              		.cfi_offset 7, -8
 459              		.cfi_offset 14, -4
 460 0002 84B0     		sub	sp, sp, #16
 461              		.cfi_def_cfa_offset 24
 462 0004 00AF     		add	r7, sp, #0
 463              		.cfi_def_cfa_register 7
 464 0006 F860     		str	r0, [r7, #12]
 465 0008 B960     		str	r1, [r7, #8]
 466 000a 7A60     		str	r2, [r7, #4]
 467 000c 3B60     		str	r3, [r7]
 153:../src/frame_m0.c **** //	asm("PRESERVE8");
 154:../src/frame_m0.c **** //	asm("IMPORT callSyncM0");
 155:../src/frame_m0.c **** asm(".syntax unified");
 468              		.loc 1 155 0
 469              		.syntax divided
 470              	@ 155 "../src/frame_m0.c" 1
 471              		.syntax unified
 472              	@ 0 "" 2
 156:../src/frame_m0.c **** 
 157:../src/frame_m0.c **** 	asm("PUSH	{r4-r5}");
 473              		.loc 1 157 0
 474              	@ 157 "../src/frame_m0.c" 1
 475 000e 30B4     		PUSH	{r4-r5}
 476              	@ 0 "" 2
 158:../src/frame_m0.c **** 
 159:../src/frame_m0.c **** 	// add width to memory pointer so we can compare
 160:../src/frame_m0.c **** 	asm("ADDS	r3, r1");
 477              		.loc 1 160 0
 478              	@ 160 "../src/frame_m0.c" 1
 479 0010 5B18     		ADDS	r3, r1
 480              	@ 0 "" 2
 161:../src/frame_m0.c **** 	// generate hsync bit
 162:../src/frame_m0.c **** 	asm("MOVS	r4, #0x1");
 481              		.loc 1 162 0
 482              	@ 162 "../src/frame_m0.c" 1
 483 0012 0124     		MOVS	r4, #0x1
 484              	@ 0 "" 2
 163:../src/frame_m0.c **** 	asm("LSLS	r4, #11");
 485              		.loc 1 163 0
 486              	@ 163 "../src/frame_m0.c" 1
 487 0014 E402     		LSLS	r4, #11
 488              	@ 0 "" 2
 164:../src/frame_m0.c **** 
 165:../src/frame_m0.c **** 	asm("PUSH	{r0-r3}");	 	// save args
 489              		.loc 1 165 0
 490              	@ 165 "../src/frame_m0.c" 1
 491 0016 0FB4     		PUSH	{r0-r3}
 492              	@ 0 "" 2
 166:../src/frame_m0.c **** 	asm("BL		callSyncM0");	// get pixel sync
 493              		.loc 1 166 0
 494              	@ 166 "../src/frame_m0.c" 1
 495 0018 FFF7FEFF 		BL		callSyncM0
 496              	@ 0 "" 2
 167:../src/frame_m0.c **** 	asm("POP	{r0-r3}");		// restore args
 497              		.loc 1 167 0
 498              	@ 167 "../src/frame_m0.c" 1
 499 001c 0FBC     		POP	{r0-r3}
 500              	@ 0 "" 2
 168:../src/frame_m0.c **** 	   
 169:../src/frame_m0.c **** 	// pixel sync starts here
 170:../src/frame_m0.c **** 
 171:../src/frame_m0.c ****     // these nops are set us up for sampling hsync reliably
 172:../src/frame_m0.c **** 	asm("NOP");
 501              		.loc 1 172 0
 502              	@ 172 "../src/frame_m0.c" 1
 503 001e C046     		NOP
 504              	@ 0 "" 2
 173:../src/frame_m0.c **** 	asm("NOP");
 505              		.loc 1 173 0
 506              	@ 173 "../src/frame_m0.c" 1
 507 0020 C046     		NOP
 508              	@ 0 "" 2
 174:../src/frame_m0.c **** 
 175:../src/frame_m0.c **** 	// wait for hsync to go high
 176:../src/frame_m0.c **** asm("dest21:");
 509              		.loc 1 176 0
 510              	@ 176 "../src/frame_m0.c" 1
 511              		dest21:
 512              	@ 0 "" 2
 177:../src/frame_m0.c ****     asm("LDR 	r5, [r0]");	 	// 2
 513              		.loc 1 177 0
 514              	@ 177 "../src/frame_m0.c" 1
 515 0022 0568     		LDR 	r5, [r0]
 516              	@ 0 "" 2
 178:../src/frame_m0.c **** 	asm("TST	r5, r4");			// 1
 517              		.loc 1 178 0
 518              	@ 178 "../src/frame_m0.c" 1
 519 0024 2542     		TST	r5, r4
 520              	@ 0 "" 2
 179:../src/frame_m0.c **** 	asm("BEQ	dest21");			// 3
 521              		.loc 1 179 0
 522              	@ 179 "../src/frame_m0.c" 1
 523 0026 FCD0     		BEQ	dest21
 524              	@ 0 "" 2
 180:../src/frame_m0.c **** 
 181:../src/frame_m0.c **** 		// skip pixels
 182:../src/frame_m0.c **** asm("dest22:");
 525              		.loc 1 182 0
 526              	@ 182 "../src/frame_m0.c" 1
 527              		dest22:
 528              	@ 0 "" 2
 183:../src/frame_m0.c **** 	asm("SUBS	r2, #0x1");	// 1
 529              		.loc 1 183 0
 530              	@ 183 "../src/frame_m0.c" 1
 531 0028 013A     		SUBS	r2, #0x1
 532              	@ 0 "" 2
 184:../src/frame_m0.c ****     asm("NOP");				// 1
 533              		.loc 1 184 0
 534              	@ 184 "../src/frame_m0.c" 1
 535 002a C046     		NOP
 536              	@ 0 "" 2
 185:../src/frame_m0.c ****     asm("NOP");				// 1
 537              		.loc 1 185 0
 538              	@ 185 "../src/frame_m0.c" 1
 539 002c C046     		NOP
 540              	@ 0 "" 2
 186:../src/frame_m0.c ****     asm("NOP");				// 1
 541              		.loc 1 186 0
 542              	@ 186 "../src/frame_m0.c" 1
 543 002e C046     		NOP
 544              	@ 0 "" 2
 187:../src/frame_m0.c ****     asm("NOP");				// 1
 545              		.loc 1 187 0
 546              	@ 187 "../src/frame_m0.c" 1
 547 0030 C046     		NOP
 548              	@ 0 "" 2
 188:../src/frame_m0.c ****     asm("NOP");				// 1
 549              		.loc 1 188 0
 550              	@ 188 "../src/frame_m0.c" 1
 551 0032 C046     		NOP
 552              	@ 0 "" 2
 189:../src/frame_m0.c ****     asm("NOP");				// 1
 553              		.loc 1 189 0
 554              	@ 189 "../src/frame_m0.c" 1
 555 0034 C046     		NOP
 556              	@ 0 "" 2
 190:../src/frame_m0.c ****     asm("NOP");				// 1
 557              		.loc 1 190 0
 558              	@ 190 "../src/frame_m0.c" 1
 559 0036 C046     		NOP
 560              	@ 0 "" 2
 191:../src/frame_m0.c ****     asm("NOP");				// 1
 561              		.loc 1 191 0
 562              	@ 191 "../src/frame_m0.c" 1
 563 0038 C046     		NOP
 564              	@ 0 "" 2
 192:../src/frame_m0.c ****     asm("BGE	dest22");	// 3
 565              		.loc 1 192 0
 566              	@ 192 "../src/frame_m0.c" 1
 567 003a F5DA     		BGE	dest22
 568              	@ 0 "" 2
 193:../src/frame_m0.c **** 
 194:../src/frame_m0.c **** 	// variable delay --- get correct phase for sampling
 195:../src/frame_m0.c **** 
 196:../src/frame_m0.c ****     asm("LDRB 	r2, [r0]");	 	  // 0
 569              		.loc 1 196 0
 570              	@ 196 "../src/frame_m0.c" 1
 571 003c 0278     		LDRB 	r2, [r0]
 572              	@ 0 "" 2
 197:../src/frame_m0.c ****     asm("STRB 	r2, [r1, #0x00]");
 573              		.loc 1 197 0
 574              	@ 197 "../src/frame_m0.c" 1
 575 003e 0A70     		STRB 	r2, [r1, #0x00]
 576              	@ 0 "" 2
 198:../src/frame_m0.c ****     asm("NOP");
 577              		.loc 1 198 0
 578              	@ 198 "../src/frame_m0.c" 1
 579 0040 C046     		NOP
 580              	@ 0 "" 2
 199:../src/frame_m0.c ****     asm("NOP");
 581              		.loc 1 199 0
 582              	@ 199 "../src/frame_m0.c" 1
 583 0042 C046     		NOP
 584              	@ 0 "" 2
 200:../src/frame_m0.c **** 
 201:../src/frame_m0.c ****     asm("LDRB 	r2, [r0]");	 	  // 0
 585              		.loc 1 201 0
 586              	@ 201 "../src/frame_m0.c" 1
 587 0044 0278     		LDRB 	r2, [r0]
 588              	@ 0 "" 2
 202:../src/frame_m0.c ****     asm("STRB 	r2, [r1, #0x01]");
 589              		.loc 1 202 0
 590              	@ 202 "../src/frame_m0.c" 1
 591 0046 4A70     		STRB 	r2, [r1, #0x01]
 592              	@ 0 "" 2
 203:../src/frame_m0.c ****     asm("NOP");
 593              		.loc 1 203 0
 594              	@ 203 "../src/frame_m0.c" 1
 595 0048 C046     		NOP
 596              	@ 0 "" 2
 204:../src/frame_m0.c ****     asm("NOP");
 597              		.loc 1 204 0
 598              	@ 204 "../src/frame_m0.c" 1
 599 004a C046     		NOP
 600              	@ 0 "" 2
 205:../src/frame_m0.c **** 
 206:../src/frame_m0.c **** asm("loop11:");
 601              		.loc 1 206 0
 602              	@ 206 "../src/frame_m0.c" 1
 603              		loop11:
 604              	@ 0 "" 2
 207:../src/frame_m0.c **** 	asm("LDRB 	r2, [r0]"); 	  // 0
 605              		.loc 1 207 0
 606              	@ 207 "../src/frame_m0.c" 1
 607 004c 0278     		LDRB 	r2, [r0]
 608              	@ 0 "" 2
 208:../src/frame_m0.c **** 	asm("STRB 	r2, [r1, #0x2]");
 609              		.loc 1 208 0
 610              	@ 208 "../src/frame_m0.c" 1
 611 004e 8A70     		STRB 	r2, [r1, #0x2]
 612              	@ 0 "" 2
 209:../src/frame_m0.c **** 
 210:../src/frame_m0.c **** 	asm("ADDS	r1, #0x03");
 613              		.loc 1 210 0
 614              	@ 210 "../src/frame_m0.c" 1
 615 0050 0331     		ADDS	r1, #0x03
 616              	@ 0 "" 2
 211:../src/frame_m0.c **** 	asm("NOP");
 617              		.loc 1 211 0
 618              	@ 211 "../src/frame_m0.c" 1
 619 0052 C046     		NOP
 620              	@ 0 "" 2
 212:../src/frame_m0.c **** 
 213:../src/frame_m0.c **** 	asm("LDRB 	r2, [r0]");	  // 0
 621              		.loc 1 213 0
 622              	@ 213 "../src/frame_m0.c" 1
 623 0054 0278     		LDRB 	r2, [r0]
 624              	@ 0 "" 2
 214:../src/frame_m0.c **** 	asm("STRB 	r2, [r1, #0x0]");
 625              		.loc 1 214 0
 626              	@ 214 "../src/frame_m0.c" 1
 627 0056 0A70     		STRB 	r2, [r1, #0x0]
 628              	@ 0 "" 2
 215:../src/frame_m0.c **** 
 216:../src/frame_m0.c **** 	asm("CMP	r1, r3");
 629              		.loc 1 216 0
 630              	@ 216 "../src/frame_m0.c" 1
 631 0058 9942     		CMP	r1, r3
 632              	@ 0 "" 2
 217:../src/frame_m0.c **** 
 218:../src/frame_m0.c **** 	asm("LDRB 	r2, [r0]");	  // -1
 633              		.loc 1 218 0
 634              	@ 218 "../src/frame_m0.c" 1
 635 005a 0278     		LDRB 	r2, [r0]
 636              	@ 0 "" 2
 219:../src/frame_m0.c **** 	asm("STRB 	r2, [r1, #0x1]");
 637              		.loc 1 219 0
 638              	@ 219 "../src/frame_m0.c" 1
 639 005c 4A70     		STRB 	r2, [r1, #0x1]
 640              	@ 0 "" 2
 220:../src/frame_m0.c **** 
 221:../src/frame_m0.c **** 	asm("BLT	loop11");
 641              		.loc 1 221 0
 642              	@ 221 "../src/frame_m0.c" 1
 643 005e F5DB     		BLT	loop11
 644              	@ 0 "" 2
 222:../src/frame_m0.c **** 
 223:../src/frame_m0.c **** 	// wait for hsync to go low (end of line)
 224:../src/frame_m0.c **** asm("dest13:");
 645              		.loc 1 224 0
 646              	@ 224 "../src/frame_m0.c" 1
 647              		dest13:
 648              	@ 0 "" 2
 225:../src/frame_m0.c ****     asm("LDR 	r5, [r0]"); 	// 2
 649              		.loc 1 225 0
 650              	@ 225 "../src/frame_m0.c" 1
 651 0060 0568     		LDR 	r5, [r0]
 652              	@ 0 "" 2
 226:../src/frame_m0.c **** 	asm("TST	r5, r4");		// 1
 653              		.loc 1 226 0
 654              	@ 226 "../src/frame_m0.c" 1
 655 0062 2542     		TST	r5, r4
 656              	@ 0 "" 2
 227:../src/frame_m0.c **** 	asm("BNE	dest13");		// 3
 657              		.loc 1 227 0
 658              	@ 227 "../src/frame_m0.c" 1
 659 0064 FCD1     		BNE	dest13
 660              	@ 0 "" 2
 228:../src/frame_m0.c **** 
 229:../src/frame_m0.c **** 	asm("POP	{r4-r5}");
 661              		.loc 1 229 0
 662              	@ 229 "../src/frame_m0.c" 1
 663 0066 30BC     		POP	{r4-r5}
 664              	@ 0 "" 2
 230:../src/frame_m0.c **** 
 231:../src/frame_m0.c **** 	asm(".syntax divided");
 665              		.loc 1 231 0
 666              	@ 231 "../src/frame_m0.c" 1
 667              		.syntax divided
 668              	@ 0 "" 2
 232:../src/frame_m0.c **** }
 669              		.loc 1 232 0
 670              		.thumb
 671              		.syntax unified
 672 0068 C046     		nop
 673 006a BD46     		mov	sp, r7
 674 006c 04B0     		add	sp, sp, #16
 675              		@ sp needed
 676 006e 80BD     		pop	{r7, pc}
 677              		.cfi_endproc
 678              	.LFE35:
 680              		.section	.text.lineM1R1,"ax",%progbits
 681              		.align	2
 682              		.global	lineM1R1
 683              		.code	16
 684              		.thumb_func
 686              	lineM1R1:
 687              	.LFB36:
 233:../src/frame_m0.c **** 
 234:../src/frame_m0.c **** 
 235:../src/frame_m0.c **** void lineM1R1(uint32_t *gpio, uint8_t *memory, uint32_t xoffset, uint32_t xwidth)
 236:../src/frame_m0.c **** {
 688              		.loc 1 236 0
 689              		.cfi_startproc
 690 0000 80B5     		push	{r7, lr}
 691              		.cfi_def_cfa_offset 8
 692              		.cfi_offset 7, -8
 693              		.cfi_offset 14, -4
 694 0002 84B0     		sub	sp, sp, #16
 695              		.cfi_def_cfa_offset 24
 696 0004 00AF     		add	r7, sp, #0
 697              		.cfi_def_cfa_register 7
 698 0006 F860     		str	r0, [r7, #12]
 699 0008 B960     		str	r1, [r7, #8]
 700 000a 7A60     		str	r2, [r7, #4]
 701 000c 3B60     		str	r3, [r7]
 237:../src/frame_m0.c **** //	asm("PRESERVE8");
 238:../src/frame_m0.c **** //	asm("IMPORT	callSyncM1");
 239:../src/frame_m0.c **** asm(".syntax unified");
 702              		.loc 1 239 0
 703              		.syntax divided
 704              	@ 239 "../src/frame_m0.c" 1
 705              		.syntax unified
 706              	@ 0 "" 2
 240:../src/frame_m0.c **** 
 241:../src/frame_m0.c **** 	asm("PUSH	{r4-r5}");
 707              		.loc 1 241 0
 708              	@ 241 "../src/frame_m0.c" 1
 709 000e 30B4     		PUSH	{r4-r5}
 710              	@ 0 "" 2
 242:../src/frame_m0.c **** 
 243:../src/frame_m0.c **** 	// add width to memory pointer so we can compare
 244:../src/frame_m0.c **** 	asm("ADDS	r3, r1");
 711              		.loc 1 244 0
 712              	@ 244 "../src/frame_m0.c" 1
 713 0010 5B18     		ADDS	r3, r1
 714              	@ 0 "" 2
 245:../src/frame_m0.c **** 	// generate hsync bit
 246:../src/frame_m0.c **** 	asm("MOVS	r4, #0x1");
 715              		.loc 1 246 0
 716              	@ 246 "../src/frame_m0.c" 1
 717 0012 0124     		MOVS	r4, #0x1
 718              	@ 0 "" 2
 247:../src/frame_m0.c **** 	asm("LSLS	r4, #11");
 719              		.loc 1 247 0
 720              	@ 247 "../src/frame_m0.c" 1
 721 0014 E402     		LSLS	r4, #11
 722              	@ 0 "" 2
 248:../src/frame_m0.c **** 
 249:../src/frame_m0.c **** 	asm("PUSH	{r0-r3}"); // save args
 723              		.loc 1 249 0
 724              	@ 249 "../src/frame_m0.c" 1
 725 0016 0FB4     		PUSH	{r0-r3}
 726              	@ 0 "" 2
 250:../src/frame_m0.c **** 	asm("BL 	callSyncM1"); // get pixel sync
 727              		.loc 1 250 0
 728              	@ 250 "../src/frame_m0.c" 1
 729 0018 FFF7FEFF 		BL 	callSyncM1
 730              	@ 0 "" 2
 251:../src/frame_m0.c **** 	asm("POP	{r0-r3}");	// restore args
 731              		.loc 1 251 0
 732              	@ 251 "../src/frame_m0.c" 1
 733 001c 0FBC     		POP	{r0-r3}
 734              	@ 0 "" 2
 252:../src/frame_m0.c **** 	   
 253:../src/frame_m0.c **** 	// pixel sync starts here
 254:../src/frame_m0.c **** 
 255:../src/frame_m0.c **** 	// wait for hsync to go high
 256:../src/frame_m0.c **** asm("dest1:");
 735              		.loc 1 256 0
 736              	@ 256 "../src/frame_m0.c" 1
 737              		dest1:
 738              	@ 0 "" 2
 257:../src/frame_m0.c ****     asm("LDR	r5, [r0]"); // 2
 739              		.loc 1 257 0
 740              	@ 257 "../src/frame_m0.c" 1
 741 001e 0568     		LDR	r5, [r0]
 742              	@ 0 "" 2
 258:../src/frame_m0.c **** 	asm("TST	r5, r4");	// 1
 743              		.loc 1 258 0
 744              	@ 258 "../src/frame_m0.c" 1
 745 0020 2542     		TST	r5, r4
 746              	@ 0 "" 2
 259:../src/frame_m0.c **** 	asm("BEQ	dest1");	// 3
 747              		.loc 1 259 0
 748              	@ 259 "../src/frame_m0.c" 1
 749 0022 FCD0     		BEQ	dest1
 750              	@ 0 "" 2
 260:../src/frame_m0.c **** 
 261:../src/frame_m0.c **** 	// skip pixels
 262:../src/frame_m0.c **** asm("dest2:");
 751              		.loc 1 262 0
 752              	@ 262 "../src/frame_m0.c" 1
 753              		dest2:
 754              	@ 0 "" 2
 263:../src/frame_m0.c **** 	asm("SUBS	r2, #0x1");	// 1
 755              		.loc 1 263 0
 756              	@ 263 "../src/frame_m0.c" 1
 757 0024 013A     		SUBS	r2, #0x1
 758              	@ 0 "" 2
 264:../src/frame_m0.c **** 	asm("NOP");				// 1
 759              		.loc 1 264 0
 760              	@ 264 "../src/frame_m0.c" 1
 761 0026 C046     		NOP
 762              	@ 0 "" 2
 265:../src/frame_m0.c **** 	asm("NOP");				// 1
 763              		.loc 1 265 0
 764              	@ 265 "../src/frame_m0.c" 1
 765 0028 C046     		NOP
 766              	@ 0 "" 2
 266:../src/frame_m0.c **** 	asm("NOP");				// 1
 767              		.loc 1 266 0
 768              	@ 266 "../src/frame_m0.c" 1
 769 002a C046     		NOP
 770              	@ 0 "" 2
 267:../src/frame_m0.c **** 	asm("NOP");				// 1
 771              		.loc 1 267 0
 772              	@ 267 "../src/frame_m0.c" 1
 773 002c C046     		NOP
 774              	@ 0 "" 2
 268:../src/frame_m0.c **** 	asm("NOP");				// 1
 775              		.loc 1 268 0
 776              	@ 268 "../src/frame_m0.c" 1
 777 002e C046     		NOP
 778              	@ 0 "" 2
 269:../src/frame_m0.c **** 	asm("NOP");				// 1
 779              		.loc 1 269 0
 780              	@ 269 "../src/frame_m0.c" 1
 781 0030 C046     		NOP
 782              	@ 0 "" 2
 270:../src/frame_m0.c **** 	asm("NOP");				// 1
 783              		.loc 1 270 0
 784              	@ 270 "../src/frame_m0.c" 1
 785 0032 C046     		NOP
 786              	@ 0 "" 2
 271:../src/frame_m0.c **** 	asm("NOP");				// 1
 787              		.loc 1 271 0
 788              	@ 271 "../src/frame_m0.c" 1
 789 0034 C046     		NOP
 790              	@ 0 "" 2
 272:../src/frame_m0.c **** 	asm("NOP");				// 1
 791              		.loc 1 272 0
 792              	@ 272 "../src/frame_m0.c" 1
 793 0036 C046     		NOP
 794              	@ 0 "" 2
 273:../src/frame_m0.c **** 	asm("NOP");				// 1
 795              		.loc 1 273 0
 796              	@ 273 "../src/frame_m0.c" 1
 797 0038 C046     		NOP
 798              	@ 0 "" 2
 274:../src/frame_m0.c **** 	asm("NOP");				// 1
 799              		.loc 1 274 0
 800              	@ 274 "../src/frame_m0.c" 1
 801 003a C046     		NOP
 802              	@ 0 "" 2
 275:../src/frame_m0.c **** 	asm("NOP");				// 1
 803              		.loc 1 275 0
 804              	@ 275 "../src/frame_m0.c" 1
 805 003c C046     		NOP
 806              	@ 0 "" 2
 276:../src/frame_m0.c **** 	asm("NOP");				// 1
 807              		.loc 1 276 0
 808              	@ 276 "../src/frame_m0.c" 1
 809 003e C046     		NOP
 810              	@ 0 "" 2
 277:../src/frame_m0.c **** 	asm("NOP");				// 1
 811              		.loc 1 277 0
 812              	@ 277 "../src/frame_m0.c" 1
 813 0040 C046     		NOP
 814              	@ 0 "" 2
 278:../src/frame_m0.c **** 	asm("NOP");				// 1
 815              		.loc 1 278 0
 816              	@ 278 "../src/frame_m0.c" 1
 817 0042 C046     		NOP
 818              	@ 0 "" 2
 279:../src/frame_m0.c **** 	asm("NOP");				// 1
 819              		.loc 1 279 0
 820              	@ 279 "../src/frame_m0.c" 1
 821 0044 C046     		NOP
 822              	@ 0 "" 2
 280:../src/frame_m0.c **** 	asm("NOP");				// 1
 823              		.loc 1 280 0
 824              	@ 280 "../src/frame_m0.c" 1
 825 0046 C046     		NOP
 826              	@ 0 "" 2
 281:../src/frame_m0.c **** 	asm("NOP");				// 1
 827              		.loc 1 281 0
 828              	@ 281 "../src/frame_m0.c" 1
 829 0048 C046     		NOP
 830              	@ 0 "" 2
 282:../src/frame_m0.c **** 	asm("NOP");				// 1
 831              		.loc 1 282 0
 832              	@ 282 "../src/frame_m0.c" 1
 833 004a C046     		NOP
 834              	@ 0 "" 2
 283:../src/frame_m0.c **** 	asm("NOP");				// 1
 835              		.loc 1 283 0
 836              	@ 283 "../src/frame_m0.c" 1
 837 004c C046     		NOP
 838              	@ 0 "" 2
 284:../src/frame_m0.c **** 	asm("BGE	dest2");		// 3
 839              		.loc 1 284 0
 840              	@ 284 "../src/frame_m0.c" 1
 841 004e E9DA     		BGE	dest2
 842              	@ 0 "" 2
 285:../src/frame_m0.c **** 
 286:../src/frame_m0.c **** 	// variable delay --- get correct phase for sampling
 287:../src/frame_m0.c **** 	asm("NOP");
 843              		.loc 1 287 0
 844              	@ 287 "../src/frame_m0.c" 1
 845 0050 C046     		NOP
 846              	@ 0 "" 2
 288:../src/frame_m0.c **** 	asm("NOP");
 847              		.loc 1 288 0
 848              	@ 288 "../src/frame_m0.c" 1
 849 0052 C046     		NOP
 850              	@ 0 "" 2
 289:../src/frame_m0.c **** 
 290:../src/frame_m0.c **** asm("loop1:");
 851              		.loc 1 290 0
 852              	@ 290 "../src/frame_m0.c" 1
 853              		loop1:
 854              	@ 0 "" 2
 291:../src/frame_m0.c **** 	asm("LDRB 	r2, [r0]");
 855              		.loc 1 291 0
 856              	@ 291 "../src/frame_m0.c" 1
 857 0054 0278     		LDRB 	r2, [r0]
 858              	@ 0 "" 2
 292:../src/frame_m0.c **** 	asm("STRB 	r2, [r1]");
 859              		.loc 1 292 0
 860              	@ 292 "../src/frame_m0.c" 1
 861 0056 0A70     		STRB 	r2, [r1]
 862              	@ 0 "" 2
 293:../src/frame_m0.c **** 	asm("NOP");
 863              		.loc 1 293 0
 864              	@ 293 "../src/frame_m0.c" 1
 865 0058 C046     		NOP
 866              	@ 0 "" 2
 294:../src/frame_m0.c **** 	asm("NOP");
 867              		.loc 1 294 0
 868              	@ 294 "../src/frame_m0.c" 1
 869 005a C046     		NOP
 870              	@ 0 "" 2
 295:../src/frame_m0.c **** 	asm("NOP");
 871              		.loc 1 295 0
 872              	@ 295 "../src/frame_m0.c" 1
 873 005c C046     		NOP
 874              	@ 0 "" 2
 296:../src/frame_m0.c **** 	asm("ADDS	r1, #0x01");
 875              		.loc 1 296 0
 876              	@ 296 "../src/frame_m0.c" 1
 877 005e 0131     		ADDS	r1, #0x01
 878              	@ 0 "" 2
 297:../src/frame_m0.c **** 	asm("CMP	r1, r3");
 879              		.loc 1 297 0
 880              	@ 297 "../src/frame_m0.c" 1
 881 0060 9942     		CMP	r1, r3
 882              	@ 0 "" 2
 298:../src/frame_m0.c **** 	asm("BLT	loop1");
 883              		.loc 1 298 0
 884              	@ 298 "../src/frame_m0.c" 1
 885 0062 F7DB     		BLT	loop1
 886              	@ 0 "" 2
 299:../src/frame_m0.c **** 
 300:../src/frame_m0.c **** 	// wait for hsync to go low (end of line)
 301:../src/frame_m0.c **** asm("dest3:");
 887              		.loc 1 301 0
 888              	@ 301 "../src/frame_m0.c" 1
 889              		dest3:
 890              	@ 0 "" 2
 302:../src/frame_m0.c ****     asm("LDR 	r5, [r0]"); 	// 2
 891              		.loc 1 302 0
 892              	@ 302 "../src/frame_m0.c" 1
 893 0064 0568     		LDR 	r5, [r0]
 894              	@ 0 "" 2
 303:../src/frame_m0.c **** 	asm("TST	r5, r4");		// 1
 895              		.loc 1 303 0
 896              	@ 303 "../src/frame_m0.c" 1
 897 0066 2542     		TST	r5, r4
 898              	@ 0 "" 2
 304:../src/frame_m0.c **** 	asm("BNE	dest3");		// 3
 899              		.loc 1 304 0
 900              	@ 304 "../src/frame_m0.c" 1
 901 0068 FCD1     		BNE	dest3
 902              	@ 0 "" 2
 305:../src/frame_m0.c **** 
 306:../src/frame_m0.c **** 	asm("POP	{r4-r5}");
 903              		.loc 1 306 0
 904              	@ 306 "../src/frame_m0.c" 1
 905 006a 30BC     		POP	{r4-r5}
 906              	@ 0 "" 2
 307:../src/frame_m0.c **** 
 308:../src/frame_m0.c **** 	asm(".syntax divided");
 907              		.loc 1 308 0
 908              	@ 308 "../src/frame_m0.c" 1
 909              		.syntax divided
 910              	@ 0 "" 2
 309:../src/frame_m0.c **** }
 911              		.loc 1 309 0
 912              		.thumb
 913              		.syntax unified
 914 006c C046     		nop
 915 006e BD46     		mov	sp, r7
 916 0070 04B0     		add	sp, sp, #16
 917              		@ sp needed
 918 0072 80BD     		pop	{r7, pc}
 919              		.cfi_endproc
 920              	.LFE36:
 922              		.section	.text.lineM1R2,"ax",%progbits
 923              		.align	2
 924              		.global	lineM1R2
 925              		.code	16
 926              		.thumb_func
 928              	lineM1R2:
 929              	.LFB37:
 310:../src/frame_m0.c **** 
 311:../src/frame_m0.c **** 
 312:../src/frame_m0.c **** void lineM1R2(uint32_t *gpio, uint16_t *memory, uint32_t xoffset, uint32_t xwidth)
 313:../src/frame_m0.c **** {
 930              		.loc 1 313 0
 931              		.cfi_startproc
 932 0000 80B5     		push	{r7, lr}
 933              		.cfi_def_cfa_offset 8
 934              		.cfi_offset 7, -8
 935              		.cfi_offset 14, -4
 936 0002 84B0     		sub	sp, sp, #16
 937              		.cfi_def_cfa_offset 24
 938 0004 00AF     		add	r7, sp, #0
 939              		.cfi_def_cfa_register 7
 940 0006 F860     		str	r0, [r7, #12]
 941 0008 B960     		str	r1, [r7, #8]
 942 000a 7A60     		str	r2, [r7, #4]
 943 000c 3B60     		str	r3, [r7]
 314:../src/frame_m0.c **** //	asm("PRESERVE8");
 315:../src/frame_m0.c **** //	asm("IMPORT callSyncM1");
 316:../src/frame_m0.c **** asm(".syntax unified");
 944              		.loc 1 316 0
 945              		.syntax divided
 946              	@ 316 "../src/frame_m0.c" 1
 947              		.syntax unified
 948              	@ 0 "" 2
 317:../src/frame_m0.c **** 
 318:../src/frame_m0.c **** 	asm("PUSH	{r4-r6}");
 949              		.loc 1 318 0
 950              	@ 318 "../src/frame_m0.c" 1
 951 000e 70B4     		PUSH	{r4-r6}
 952              	@ 0 "" 2
 319:../src/frame_m0.c **** 
 320:../src/frame_m0.c **** 	// add width to memory pointer so we can compare
 321:../src/frame_m0.c **** 	asm("LSLS	r3, #1");
 953              		.loc 1 321 0
 954              	@ 321 "../src/frame_m0.c" 1
 955 0010 5B00     		LSLS	r3, #1
 956              	@ 0 "" 2
 322:../src/frame_m0.c **** 	asm("ADDS	r3, r1");
 957              		.loc 1 322 0
 958              	@ 322 "../src/frame_m0.c" 1
 959 0012 5B18     		ADDS	r3, r1
 960              	@ 0 "" 2
 323:../src/frame_m0.c **** 	// generate hsync bit
 324:../src/frame_m0.c **** 	asm("MOVS	r4, #0x1");
 961              		.loc 1 324 0
 962              	@ 324 "../src/frame_m0.c" 1
 963 0014 0124     		MOVS	r4, #0x1
 964              	@ 0 "" 2
 325:../src/frame_m0.c **** 	asm("LSLS	r4, #11");
 965              		.loc 1 325 0
 966              	@ 325 "../src/frame_m0.c" 1
 967 0016 E402     		LSLS	r4, #11
 968              	@ 0 "" 2
 326:../src/frame_m0.c **** 
 327:../src/frame_m0.c **** 	asm("PUSH	{r0-r3}"); // save args
 969              		.loc 1 327 0
 970              	@ 327 "../src/frame_m0.c" 1
 971 0018 0FB4     		PUSH	{r0-r3}
 972              	@ 0 "" 2
 328:../src/frame_m0.c **** 	asm("BL		callSyncM1"); // get pixel sync
 973              		.loc 1 328 0
 974              	@ 328 "../src/frame_m0.c" 1
 975 001a FFF7FEFF 		BL		callSyncM1
 976              	@ 0 "" 2
 329:../src/frame_m0.c **** 	asm("POP	{r0-r3}");	// restore args
 977              		.loc 1 329 0
 978              	@ 329 "../src/frame_m0.c" 1
 979 001e 0FBC     		POP	{r0-r3}
 980              	@ 0 "" 2
 330:../src/frame_m0.c **** 	   
 331:../src/frame_m0.c **** 	// pixel sync starts here
 332:../src/frame_m0.c **** asm("dest7:");
 981              		.loc 1 332 0
 982              	@ 332 "../src/frame_m0.c" 1
 983              		dest7:
 984              	@ 0 "" 2
 333:../src/frame_m0.c ****    asm("LDR 	r5, [r0]"); // 2
 985              		.loc 1 333 0
 986              	@ 333 "../src/frame_m0.c" 1
 987 0020 0568     		LDR 	r5, [r0]
 988              	@ 0 "" 2
 334:../src/frame_m0.c ****    asm("TST		r5, r4");	// 1
 989              		.loc 1 334 0
 990              	@ 334 "../src/frame_m0.c" 1
 991 0022 2542     		TST		r5, r4
 992              	@ 0 "" 2
 335:../src/frame_m0.c ****    asm("BEQ		dest7");	// 3
 993              		.loc 1 335 0
 994              	@ 335 "../src/frame_m0.c" 1
 995 0024 FCD0     		BEQ		dest7
 996              	@ 0 "" 2
 336:../src/frame_m0.c **** 
 337:../src/frame_m0.c ****    // skip pixels
 338:../src/frame_m0.c **** asm("dest8:");
 997              		.loc 1 338 0
 998              	@ 338 "../src/frame_m0.c" 1
 999              		dest8:
 1000              	@ 0 "" 2
 339:../src/frame_m0.c ****     asm("SUBS	r2, #0x1");	// 1
 1001              		.loc 1 339 0
 1002              	@ 339 "../src/frame_m0.c" 1
 1003 0026 013A     		SUBS	r2, #0x1
 1004              	@ 0 "" 2
 340:../src/frame_m0.c **** 	asm("NOP");				// 1
 1005              		.loc 1 340 0
 1006              	@ 340 "../src/frame_m0.c" 1
 1007 0028 C046     		NOP
 1008              	@ 0 "" 2
 341:../src/frame_m0.c **** 	asm("NOP");				// 1
 1009              		.loc 1 341 0
 1010              	@ 341 "../src/frame_m0.c" 1
 1011 002a C046     		NOP
 1012              	@ 0 "" 2
 342:../src/frame_m0.c **** 	asm("NOP");				// 1
 1013              		.loc 1 342 0
 1014              	@ 342 "../src/frame_m0.c" 1
 1015 002c C046     		NOP
 1016              	@ 0 "" 2
 343:../src/frame_m0.c **** 	asm("NOP");				// 1
 1017              		.loc 1 343 0
 1018              	@ 343 "../src/frame_m0.c" 1
 1019 002e C046     		NOP
 1020              	@ 0 "" 2
 344:../src/frame_m0.c **** 	asm("NOP");				// 1
 1021              		.loc 1 344 0
 1022              	@ 344 "../src/frame_m0.c" 1
 1023 0030 C046     		NOP
 1024              	@ 0 "" 2
 345:../src/frame_m0.c **** 	asm("NOP");				// 1
 1025              		.loc 1 345 0
 1026              	@ 345 "../src/frame_m0.c" 1
 1027 0032 C046     		NOP
 1028              	@ 0 "" 2
 346:../src/frame_m0.c **** 	asm("NOP");				// 1
 1029              		.loc 1 346 0
 1030              	@ 346 "../src/frame_m0.c" 1
 1031 0034 C046     		NOP
 1032              	@ 0 "" 2
 347:../src/frame_m0.c **** 	asm("NOP");				// 1
 1033              		.loc 1 347 0
 1034              	@ 347 "../src/frame_m0.c" 1
 1035 0036 C046     		NOP
 1036              	@ 0 "" 2
 348:../src/frame_m0.c **** 	asm("NOP");				// 1
 1037              		.loc 1 348 0
 1038              	@ 348 "../src/frame_m0.c" 1
 1039 0038 C046     		NOP
 1040              	@ 0 "" 2
 349:../src/frame_m0.c **** 	asm("NOP");				// 1
 1041              		.loc 1 349 0
 1042              	@ 349 "../src/frame_m0.c" 1
 1043 003a C046     		NOP
 1044              	@ 0 "" 2
 350:../src/frame_m0.c **** 	asm("NOP");				// 1
 1045              		.loc 1 350 0
 1046              	@ 350 "../src/frame_m0.c" 1
 1047 003c C046     		NOP
 1048              	@ 0 "" 2
 351:../src/frame_m0.c **** 	asm("NOP");				// 1
 1049              		.loc 1 351 0
 1050              	@ 351 "../src/frame_m0.c" 1
 1051 003e C046     		NOP
 1052              	@ 0 "" 2
 352:../src/frame_m0.c **** 	asm("NOP");				// 1
 1053              		.loc 1 352 0
 1054              	@ 352 "../src/frame_m0.c" 1
 1055 0040 C046     		NOP
 1056              	@ 0 "" 2
 353:../src/frame_m0.c **** 	asm("NOP");				// 1
 1057              		.loc 1 353 0
 1058              	@ 353 "../src/frame_m0.c" 1
 1059 0042 C046     		NOP
 1060              	@ 0 "" 2
 354:../src/frame_m0.c **** 	asm("NOP");				// 1
 1061              		.loc 1 354 0
 1062              	@ 354 "../src/frame_m0.c" 1
 1063 0044 C046     		NOP
 1064              	@ 0 "" 2
 355:../src/frame_m0.c **** 	asm("NOP");				// 1
 1065              		.loc 1 355 0
 1066              	@ 355 "../src/frame_m0.c" 1
 1067 0046 C046     		NOP
 1068              	@ 0 "" 2
 356:../src/frame_m0.c **** 	asm("NOP");				// 1
 1069              		.loc 1 356 0
 1070              	@ 356 "../src/frame_m0.c" 1
 1071 0048 C046     		NOP
 1072              	@ 0 "" 2
 357:../src/frame_m0.c **** 	asm("NOP");				// 1
 1073              		.loc 1 357 0
 1074              	@ 357 "../src/frame_m0.c" 1
 1075 004a C046     		NOP
 1076              	@ 0 "" 2
 358:../src/frame_m0.c **** 	asm("NOP");				// 1
 1077              		.loc 1 358 0
 1078              	@ 358 "../src/frame_m0.c" 1
 1079 004c C046     		NOP
 1080              	@ 0 "" 2
 359:../src/frame_m0.c **** 	asm("NOP");				// 1
 1081              		.loc 1 359 0
 1082              	@ 359 "../src/frame_m0.c" 1
 1083 004e C046     		NOP
 1084              	@ 0 "" 2
 360:../src/frame_m0.c **** 	asm("BGE	dest8");		// 3
 1085              		.loc 1 360 0
 1086              	@ 360 "../src/frame_m0.c" 1
 1087 0050 E9DA     		BGE	dest8
 1088              	@ 0 "" 2
 361:../src/frame_m0.c **** 
 362:../src/frame_m0.c **** 	// variable delay --- get correct phase for sampling
 363:../src/frame_m0.c **** 	asm("NOP");
 1089              		.loc 1 363 0
 1090              	@ 363 "../src/frame_m0.c" 1
 1091 0052 C046     		NOP
 1092              	@ 0 "" 2
 364:../src/frame_m0.c **** 	asm("NOP");
 1093              		.loc 1 364 0
 1094              	@ 364 "../src/frame_m0.c" 1
 1095 0054 C046     		NOP
 1096              	@ 0 "" 2
 365:../src/frame_m0.c **** 
 366:../src/frame_m0.c **** asm("loop3:");
 1097              		.loc 1 366 0
 1098              	@ 366 "../src/frame_m0.c" 1
 1099              		loop3:
 1100              	@ 0 "" 2
 367:../src/frame_m0.c **** 	asm("LDRB 	r2, [r0]");
 1101              		.loc 1 367 0
 1102              	@ 367 "../src/frame_m0.c" 1
 1103 0056 0278     		LDRB 	r2, [r0]
 1104              	@ 0 "" 2
 368:../src/frame_m0.c **** 	asm("NOP");
 1105              		.loc 1 368 0
 1106              	@ 368 "../src/frame_m0.c" 1
 1107 0058 C046     		NOP
 1108              	@ 0 "" 2
 369:../src/frame_m0.c **** 	asm("NOP");
 1109              		.loc 1 369 0
 1110              	@ 369 "../src/frame_m0.c" 1
 1111 005a C046     		NOP
 1112              	@ 0 "" 2
 370:../src/frame_m0.c **** 	asm("NOP");
 1113              		.loc 1 370 0
 1114              	@ 370 "../src/frame_m0.c" 1
 1115 005c C046     		NOP
 1116              	@ 0 "" 2
 371:../src/frame_m0.c **** 	asm("NOP");
 1117              		.loc 1 371 0
 1118              	@ 371 "../src/frame_m0.c" 1
 1119 005e C046     		NOP
 1120              	@ 0 "" 2
 372:../src/frame_m0.c **** 	asm("NOP");
 1121              		.loc 1 372 0
 1122              	@ 372 "../src/frame_m0.c" 1
 1123 0060 C046     		NOP
 1124              	@ 0 "" 2
 373:../src/frame_m0.c **** 	asm("NOP");
 1125              		.loc 1 373 0
 1126              	@ 373 "../src/frame_m0.c" 1
 1127 0062 C046     		NOP
 1128              	@ 0 "" 2
 374:../src/frame_m0.c **** 	asm("NOP");
 1129              		.loc 1 374 0
 1130              	@ 374 "../src/frame_m0.c" 1
 1131 0064 C046     		NOP
 1132              	@ 0 "" 2
 375:../src/frame_m0.c **** 	asm("NOP");
 1133              		.loc 1 375 0
 1134              	@ 375 "../src/frame_m0.c" 1
 1135 0066 C046     		NOP
 1136              	@ 0 "" 2
 376:../src/frame_m0.c **** 	asm("NOP");
 1137              		.loc 1 376 0
 1138              	@ 376 "../src/frame_m0.c" 1
 1139 0068 C046     		NOP
 1140              	@ 0 "" 2
 377:../src/frame_m0.c **** 	asm("NOP");
 1141              		.loc 1 377 0
 1142              	@ 377 "../src/frame_m0.c" 1
 1143 006a C046     		NOP
 1144              	@ 0 "" 2
 378:../src/frame_m0.c **** 
 379:../src/frame_m0.c **** 	asm("LDRB 	r5, [r0]");
 1145              		.loc 1 379 0
 1146              	@ 379 "../src/frame_m0.c" 1
 1147 006c 0578     		LDRB 	r5, [r0]
 1148              	@ 0 "" 2
 380:../src/frame_m0.c ****     asm("NOP");
 1149              		.loc 1 380 0
 1150              	@ 380 "../src/frame_m0.c" 1
 1151 006e C046     		NOP
 1152              	@ 0 "" 2
 381:../src/frame_m0.c **** 	asm("NOP");
 1153              		.loc 1 381 0
 1154              	@ 381 "../src/frame_m0.c" 1
 1155 0070 C046     		NOP
 1156              	@ 0 "" 2
 382:../src/frame_m0.c **** 	asm("NOP");
 1157              		.loc 1 382 0
 1158              	@ 382 "../src/frame_m0.c" 1
 1159 0072 C046     		NOP
 1160              	@ 0 "" 2
 383:../src/frame_m0.c **** 	asm("NOP");
 1161              		.loc 1 383 0
 1162              	@ 383 "../src/frame_m0.c" 1
 1163 0074 C046     		NOP
 1164              	@ 0 "" 2
 384:../src/frame_m0.c **** 	asm("NOP");
 1165              		.loc 1 384 0
 1166              	@ 384 "../src/frame_m0.c" 1
 1167 0076 C046     		NOP
 1168              	@ 0 "" 2
 385:../src/frame_m0.c **** 	asm("NOP");
 1169              		.loc 1 385 0
 1170              	@ 385 "../src/frame_m0.c" 1
 1171 0078 C046     		NOP
 1172              	@ 0 "" 2
 386:../src/frame_m0.c **** 	asm("NOP");
 1173              		.loc 1 386 0
 1174              	@ 386 "../src/frame_m0.c" 1
 1175 007a C046     		NOP
 1176              	@ 0 "" 2
 387:../src/frame_m0.c **** 	asm("NOP");
 1177              		.loc 1 387 0
 1178              	@ 387 "../src/frame_m0.c" 1
 1179 007c C046     		NOP
 1180              	@ 0 "" 2
 388:../src/frame_m0.c **** 	asm("NOP");
 1181              		.loc 1 388 0
 1182              	@ 388 "../src/frame_m0.c" 1
 1183 007e C046     		NOP
 1184              	@ 0 "" 2
 389:../src/frame_m0.c **** 	asm("NOP");
 1185              		.loc 1 389 0
 1186              	@ 389 "../src/frame_m0.c" 1
 1187 0080 C046     		NOP
 1188              	@ 0 "" 2
 390:../src/frame_m0.c **** 
 391:../src/frame_m0.c **** 	asm("LDRB 	r6, [r0]");
 1189              		.loc 1 391 0
 1190              	@ 391 "../src/frame_m0.c" 1
 1191 0082 0678     		LDRB 	r6, [r0]
 1192              	@ 0 "" 2
 392:../src/frame_m0.c **** 	asm("ADDS   r6, r2");
 1193              		.loc 1 392 0
 1194              	@ 392 "../src/frame_m0.c" 1
 1195 0084 B618     		ADDS   r6, r2
 1196              	@ 0 "" 2
 393:../src/frame_m0.c **** 	asm("STRH 	r6, [r1, #0x00]");
 1197              		.loc 1 393 0
 1198              	@ 393 "../src/frame_m0.c" 1
 1199 0086 0E80     		STRH 	r6, [r1, #0x00]
 1200              	@ 0 "" 2
 394:../src/frame_m0.c ****     asm("NOP");
 1201              		.loc 1 394 0
 1202              	@ 394 "../src/frame_m0.c" 1
 1203 0088 C046     		NOP
 1204              	@ 0 "" 2
 395:../src/frame_m0.c **** 	asm("NOP");
 1205              		.loc 1 395 0
 1206              	@ 395 "../src/frame_m0.c" 1
 1207 008a C046     		NOP
 1208              	@ 0 "" 2
 396:../src/frame_m0.c **** 	asm("NOP");
 1209              		.loc 1 396 0
 1210              	@ 396 "../src/frame_m0.c" 1
 1211 008c C046     		NOP
 1212              	@ 0 "" 2
 397:../src/frame_m0.c **** 	asm("NOP");
 1213              		.loc 1 397 0
 1214              	@ 397 "../src/frame_m0.c" 1
 1215 008e C046     		NOP
 1216              	@ 0 "" 2
 398:../src/frame_m0.c **** 	asm("NOP");
 1217              		.loc 1 398 0
 1218              	@ 398 "../src/frame_m0.c" 1
 1219 0090 C046     		NOP
 1220              	@ 0 "" 2
 399:../src/frame_m0.c **** 	asm("NOP");
 1221              		.loc 1 399 0
 1222              	@ 399 "../src/frame_m0.c" 1
 1223 0092 C046     		NOP
 1224              	@ 0 "" 2
 400:../src/frame_m0.c **** 	asm("NOP");
 1225              		.loc 1 400 0
 1226              	@ 400 "../src/frame_m0.c" 1
 1227 0094 C046     		NOP
 1228              	@ 0 "" 2
 401:../src/frame_m0.c **** 
 402:../src/frame_m0.c **** 	asm("LDRB 	r6, [r0]");
 1229              		.loc 1 402 0
 1230              	@ 402 "../src/frame_m0.c" 1
 1231 0096 0678     		LDRB 	r6, [r0]
 1232              	@ 0 "" 2
 403:../src/frame_m0.c **** 	asm("ADDS   r6, r5");
 1233              		.loc 1 403 0
 1234              	@ 403 "../src/frame_m0.c" 1
 1235 0098 7619     		ADDS   r6, r5
 1236              	@ 0 "" 2
 404:../src/frame_m0.c **** 	asm("STRH 	r6, [r1, #0x02]");
 1237              		.loc 1 404 0
 1238              	@ 404 "../src/frame_m0.c" 1
 1239 009a 4E80     		STRH 	r6, [r1, #0x02]
 1240              	@ 0 "" 2
 405:../src/frame_m0.c **** 	asm("NOP");
 1241              		.loc 1 405 0
 1242              	@ 405 "../src/frame_m0.c" 1
 1243 009c C046     		NOP
 1244              	@ 0 "" 2
 406:../src/frame_m0.c **** 	asm("NOP");
 1245              		.loc 1 406 0
 1246              	@ 406 "../src/frame_m0.c" 1
 1247 009e C046     		NOP
 1248              	@ 0 "" 2
 407:../src/frame_m0.c **** 	asm("ADDS	r1, #0x04");
 1249              		.loc 1 407 0
 1250              	@ 407 "../src/frame_m0.c" 1
 1251 00a0 0431     		ADDS	r1, #0x04
 1252              	@ 0 "" 2
 408:../src/frame_m0.c **** 	asm("CMP	r1, r3");
 1253              		.loc 1 408 0
 1254              	@ 408 "../src/frame_m0.c" 1
 1255 00a2 9942     		CMP	r1, r3
 1256              	@ 0 "" 2
 409:../src/frame_m0.c **** 	asm("BLT	loop3");
 1257              		.loc 1 409 0
 1258              	@ 409 "../src/frame_m0.c" 1
 1259 00a4 D7DB     		BLT	loop3
 1260              	@ 0 "" 2
 410:../src/frame_m0.c **** 
 411:../src/frame_m0.c **** 		// wait for hsync to go low (end of line)
 412:../src/frame_m0.c **** asm("dest9:");
 1261              		.loc 1 412 0
 1262              	@ 412 "../src/frame_m0.c" 1
 1263              		dest9:
 1264              	@ 0 "" 2
 413:../src/frame_m0.c **** 	asm("LDR 	r5, [r0]"); 	// 2
 1265              		.loc 1 413 0
 1266              	@ 413 "../src/frame_m0.c" 1
 1267 00a6 0568     		LDR 	r5, [r0]
 1268              	@ 0 "" 2
 414:../src/frame_m0.c **** 	asm("TST	r5, r4");		// 1
 1269              		.loc 1 414 0
 1270              	@ 414 "../src/frame_m0.c" 1
 1271 00a8 2542     		TST	r5, r4
 1272              	@ 0 "" 2
 415:../src/frame_m0.c **** 	asm("BNE	dest9");		// 3
 1273              		.loc 1 415 0
 1274              	@ 415 "../src/frame_m0.c" 1
 1275 00aa FCD1     		BNE	dest9
 1276              	@ 0 "" 2
 416:../src/frame_m0.c **** 
 417:../src/frame_m0.c **** 	asm("POP	{r4-r6}");
 1277              		.loc 1 417 0
 1278              	@ 417 "../src/frame_m0.c" 1
 1279 00ac 70BC     		POP	{r4-r6}
 1280              	@ 0 "" 2
 418:../src/frame_m0.c **** 
 419:../src/frame_m0.c **** 	asm(".syntax divided");
 1281              		.loc 1 419 0
 1282              	@ 419 "../src/frame_m0.c" 1
 1283              		.syntax divided
 1284              	@ 0 "" 2
 420:../src/frame_m0.c **** }
 1285              		.loc 1 420 0
 1286              		.thumb
 1287              		.syntax unified
 1288 00ae C046     		nop
 1289 00b0 BD46     		mov	sp, r7
 1290 00b2 04B0     		add	sp, sp, #16
 1291              		@ sp needed
 1292 00b4 80BD     		pop	{r7, pc}
 1293              		.cfi_endproc
 1294              	.LFE37:
 1296 00b6 C046     		.section	.text.lineM1R2Merge,"ax",%progbits
 1297              		.align	2
 1298              		.global	lineM1R2Merge
 1299              		.code	16
 1300              		.thumb_func
 1302              	lineM1R2Merge:
 1303              	.LFB38:
 421:../src/frame_m0.c **** 
 422:../src/frame_m0.c **** 
 423:../src/frame_m0.c **** void lineM1R2Merge(uint32_t *gpio, uint16_t *lineMemory, uint8_t *memory, uint32_t xoffset, uint32_
 424:../src/frame_m0.c **** {
 1304              		.loc 1 424 0
 1305              		.cfi_startproc
 1306 0000 80B5     		push	{r7, lr}
 1307              		.cfi_def_cfa_offset 8
 1308              		.cfi_offset 7, -8
 1309              		.cfi_offset 14, -4
 1310 0002 84B0     		sub	sp, sp, #16
 1311              		.cfi_def_cfa_offset 24
 1312 0004 00AF     		add	r7, sp, #0
 1313              		.cfi_def_cfa_register 7
 1314 0006 F860     		str	r0, [r7, #12]
 1315 0008 B960     		str	r1, [r7, #8]
 1316 000a 7A60     		str	r2, [r7, #4]
 1317 000c 3B60     		str	r3, [r7]
 425:../src/frame_m0.c **** //	asm("PRESERVE8");
 426:../src/frame_m0.c **** //	asm("IMPORT callSyncM1");
 427:../src/frame_m0.c **** asm(".syntax unified");
 1318              		.loc 1 427 0
 1319              		.syntax divided
 1320              	@ 427 "../src/frame_m0.c" 1
 1321              		.syntax unified
 1322              	@ 0 "" 2
 428:../src/frame_m0.c **** 
 429:../src/frame_m0.c **** 	asm("PUSH	{r4-r7}");
 1323              		.loc 1 429 0
 1324              	@ 429 "../src/frame_m0.c" 1
 1325 000e F0B4     		PUSH	{r4-r7}
 1326              	@ 0 "" 2
 430:../src/frame_m0.c **** 	asm("LDR	r4, [sp, #0x28]"); // *** keil
 1327              		.loc 1 430 0
 1328              	@ 430 "../src/frame_m0.c" 1
 1329 0010 0A9C     		LDR	r4, [sp, #0x28]
 1330              	@ 0 "" 2
 431:../src/frame_m0.c **** 
 432:../src/frame_m0.c ****    	// add width to memory pointer so we can compare
 433:../src/frame_m0.c **** 	asm("ADDS	r4, r2");
 1331              		.loc 1 433 0
 1332              	@ 433 "../src/frame_m0.c" 1
 1333 0012 A418     		ADDS	r4, r2
 1334              	@ 0 "" 2
 434:../src/frame_m0.c **** 	// generate hsync bit
 435:../src/frame_m0.c **** 	asm("MOVS	r5, #0x1");
 1335              		.loc 1 435 0
 1336              	@ 435 "../src/frame_m0.c" 1
 1337 0014 0125     		MOVS	r5, #0x1
 1338              	@ 0 "" 2
 436:../src/frame_m0.c **** 	asm("LSLS	r5, #11");
 1339              		.loc 1 436 0
 1340              	@ 436 "../src/frame_m0.c" 1
 1341 0016 ED02     		LSLS	r5, #11
 1342              	@ 0 "" 2
 437:../src/frame_m0.c **** 
 438:../src/frame_m0.c **** 	asm("PUSH	{r0-r3}"); // save args
 1343              		.loc 1 438 0
 1344              	@ 438 "../src/frame_m0.c" 1
 1345 0018 0FB4     		PUSH	{r0-r3}
 1346              	@ 0 "" 2
 439:../src/frame_m0.c **** 	asm("BL 	callSyncM1"); // get pixel sync
 1347              		.loc 1 439 0
 1348              	@ 439 "../src/frame_m0.c" 1
 1349 001a FFF7FEFF 		BL 	callSyncM1
 1350              	@ 0 "" 2
 440:../src/frame_m0.c **** 	asm("POP	{r0-r3}");	// restore args
 1351              		.loc 1 440 0
 1352              	@ 440 "../src/frame_m0.c" 1
 1353 001e 0FBC     		POP	{r0-r3}
 1354              	@ 0 "" 2
 441:../src/frame_m0.c **** 	   
 442:../src/frame_m0.c **** 	// pixel sync starts here
 443:../src/frame_m0.c **** 
 444:../src/frame_m0.c **** 	// wait for hsync to go high
 445:../src/frame_m0.c **** asm("dest4:");
 1355              		.loc 1 445 0
 1356              	@ 445 "../src/frame_m0.c" 1
 1357              		dest4:
 1358              	@ 0 "" 2
 446:../src/frame_m0.c **** 	asm("LDR 	r6, [r0]"); 	// 2
 1359              		.loc 1 446 0
 1360              	@ 446 "../src/frame_m0.c" 1
 1361 0020 0668     		LDR 	r6, [r0]
 1362              	@ 0 "" 2
 447:../src/frame_m0.c **** 	asm("TST	r6, r5");		// 1
 1363              		.loc 1 447 0
 1364              	@ 447 "../src/frame_m0.c" 1
 1365 0022 2E42     		TST	r6, r5
 1366              	@ 0 "" 2
 448:../src/frame_m0.c **** 	asm("BEQ	dest4");		// 3
 1367              		.loc 1 448 0
 1368              	@ 448 "../src/frame_m0.c" 1
 1369 0024 FCD0     		BEQ	dest4
 1370              	@ 0 "" 2
 449:../src/frame_m0.c **** 
 450:../src/frame_m0.c **** 		// skip pixels
 451:../src/frame_m0.c **** asm("dest5:");
 1371              		.loc 1 451 0
 1372              	@ 451 "../src/frame_m0.c" 1
 1373              		dest5:
 1374              	@ 0 "" 2
 452:../src/frame_m0.c **** 	asm("SUBS	r3, #0x1");	    // 1
 1375              		.loc 1 452 0
 1376              	@ 452 "../src/frame_m0.c" 1
 1377 0026 013B     		SUBS	r3, #0x1
 1378              	@ 0 "" 2
 453:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1379              		.loc 1 453 0
 1380              	@ 453 "../src/frame_m0.c" 1
 1381 0028 C046     		NOP
 1382              	@ 0 "" 2
 454:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1383              		.loc 1 454 0
 1384              	@ 454 "../src/frame_m0.c" 1
 1385 002a C046     		NOP
 1386              	@ 0 "" 2
 455:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1387              		.loc 1 455 0
 1388              	@ 455 "../src/frame_m0.c" 1
 1389 002c C046     		NOP
 1390              	@ 0 "" 2
 456:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1391              		.loc 1 456 0
 1392              	@ 456 "../src/frame_m0.c" 1
 1393 002e C046     		NOP
 1394              	@ 0 "" 2
 457:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1395              		.loc 1 457 0
 1396              	@ 457 "../src/frame_m0.c" 1
 1397 0030 C046     		NOP
 1398              	@ 0 "" 2
 458:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1399              		.loc 1 458 0
 1400              	@ 458 "../src/frame_m0.c" 1
 1401 0032 C046     		NOP
 1402              	@ 0 "" 2
 459:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1403              		.loc 1 459 0
 1404              	@ 459 "../src/frame_m0.c" 1
 1405 0034 C046     		NOP
 1406              	@ 0 "" 2
 460:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1407              		.loc 1 460 0
 1408              	@ 460 "../src/frame_m0.c" 1
 1409 0036 C046     		NOP
 1410              	@ 0 "" 2
 461:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1411              		.loc 1 461 0
 1412              	@ 461 "../src/frame_m0.c" 1
 1413 0038 C046     		NOP
 1414              	@ 0 "" 2
 462:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1415              		.loc 1 462 0
 1416              	@ 462 "../src/frame_m0.c" 1
 1417 003a C046     		NOP
 1418              	@ 0 "" 2
 463:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1419              		.loc 1 463 0
 1420              	@ 463 "../src/frame_m0.c" 1
 1421 003c C046     		NOP
 1422              	@ 0 "" 2
 464:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1423              		.loc 1 464 0
 1424              	@ 464 "../src/frame_m0.c" 1
 1425 003e C046     		NOP
 1426              	@ 0 "" 2
 465:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1427              		.loc 1 465 0
 1428              	@ 465 "../src/frame_m0.c" 1
 1429 0040 C046     		NOP
 1430              	@ 0 "" 2
 466:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1431              		.loc 1 466 0
 1432              	@ 466 "../src/frame_m0.c" 1
 1433 0042 C046     		NOP
 1434              	@ 0 "" 2
 467:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1435              		.loc 1 467 0
 1436              	@ 467 "../src/frame_m0.c" 1
 1437 0044 C046     		NOP
 1438              	@ 0 "" 2
 468:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1439              		.loc 1 468 0
 1440              	@ 468 "../src/frame_m0.c" 1
 1441 0046 C046     		NOP
 1442              	@ 0 "" 2
 469:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1443              		.loc 1 469 0
 1444              	@ 469 "../src/frame_m0.c" 1
 1445 0048 C046     		NOP
 1446              	@ 0 "" 2
 470:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1447              		.loc 1 470 0
 1448              	@ 470 "../src/frame_m0.c" 1
 1449 004a C046     		NOP
 1450              	@ 0 "" 2
 471:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1451              		.loc 1 471 0
 1452              	@ 471 "../src/frame_m0.c" 1
 1453 004c C046     		NOP
 1454              	@ 0 "" 2
 472:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1455              		.loc 1 472 0
 1456              	@ 472 "../src/frame_m0.c" 1
 1457 004e C046     		NOP
 1458              	@ 0 "" 2
 473:../src/frame_m0.c **** 	asm("BGE	dest5");		// 3
 1459              		.loc 1 473 0
 1460              	@ 473 "../src/frame_m0.c" 1
 1461 0050 E9DA     		BGE	dest5
 1462              	@ 0 "" 2
 474:../src/frame_m0.c **** 
 475:../src/frame_m0.c **** 	// variable delay --- get correct phase for sampling
 476:../src/frame_m0.c **** 	asm("NOP");
 1463              		.loc 1 476 0
 1464              	@ 476 "../src/frame_m0.c" 1
 1465 0052 C046     		NOP
 1466              	@ 0 "" 2
 477:../src/frame_m0.c **** 	asm("NOP");
 1467              		.loc 1 477 0
 1468              	@ 477 "../src/frame_m0.c" 1
 1469 0054 C046     		NOP
 1470              	@ 0 "" 2
 478:../src/frame_m0.c **** 
 479:../src/frame_m0.c **** asm("loop4:");
 1471              		.loc 1 479 0
 1472              	@ 479 "../src/frame_m0.c" 1
 1473              		loop4:
 1474              	@ 0 "" 2
 480:../src/frame_m0.c **** 	asm("LDRB 	r3, [r0]"); // 0
 1475              		.loc 1 480 0
 1476              	@ 480 "../src/frame_m0.c" 1
 1477 0056 0378     		LDRB 	r3, [r0]
 1478              	@ 0 "" 2
 481:../src/frame_m0.c **** 	asm("LDRH	r6, [r1, #0x00]");
 1479              		.loc 1 481 0
 1480              	@ 481 "../src/frame_m0.c" 1
 1481 0058 0E88     		LDRH	r6, [r1, #0x00]
 1482              	@ 0 "" 2
 482:../src/frame_m0.c **** 	asm("ADDS   r6, r3");
 1483              		.loc 1 482 0
 1484              	@ 482 "../src/frame_m0.c" 1
 1485 005a F618     		ADDS   r6, r3
 1486              	@ 0 "" 2
 483:../src/frame_m0.c **** 	asm("NOP");
 1487              		.loc 1 483 0
 1488              	@ 483 "../src/frame_m0.c" 1
 1489 005c C046     		NOP
 1490              	@ 0 "" 2
 484:../src/frame_m0.c **** 	asm("NOP");
 1491              		.loc 1 484 0
 1492              	@ 484 "../src/frame_m0.c" 1
 1493 005e C046     		NOP
 1494              	@ 0 "" 2
 485:../src/frame_m0.c **** 	asm("NOP");
 1495              		.loc 1 485 0
 1496              	@ 485 "../src/frame_m0.c" 1
 1497 0060 C046     		NOP
 1498              	@ 0 "" 2
 486:../src/frame_m0.c **** 	asm("NOP");
 1499              		.loc 1 486 0
 1500              	@ 486 "../src/frame_m0.c" 1
 1501 0062 C046     		NOP
 1502              	@ 0 "" 2
 487:../src/frame_m0.c **** 	asm("NOP");
 1503              		.loc 1 487 0
 1504              	@ 487 "../src/frame_m0.c" 1
 1505 0064 C046     		NOP
 1506              	@ 0 "" 2
 488:../src/frame_m0.c **** 	asm("NOP");
 1507              		.loc 1 488 0
 1508              	@ 488 "../src/frame_m0.c" 1
 1509 0066 C046     		NOP
 1510              	@ 0 "" 2
 489:../src/frame_m0.c **** 	asm("NOP");
 1511              		.loc 1 489 0
 1512              	@ 489 "../src/frame_m0.c" 1
 1513 0068 C046     		NOP
 1514              	@ 0 "" 2
 490:../src/frame_m0.c **** 
 491:../src/frame_m0.c **** 	asm("LDRB 	r3, [r0]"); // 0
 1515              		.loc 1 491 0
 1516              	@ 491 "../src/frame_m0.c" 1
 1517 006a 0378     		LDRB 	r3, [r0]
 1518              	@ 0 "" 2
 492:../src/frame_m0.c **** 	asm("LDRH	r7, [r1, #0x02]");
 1519              		.loc 1 492 0
 1520              	@ 492 "../src/frame_m0.c" 1
 1521 006c 4F88     		LDRH	r7, [r1, #0x02]
 1522              	@ 0 "" 2
 493:../src/frame_m0.c **** 	asm("ADDS   r7, r3");
 1523              		.loc 1 493 0
 1524              	@ 493 "../src/frame_m0.c" 1
 1525 006e FF18     		ADDS   r7, r3
 1526              	@ 0 "" 2
 494:../src/frame_m0.c **** 	asm("NOP");
 1527              		.loc 1 494 0
 1528              	@ 494 "../src/frame_m0.c" 1
 1529 0070 C046     		NOP
 1530              	@ 0 "" 2
 495:../src/frame_m0.c **** 	asm("NOP");
 1531              		.loc 1 495 0
 1532              	@ 495 "../src/frame_m0.c" 1
 1533 0072 C046     		NOP
 1534              	@ 0 "" 2
 496:../src/frame_m0.c **** 	asm("NOP");
 1535              		.loc 1 496 0
 1536              	@ 496 "../src/frame_m0.c" 1
 1537 0074 C046     		NOP
 1538              	@ 0 "" 2
 497:../src/frame_m0.c **** 	asm("NOP");
 1539              		.loc 1 497 0
 1540              	@ 497 "../src/frame_m0.c" 1
 1541 0076 C046     		NOP
 1542              	@ 0 "" 2
 498:../src/frame_m0.c **** 	asm("NOP");
 1543              		.loc 1 498 0
 1544              	@ 498 "../src/frame_m0.c" 1
 1545 0078 C046     		NOP
 1546              	@ 0 "" 2
 499:../src/frame_m0.c **** 	asm("NOP");
 1547              		.loc 1 499 0
 1548              	@ 499 "../src/frame_m0.c" 1
 1549 007a C046     		NOP
 1550              	@ 0 "" 2
 500:../src/frame_m0.c **** 	asm("NOP");
 1551              		.loc 1 500 0
 1552              	@ 500 "../src/frame_m0.c" 1
 1553 007c C046     		NOP
 1554              	@ 0 "" 2
 501:../src/frame_m0.c **** 
 502:../src/frame_m0.c **** 	asm("LDRB	r3, [r0]"); 	  // 0
 1555              		.loc 1 502 0
 1556              	@ 502 "../src/frame_m0.c" 1
 1557 007e 0378     		LDRB	r3, [r0]
 1558              	@ 0 "" 2
 503:../src/frame_m0.c **** 	asm("ADDS   r6, r3");
 1559              		.loc 1 503 0
 1560              	@ 503 "../src/frame_m0.c" 1
 1561 0080 F618     		ADDS   r6, r3
 1562              	@ 0 "" 2
 504:../src/frame_m0.c **** 	asm("LSRS   r6, #2");
 1563              		.loc 1 504 0
 1564              	@ 504 "../src/frame_m0.c" 1
 1565 0082 B608     		LSRS   r6, #2
 1566              	@ 0 "" 2
 505:../src/frame_m0.c **** 	asm("STRB 	r6, [r2, #0x00]");
 1567              		.loc 1 505 0
 1568              	@ 505 "../src/frame_m0.c" 1
 1569 0084 1670     		STRB 	r6, [r2, #0x00]
 1570              	@ 0 "" 2
 506:../src/frame_m0.c **** 	asm("NOP");
 1571              		.loc 1 506 0
 1572              	@ 506 "../src/frame_m0.c" 1
 1573 0086 C046     		NOP
 1574              	@ 0 "" 2
 507:../src/frame_m0.c **** 	asm("NOP");
 1575              		.loc 1 507 0
 1576              	@ 507 "../src/frame_m0.c" 1
 1577 0088 C046     		NOP
 1578              	@ 0 "" 2
 508:../src/frame_m0.c **** 	asm("NOP");
 1579              		.loc 1 508 0
 1580              	@ 508 "../src/frame_m0.c" 1
 1581 008a C046     		NOP
 1582              	@ 0 "" 2
 509:../src/frame_m0.c **** 	asm("NOP");
 1583              		.loc 1 509 0
 1584              	@ 509 "../src/frame_m0.c" 1
 1585 008c C046     		NOP
 1586              	@ 0 "" 2
 510:../src/frame_m0.c **** 	asm("NOP");
 1587              		.loc 1 510 0
 1588              	@ 510 "../src/frame_m0.c" 1
 1589 008e C046     		NOP
 1590              	@ 0 "" 2
 511:../src/frame_m0.c **** 	asm("NOP");
 1591              		.loc 1 511 0
 1592              	@ 511 "../src/frame_m0.c" 1
 1593 0090 C046     		NOP
 1594              	@ 0 "" 2
 512:../src/frame_m0.c **** 
 513:../src/frame_m0.c **** 	asm("LDRB	r3, [r0]"); 	 // 0
 1595              		.loc 1 513 0
 1596              	@ 513 "../src/frame_m0.c" 1
 1597 0092 0378     		LDRB	r3, [r0]
 1598              	@ 0 "" 2
 514:../src/frame_m0.c **** 	asm("ADDS	r7, r3");
 1599              		.loc 1 514 0
 1600              	@ 514 "../src/frame_m0.c" 1
 1601 0094 FF18     		ADDS	r7, r3
 1602              	@ 0 "" 2
 515:../src/frame_m0.c **** 	asm("LSRS	r7, #2");
 1603              		.loc 1 515 0
 1604              	@ 515 "../src/frame_m0.c" 1
 1605 0096 BF08     		LSRS	r7, #2
 1606              	@ 0 "" 2
 516:../src/frame_m0.c **** 	asm("STRB	r7, [r2, #0x01]");
 1607              		.loc 1 516 0
 1608              	@ 516 "../src/frame_m0.c" 1
 1609 0098 5770     		STRB	r7, [r2, #0x01]
 1610              	@ 0 "" 2
 517:../src/frame_m0.c **** 	asm("ADDS	r1, #0x04");
 1611              		.loc 1 517 0
 1612              	@ 517 "../src/frame_m0.c" 1
 1613 009a 0431     		ADDS	r1, #0x04
 1614              	@ 0 "" 2
 518:../src/frame_m0.c **** 	asm("ADDS	r2, #0x02");
 1615              		.loc 1 518 0
 1616              	@ 518 "../src/frame_m0.c" 1
 1617 009c 0232     		ADDS	r2, #0x02
 1618              	@ 0 "" 2
 519:../src/frame_m0.c **** 	asm("CMP	r2, r4");
 1619              		.loc 1 519 0
 1620              	@ 519 "../src/frame_m0.c" 1
 1621 009e A242     		CMP	r2, r4
 1622              	@ 0 "" 2
 520:../src/frame_m0.c **** 	asm("BLT	loop4");
 1623              		.loc 1 520 0
 1624              	@ 520 "../src/frame_m0.c" 1
 1625 00a0 D9DB     		BLT	loop4
 1626              	@ 0 "" 2
 521:../src/frame_m0.c **** 
 522:../src/frame_m0.c **** 	// wait for hsync to go low (end of line)
 523:../src/frame_m0.c **** asm("dest6:");
 1627              		.loc 1 523 0
 1628              	@ 523 "../src/frame_m0.c" 1
 1629              		dest6:
 1630              	@ 0 "" 2
 524:../src/frame_m0.c **** 	asm("LDR	r6, [r0]"); 	// 2
 1631              		.loc 1 524 0
 1632              	@ 524 "../src/frame_m0.c" 1
 1633 00a2 0668     		LDR	r6, [r0]
 1634              	@ 0 "" 2
 525:../src/frame_m0.c **** 	asm("TST	r6, r5");		// 1
 1635              		.loc 1 525 0
 1636              	@ 525 "../src/frame_m0.c" 1
 1637 00a4 2E42     		TST	r6, r5
 1638              	@ 0 "" 2
 526:../src/frame_m0.c **** 	asm("BNE	dest6");		// 3
 1639              		.loc 1 526 0
 1640              	@ 526 "../src/frame_m0.c" 1
 1641 00a6 FCD1     		BNE	dest6
 1642              	@ 0 "" 2
 527:../src/frame_m0.c **** 
 528:../src/frame_m0.c **** 	asm("POP	{r4-r7}");
 1643              		.loc 1 528 0
 1644              	@ 528 "../src/frame_m0.c" 1
 1645 00a8 F0BC     		POP	{r4-r7}
 1646              	@ 0 "" 2
 529:../src/frame_m0.c **** 
 530:../src/frame_m0.c **** 	asm(".syntax divided");
 1647              		.loc 1 530 0
 1648              	@ 530 "../src/frame_m0.c" 1
 1649              		.syntax divided
 1650              	@ 0 "" 2
 531:../src/frame_m0.c **** }
 1651              		.loc 1 531 0
 1652              		.thumb
 1653              		.syntax unified
 1654 00aa C046     		nop
 1655 00ac BD46     		mov	sp, r7
 1656 00ae 04B0     		add	sp, sp, #16
 1657              		@ sp needed
 1658 00b0 80BD     		pop	{r7, pc}
 1659              		.cfi_endproc
 1660              	.LFE38:
 1662 00b2 C046     		.section	.text.skipLine,"ax",%progbits
 1663              		.align	2
 1664              		.global	skipLine
 1665              		.code	16
 1666              		.thumb_func
 1668              	skipLine:
 1669              	.LFB39:
 532:../src/frame_m0.c **** 
 533:../src/frame_m0.c **** 
 534:../src/frame_m0.c **** void skipLine()
 535:../src/frame_m0.c **** {
 1670              		.loc 1 535 0
 1671              		.cfi_startproc
 1672 0000 80B5     		push	{r7, lr}
 1673              		.cfi_def_cfa_offset 8
 1674              		.cfi_offset 7, -8
 1675              		.cfi_offset 14, -4
 1676 0002 00AF     		add	r7, sp, #0
 1677              		.cfi_def_cfa_register 7
 536:../src/frame_m0.c **** 	while(!CAM_HSYNC());
 1678              		.loc 1 536 0
 1679 0004 C046     		nop
 1680              	.L20:
 1681              		.loc 1 536 0 is_stmt 0 discriminator 1
 1682 0006 094A     		ldr	r2, .L22
 1683 0008 094B     		ldr	r3, .L22+4
 1684 000a D258     		ldr	r2, [r2, r3]
 1685 000c 8023     		movs	r3, #128
 1686 000e 1B01     		lsls	r3, r3, #4
 1687 0010 1340     		ands	r3, r2
 1688 0012 F8D0     		beq	.L20
 537:../src/frame_m0.c **** 	while(CAM_HSYNC());
 1689              		.loc 1 537 0 is_stmt 1
 1690 0014 C046     		nop
 1691              	.L21:
 1692              		.loc 1 537 0 is_stmt 0 discriminator 1
 1693 0016 054A     		ldr	r2, .L22
 1694 0018 054B     		ldr	r3, .L22+4
 1695 001a D258     		ldr	r2, [r2, r3]
 1696 001c 8023     		movs	r3, #128
 1697 001e 1B01     		lsls	r3, r3, #4
 1698 0020 1340     		ands	r3, r2
 1699 0022 F8D1     		bne	.L21
 538:../src/frame_m0.c **** }
 1700              		.loc 1 538 0 is_stmt 1
 1701 0024 C046     		nop
 1702 0026 BD46     		mov	sp, r7
 1703              		@ sp needed
 1704 0028 80BD     		pop	{r7, pc}
 1705              	.L23:
 1706 002a C046     		.align	2
 1707              	.L22:
 1708 002c 00400F40 		.word	1074741248
 1709 0030 04210000 		.word	8452
 1710              		.cfi_endproc
 1711              	.LFE39:
 1713              		.section	.text.skipLines,"ax",%progbits
 1714              		.align	2
 1715              		.global	skipLines
 1716              		.code	16
 1717              		.thumb_func
 1719              	skipLines:
 1720              	.LFB40:
 539:../src/frame_m0.c **** 
 540:../src/frame_m0.c **** 
 541:../src/frame_m0.c **** void skipLines(uint32_t lines)
 542:../src/frame_m0.c **** {
 1721              		.loc 1 542 0
 1722              		.cfi_startproc
 1723 0000 80B5     		push	{r7, lr}
 1724              		.cfi_def_cfa_offset 8
 1725              		.cfi_offset 7, -8
 1726              		.cfi_offset 14, -4
 1727 0002 84B0     		sub	sp, sp, #16
 1728              		.cfi_def_cfa_offset 24
 1729 0004 00AF     		add	r7, sp, #0
 1730              		.cfi_def_cfa_register 7
 1731 0006 7860     		str	r0, [r7, #4]
 543:../src/frame_m0.c **** 	uint32_t line;
 544:../src/frame_m0.c **** 
 545:../src/frame_m0.c **** 	// wait for remainder of frame to pass
 546:../src/frame_m0.c **** 	while(!CAM_VSYNC()); 
 1732              		.loc 1 546 0
 1733 0008 C046     		nop
 1734              	.L25:
 1735              		.loc 1 546 0 is_stmt 0 discriminator 1
 1736 000a 0F4A     		ldr	r2, .L29
 1737 000c 0F4B     		ldr	r3, .L29+4
 1738 000e D258     		ldr	r2, [r2, r3]
 1739 0010 8023     		movs	r3, #128
 1740 0012 5B01     		lsls	r3, r3, #5
 1741 0014 1340     		ands	r3, r2
 1742 0016 F8D0     		beq	.L25
 547:../src/frame_m0.c **** 	// vsync asserted
 548:../src/frame_m0.c **** 	while(CAM_VSYNC());
 1743              		.loc 1 548 0 is_stmt 1
 1744 0018 C046     		nop
 1745              	.L26:
 1746              		.loc 1 548 0 is_stmt 0 discriminator 1
 1747 001a 0B4A     		ldr	r2, .L29
 1748 001c 0B4B     		ldr	r3, .L29+4
 1749 001e D258     		ldr	r2, [r2, r3]
 1750 0020 8023     		movs	r3, #128
 1751 0022 5B01     		lsls	r3, r3, #5
 1752 0024 1340     		ands	r3, r2
 1753 0026 F8D1     		bne	.L26
 549:../src/frame_m0.c **** 	// skip lines
 550:../src/frame_m0.c **** 	for (line=0; line<lines; line++)
 1754              		.loc 1 550 0 is_stmt 1
 1755 0028 0023     		movs	r3, #0
 1756 002a FB60     		str	r3, [r7, #12]
 1757 002c 04E0     		b	.L27
 1758              	.L28:
 551:../src/frame_m0.c **** 		skipLine();
 1759              		.loc 1 551 0 discriminator 3
 1760 002e FFF7FEFF 		bl	skipLine
 550:../src/frame_m0.c **** 		skipLine();
 1761              		.loc 1 550 0 discriminator 3
 1762 0032 FB68     		ldr	r3, [r7, #12]
 1763 0034 0133     		adds	r3, r3, #1
 1764 0036 FB60     		str	r3, [r7, #12]
 1765              	.L27:
 550:../src/frame_m0.c **** 		skipLine();
 1766              		.loc 1 550 0 is_stmt 0 discriminator 1
 1767 0038 FA68     		ldr	r2, [r7, #12]
 1768 003a 7B68     		ldr	r3, [r7, #4]
 1769 003c 9A42     		cmp	r2, r3
 1770 003e F6D3     		bcc	.L28
 552:../src/frame_m0.c **** }
 1771              		.loc 1 552 0 is_stmt 1
 1772 0040 C046     		nop
 1773 0042 BD46     		mov	sp, r7
 1774 0044 04B0     		add	sp, sp, #16
 1775              		@ sp needed
 1776 0046 80BD     		pop	{r7, pc}
 1777              	.L30:
 1778              		.align	2
 1779              	.L29:
 1780 0048 00400F40 		.word	1074741248
 1781 004c 04210000 		.word	8452
 1782              		.cfi_endproc
 1783              	.LFE40:
 1785              		.section	.text.grabM0R0,"ax",%progbits
 1786              		.align	2
 1787              		.global	grabM0R0
 1788              		.code	16
 1789              		.thumb_func
 1791              	grabM0R0:
 1792              	.LFB41:
 553:../src/frame_m0.c **** 
 554:../src/frame_m0.c **** 
 555:../src/frame_m0.c **** void grabM0R0(uint32_t xoffset, uint32_t yoffset, uint32_t xwidth, uint32_t ywidth, uint8_t *memory
 556:../src/frame_m0.c **** {
 1793              		.loc 1 556 0
 1794              		.cfi_startproc
 1795 0000 80B5     		push	{r7, lr}
 1796              		.cfi_def_cfa_offset 8
 1797              		.cfi_offset 7, -8
 1798              		.cfi_offset 14, -4
 1799 0002 86B0     		sub	sp, sp, #24
 1800              		.cfi_def_cfa_offset 32
 1801 0004 00AF     		add	r7, sp, #0
 1802              		.cfi_def_cfa_register 7
 1803 0006 F860     		str	r0, [r7, #12]
 1804 0008 B960     		str	r1, [r7, #8]
 1805 000a 7A60     		str	r2, [r7, #4]
 1806 000c 3B60     		str	r3, [r7]
 557:../src/frame_m0.c **** 	uint32_t line;
 558:../src/frame_m0.c **** 
 559:../src/frame_m0.c **** 	xoffset >>= 1;
 1807              		.loc 1 559 0
 1808 000e FB68     		ldr	r3, [r7, #12]
 1809 0010 5B08     		lsrs	r3, r3, #1
 1810 0012 FB60     		str	r3, [r7, #12]
 560:../src/frame_m0.c **** 	yoffset &= ~1;
 1811              		.loc 1 560 0
 1812 0014 BB68     		ldr	r3, [r7, #8]
 1813 0016 0122     		movs	r2, #1
 1814 0018 9343     		bics	r3, r2
 1815 001a BB60     		str	r3, [r7, #8]
 561:../src/frame_m0.c **** 
 562:../src/frame_m0.c **** 	skipLines(yoffset);
 1816              		.loc 1 562 0
 1817 001c BB68     		ldr	r3, [r7, #8]
 1818 001e 1800     		movs	r0, r3
 1819 0020 FFF7FEFF 		bl	skipLines
 563:../src/frame_m0.c **** 	for (line=0; line<ywidth; line++, memory+=xwidth)
 1820              		.loc 1 563 0
 1821 0024 0023     		movs	r3, #0
 1822 0026 7B61     		str	r3, [r7, #20]
 1823 0028 0CE0     		b	.L32
 1824              	.L33:
 564:../src/frame_m0.c **** 		lineM0((uint32_t *)&CAM_PORT, memory, xoffset, xwidth); // wait, grab, wait
 1825              		.loc 1 564 0 discriminator 3
 1826 002a 7B68     		ldr	r3, [r7, #4]
 1827 002c FA68     		ldr	r2, [r7, #12]
 1828 002e 396A     		ldr	r1, [r7, #32]
 1829 0030 0848     		ldr	r0, .L34
 1830 0032 FFF7FEFF 		bl	lineM0
 563:../src/frame_m0.c **** 	for (line=0; line<ywidth; line++, memory+=xwidth)
 1831              		.loc 1 563 0 discriminator 3
 1832 0036 7B69     		ldr	r3, [r7, #20]
 1833 0038 0133     		adds	r3, r3, #1
 1834 003a 7B61     		str	r3, [r7, #20]
 1835 003c 3A6A     		ldr	r2, [r7, #32]
 1836 003e 7B68     		ldr	r3, [r7, #4]
 1837 0040 D318     		adds	r3, r2, r3
 1838 0042 3B62     		str	r3, [r7, #32]
 1839              	.L32:
 563:../src/frame_m0.c **** 	for (line=0; line<ywidth; line++, memory+=xwidth)
 1840              		.loc 1 563 0 is_stmt 0 discriminator 1
 1841 0044 7A69     		ldr	r2, [r7, #20]
 1842 0046 3B68     		ldr	r3, [r7]
 1843 0048 9A42     		cmp	r2, r3
 1844 004a EED3     		bcc	.L33
 565:../src/frame_m0.c **** }
 1845              		.loc 1 565 0 is_stmt 1
 1846 004c C046     		nop
 1847 004e BD46     		mov	sp, r7
 1848 0050 06B0     		add	sp, sp, #24
 1849              		@ sp needed
 1850 0052 80BD     		pop	{r7, pc}
 1851              	.L35:
 1852              		.align	2
 1853              	.L34:
 1854 0054 04610F40 		.word	1074749700
 1855              		.cfi_endproc
 1856              	.LFE41:
 1858              		.section	.text.grabM1R1,"ax",%progbits
 1859              		.align	2
 1860              		.global	grabM1R1
 1861              		.code	16
 1862              		.thumb_func
 1864              	grabM1R1:
 1865              	.LFB42:
 566:../src/frame_m0.c **** 
 567:../src/frame_m0.c **** 
 568:../src/frame_m0.c **** void grabM1R1(uint32_t xoffset, uint32_t yoffset, uint32_t xwidth, uint32_t ywidth, uint8_t *memory
 569:../src/frame_m0.c **** {
 1866              		.loc 1 569 0
 1867              		.cfi_startproc
 1868 0000 80B5     		push	{r7, lr}
 1869              		.cfi_def_cfa_offset 8
 1870              		.cfi_offset 7, -8
 1871              		.cfi_offset 14, -4
 1872 0002 86B0     		sub	sp, sp, #24
 1873              		.cfi_def_cfa_offset 32
 1874 0004 00AF     		add	r7, sp, #0
 1875              		.cfi_def_cfa_register 7
 1876 0006 F860     		str	r0, [r7, #12]
 1877 0008 B960     		str	r1, [r7, #8]
 1878 000a 7A60     		str	r2, [r7, #4]
 1879 000c 3B60     		str	r3, [r7]
 570:../src/frame_m0.c **** 	uint32_t line;
 571:../src/frame_m0.c **** 
 572:../src/frame_m0.c **** 	xoffset >>= 1;
 1880              		.loc 1 572 0
 1881 000e FB68     		ldr	r3, [r7, #12]
 1882 0010 5B08     		lsrs	r3, r3, #1
 1883 0012 FB60     		str	r3, [r7, #12]
 573:../src/frame_m0.c **** 	yoffset &= ~1;
 1884              		.loc 1 573 0
 1885 0014 BB68     		ldr	r3, [r7, #8]
 1886 0016 0122     		movs	r2, #1
 1887 0018 9343     		bics	r3, r2
 1888 001a BB60     		str	r3, [r7, #8]
 574:../src/frame_m0.c **** 
 575:../src/frame_m0.c **** 	skipLines(yoffset);
 1889              		.loc 1 575 0
 1890 001c BB68     		ldr	r3, [r7, #8]
 1891 001e 1800     		movs	r0, r3
 1892 0020 FFF7FEFF 		bl	skipLines
 576:../src/frame_m0.c **** 	for (line=0; line<ywidth; line++, memory+=xwidth)
 1893              		.loc 1 576 0
 1894 0024 0023     		movs	r3, #0
 1895 0026 7B61     		str	r3, [r7, #20]
 1896 0028 0CE0     		b	.L37
 1897              	.L38:
 577:../src/frame_m0.c **** 		lineM1R1((uint32_t *)&CAM_PORT, memory, xoffset, xwidth); // wait, grab, wait
 1898              		.loc 1 577 0 discriminator 3
 1899 002a 7B68     		ldr	r3, [r7, #4]
 1900 002c FA68     		ldr	r2, [r7, #12]
 1901 002e 396A     		ldr	r1, [r7, #32]
 1902 0030 0848     		ldr	r0, .L39
 1903 0032 FFF7FEFF 		bl	lineM1R1
 576:../src/frame_m0.c **** 	for (line=0; line<ywidth; line++, memory+=xwidth)
 1904              		.loc 1 576 0 discriminator 3
 1905 0036 7B69     		ldr	r3, [r7, #20]
 1906 0038 0133     		adds	r3, r3, #1
 1907 003a 7B61     		str	r3, [r7, #20]
 1908 003c 3A6A     		ldr	r2, [r7, #32]
 1909 003e 7B68     		ldr	r3, [r7, #4]
 1910 0040 D318     		adds	r3, r2, r3
 1911 0042 3B62     		str	r3, [r7, #32]
 1912              	.L37:
 576:../src/frame_m0.c **** 	for (line=0; line<ywidth; line++, memory+=xwidth)
 1913              		.loc 1 576 0 is_stmt 0 discriminator 1
 1914 0044 7A69     		ldr	r2, [r7, #20]
 1915 0046 3B68     		ldr	r3, [r7]
 1916 0048 9A42     		cmp	r2, r3
 1917 004a EED3     		bcc	.L38
 578:../src/frame_m0.c **** }
 1918              		.loc 1 578 0 is_stmt 1
 1919 004c C046     		nop
 1920 004e BD46     		mov	sp, r7
 1921 0050 06B0     		add	sp, sp, #24
 1922              		@ sp needed
 1923 0052 80BD     		pop	{r7, pc}
 1924              	.L40:
 1925              		.align	2
 1926              	.L39:
 1927 0054 04610F40 		.word	1074749700
 1928              		.cfi_endproc
 1929              	.LFE42:
 1931              		.section	.text.grabM1R2,"ax",%progbits
 1932              		.align	2
 1933              		.global	grabM1R2
 1934              		.code	16
 1935              		.thumb_func
 1937              	grabM1R2:
 1938              	.LFB43:
 579:../src/frame_m0.c **** 
 580:../src/frame_m0.c **** 
 581:../src/frame_m0.c **** void grabM1R2(uint32_t xoffset, uint32_t yoffset, uint32_t xwidth, uint32_t ywidth, uint8_t *memory
 582:../src/frame_m0.c **** {
 1939              		.loc 1 582 0
 1940              		.cfi_startproc
 1941 0000 90B5     		push	{r4, r7, lr}
 1942              		.cfi_def_cfa_offset 12
 1943              		.cfi_offset 4, -12
 1944              		.cfi_offset 7, -8
 1945              		.cfi_offset 14, -4
 1946 0002 89B0     		sub	sp, sp, #36
 1947              		.cfi_def_cfa_offset 48
 1948 0004 02AF     		add	r7, sp, #8
 1949              		.cfi_def_cfa 7, 40
 1950 0006 F860     		str	r0, [r7, #12]
 1951 0008 B960     		str	r1, [r7, #8]
 1952 000a 7A60     		str	r2, [r7, #4]
 1953 000c 3B60     		str	r3, [r7]
 583:../src/frame_m0.c **** 	uint32_t line;
 584:../src/frame_m0.c **** 	uint16_t *lineStore = (uint16_t *)(memory + xwidth*ywidth + 16);
 1954              		.loc 1 584 0
 1955 000e 7B68     		ldr	r3, [r7, #4]
 1956 0010 3A68     		ldr	r2, [r7]
 1957 0012 5343     		muls	r3, r2
 1958 0014 1033     		adds	r3, r3, #16
 1959 0016 BA6A     		ldr	r2, [r7, #40]
 1960 0018 D318     		adds	r3, r2, r3
 1961 001a 3B61     		str	r3, [r7, #16]
 585:../src/frame_m0.c **** 	lineStore = (uint16_t *)ALIGN(lineStore, 2);
 1962              		.loc 1 585 0
 1963 001c 3B69     		ldr	r3, [r7, #16]
 1964 001e 0122     		movs	r2, #1
 1965 0020 1340     		ands	r3, r2
 1966 0022 04D0     		beq	.L42
 1967              		.loc 1 585 0 is_stmt 0 discriminator 1
 1968 0024 3B69     		ldr	r3, [r7, #16]
 1969 0026 0122     		movs	r2, #1
 1970 0028 9343     		bics	r3, r2
 1971 002a 0233     		adds	r3, r3, #2
 1972 002c 00E0     		b	.L43
 1973              	.L42:
 1974              		.loc 1 585 0 discriminator 2
 1975 002e 3B69     		ldr	r3, [r7, #16]
 1976              	.L43:
 1977              		.loc 1 585 0 discriminator 4
 1978 0030 3B61     		str	r3, [r7, #16]
 586:../src/frame_m0.c **** 
 587:../src/frame_m0.c **** 	// clear line storage for 1 line
 588:../src/frame_m0.c **** 	for (line=0; line<xwidth; line++)
 1979              		.loc 1 588 0 is_stmt 1 discriminator 4
 1980 0032 0023     		movs	r3, #0
 1981 0034 7B61     		str	r3, [r7, #20]
 1982 0036 08E0     		b	.L44
 1983              	.L45:
 589:../src/frame_m0.c **** 		lineStore[line] = 0;
 1984              		.loc 1 589 0 discriminator 3
 1985 0038 7B69     		ldr	r3, [r7, #20]
 1986 003a 5B00     		lsls	r3, r3, #1
 1987 003c 3A69     		ldr	r2, [r7, #16]
 1988 003e D318     		adds	r3, r2, r3
 1989 0040 0022     		movs	r2, #0
 1990 0042 1A80     		strh	r2, [r3]
 588:../src/frame_m0.c **** 		lineStore[line] = 0;
 1991              		.loc 1 588 0 discriminator 3
 1992 0044 7B69     		ldr	r3, [r7, #20]
 1993 0046 0133     		adds	r3, r3, #1
 1994 0048 7B61     		str	r3, [r7, #20]
 1995              	.L44:
 588:../src/frame_m0.c **** 		lineStore[line] = 0;
 1996              		.loc 1 588 0 is_stmt 0 discriminator 1
 1997 004a 7A69     		ldr	r2, [r7, #20]
 1998 004c 7B68     		ldr	r3, [r7, #4]
 1999 004e 9A42     		cmp	r2, r3
 2000 0050 F2D3     		bcc	.L45
 590:../src/frame_m0.c **** 
 591:../src/frame_m0.c **** 	skipLines(yoffset*2);
 2001              		.loc 1 591 0 is_stmt 1
 2002 0052 BB68     		ldr	r3, [r7, #8]
 2003 0054 5B00     		lsls	r3, r3, #1
 2004 0056 1800     		movs	r0, r3
 2005 0058 FFF7FEFF 		bl	skipLines
 592:../src/frame_m0.c **** 	// grab 1 line to put us out of phase with the camera's internal vertical downsample (800 to 400 l
 593:../src/frame_m0.c **** 	// ie, we are going to downsample again from 400 to 200.  Because the bayer lines alternate
 594:../src/frame_m0.c **** 	// there tends to be little difference between line pairs bg and gr lines after downsampling.
 595:../src/frame_m0.c **** 	// Same logic applies horizontally as well, but we always skip a pixel pair in the line routine.  
 596:../src/frame_m0.c **** 	lineM1R2Merge((uint32_t *)&CAM_PORT, lineStore, memory, xoffset, xwidth); // wait, grab, wait
 2006              		.loc 1 596 0
 2007 005c F868     		ldr	r0, [r7, #12]
 2008 005e BA6A     		ldr	r2, [r7, #40]
 2009 0060 3969     		ldr	r1, [r7, #16]
 2010 0062 244C     		ldr	r4, .L49
 2011 0064 7B68     		ldr	r3, [r7, #4]
 2012 0066 0093     		str	r3, [sp]
 2013 0068 0300     		movs	r3, r0
 2014 006a 2000     		movs	r0, r4
 2015 006c FFF7FEFF 		bl	lineM1R2Merge
 597:../src/frame_m0.c **** 	memory += xwidth;
 2016              		.loc 1 597 0
 2017 0070 BA6A     		ldr	r2, [r7, #40]
 2018 0072 7B68     		ldr	r3, [r7, #4]
 2019 0074 D318     		adds	r3, r2, r3
 2020 0076 BB62     		str	r3, [r7, #40]
 598:../src/frame_m0.c **** 	for (line=0; line<ywidth; line+=2, memory+=xwidth*2)
 2021              		.loc 1 598 0
 2022 0078 0023     		movs	r3, #0
 2023 007a 7B61     		str	r3, [r7, #20]
 2024 007c 32E0     		b	.L46
 2025              	.L48:
 599:../src/frame_m0.c **** 	{
 600:../src/frame_m0.c **** 		// CAM_HSYNC is negated here
 601:../src/frame_m0.c **** 		lineM1R2((uint32_t *)&CAM_PORT, lineStore, xoffset, xwidth); // wait, grab, wait
 2026              		.loc 1 601 0
 2027 007e 7B68     		ldr	r3, [r7, #4]
 2028 0080 FA68     		ldr	r2, [r7, #12]
 2029 0082 3969     		ldr	r1, [r7, #16]
 2030 0084 1B48     		ldr	r0, .L49
 2031 0086 FFF7FEFF 		bl	lineM1R2
 602:../src/frame_m0.c **** 		lineM1R2((uint32_t *)&CAM_PORT, lineStore+xwidth, xoffset, xwidth); // wait, grab, wait
 2032              		.loc 1 602 0
 2033 008a 7B68     		ldr	r3, [r7, #4]
 2034 008c 5B00     		lsls	r3, r3, #1
 2035 008e 3A69     		ldr	r2, [r7, #16]
 2036 0090 D118     		adds	r1, r2, r3
 2037 0092 7B68     		ldr	r3, [r7, #4]
 2038 0094 FA68     		ldr	r2, [r7, #12]
 2039 0096 1748     		ldr	r0, .L49
 2040 0098 FFF7FEFF 		bl	lineM1R2
 603:../src/frame_m0.c **** 		lineM1R2Merge((uint32_t *)&CAM_PORT, lineStore, memory, xoffset, xwidth); // wait, grab, wait
 2041              		.loc 1 603 0
 2042 009c F868     		ldr	r0, [r7, #12]
 2043 009e BA6A     		ldr	r2, [r7, #40]
 2044 00a0 3969     		ldr	r1, [r7, #16]
 2045 00a2 144C     		ldr	r4, .L49
 2046 00a4 7B68     		ldr	r3, [r7, #4]
 2047 00a6 0093     		str	r3, [sp]
 2048 00a8 0300     		movs	r3, r0
 2049 00aa 2000     		movs	r0, r4
 2050 00ac FFF7FEFF 		bl	lineM1R2Merge
 604:../src/frame_m0.c **** 		if (line<CAM_RES2_HEIGHT-2)
 2051              		.loc 1 604 0
 2052 00b0 7B69     		ldr	r3, [r7, #20]
 2053 00b2 C52B     		cmp	r3, #197
 2054 00b4 0ED8     		bhi	.L47
 605:../src/frame_m0.c **** 			lineM1R2Merge((uint32_t *)&CAM_PORT, lineStore+xwidth, memory+xwidth, xoffset, xwidth); // wait,
 2055              		.loc 1 605 0
 2056 00b6 7B68     		ldr	r3, [r7, #4]
 2057 00b8 5B00     		lsls	r3, r3, #1
 2058 00ba 3A69     		ldr	r2, [r7, #16]
 2059 00bc D118     		adds	r1, r2, r3
 2060 00be BA6A     		ldr	r2, [r7, #40]
 2061 00c0 7B68     		ldr	r3, [r7, #4]
 2062 00c2 D218     		adds	r2, r2, r3
 2063 00c4 F868     		ldr	r0, [r7, #12]
 2064 00c6 0B4C     		ldr	r4, .L49
 2065 00c8 7B68     		ldr	r3, [r7, #4]
 2066 00ca 0093     		str	r3, [sp]
 2067 00cc 0300     		movs	r3, r0
 2068 00ce 2000     		movs	r0, r4
 2069 00d0 FFF7FEFF 		bl	lineM1R2Merge
 2070              	.L47:
 598:../src/frame_m0.c **** 	{
 2071              		.loc 1 598 0 discriminator 2
 2072 00d4 7B69     		ldr	r3, [r7, #20]
 2073 00d6 0233     		adds	r3, r3, #2
 2074 00d8 7B61     		str	r3, [r7, #20]
 2075 00da 7B68     		ldr	r3, [r7, #4]
 2076 00dc 5B00     		lsls	r3, r3, #1
 2077 00de BA6A     		ldr	r2, [r7, #40]
 2078 00e0 D318     		adds	r3, r2, r3
 2079 00e2 BB62     		str	r3, [r7, #40]
 2080              	.L46:
 598:../src/frame_m0.c **** 	{
 2081              		.loc 1 598 0 is_stmt 0 discriminator 1
 2082 00e4 7A69     		ldr	r2, [r7, #20]
 2083 00e6 3B68     		ldr	r3, [r7]
 2084 00e8 9A42     		cmp	r2, r3
 2085 00ea C8D3     		bcc	.L48
 606:../src/frame_m0.c **** 	}					
 607:../src/frame_m0.c **** }
 2086              		.loc 1 607 0 is_stmt 1
 2087 00ec C046     		nop
 2088 00ee BD46     		mov	sp, r7
 2089 00f0 07B0     		add	sp, sp, #28
 2090              		@ sp needed
 2091 00f2 90BD     		pop	{r4, r7, pc}
 2092              	.L50:
 2093              		.align	2
 2094              	.L49:
 2095 00f4 04610F40 		.word	1074749700
 2096              		.cfi_endproc
 2097              	.LFE43:
 2099              		.section	.text.callSyncM0,"ax",%progbits
 2100              		.align	2
 2101              		.global	callSyncM0
 2102              		.code	16
 2103              		.thumb_func
 2105              	callSyncM0:
 2106              	.LFB44:
 608:../src/frame_m0.c **** 
 609:../src/frame_m0.c **** 
 610:../src/frame_m0.c **** void callSyncM0(void)
 611:../src/frame_m0.c **** {
 2107              		.loc 1 611 0
 2108              		.cfi_startproc
 2109 0000 80B5     		push	{r7, lr}
 2110              		.cfi_def_cfa_offset 8
 2111              		.cfi_offset 7, -8
 2112              		.cfi_offset 14, -4
 2113 0002 00AF     		add	r7, sp, #0
 2114              		.cfi_def_cfa_register 7
 612:../src/frame_m0.c **** 	syncM0((uint32_t *)&CAM_PORT, CAM_PCLK_MASK);
 2115              		.loc 1 612 0
 2116 0004 8023     		movs	r3, #128
 2117 0006 9B01     		lsls	r3, r3, #6
 2118 0008 034A     		ldr	r2, .L52
 2119 000a 1900     		movs	r1, r3
 2120 000c 1000     		movs	r0, r2
 2121 000e FFF7FEFF 		bl	syncM0
 613:../src/frame_m0.c **** }
 2122              		.loc 1 613 0
 2123 0012 C046     		nop
 2124 0014 BD46     		mov	sp, r7
 2125              		@ sp needed
 2126 0016 80BD     		pop	{r7, pc}
 2127              	.L53:
 2128              		.align	2
 2129              	.L52:
 2130 0018 04610F40 		.word	1074749700
 2131              		.cfi_endproc
 2132              	.LFE44:
 2134              		.section	.text.callSyncM1,"ax",%progbits
 2135              		.align	2
 2136              		.global	callSyncM1
 2137              		.code	16
 2138              		.thumb_func
 2140              	callSyncM1:
 2141              	.LFB45:
 614:../src/frame_m0.c **** 
 615:../src/frame_m0.c **** 
 616:../src/frame_m0.c **** void callSyncM1(void)
 617:../src/frame_m0.c **** {
 2142              		.loc 1 617 0
 2143              		.cfi_startproc
 2144 0000 80B5     		push	{r7, lr}
 2145              		.cfi_def_cfa_offset 8
 2146              		.cfi_offset 7, -8
 2147              		.cfi_offset 14, -4
 2148 0002 00AF     		add	r7, sp, #0
 2149              		.cfi_def_cfa_register 7
 618:../src/frame_m0.c **** 	syncM1((uint32_t *)&CAM_PORT, CAM_PCLK_MASK);
 2150              		.loc 1 618 0
 2151 0004 8023     		movs	r3, #128
 2152 0006 9B01     		lsls	r3, r3, #6
 2153 0008 034A     		ldr	r2, .L55
 2154 000a 1900     		movs	r1, r3
 2155 000c 1000     		movs	r0, r2
 2156 000e FFF7FEFF 		bl	syncM1
 619:../src/frame_m0.c **** }
 2157              		.loc 1 619 0
 2158 0012 C046     		nop
 2159 0014 BD46     		mov	sp, r7
 2160              		@ sp needed
 2161 0016 80BD     		pop	{r7, pc}
 2162              	.L56:
 2163              		.align	2
 2164              	.L55:
 2165 0018 04610F40 		.word	1074749700
 2166              		.cfi_endproc
 2167              	.LFE45:
 2169              		.section	.text.getFrame,"ax",%progbits
 2170              		.align	2
 2171              		.global	getFrame
 2172              		.code	16
 2173              		.thumb_func
 2175              	getFrame:
 2176              	.LFB46:
 620:../src/frame_m0.c **** 
 621:../src/frame_m0.c **** 
 622:../src/frame_m0.c **** int32_t getFrame(uint8_t *type, uint32_t *memory, uint16_t *xoffset, uint16_t *yoffset, uint16_t *x
 623:../src/frame_m0.c **** {
 2177              		.loc 1 623 0
 2178              		.cfi_startproc
 2179 0000 90B5     		push	{r4, r7, lr}
 2180              		.cfi_def_cfa_offset 12
 2181              		.cfi_offset 4, -12
 2182              		.cfi_offset 7, -8
 2183              		.cfi_offset 14, -4
 2184 0002 87B0     		sub	sp, sp, #28
 2185              		.cfi_def_cfa_offset 40
 2186 0004 02AF     		add	r7, sp, #8
 2187              		.cfi_def_cfa 7, 32
 2188 0006 F860     		str	r0, [r7, #12]
 2189 0008 B960     		str	r1, [r7, #8]
 2190 000a 7A60     		str	r2, [r7, #4]
 2191 000c 3B60     		str	r3, [r7]
 624:../src/frame_m0.c **** 	//printf("M0: grab %d %d %d %d %d\n", *type, *xoffset, *yoffset, *xwidth, *ywidth);
 625:../src/frame_m0.c **** 
 626:../src/frame_m0.c **** 	if (*type==CAM_GRAB_M0R0)
 2192              		.loc 1 626 0
 2193 000e FB68     		ldr	r3, [r7, #12]
 2194 0010 1B78     		ldrb	r3, [r3]
 2195 0012 002B     		cmp	r3, #0
 2196 0014 12D1     		bne	.L58
 627:../src/frame_m0.c **** 		grabM0R0(*xoffset, *yoffset, *xwidth, *ywidth, (uint8_t *)*memory);
 2197              		.loc 1 627 0
 2198 0016 7B68     		ldr	r3, [r7, #4]
 2199 0018 1B88     		ldrh	r3, [r3]
 2200 001a 1800     		movs	r0, r3
 2201 001c 3B68     		ldr	r3, [r7]
 2202 001e 1B88     		ldrh	r3, [r3]
 2203 0020 1900     		movs	r1, r3
 2204 0022 3B6A     		ldr	r3, [r7, #32]
 2205 0024 1B88     		ldrh	r3, [r3]
 2206 0026 1A00     		movs	r2, r3
 2207 0028 7B6A     		ldr	r3, [r7, #36]
 2208 002a 1B88     		ldrh	r3, [r3]
 2209 002c 1C00     		movs	r4, r3
 2210 002e BB68     		ldr	r3, [r7, #8]
 2211 0030 1B68     		ldr	r3, [r3]
 2212 0032 0093     		str	r3, [sp]
 2213 0034 2300     		movs	r3, r4
 2214 0036 FFF7FEFF 		bl	grabM0R0
 2215 003a 30E0     		b	.L59
 2216              	.L58:
 628:../src/frame_m0.c **** 	else if (*type==CAM_GRAB_M1R1)
 2217              		.loc 1 628 0
 2218 003c FB68     		ldr	r3, [r7, #12]
 2219 003e 1B78     		ldrb	r3, [r3]
 2220 0040 112B     		cmp	r3, #17
 2221 0042 12D1     		bne	.L60
 629:../src/frame_m0.c **** 		grabM1R1(*xoffset, *yoffset, *xwidth, *ywidth, (uint8_t *)*memory);
 2222              		.loc 1 629 0
 2223 0044 7B68     		ldr	r3, [r7, #4]
 2224 0046 1B88     		ldrh	r3, [r3]
 2225 0048 1800     		movs	r0, r3
 2226 004a 3B68     		ldr	r3, [r7]
 2227 004c 1B88     		ldrh	r3, [r3]
 2228 004e 1900     		movs	r1, r3
 2229 0050 3B6A     		ldr	r3, [r7, #32]
 2230 0052 1B88     		ldrh	r3, [r3]
 2231 0054 1A00     		movs	r2, r3
 2232 0056 7B6A     		ldr	r3, [r7, #36]
 2233 0058 1B88     		ldrh	r3, [r3]
 2234 005a 1C00     		movs	r4, r3
 2235 005c BB68     		ldr	r3, [r7, #8]
 2236 005e 1B68     		ldr	r3, [r3]
 2237 0060 0093     		str	r3, [sp]
 2238 0062 2300     		movs	r3, r4
 2239 0064 FFF7FEFF 		bl	grabM1R1
 2240 0068 19E0     		b	.L59
 2241              	.L60:
 630:../src/frame_m0.c **** 	else if (*type==CAM_GRAB_M1R2)
 2242              		.loc 1 630 0
 2243 006a FB68     		ldr	r3, [r7, #12]
 2244 006c 1B78     		ldrb	r3, [r3]
 2245 006e 212B     		cmp	r3, #33
 2246 0070 12D1     		bne	.L61
 631:../src/frame_m0.c **** 		grabM1R2(*xoffset, *yoffset, *xwidth, *ywidth, (uint8_t *)*memory);
 2247              		.loc 1 631 0
 2248 0072 7B68     		ldr	r3, [r7, #4]
 2249 0074 1B88     		ldrh	r3, [r3]
 2250 0076 1800     		movs	r0, r3
 2251 0078 3B68     		ldr	r3, [r7]
 2252 007a 1B88     		ldrh	r3, [r3]
 2253 007c 1900     		movs	r1, r3
 2254 007e 3B6A     		ldr	r3, [r7, #32]
 2255 0080 1B88     		ldrh	r3, [r3]
 2256 0082 1A00     		movs	r2, r3
 2257 0084 7B6A     		ldr	r3, [r7, #36]
 2258 0086 1B88     		ldrh	r3, [r3]
 2259 0088 1C00     		movs	r4, r3
 2260 008a BB68     		ldr	r3, [r7, #8]
 2261 008c 1B68     		ldr	r3, [r3]
 2262 008e 0093     		str	r3, [sp]
 2263 0090 2300     		movs	r3, r4
 2264 0092 FFF7FEFF 		bl	grabM1R2
 2265 0096 02E0     		b	.L59
 2266              	.L61:
 632:../src/frame_m0.c **** 	else
 633:../src/frame_m0.c **** 		return -1;
 2267              		.loc 1 633 0
 2268 0098 0123     		movs	r3, #1
 2269 009a 5B42     		rsbs	r3, r3, #0
 2270 009c 00E0     		b	.L62
 2271              	.L59:
 634:../src/frame_m0.c **** 
 635:../src/frame_m0.c **** 	return 0;
 2272              		.loc 1 635 0
 2273 009e 0023     		movs	r3, #0
 2274              	.L62:
 636:../src/frame_m0.c **** }
 2275              		.loc 1 636 0
 2276 00a0 1800     		movs	r0, r3
 2277 00a2 BD46     		mov	sp, r7
 2278 00a4 05B0     		add	sp, sp, #20
 2279              		@ sp needed
 2280 00a6 90BD     		pop	{r4, r7, pc}
 2281              		.cfi_endproc
 2282              	.LFE46:
 2284              		.section	.rodata
 2285              		.align	2
 2286              	.LC1:
 2287 0000 67657446 		.ascii	"getFrame\000"
 2287      72616D65 
 2287      00
 2288              		.section	.text.frame_init,"ax",%progbits
 2289              		.align	2
 2290              		.global	frame_init
 2291              		.code	16
 2292              		.thumb_func
 2294              	frame_init:
 2295              	.LFB47:
 637:../src/frame_m0.c **** 
 638:../src/frame_m0.c **** 
 639:../src/frame_m0.c **** int frame_init(void)
 640:../src/frame_m0.c **** {
 2296              		.loc 1 640 0
 2297              		.cfi_startproc
 2298 0000 80B5     		push	{r7, lr}
 2299              		.cfi_def_cfa_offset 8
 2300              		.cfi_offset 7, -8
 2301              		.cfi_offset 14, -4
 2302 0002 00AF     		add	r7, sp, #0
 2303              		.cfi_def_cfa_register 7
 641:../src/frame_m0.c **** 	chirpSetProc("getFrame", (ProcPtr)getFrame);
 2304              		.loc 1 641 0
 2305 0004 044A     		ldr	r2, .L65
 2306 0006 054B     		ldr	r3, .L65+4
 2307 0008 1100     		movs	r1, r2
 2308 000a 1800     		movs	r0, r3
 2309 000c FFF7FEFF 		bl	chirpSetProc
 642:../src/frame_m0.c **** 		
 643:../src/frame_m0.c **** 	return 0;	
 2310              		.loc 1 643 0
 2311 0010 0023     		movs	r3, #0
 644:../src/frame_m0.c **** }
 2312              		.loc 1 644 0
 2313 0012 1800     		movs	r0, r3
 2314 0014 BD46     		mov	sp, r7
 2315              		@ sp needed
 2316 0016 80BD     		pop	{r7, pc}
 2317              	.L66:
 2318              		.align	2
 2319              	.L65:
 2320 0018 00000000 		.word	getFrame
 2321 001c 00000000 		.word	.LC1
 2322              		.cfi_endproc
 2323              	.LFE47:
 2325              		.text
 2326              	.Letext0:
 2327              		.file 2 "/usr/local/lpcxpresso_8.1.4_606/lpcxpresso/tools/redlib/include/stdint.h"
 2328              		.file 3 "/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/misc/gcc/pixy_m0/inc/lpc43xx.h"
 2329              		.file 4 "/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/misc/gcc/m0/inc/chirp.h"
DEFINED SYMBOLS
                            *ABS*:00000000 frame_m0.c
     /tmp/ccmWfK1Q.s:20     .text.vsync:00000000 $t
     /tmp/ccmWfK1Q.s:25     .text.vsync:00000000 vsync
     /tmp/ccmWfK1Q.s:109    .text.vsync:00000064 $d
     /tmp/ccmWfK1Q.s:115    .text.syncM0:00000000 $t
     /tmp/ccmWfK1Q.s:120    .text.syncM0:00000000 syncM0
     /tmp/ccmWfK1Q.s:145    .text.syncM0:0000000c start
     /tmp/ccmWfK1Q.s:239    .text.syncM1:00000000 $t
     /tmp/ccmWfK1Q.s:244    .text.syncM1:00000000 syncM1
     /tmp/ccmWfK1Q.s:269    .text.syncM1:0000000c startSyncM1
     /tmp/ccmWfK1Q.s:447    .text.lineM0:00000000 $t
     /tmp/ccmWfK1Q.s:452    .text.lineM0:00000000 lineM0
     /tmp/ccmWfK1Q.s:2105   .text.callSyncM0:00000000 callSyncM0
     /tmp/ccmWfK1Q.s:511    .text.lineM0:00000022 dest21
     /tmp/ccmWfK1Q.s:527    .text.lineM0:00000028 dest22
     /tmp/ccmWfK1Q.s:603    .text.lineM0:0000004c loop11
     /tmp/ccmWfK1Q.s:647    .text.lineM0:00000060 dest13
     /tmp/ccmWfK1Q.s:681    .text.lineM1R1:00000000 $t
     /tmp/ccmWfK1Q.s:686    .text.lineM1R1:00000000 lineM1R1
     /tmp/ccmWfK1Q.s:2140   .text.callSyncM1:00000000 callSyncM1
     /tmp/ccmWfK1Q.s:737    .text.lineM1R1:0000001e dest1
     /tmp/ccmWfK1Q.s:753    .text.lineM1R1:00000024 dest2
     /tmp/ccmWfK1Q.s:853    .text.lineM1R1:00000054 loop1
     /tmp/ccmWfK1Q.s:889    .text.lineM1R1:00000064 dest3
     /tmp/ccmWfK1Q.s:923    .text.lineM1R2:00000000 $t
     /tmp/ccmWfK1Q.s:928    .text.lineM1R2:00000000 lineM1R2
     /tmp/ccmWfK1Q.s:983    .text.lineM1R2:00000020 dest7
     /tmp/ccmWfK1Q.s:999    .text.lineM1R2:00000026 dest8
     /tmp/ccmWfK1Q.s:1099   .text.lineM1R2:00000056 loop3
     /tmp/ccmWfK1Q.s:1263   .text.lineM1R2:000000a6 dest9
     /tmp/ccmWfK1Q.s:1297   .text.lineM1R2Merge:00000000 $t
     /tmp/ccmWfK1Q.s:1302   .text.lineM1R2Merge:00000000 lineM1R2Merge
     /tmp/ccmWfK1Q.s:1357   .text.lineM1R2Merge:00000020 dest4
     /tmp/ccmWfK1Q.s:1373   .text.lineM1R2Merge:00000026 dest5
     /tmp/ccmWfK1Q.s:1473   .text.lineM1R2Merge:00000056 loop4
     /tmp/ccmWfK1Q.s:1629   .text.lineM1R2Merge:000000a2 dest6
     /tmp/ccmWfK1Q.s:1663   .text.skipLine:00000000 $t
     /tmp/ccmWfK1Q.s:1668   .text.skipLine:00000000 skipLine
     /tmp/ccmWfK1Q.s:1708   .text.skipLine:0000002c $d
     /tmp/ccmWfK1Q.s:1714   .text.skipLines:00000000 $t
     /tmp/ccmWfK1Q.s:1719   .text.skipLines:00000000 skipLines
     /tmp/ccmWfK1Q.s:1780   .text.skipLines:00000048 $d
     /tmp/ccmWfK1Q.s:1786   .text.grabM0R0:00000000 $t
     /tmp/ccmWfK1Q.s:1791   .text.grabM0R0:00000000 grabM0R0
     /tmp/ccmWfK1Q.s:1854   .text.grabM0R0:00000054 $d
     /tmp/ccmWfK1Q.s:1859   .text.grabM1R1:00000000 $t
     /tmp/ccmWfK1Q.s:1864   .text.grabM1R1:00000000 grabM1R1
     /tmp/ccmWfK1Q.s:1927   .text.grabM1R1:00000054 $d
     /tmp/ccmWfK1Q.s:1932   .text.grabM1R2:00000000 $t
     /tmp/ccmWfK1Q.s:1937   .text.grabM1R2:00000000 grabM1R2
     /tmp/ccmWfK1Q.s:2095   .text.grabM1R2:000000f4 $d
     /tmp/ccmWfK1Q.s:2100   .text.callSyncM0:00000000 $t
     /tmp/ccmWfK1Q.s:2130   .text.callSyncM0:00000018 $d
     /tmp/ccmWfK1Q.s:2135   .text.callSyncM1:00000000 $t
     /tmp/ccmWfK1Q.s:2165   .text.callSyncM1:00000018 $d
     /tmp/ccmWfK1Q.s:2170   .text.getFrame:00000000 $t
     /tmp/ccmWfK1Q.s:2175   .text.getFrame:00000000 getFrame
     /tmp/ccmWfK1Q.s:2285   .rodata:00000000 $d
     /tmp/ccmWfK1Q.s:2289   .text.frame_init:00000000 $t
     /tmp/ccmWfK1Q.s:2294   .text.frame_init:00000000 frame_init
     /tmp/ccmWfK1Q.s:2320   .text.frame_init:00000018 $d
                     .debug_frame:00000010 $d

UNDEFINED SYMBOLS
chirpSetProc
