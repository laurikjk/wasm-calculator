async function init() {
    const response = await fetch("./calculator.wasm");
    const { instance } = await WebAssembly.instantiateStreaming(response);
    const { add, sub, mul } = instance.exports;

    const app = document.querySelector("#app");
    const operator = app.querySelector("select");
    const a = app.querySelector("#a");
    const b = app.querySelector("#b");
    const result = app.querySelector("#result");

    const operations = { add, sub, mul };

    const calculate = () => {
        const op = operations[operator.value];
        const x = Number(a.value);
        const y = Number(b.value);
        const res = op ? op(x, y) : 0;
        result.textContent = res;
    }

    app.querySelector("button").addEventListener("click", calculate);
}

init();
