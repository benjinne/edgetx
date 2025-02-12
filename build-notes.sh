https://github.com/EdgeTX/edgetx/wiki/Build-Instructions-using-docker-and-Windows-10
sudo docker run --name="ETXDocker" -it --rm --mount src="$(pwd)",target="$(pwd)",type=bind -w "$(pwd)" ghcr.io/edgetx/edgetx-dev bash
mkdir -p build-output
cd build-output


cmake -DPCB=X7 -DPCBREV=ZORRO -DDEFAULT_MODE=2 -DGVARS=YES -DDEBUG_SEGGER_RTT=y and -DDEBUG=n -DCMAKE_BUILD_TYPE=Debug ../
make arm-none-eabi-configure
make -j`nproc` firmware


st-flash write ../firmware.bin 0x08000000

openocd -f /usr/share/openocd/scripts/interface/stlink-v2.cfg -f /usr/share/openocd/scripts/target/stm32f4x.cfg

arm-none-eabi-gdb arm-none-eabi/firmware.elf
target extended-remote localhost:3333

FLASH WITH OZONE!!!!