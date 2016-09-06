################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/analogdig.cpp \
../src/button.cpp \
../src/conncomp.cpp \
../src/cr_cpp_config.cpp \
../src/cr_startup_lpc43xx.cpp \
../src/exec.cpp \
../src/i2c.cpp \
../src/main_m4.cpp \
../src/progblobs.cpp \
../src/progchase.cpp \
../src/progpt.cpp \
../src/progvideo.cpp \
../src/serial.cpp \
../src/spi.cpp \
../src/uart.cpp 

C_SRCS += \
../src/cr_start_m0.c 

OBJS += \
./src/analogdig.o \
./src/button.o \
./src/conncomp.o \
./src/cr_cpp_config.o \
./src/cr_start_m0.o \
./src/cr_startup_lpc43xx.o \
./src/exec.o \
./src/i2c.o \
./src/main_m4.o \
./src/progblobs.o \
./src/progchase.o \
./src/progpt.o \
./src/progvideo.o \
./src/serial.o \
./src/spi.o \
./src/uart.o 

CPP_DEPS += \
./src/analogdig.d \
./src/button.d \
./src/conncomp.d \
./src/cr_cpp_config.d \
./src/cr_startup_lpc43xx.d \
./src/exec.d \
./src/i2c.d \
./src/main_m4.d \
./src/progblobs.d \
./src/progchase.d \
./src/progpt.d \
./src/progvideo.d \
./src/serial.d \
./src/spi.d \
./src/uart.d 

C_DEPS += \
./src/cr_start_m0.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C++ Compiler'
	arm-none-eabi-c++ -D__MULTICORE_MASTER -DIPC_MASTER -DPIXY -D__NEWLIB__ -DNDEBUG -D__CODE_RED -DCORE_M4 -DCPP_USE_HEAP -D__LPC43XX__ -DLPC43_MULTICORE_M0APP -D__MULTICORE_MASTER_SLAVE_M0APP -I"/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/src/device/main_m4/inc" -I../../libpixy_m4/inc -I../../common/inc -I../../../common/inc -O1 -Os -g -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -fno-rtti -fno-exceptions -fsingle-precision-constant -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=softfp -mthumb -D__NEWLIB__ -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -D__NEWLIB__ -DIPC_MASTER -DPIXY -D__MULTICORE_MASTER -DNDEBUG -D__CODE_RED -DCORE_M4 -DCPP_USE_HEAP -D__LPC43XX__ -DLPC43_MULTICORE_M0APP -D__MULTICORE_MASTER_SLAVE_M0APP -I"/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/src/device/main_m4/inc" -I../../libpixy_m4/inc -I../../common/inc -I../../../common/inc -Os -g -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -fsingle-precision-constant -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=softfp -mthumb -D__NEWLIB__ -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


