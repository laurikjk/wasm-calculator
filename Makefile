main:
	clang --target=wasm32 -nostdlib -Wl,--no-entry -Wl,--export-all -o calculator.wasm calculator.c

run: main
	http-server -p 8080 --cors -c-1 .

intermediate: 
	clang --target=wasm32 -emit-llvm -c -S  calculator.c
	llc -march=wasm32 -filetype=obj calculator.ll
	wasm-ld --no-entry --export-all -o calculator.wasm calculator.o

clean:
	rm -f *.wasm *.o *.ll

