################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/chirp.c \
../src/debug.c \
../src/debug_frmwrk.c \
../src/exec_m0.c \
../src/frame_m0.c \
../src/ipc_mbx.c \
../src/lpc43xx_adc.c \
../src/lpc43xx_cgu.c \
../src/lpc43xx_i2c.c \
../src/lpc43xx_scu.c \
../src/lpc43xx_ssp.c \
../src/lpc43xx_uart.c \
../src/qqueue.c \
../src/rls_m0.c \
../src/smlink.c \
../src/system_LPC43xx.c 

OBJS += \
./src/chirp.o \
./src/debug.o \
./src/debug_frmwrk.o \
./src/exec_m0.o \
./src/frame_m0.o \
./src/ipc_mbx.o \
./src/lpc43xx_adc.o \
./src/lpc43xx_cgu.o \
./src/lpc43xx_i2c.o \
./src/lpc43xx_scu.o \
./src/lpc43xx_ssp.o \
./src/lpc43xx_uart.o \
./src/qqueue.o \
./src/rls_m0.o \
./src/smlink.o \
./src/system_LPC43xx.o 

C_DEPS += \
./src/chirp.d \
./src/debug.d \
./src/debug_frmwrk.d \
./src/exec_m0.d \
./src/frame_m0.d \
./src/ipc_mbx.d \
./src/lpc43xx_adc.d \
./src/lpc43xx_cgu.d \
./src/lpc43xx_i2c.d \
./src/lpc43xx_scu.d \
./src/lpc43xx_ssp.d \
./src/lpc43xx_uart.d \
./src/qqueue.d \
./src/rls_m0.d \
./src/smlink.d \
./src/system_LPC43xx.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -DIPC_SLAVE -DPIXY -D__REDLIB__ -D__MULTICORE_NONE -DNDEBUG -D__CODE_RED -DCORE_M0 -DCR_PRINTF_CHAR -D__LPC43XX__ -I"/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/src/device/libpixy_m0/inc" -I../../common/inc -I../../../common/inc -O0 -g -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -mcpu=cortex-m0 -mthumb -D__REDLIB__ -specs=redlib.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


