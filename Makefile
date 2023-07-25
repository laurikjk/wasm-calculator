CC=clang
CCFLAGS=--target=wasm32 -O3 -flto -nostdlib
WASM_LDFLAGS=-Wl,--no-entry -Wl,--export-all -Wl,--lto-O3
OUTFILE=calculator.wasm
SOURCE=calculator.c

SERVER=http-server
SERVERFLAGS=-p 8080 --cors -c-1

LLC=llc
LLCFLAGS=-march=wasm32 -filetype=obj

WASM_LD=wasm-ld
WASM_LD_FLAGS=--no-entry --export-all

WASM2WAT=wasm2wat
WASM2WATFLAGS=-o calculator.wat

CLEAN=rm -f

.PHONY: main run intermediate wasm2wat clean

main:
	$(CC) $(CCFLAGS) $(WASM_LDFLAGS) -o $(OUTFILE) $(SOURCE)

run: main
	$(SERVER) $(SERVERFLAGS) .

intermediate: 
	$(CC) --target=wasm32 -emit-llvm -c -S  $(SOURCE)
	$(LLC) $(LLCFLAGS) calculator.ll
	$(WASM_LD) $(WASM_LD_FLAGS) -o $(OUTFILE) calculator.o

wasm2wat: main
	$(WASM2WAT) $(OUTFILE) $(WASM2WATFLAGS)

clean:
	$(CLEAN) *.wasm *.o *.ll
