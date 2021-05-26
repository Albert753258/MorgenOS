all:
	yasm -f bin -o MorgenOS.bin MorgenOS.asm
	dd if=/dev/zero of=MorgenOS.img bs=1024 count=1440
	dd if=MorgenOS.bin of=MorgenOS.img conv=notrunc
clean:
	rm MorgenOS.img MorgenOS.bin
