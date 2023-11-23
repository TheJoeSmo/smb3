# Assumed to be used on Ubuntu with wine for asm6.exe compatibility.

all: smb3.nes

smb3.nes: smb3.asm config.asm PRG/* CHR/* PRG/core/* PRG/enemies/* PRG/levels/* PRG/maps/* PRG/objects/* PRG/levels/custom/*
	wine asm6.exe smb3.asm
	mv smb3.bin smb3.nes

clean:
	rm smb3.nes 
