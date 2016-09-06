################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/cr_startup_lpc43xx-m0app.c \
../src/exec_m0.c \
../src/frame_m0.c \
../src/main_m0.c \
../src/qqueue.c \
../src/rls_m0.c 

OBJS += \
./src/cr_startup_lpc43xx-m0app.o \
./src/exec_m0.o \
./src/frame_m0.o \
./src/main_m0.o \
./src/qqueue.o \
./src/rls_m0.o 

C_DEPS += \
./src/cr_startup_lpc43xx-m0app.d \
./src/exec_m0.d \
./src/frame_m0.d \
./src/main_m0.d \
./src/qqueue.d \
./src/rls_m0.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -DIPC_SLAVE -DPIXY -D__REDLIB__ -D__MULTICORE_M0APP -DNDEBUG -D__CODE_RED -DCORE_M0 -D__LPC43XX__ -DCORE_M0APP -I"/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/misc/gcc/m0/inc" -I"/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/misc/gcc/pixy_m0/inc" -O0 -g -Wall -Wa,-ahlnds=$(basename $(notdir $@)).asm -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -mcpu=cortex-m0 -mthumb -D__REDLIB__ -specs=redlib.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


