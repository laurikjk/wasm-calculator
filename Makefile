main:
	clang --target=wasm32 -O3 -flto -nostdlib -Wl,--no-entry -Wl,--export-all -Wl,--lto-O3 -o calculator.wasm calculator.c

run: main
	http-server -p 8080 --cors -c-1 .

intermediate: 
	clang --target=wasm32 -emit-llvm -c -S  calculator.c
	llc -march=wasm32 -filetype=obj calculator.ll
	wasm-ld --no-entry --export-all -o calculator.wasm calculator.o

wasm2wat: main
	wasm2wat calculator.wasm -o calculator.wat

clean:
	rm -f *.wasm *.o *.ll

