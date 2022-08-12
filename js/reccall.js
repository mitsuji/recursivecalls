// https://jsstudy.hatenablog.com/entry/tail-call-optimisation-of-JavaScript-ES2015#:~:text=%E6%9C%AB%E5%B0%BE%E5%86%8D%E5%B8%B0%EF%BC%88%E3%81%BE%E3%81%A4%E3%81%B3%E3%81%95%E3%81%84%E3%81%8D,%E5%91%BC%E3%81%B3%E5%87%BA%E3%81%97%20%EF%BC%88Tail%20call%EF%BC%89%E3%81%A8%E3%81%84%E3%81%86%E3%80%82

function ffor (x) {
    for (;;) {
        console.log("x: ",x);
        x ++;
    }
}

function frec1 (x) {
    console.log("x: ", x);
    frec1 (x+1);
}

function frec2 (x) {
    let loop = function (x) {
        console.log("x: ", x);
        loop(x+1);
    }
    loop(x);
}

ffor(0);
//frec1(0);
//frec2(0);
//window.onload = function (e) {
////    frec1(0);
////    frec2(0);
//}
