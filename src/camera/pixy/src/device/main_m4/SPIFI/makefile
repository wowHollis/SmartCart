################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(CC_DEPS)),)
-include $(CC_DEPS)
endif
ifneq ($(strip $(C++_DEPS)),)
-include $(C++_DEPS)
endif
ifneq ($(strip $(C_UPPER_DEPS)),)
-include $(C_UPPER_DEPS)
endif
ifneq ($(strip $(CXX_DEPS)),)
-include $(CXX_DEPS)
endif
ifneq ($(strip $(CPP_DEPS)),)
-include $(CPP_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: main_m4.axf

# Tool invocations
main_m4.axf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: MCU C++ Linker'
	arm-none-eabi-c++ -nostdlib -L"/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/src/device/main_m4/src" -L"/home/weyoui/PROJECTS/SmartCart/Pixy/pixy/src/device/libpixy_m4/Release" -Xlinker -Map="main_m4.map" -Xlinker --gc-sections -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=softfp -mthumb -T "SPIFI_link_template.ld" -L ../linkscripts -o "main_m4.axf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '
	$(MAKE) --no-print-directory post-build

# Other Targets
clean:
	-$(RM) $(CC_DEPS)$(C++_DEPS)$(EXECUTABLES)$(C_UPPER_DEPS)$(CXX_DEPS)$(OBJS)$(CPP_DEPS)$(C_DEPS) main_m4.axf
	-@echo ' '

post-build:
	-@echo 'Performing post-build steps'
	-arm-none-eabi-size "main_m4.axf" ; arm-none-eabi-objcopy -v -O binary "main_m4.axf" "main_m4.bin" ; checksum -p LPC4330 -d "main_m4.bin" ; arm-none-eabi-objcopy -v -O ihex "main_m4.axf" pixy_firmware.hex
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY: post-build

-include ../makefile.targets
