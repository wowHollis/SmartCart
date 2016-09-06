################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/chirp.c \
../src/debug.c \
../src/debug_frmwrk.c \
../src/ipc_mbx.c \
../src/lpc43xx_uart.c \
../src/smlink.c 

OBJS += \
./src/chirp.o \
./src/debug.o \
./src/debug_frmwrk.o \
./src/ipc_mbx.o \
./src/lpc43xx_uart.o \
./src/smlink.o 

C_DEPS += \
./src/chirp.d \
./src/debug.d \
./src/debug_frmwrk.d \
./src/ipc_mbx.d \
./src/lpc43xx_uart.d \
./src/smlink.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -DIPC_SLAVE -DPIXY -D__REDLIB__ -D__MULTICORE_NONE -DNDEBUG -D__CODE_RED -DCORE_M0 -DCR_PRINTF_CHAR -D__LPC43XX__ -I"/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/misc/gcc/pixy_m0/inc" -O0 -g -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -mcpu=cortex-m0 -mthumb -specs=redlib.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


