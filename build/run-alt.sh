dtc test.dts > test.dtb
rm nuttx.bin
dd if=/home/jimm/apps/nuttx/nuttx/nuttx.bin of=nuttx.bin obs=64k seek=$((0x28)) conv=notrunc
dd if=test.dtb of=nuttx.bin conv=notrunc

qemu-system-aarch64 -machine virt,virtualization=on,gic-version=2   -cpu cortex-a72 -smp 4   -m 4G   -nographic -net none   -chardev stdio,id=con,mux=on -serial chardev:con -mon chardev=con,mode=readline   -kernel ./kernel.elf   -drive file=./nuttx.bin,format=raw,id=drive0,if=none   -device virtio-blk-device,drive=drive0,bus=virtio-mmio-bus.0


