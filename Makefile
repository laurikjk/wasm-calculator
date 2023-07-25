main: 
	clang --target=wasm32 -emit-llvm -c -S  calculator.c
	llc -march=wasm32 -filetype=obj calculator.ll
	wasm-ld --no-entry --export-all -o calculator.wasm calculator.o

	
