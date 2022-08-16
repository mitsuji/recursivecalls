
function series(x) {
	if (x==0)
		return 0;
	else
		return x + series(x-1);
}

console.log(series(10));
//console.log(series(100000));
