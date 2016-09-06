################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/camera.cpp \
../src/chirp.cpp \
../src/led.cpp \
../src/misc.cpp \
../src/param.cpp \
../src/pixy_init.cpp \
../src/power.cpp \
../src/rcservo.cpp \
../src/sccb.cpp \
../src/smlink.cpp \
../src/usblink.cpp 

C_SRCS += \
../src/crp.c \
../src/debug_frmwrk.c \
../src/fpu_init.c \
../src/ipc_mbx.c \
../src/lpc43xx_adc.c \
../src/lpc43xx_cgu.c \
../src/lpc43xx_scu.c \
../src/lpc43xx_ssp.c \
../src/lpc43xx_uart.c \
../src/platform_config.c \
../src/usbcore.c \
../src/usbdesc.c \
../src/usbhw.c \
../src/usbuser.c 

OBJS += \
./src/camera.o \
./src/chirp.o \
./src/crp.o \
./src/debug_frmwrk.o \
./src/fpu_init.o \
./src/ipc_mbx.o \
./src/led.o \
./src/lpc43xx_adc.o \
./src/lpc43xx_cgu.o \
./src/lpc43xx_scu.o \
./src/lpc43xx_ssp.o \
./src/lpc43xx_uart.o \
./src/misc.o \
./src/param.o \
./src/pixy_init.o \
./src/platform_config.o \
./src/power.o \
./src/rcservo.o \
./src/sccb.o \
./src/smlink.o \
./src/usbcore.o \
./src/usbdesc.o \
./src/usbhw.o \
./src/usblink.o \
./src/usbuser.o 

CPP_DEPS += \
./src/camera.d \
./src/chirp.d \
./src/led.d \
./src/misc.d \
./src/param.d \
./src/pixy_init.d \
./src/power.d \
./src/rcservo.d \
./src/sccb.d \
./src/smlink.d \
./src/usblink.d 

C_DEPS += \
./src/crp.d \
./src/debug_frmwrk.d \
./src/fpu_init.d \
./src/ipc_mbx.d \
./src/lpc43xx_adc.d \
./src/lpc43xx_cgu.d \
./src/lpc43xx_scu.d \
./src/lpc43xx_ssp.d \
./src/lpc43xx_uart.d \
./src/platform_config.d \
./src/usbcore.d \
./src/usbdesc.d \
./src/usbhw.d \
./src/usbuser.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C++ Compiler'
	arm-none-eabi-c++ -D__MULTICORE_NONE -DIPC_MASTER -DPIXY -D__NEWLIB__ -DNDEBUG -D__CODE_RED -DCORE_M4 -D__LPC43XX__ -I"/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/misc/gcc/pixy_m4/inc" -Os -Os -g -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -fno-rtti -fno-exceptions -fsingle-precision-constant -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=softfp -mthumb -D__NEWLIB__ -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -D__NEWLIB__ -DIPC_MASTER -DPIXY -D__MULTICORE_NONE -DNDEBUG -D__CODE_RED -DCORE_M4 -D__LPC43XX__ -I"/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/misc/gcc/pixy_m4/inc" -Os -g -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -fsingle-precision-constant -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=softfp -mthumb -D__NEWLIB__ -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


