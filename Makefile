main:
	clang --target=wasm32 -emit-llvm -c -S  calculator.c