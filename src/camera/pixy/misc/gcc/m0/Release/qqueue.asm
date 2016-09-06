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
  15              		.file	"qqueue.c"
  16              		.text
  17              	.Ltext0:
  18              		.cfi_sections	.debug_frame
  19              		.global	g_qqueue
  20              		.section	.data.g_qqueue,"aw",%progbits
  21              		.align	2
  24              	g_qqueue:
  25 0000 00C00020 		.word	536920064
  26              		.section	.text.qq_enqueue,"ax",%progbits
  27              		.align	2
  28              		.global	qq_enqueue
  29              		.code	16
  30              		.thumb_func
  32              	qq_enqueue:
  33              	.LFB0:
  34              		.file 1 "../src/qqueue.c"
   1:../src/qqueue.c **** //
   2:../src/qqueue.c **** // begin license header
   3:../src/qqueue.c **** //
   4:../src/qqueue.c **** // This file is part of Pixy CMUcam5 or "Pixy" for short
   5:../src/qqueue.c **** //
   6:../src/qqueue.c **** // All Pixy source code is provided under the terms of the
   7:../src/qqueue.c **** // GNU General Public License v2 (http://www.gnu.org/licenses/gpl-2.0.html).
   8:../src/qqueue.c **** // Those wishing to use Pixy source code, software and/or
   9:../src/qqueue.c **** // technologies under different licensing terms should contact us at
  10:../src/qqueue.c **** // cmucam@cs.cmu.edu. Such licensing terms are available for
  11:../src/qqueue.c **** // all portions of the Pixy codebase presented here.
  12:../src/qqueue.c **** //
  13:../src/qqueue.c **** // end license header
  14:../src/qqueue.c **** //
  15:../src/qqueue.c **** 
  16:../src/qqueue.c **** #include "qqueue.h"
  17:../src/qqueue.c **** #include "pixyvals.h"
  18:../src/qqueue.c **** 
  19:../src/qqueue.c **** struct QqueueFields *g_qqueue = (struct QqueueFields *)QQ_LOC;
  20:../src/qqueue.c **** 
  21:../src/qqueue.c **** uint32_t qq_enqueue(Qval val)
  22:../src/qqueue.c **** {
  35              		.loc 1 22 0
  36              		.cfi_startproc
  37 0000 80B5     		push	{r7, lr}
  38              		.cfi_def_cfa_offset 8
  39              		.cfi_offset 7, -8
  40              		.cfi_offset 14, -4
  41 0002 82B0     		sub	sp, sp, #8
  42              		.cfi_def_cfa_offset 16
  43 0004 00AF     		add	r7, sp, #0
  44              		.cfi_def_cfa_register 7
  45 0006 7860     		str	r0, [r7, #4]
  23:../src/qqueue.c ****     if (qq_free()>0)
  46              		.loc 1 23 0
  47 0008 FFF7FEFF 		bl	qq_free
  48 000c 031E     		subs	r3, r0, #0
  49 000e 21D0     		beq	.L2
  24:../src/qqueue.c ****     {
  25:../src/qqueue.c ****         g_qqueue->data[g_qqueue->writeIndex++] = val;
  50              		.loc 1 25 0
  51 0010 134B     		ldr	r3, .L5
  52 0012 1968     		ldr	r1, [r3]
  53 0014 124B     		ldr	r3, .L5
  54 0016 1B68     		ldr	r3, [r3]
  55 0018 5A88     		ldrh	r2, [r3, #2]
  56 001a 92B2     		uxth	r2, r2
  57 001c 501C     		adds	r0, r2, #1
  58 001e 80B2     		uxth	r0, r0
  59 0020 5880     		strh	r0, [r3, #2]
  60 0022 1300     		movs	r3, r2
  61 0024 0233     		adds	r3, r3, #2
  62 0026 9B00     		lsls	r3, r3, #2
  63 0028 7A68     		ldr	r2, [r7, #4]
  64 002a 5A50     		str	r2, [r3, r1]
  26:../src/qqueue.c ****         g_qqueue->produced++;
  65              		.loc 1 26 0
  66 002c 0C4B     		ldr	r3, .L5
  67 002e 1B68     		ldr	r3, [r3]
  68 0030 9A88     		ldrh	r2, [r3, #4]
  69 0032 92B2     		uxth	r2, r2
  70 0034 0132     		adds	r2, r2, #1
  71 0036 92B2     		uxth	r2, r2
  72 0038 9A80     		strh	r2, [r3, #4]
  27:../src/qqueue.c **** 		if (g_qqueue->writeIndex==QQ_MEM_SIZE)
  73              		.loc 1 27 0
  74 003a 094B     		ldr	r3, .L5
  75 003c 1B68     		ldr	r3, [r3]
  76 003e 5B88     		ldrh	r3, [r3, #2]
  77 0040 9BB2     		uxth	r3, r3
  78 0042 084A     		ldr	r2, .L5+4
  79 0044 9342     		cmp	r3, r2
  80 0046 03D1     		bne	.L3
  28:../src/qqueue.c **** 			g_qqueue->writeIndex = 0;
  81              		.loc 1 28 0
  82 0048 054B     		ldr	r3, .L5
  83 004a 1B68     		ldr	r3, [r3]
  84 004c 0022     		movs	r2, #0
  85 004e 5A80     		strh	r2, [r3, #2]
  86              	.L3:
  29:../src/qqueue.c ****         return 1;
  87              		.loc 1 29 0
  88 0050 0123     		movs	r3, #1
  89 0052 00E0     		b	.L4
  90              	.L2:
  30:../src/qqueue.c ****     }
  31:../src/qqueue.c ****     return 0;
  91              		.loc 1 31 0
  92 0054 0023     		movs	r3, #0
  93              	.L4:
  32:../src/qqueue.c **** }
  94              		.loc 1 32 0
  95 0056 1800     		movs	r0, r3
  96 0058 BD46     		mov	sp, r7
  97 005a 02B0     		add	sp, sp, #8
  98              		@ sp needed
  99 005c 80BD     		pop	{r7, pc}
 100              	.L6:
 101 005e C046     		.align	2
 102              	.L5:
 103 0060 00000000 		.word	g_qqueue
 104 0064 FE0B0000 		.word	3070
 105              		.cfi_endproc
 106              	.LFE0:
 108              		.section	.text.qq_free,"ax",%progbits
 109              		.align	2
 110              		.global	qq_free
 111              		.code	16
 112              		.thumb_func
 114              	qq_free:
 115              	.LFB1:
  33:../src/qqueue.c **** 
  34:../src/qqueue.c **** uint16_t qq_free(void)
  35:../src/qqueue.c **** {
 116              		.loc 1 35 0
 117              		.cfi_startproc
 118 0000 80B5     		push	{r7, lr}
 119              		.cfi_def_cfa_offset 8
 120              		.cfi_offset 7, -8
 121              		.cfi_offset 14, -4
 122 0002 82B0     		sub	sp, sp, #8
 123              		.cfi_def_cfa_offset 16
 124 0004 00AF     		add	r7, sp, #0
 125              		.cfi_def_cfa_register 7
  36:../src/qqueue.c ****     uint16_t len = g_qqueue->produced - g_qqueue->consumed;
 126              		.loc 1 36 0
 127 0006 0A4B     		ldr	r3, .L9
 128 0008 1B68     		ldr	r3, [r3]
 129 000a 9B88     		ldrh	r3, [r3, #4]
 130 000c 99B2     		uxth	r1, r3
 131 000e 084B     		ldr	r3, .L9
 132 0010 1B68     		ldr	r3, [r3]
 133 0012 DB88     		ldrh	r3, [r3, #6]
 134 0014 9AB2     		uxth	r2, r3
 135 0016 BB1D     		adds	r3, r7, #6
 136 0018 8A1A     		subs	r2, r1, r2
 137 001a 1A80     		strh	r2, [r3]
  37:../src/qqueue.c **** 	return QQ_MEM_SIZE-len;
 138              		.loc 1 37 0
 139 001c BB1D     		adds	r3, r7, #6
 140 001e 1B88     		ldrh	r3, [r3]
 141 0020 044A     		ldr	r2, .L9+4
 142 0022 D31A     		subs	r3, r2, r3
 143 0024 9BB2     		uxth	r3, r3
  38:../src/qqueue.c **** } 
 144              		.loc 1 38 0
 145 0026 1800     		movs	r0, r3
 146 0028 BD46     		mov	sp, r7
 147 002a 02B0     		add	sp, sp, #8
 148              		@ sp needed
 149 002c 80BD     		pop	{r7, pc}
 150              	.L10:
 151 002e C046     		.align	2
 152              	.L9:
 153 0030 00000000 		.word	g_qqueue
 154 0034 FE0B0000 		.word	3070
 155              		.cfi_endproc
 156              	.LFE1:
 158              		.text
 159              	.Letext0:
 160              		.file 2 "/usr/local/lpcxpresso_8.1.4_606/lpcxpresso/tools/redlib/include/stdint.h"
 161              		.file 3 "/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/misc/gcc/m0/inc/qqueue.h"
DEFINED SYMBOLS
                            *ABS*:00000000 qqueue.c
     /tmp/cckzgME9.s:24     .data.g_qqueue:00000000 g_qqueue
     /tmp/cckzgME9.s:21     .data.g_qqueue:00000000 $d
     /tmp/cckzgME9.s:27     .text.qq_enqueue:00000000 $t
     /tmp/cckzgME9.s:32     .text.qq_enqueue:00000000 qq_enqueue
     /tmp/cckzgME9.s:114    .text.qq_free:00000000 qq_free
     /tmp/cckzgME9.s:103    .text.qq_enqueue:00000060 $d
     /tmp/cckzgME9.s:109    .text.qq_free:00000000 $t
     /tmp/cckzgME9.s:153    .text.qq_free:00000030 $d
                     .debug_frame:00000010 $d

NO UNDEFINED SYMBOLS
