import java.util.function.BiFunction;


public class RecCall {

    public static void main (String [] args) {
//        System.out.println(String.format("%d",series1(10000)));
//        System.out.println(String.format("%d",series2(10000,0)));
//        ffor(0);
//        frec(0);
    }

	// java.lang.StackOverflowError
    private static long series1(long x) {
		if (x==0)
			return 0;
		else
			return x + series1(x-1);
    }

	// java.lang.StackOverflowError
	// ラムダ式も試したけど再帰はできなかった
    private static long series2(long x, long acc) {
		if (x==0)
			return acc;
		else
			return series2(x-1, acc+x);
    }


    private static void ffor(int x) {
        for (;;) {
            System.out.println(String.format("x: %d",x));
            x++;
        }
    }

    private static void frec(int x) {
        System.out.println(String.format("x: %d",x));
        frec(x+1);
    }

}
