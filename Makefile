# 아키텍쳐 정의
MCPU = cortex-a53	

# 컴파일러 변수 추가.
CC = /opt/ArmCompilerforEmbeddedFuSa6.16.2/bin/armclang
AS = /opt/ArmCompilerforEmbeddedFuSa6.16.2/bin/armasm
LD = ld.lld
OC = llvm-objcopy
OD = llvm-objdump

# 입력 파일 이름 정의.
LD_FILE = linker.ld

# 출력 파일 이름 정의.
output = build
MAP_FILE = build/a53_qemu.map
ASM_FILE = build/a53_qemu.asm
a53_qemu = build/a53_qemu.elf

# 컴파일 옵션 정의.
CFLAGS = -target=aarch64-arm-none-eabi -mcpu=cortex-a53 -c -g -O0 -Wall -ffreestanding

# 링커 옵션 선언.
LDFLAGS = -nostdlib -z noexecstack --format=elf -o

# 컴파일 목록들 정의.
C_SRCS = $(wildcard *.c)
C_OBJS = $(patsubst %.c, build/%.o, $(C_SRCS))

ASM_SRCS = $(wildcard *.S)
ASM_OBJS = $(patsubst %.S, build/%.o, $(ASM_SRCS))

# 컴파일 경로 정의
# INC_DIRS = 

# Makefile의 검색 경로 설정
# VPATH = 

# Makefile 타겟 정의
.PHONY: all clean

# build
all: $(a53_qemu)

# build 폴더 삭제
clean:
	@rm -fr build

# object파일 링크
$(a53_qemu): $(C_OBJS) $(ASM_OBJS)
	$(LD) -T $(LD_FILE) $(LDFLAGS) $(a53_qemu) $(C_OBJS) $(ASM_OBJS)
	$(OD) -d $(a53_qemu) >> $(ASM_FILE)
	rm $(output)/*.o

# s파일 컴파일
$(output)/%.o: %.S
	mkdir -p $(shell dirname $@)
	$(CC) $(CFLAGS) -o $@ $<

# c파일 컴파일
$(output)/%.o: %.c
	mkdir -p $(shell dirname $@)
	$(CC) $(CFLAGS) -o $@ $<