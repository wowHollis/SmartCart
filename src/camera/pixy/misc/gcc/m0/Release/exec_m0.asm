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
  15              		.file	"exec_m0.c"
  16              		.text
  17              	.Ltext0:
  18              		.cfi_sections	.debug_frame
  19              		.global	g_running
  20              		.section	.bss.g_running,"aw",%nobits
  23              	g_running:
  24 0000 00       		.space	1
  25              		.global	g_run
  26              		.section	.bss.g_run,"aw",%nobits
  29              	g_run:
  30 0000 00       		.space	1
  31              		.global	g_program
  32              		.section	.data.g_program,"aw",%progbits
  35              	g_program:
  36 0000 FF       		.byte	-1
  37              		.section	.rodata
  38              		.align	2
  39              	.LC1:
  40 0000 72756E00 		.ascii	"run\000"
  41              		.align	2
  42              	.LC4:
  43 0004 73746F70 		.ascii	"stop\000"
  43      00
  44 0009 000000   		.align	2
  45              	.LC7:
  46 000c 72756E6E 		.ascii	"running\000"
  46      696E6700 
  47              		.section	.text.exec_init,"ax",%progbits
  48              		.align	2
  49              		.global	exec_init
  50              		.code	16
  51              		.thumb_func
  53              	exec_init:
  54              	.LFB0:
  55              		.file 1 "../src/exec_m0.c"
   1:../src/exec_m0.c **** //
   2:../src/exec_m0.c **** // begin license header
   3:../src/exec_m0.c **** //
   4:../src/exec_m0.c **** // This file is part of Pixy CMUcam5 or "Pixy" for short
   5:../src/exec_m0.c **** //
   6:../src/exec_m0.c **** // All Pixy source code is provided under the terms of the
   7:../src/exec_m0.c **** // GNU General Public License v2 (http://www.gnu.org/licenses/gpl-2.0.html).
   8:../src/exec_m0.c **** // Those wishing to use Pixy source code, software and/or
   9:../src/exec_m0.c **** // technologies under different licensing terms should contact us at
  10:../src/exec_m0.c **** // cmucam@cs.cmu.edu. Such licensing terms are available for
  11:../src/exec_m0.c **** // all portions of the Pixy codebase presented here.
  12:../src/exec_m0.c **** //
  13:../src/exec_m0.c **** // end license header
  14:../src/exec_m0.c **** //
  15:../src/exec_m0.c **** 
  16:../src/exec_m0.c **** #include <pixyvals.h>
  17:../src/exec_m0.c **** #include "chirp.h"
  18:../src/exec_m0.c **** #include "exec_m0.h"
  19:../src/exec_m0.c **** #include "rls_m0.h"
  20:../src/exec_m0.c **** 
  21:../src/exec_m0.c **** uint8_t g_running = 0;
  22:../src/exec_m0.c **** uint8_t g_run = 0;
  23:../src/exec_m0.c **** int8_t g_program = -1;
  24:../src/exec_m0.c **** 
  25:../src/exec_m0.c **** int exec_init(void)
  26:../src/exec_m0.c **** {
  56              		.loc 1 26 0
  57              		.cfi_startproc
  58 0000 80B5     		push	{r7, lr}
  59              		.cfi_def_cfa_offset 8
  60              		.cfi_offset 7, -8
  61              		.cfi_offset 14, -4
  62 0002 00AF     		add	r7, sp, #0
  63              		.cfi_def_cfa_register 7
  27:../src/exec_m0.c **** 	chirpSetProc("run", (ProcPtr)exec_run);
  64              		.loc 1 27 0
  65 0004 0A4A     		ldr	r2, .L3
  66 0006 0B4B     		ldr	r3, .L3+4
  67 0008 1100     		movs	r1, r2
  68 000a 1800     		movs	r0, r3
  69 000c FFF7FEFF 		bl	chirpSetProc
  28:../src/exec_m0.c **** 	chirpSetProc("stop", (ProcPtr)exec_stop);
  70              		.loc 1 28 0
  71 0010 094A     		ldr	r2, .L3+8
  72 0012 0A4B     		ldr	r3, .L3+12
  73 0014 1100     		movs	r1, r2
  74 0016 1800     		movs	r0, r3
  75 0018 FFF7FEFF 		bl	chirpSetProc
  29:../src/exec_m0.c **** 	chirpSetProc("running", (ProcPtr)exec_running);
  76              		.loc 1 29 0
  77 001c 084A     		ldr	r2, .L3+16
  78 001e 094B     		ldr	r3, .L3+20
  79 0020 1100     		movs	r1, r2
  80 0022 1800     		movs	r0, r3
  81 0024 FFF7FEFF 		bl	chirpSetProc
  30:../src/exec_m0.c **** 		
  31:../src/exec_m0.c **** 	return 0;	
  82              		.loc 1 31 0
  83 0028 0023     		movs	r3, #0
  32:../src/exec_m0.c **** }
  84              		.loc 1 32 0
  85 002a 1800     		movs	r0, r3
  86 002c BD46     		mov	sp, r7
  87              		@ sp needed
  88 002e 80BD     		pop	{r7, pc}
  89              	.L4:
  90              		.align	2
  91              	.L3:
  92 0030 00000000 		.word	exec_run
  93 0034 00000000 		.word	.LC1
  94 0038 00000000 		.word	exec_stop
  95 003c 04000000 		.word	.LC4
  96 0040 00000000 		.word	exec_running
  97 0044 0C000000 		.word	.LC7
  98              		.cfi_endproc
  99              	.LFE0:
 101              		.section	.text.exec_running,"ax",%progbits
 102              		.align	2
 103              		.global	exec_running
 104              		.code	16
 105              		.thumb_func
 107              	exec_running:
 108              	.LFB1:
  33:../src/exec_m0.c **** 
  34:../src/exec_m0.c **** uint32_t exec_running(void)
  35:../src/exec_m0.c **** {
 109              		.loc 1 35 0
 110              		.cfi_startproc
 111 0000 80B5     		push	{r7, lr}
 112              		.cfi_def_cfa_offset 8
 113              		.cfi_offset 7, -8
 114              		.cfi_offset 14, -4
 115 0002 00AF     		add	r7, sp, #0
 116              		.cfi_def_cfa_register 7
  36:../src/exec_m0.c **** 	return (uint32_t)g_running;
 117              		.loc 1 36 0
 118 0004 024B     		ldr	r3, .L7
 119 0006 1B78     		ldrb	r3, [r3]
  37:../src/exec_m0.c **** }
 120              		.loc 1 37 0
 121 0008 1800     		movs	r0, r3
 122 000a BD46     		mov	sp, r7
 123              		@ sp needed
 124 000c 80BD     		pop	{r7, pc}
 125              	.L8:
 126 000e C046     		.align	2
 127              	.L7:
 128 0010 00000000 		.word	g_running
 129              		.cfi_endproc
 130              	.LFE1:
 132              		.section	.text.exec_stop,"ax",%progbits
 133              		.align	2
 134              		.global	exec_stop
 135              		.code	16
 136              		.thumb_func
 138              	exec_stop:
 139              	.LFB2:
  38:../src/exec_m0.c **** 
  39:../src/exec_m0.c **** int32_t exec_stop(void)
  40:../src/exec_m0.c **** {
 140              		.loc 1 40 0
 141              		.cfi_startproc
 142 0000 80B5     		push	{r7, lr}
 143              		.cfi_def_cfa_offset 8
 144              		.cfi_offset 7, -8
 145              		.cfi_offset 14, -4
 146 0002 00AF     		add	r7, sp, #0
 147              		.cfi_def_cfa_register 7
  41:../src/exec_m0.c **** 	g_run = 0;
 148              		.loc 1 41 0
 149 0004 034B     		ldr	r3, .L11
 150 0006 0022     		movs	r2, #0
 151 0008 1A70     		strb	r2, [r3]
  42:../src/exec_m0.c **** 	return 0;
 152              		.loc 1 42 0
 153 000a 0023     		movs	r3, #0
  43:../src/exec_m0.c **** }
 154              		.loc 1 43 0
 155 000c 1800     		movs	r0, r3
 156 000e BD46     		mov	sp, r7
 157              		@ sp needed
 158 0010 80BD     		pop	{r7, pc}
 159              	.L12:
 160 0012 C046     		.align	2
 161              	.L11:
 162 0014 00000000 		.word	g_run
 163              		.cfi_endproc
 164              	.LFE2:
 166              		.section	.text.exec_run,"ax",%progbits
 167              		.align	2
 168              		.global	exec_run
 169              		.code	16
 170              		.thumb_func
 172              	exec_run:
 173              	.LFB3:
  44:../src/exec_m0.c **** 
  45:../src/exec_m0.c **** int32_t exec_run(uint8_t *prog)
  46:../src/exec_m0.c **** {
 174              		.loc 1 46 0
 175              		.cfi_startproc
 176 0000 80B5     		push	{r7, lr}
 177              		.cfi_def_cfa_offset 8
 178              		.cfi_offset 7, -8
 179              		.cfi_offset 14, -4
 180 0002 82B0     		sub	sp, sp, #8
 181              		.cfi_def_cfa_offset 16
 182 0004 00AF     		add	r7, sp, #0
 183              		.cfi_def_cfa_register 7
 184 0006 7860     		str	r0, [r7, #4]
  47:../src/exec_m0.c **** 	g_program = *prog;
 185              		.loc 1 47 0
 186 0008 7B68     		ldr	r3, [r7, #4]
 187 000a 1B78     		ldrb	r3, [r3]
 188 000c DAB2     		uxtb	r2, r3
 189 000e 064B     		ldr	r3, .L15
 190 0010 1A70     		strb	r2, [r3]
  48:../src/exec_m0.c **** 	g_run = 1;
 191              		.loc 1 48 0
 192 0012 064B     		ldr	r3, .L15+4
 193 0014 0122     		movs	r2, #1
 194 0016 1A70     		strb	r2, [r3]
  49:../src/exec_m0.c **** 	g_running = 1;		
 195              		.loc 1 49 0
 196 0018 054B     		ldr	r3, .L15+8
 197 001a 0122     		movs	r2, #1
 198 001c 1A70     		strb	r2, [r3]
  50:../src/exec_m0.c **** 	return 0;
 199              		.loc 1 50 0
 200 001e 0023     		movs	r3, #0
  51:../src/exec_m0.c **** }
 201              		.loc 1 51 0
 202 0020 1800     		movs	r0, r3
 203 0022 BD46     		mov	sp, r7
 204 0024 02B0     		add	sp, sp, #8
 205              		@ sp needed
 206 0026 80BD     		pop	{r7, pc}
 207              	.L16:
 208              		.align	2
 209              	.L15:
 210 0028 00000000 		.word	g_program
 211 002c 00000000 		.word	g_run
 212 0030 00000000 		.word	g_running
 213              		.cfi_endproc
 214              	.LFE3:
 216              		.section	.text.setup0,"ax",%progbits
 217              		.align	2
 218              		.global	setup0
 219              		.code	16
 220              		.thumb_func
 222              	setup0:
 223              	.LFB4:
  52:../src/exec_m0.c **** 
  53:../src/exec_m0.c **** #define LUT_MEMORY_SIZE		0x10000 // bytes
  54:../src/exec_m0.c **** 
  55:../src/exec_m0.c **** void setup0()
  56:../src/exec_m0.c **** {
 224              		.loc 1 56 0
 225              		.cfi_startproc
 226 0000 80B5     		push	{r7, lr}
 227              		.cfi_def_cfa_offset 8
 228              		.cfi_offset 7, -8
 229              		.cfi_offset 14, -4
 230 0002 00AF     		add	r7, sp, #0
 231              		.cfi_def_cfa_register 7
  57:../src/exec_m0.c **** }
 232              		.loc 1 57 0
 233 0004 C046     		nop
 234 0006 BD46     		mov	sp, r7
 235              		@ sp needed
 236 0008 80BD     		pop	{r7, pc}
 237              		.cfi_endproc
 238              	.LFE4:
 240              		.global	g_m0mem
 241 000a C046     		.section	.data.g_m0mem,"aw",%progbits
 242              		.align	2
 245              	g_m0mem:
 246 0000 00000810 		.word	268959744
 247              		.global	g_lut
 248              		.section	.data.g_lut,"aw",%progbits
 249              		.align	2
 252              	g_lut:
 253 0000 00200810 		.word	268967936
 254              		.section	.text.loop0,"ax",%progbits
 255              		.align	2
 256              		.global	loop0
 257              		.code	16
 258              		.thumb_func
 260              	loop0:
 261              	.LFB5:
  58:../src/exec_m0.c **** 
  59:../src/exec_m0.c **** uint32_t g_m0mem = SRAM1_LOC;
  60:../src/exec_m0.c **** uint32_t g_lut = SRAM1_LOC + SRAM1_SIZE-LUT_MEMORY_SIZE;
  61:../src/exec_m0.c **** 
  62:../src/exec_m0.c **** void loop0()
  63:../src/exec_m0.c **** {
 262              		.loc 1 63 0
 263              		.cfi_startproc
 264 0000 80B5     		push	{r7, lr}
 265              		.cfi_def_cfa_offset 8
 266              		.cfi_offset 7, -8
 267              		.cfi_offset 14, -4
 268 0002 00AF     		add	r7, sp, #0
 269              		.cfi_def_cfa_register 7
  64:../src/exec_m0.c **** 	getRLSFrame(&g_m0mem, &g_lut);	
 270              		.loc 1 64 0
 271 0004 044A     		ldr	r2, .L19
 272 0006 054B     		ldr	r3, .L19+4
 273 0008 1100     		movs	r1, r2
 274 000a 1800     		movs	r0, r3
 275 000c FFF7FEFF 		bl	getRLSFrame
  65:../src/exec_m0.c **** }
 276              		.loc 1 65 0
 277 0010 C046     		nop
 278 0012 BD46     		mov	sp, r7
 279              		@ sp needed
 280 0014 80BD     		pop	{r7, pc}
 281              	.L20:
 282 0016 C046     		.align	2
 283              	.L19:
 284 0018 00000000 		.word	g_lut
 285 001c 00000000 		.word	g_m0mem
 286              		.cfi_endproc
 287              	.LFE5:
 289              		.section	.text.exec_loop,"ax",%progbits
 290              		.align	2
 291              		.global	exec_loop
 292              		.code	16
 293              		.thumb_func
 295              	exec_loop:
 296              	.LFB6:
  66:../src/exec_m0.c **** 
  67:../src/exec_m0.c **** 
  68:../src/exec_m0.c **** void exec_loop(void)
  69:../src/exec_m0.c **** {
 297              		.loc 1 69 0
 298              		.cfi_startproc
 299 0000 80B5     		push	{r7, lr}
 300              		.cfi_def_cfa_offset 8
 301              		.cfi_offset 7, -8
 302              		.cfi_offset 14, -4
 303 0002 00AF     		add	r7, sp, #0
 304              		.cfi_def_cfa_register 7
 305              	.L26:
  70:../src/exec_m0.c **** 	while(1)
  71:../src/exec_m0.c **** 	{
  72:../src/exec_m0.c **** 		while(!g_run)
 306              		.loc 1 72 0
 307 0004 01E0     		b	.L22
 308              	.L23:
  73:../src/exec_m0.c **** 			chirpService();
 309              		.loc 1 73 0
 310 0006 FFF7FEFF 		bl	chirpService
 311              	.L22:
  72:../src/exec_m0.c **** 			chirpService();
 312              		.loc 1 72 0
 313 000a 094B     		ldr	r3, .L27
 314 000c 1B78     		ldrb	r3, [r3]
 315 000e 002B     		cmp	r3, #0
 316 0010 F9D0     		beq	.L23
  74:../src/exec_m0.c **** 		 	
  75:../src/exec_m0.c **** 		setup0();
 317              		.loc 1 75 0
 318 0012 FFF7FEFF 		bl	setup0
  76:../src/exec_m0.c **** 		while(g_run)
 319              		.loc 1 76 0
 320 0016 03E0     		b	.L24
 321              	.L25:
  77:../src/exec_m0.c **** 		{
  78:../src/exec_m0.c **** 			loop0();
 322              		.loc 1 78 0
 323 0018 FFF7FEFF 		bl	loop0
  79:../src/exec_m0.c **** 			chirpService();
 324              		.loc 1 79 0
 325 001c FFF7FEFF 		bl	chirpService
 326              	.L24:
  76:../src/exec_m0.c **** 		while(g_run)
 327              		.loc 1 76 0
 328 0020 034B     		ldr	r3, .L27
 329 0022 1B78     		ldrb	r3, [r3]
 330 0024 002B     		cmp	r3, #0
 331 0026 F7D1     		bne	.L25
  80:../src/exec_m0.c **** 		}
  81:../src/exec_m0.c **** 		// set variable to indicate we've stopped
  82:../src/exec_m0.c **** 		g_running = 0;
 332              		.loc 1 82 0
 333 0028 024B     		ldr	r3, .L27+4
 334 002a 0022     		movs	r2, #0
 335 002c 1A70     		strb	r2, [r3]
  83:../src/exec_m0.c **** 	}
 336              		.loc 1 83 0
 337 002e E9E7     		b	.L26
 338              	.L28:
 339              		.align	2
 340              	.L27:
 341 0030 00000000 		.word	g_run
 342 0034 00000000 		.word	g_running
 343              		.cfi_endproc
 344              	.LFE6:
 346              		.text
 347              	.Letext0:
 348              		.file 2 "/usr/local/lpcxpresso_8.1.4_606/lpcxpresso/tools/redlib/include/stdint.h"
 349              		.file 3 "/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/misc/gcc/m0/inc/chirp.h"
DEFINED SYMBOLS
                            *ABS*:00000000 exec_m0.c
     /tmp/ccMJG3fO.s:23     .bss.g_running:00000000 g_running
     /tmp/ccMJG3fO.s:24     .bss.g_running:00000000 $d
     /tmp/ccMJG3fO.s:29     .bss.g_run:00000000 g_run
     /tmp/ccMJG3fO.s:30     .bss.g_run:00000000 $d
     /tmp/ccMJG3fO.s:35     .data.g_program:00000000 g_program
     /tmp/ccMJG3fO.s:38     .rodata:00000000 $d
     /tmp/ccMJG3fO.s:48     .text.exec_init:00000000 $t
     /tmp/ccMJG3fO.s:53     .text.exec_init:00000000 exec_init
     /tmp/ccMJG3fO.s:92     .text.exec_init:00000030 $d
     /tmp/ccMJG3fO.s:172    .text.exec_run:00000000 exec_run
     /tmp/ccMJG3fO.s:138    .text.exec_stop:00000000 exec_stop
     /tmp/ccMJG3fO.s:107    .text.exec_running:00000000 exec_running
     /tmp/ccMJG3fO.s:102    .text.exec_running:00000000 $t
     /tmp/ccMJG3fO.s:128    .text.exec_running:00000010 $d
     /tmp/ccMJG3fO.s:133    .text.exec_stop:00000000 $t
     /tmp/ccMJG3fO.s:162    .text.exec_stop:00000014 $d
     /tmp/ccMJG3fO.s:167    .text.exec_run:00000000 $t
     /tmp/ccMJG3fO.s:210    .text.exec_run:00000028 $d
     /tmp/ccMJG3fO.s:217    .text.setup0:00000000 $t
     /tmp/ccMJG3fO.s:222    .text.setup0:00000000 setup0
     /tmp/ccMJG3fO.s:245    .data.g_m0mem:00000000 g_m0mem
     /tmp/ccMJG3fO.s:242    .data.g_m0mem:00000000 $d
     /tmp/ccMJG3fO.s:252    .data.g_lut:00000000 g_lut
     /tmp/ccMJG3fO.s:249    .data.g_lut:00000000 $d
     /tmp/ccMJG3fO.s:255    .text.loop0:00000000 $t
     /tmp/ccMJG3fO.s:260    .text.loop0:00000000 loop0
     /tmp/ccMJG3fO.s:284    .text.loop0:00000018 $d
     /tmp/ccMJG3fO.s:290    .text.exec_loop:00000000 $t
     /tmp/ccMJG3fO.s:295    .text.exec_loop:00000000 exec_loop
     /tmp/ccMJG3fO.s:341    .text.exec_loop:00000030 $d
                     .debug_frame:00000010 $d

UNDEFINED SYMBOLS
chirpSetProc
getRLSFrame
chirpService
