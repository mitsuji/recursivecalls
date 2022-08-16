
function frec (x) {
    console.log("x: ", x);
    frec (x+1);
}

frec(0);
