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
  15              		.file	"main_m0.c"
  16              		.text
  17              	.Ltext0:
  18              		.cfi_sections	.debug_frame
  19              		.section	.rodata
  20              		.align	2
  21              	.LC0:
  22 0000 4D302073 		.ascii	"M0 start\012\000"
  22      74617274 
  22      0A00
  23              		.section	.text.main,"ax",%progbits
  24              		.align	2
  25              		.global	main
  26              		.code	16
  27              		.thumb_func
  29              	main:
  30              	.LFB32:
  31              		.file 1 "../src/main_m0.c"
   1:../src/main_m0.c **** //
   2:../src/main_m0.c **** // begin license header
   3:../src/main_m0.c **** //
   4:../src/main_m0.c **** // This file is part of Pixy CMUcam5 or "Pixy" for short
   5:../src/main_m0.c **** //
   6:../src/main_m0.c **** // All Pixy source code is provided under the terms of the
   7:../src/main_m0.c **** // GNU General Public License v2 (http://www.gnu.org/licenses/gpl-2.0.html).
   8:../src/main_m0.c **** // Those wishing to use Pixy source code, software and/or
   9:../src/main_m0.c **** // technologies under different licensing terms should contact us at
  10:../src/main_m0.c **** // cmucam@cs.cmu.edu. Such licensing terms are available for
  11:../src/main_m0.c **** // all portions of the Pixy codebase presented here.
  12:../src/main_m0.c **** //
  13:../src/main_m0.c **** // end license header
  14:../src/main_m0.c **** //
  15:../src/main_m0.c **** 
  16:../src/main_m0.c **** #include <debug.h>
  17:../src/main_m0.c **** #include <chirp.h>
  18:../src/main_m0.c **** #include <cycletimer.h>
  19:../src/main_m0.c **** #include <pixyvals.h>
  20:../src/main_m0.c **** #include "exec_m0.h"
  21:../src/main_m0.c **** #include "frame_m0.h"
  22:../src/main_m0.c **** #include "rls_m0.h"
  23:../src/main_m0.c **** 
  24:../src/main_m0.c **** //int g_foo3 = 0x12345678;
  25:../src/main_m0.c **** //int *g_foo4 = (int *)0xdeadbeef;
  26:../src/main_m0.c **** 
  27:../src/main_m0.c **** int main(void)
  28:../src/main_m0.c **** {
  32              		.loc 1 28 0
  33              		.cfi_startproc
  34 0000 80B5     		push	{r7, lr}
  35              		.cfi_def_cfa_offset 8
  36              		.cfi_offset 7, -8
  37              		.cfi_offset 14, -4
  38 0002 00AF     		add	r7, sp, #0
  39              		.cfi_def_cfa_register 7
  29:../src/main_m0.c **** 	//CTIMER_DECLARE();
  30:../src/main_m0.c **** #if 0
  31:../src/main_m0.c **** 	uint32_t memory = SRAM1_LOC;
  32:../src/main_m0.c **** 	uint32_t lut = SRAM1_LOC;
  33:../src/main_m0.c **** 
  34:../src/main_m0.c **** 	//while(1);
  35:../src/main_m0.c **** 	memset((void *)QQ_LOC, 0x01, 0x3000);
  36:../src/main_m0.c **** 	g_qqueue->writeIndex = 0;
  37:../src/main_m0.c **** 	g_qqueue->produced = 0;
  38:../src/main_m0.c **** 	g_qqueue->consumed = 0;
  39:../src/main_m0.c **** 
  40:../src/main_m0.c ****  	while(1)
  41:../src/main_m0.c ****  		getRLSFrame(&memory, &lut); 
  42:../src/main_m0.c **** #endif
  43:../src/main_m0.c **** #if 0
  44:../src/main_m0.c **** 	int i = 0x12345678;
  45:../src/main_m0.c **** 	foo(&i);
  46:../src/main_m0.c **** 	printf("%d\n", i);
  47:../src/main_m0.c **** 	while(1);
  48:../src/main_m0.c **** #endif
  49:../src/main_m0.c **** #if 0
  50:../src/main_m0.c **** 	int i;
  51:../src/main_m0.c **** 	uint32_t lut = SRAM1_LOC;
  52:../src/main_m0.c ****  	uint32_t memory = SRAM1_LOC+0x1000;
  53:../src/main_m0.c **** 	uint8_t *plut = (uint8_t *)lut;
  54:../src/main_m0.c **** 	for (i=0; i<0x4000; i++)
  55:../src/main_m0.c **** 		plut[i] = i%5==0 ? 1 : 0;
  56:../src/main_m0.c **** 	
  57:../src/main_m0.c ****  	while(1)
  58:../src/main_m0.c ****  		getRLSFrame(&memory, &lut); 
  59:../src/main_m0.c **** 
  60:../src/main_m0.c **** #endif
  61:../src/main_m0.c **** #if 1
  62:../src/main_m0.c **** 	_DBG("M0 start\n");
  40              		.loc 1 62 0
  41 0004 094B     		ldr	r3, .L3
  42 0006 0A4A     		ldr	r2, .L3+4
  43 0008 1900     		movs	r1, r3
  44 000a 1000     		movs	r0, r2
  45 000c FFF7FEFF 		bl	UARTPuts
  63:../src/main_m0.c **** #if 0
  64:../src/main_m0.c **** 	_DBH32((int)g_foo3); _DBG("\n");
  65:../src/main_m0.c **** 	_DBH32((int)g_foo4); _DBG("\n");
  66:../src/main_m0.c **** #endif
  67:../src/main_m0.c **** 	chirpOpen();
  46              		.loc 1 67 0
  47 0010 FFF7FEFF 		bl	chirpOpen
  68:../src/main_m0.c **** 	exec_init();
  48              		.loc 1 68 0
  49 0014 FFF7FEFF 		bl	exec_init
  69:../src/main_m0.c **** 	frame_init();
  50              		.loc 1 69 0
  51 0018 FFF7FEFF 		bl	frame_init
  70:../src/main_m0.c **** 	rls_init();
  52              		.loc 1 70 0
  53 001c FFF7FEFF 		bl	rls_init
  71:../src/main_m0.c **** 
  72:../src/main_m0.c **** #if 0
  73:../src/main_m0.c **** 	while(1)
  74:../src/main_m0.c **** 	{
  75:../src/main_m0.c **** 		if (g_foo)
  76:../src/main_m0.c **** 			loop0();
  77:../src/main_m0.c **** 	}
  78:../src/main_m0.c **** #endif
  79:../src/main_m0.c **** 
  80:../src/main_m0.c **** #if 0
  81:../src/main_m0.c **** 	vsync();
  82:../src/main_m0.c **** #endif
  83:../src/main_m0.c **** #if 0
  84:../src/main_m0.c **** 	//while(g_loop);
  85:../src/main_m0.c **** 	uint8_t type = CAM_GRAB_M1R2;
  86:../src/main_m0.c **** 	uint32_t memory = SRAM1_LOC;
  87:../src/main_m0.c **** 	uint16_t offset = 0;
  88:../src/main_m0.c **** 	uint16_t width = 320;
  89:../src/main_m0.c **** 	uint16_t height = 200;
  90:../src/main_m0.c **** 	while(1)
  91:../src/main_m0.c **** 	{
  92:../src/main_m0.c **** 		 getFrame(&type, &memory, &offset, &offset, &width, &height);
  93:../src/main_m0.c **** 		 i++;
  94:../src/main_m0.c **** 
  95:../src/main_m0.c **** 		 if (i%50==0)
  96:../src/main_m0.c **** 		 {
  97:../src/main_m0.c **** 			 _DBD32(i), _CR();
  98:../src/main_m0.c **** 		 }
  99:../src/main_m0.c **** 	}
 100:../src/main_m0.c **** #endif
 101:../src/main_m0.c **** 	//printf("M0 ready\n");
 102:../src/main_m0.c **** 	exec_loop();
  54              		.loc 1 102 0
  55 0020 FFF7FEFF 		bl	exec_loop
 103:../src/main_m0.c **** #endif
 104:../src/main_m0.c **** #if 0
 105:../src/main_m0.c **** 	while(1)
 106:../src/main_m0.c **** 	{
 107:../src/main_m0.c **** 		CTIMER_START();
 108:../src/main_m0.c **** 		syncM1((uint32_t *)&LPC_GPIO_PORT->PIN[1], 0x2000);
 109:../src/main_m0.c **** 		CTIMER_STOP();
 110:../src/main_m0.c **** 		
 111:../src/main_m0.c **** 		printf("%d\n", CTIMER_GET());
 112:../src/main_m0.c **** 	}	
 113:../src/main_m0.c **** #endif
 114:../src/main_m0.c **** #if 0
 115:../src/main_m0.c **** {
 116:../src/main_m0.c **** 	uint32_t i;
 117:../src/main_m0.c **** 	uint8_t *lut = (uint8_t *)SRAM1_LOC + 0x10000;
 118:../src/main_m0.c **** 	uint32_t memory = SRAM1_LOC;
 119:../src/main_m0.c **** 	uint32_t size = SRAM1_SIZE/2;
 120:../src/main_m0.c **** 	for (i=0; i<0x10000; i++)
 121:../src/main_m0.c **** 		lut[i] = 0;
 122:../src/main_m0.c **** 	lut[0xb400] = 0;
 123:../src/main_m0.c **** 	lut[0xb401] = 1;
 124:../src/main_m0.c **** 	lut[0xb402] = 1;
 125:../src/main_m0.c **** 	lut[0xb403] = 1;
 126:../src/main_m0.c **** 	lut[0xb404] = 0;
 127:../src/main_m0.c **** 	lut[0xb405] = 1;
 128:../src/main_m0.c **** 	lut[0xb406] = 1;
 129:../src/main_m0.c **** 	lut[0xb407] = 0;
 130:../src/main_m0.c **** 	lut[0xb408] = 0;
 131:../src/main_m0.c **** 	lut[0xb409] = 0;
 132:../src/main_m0.c **** 
 133:../src/main_m0.c **** 	while(1)
 134:../src/main_m0.c ****  		getRLSFrame(&memory, &size); //, (uint32_t *)&lut);
 135:../src/main_m0.c **** }
 136:../src/main_m0.c **** #endif
 137:../src/main_m0.c **** 
 138:../src/main_m0.c **** return 0;
  56              		.loc 1 138 0
  57 0024 0023     		movs	r3, #0
 139:../src/main_m0.c **** }
  58              		.loc 1 139 0
  59 0026 1800     		movs	r0, r3
  60 0028 BD46     		mov	sp, r7
  61              		@ sp needed
  62 002a 80BD     		pop	{r7, pc}
  63              	.L4:
  64              		.align	2
  65              	.L3:
  66 002c 00000000 		.word	.LC0
  67 0030 00200840 		.word	1074274304
  68              		.cfi_endproc
  69              	.LFE32:
  71              		.text
  72              	.Letext0:
  73              		.file 2 "../../common/inc/lpc43xx.h"
  74              		.file 3 "/usr/local/lpcxpresso_8.1.4_606/lpcxpresso/tools/redlib/include/stdint.h"
DEFINED SYMBOLS
                            *ABS*:00000000 main_m0.c
     /tmp/cc0abVdB.s:20     .rodata:00000000 $d
     /tmp/cc0abVdB.s:24     .text.main:00000000 $t
     /tmp/cc0abVdB.s:29     .text.main:00000000 main
     /tmp/cc0abVdB.s:66     .text.main:0000002c $d
                     .debug_frame:00000010 $d

UNDEFINED SYMBOLS
UARTPuts
chirpOpen
exec_init
frame_init
rls_init
exec_loop
