// java Series.java


public class Series {

    public static void main (String [] args) {
        System.out.println(String.format("%d",series(10)));
//        System.out.println(String.format("%d",series(100000))); // java.lang.StackOverflowError
    }

    private static long series(long x) {
		if (x==0)
			return 0;
		else
			return x + series(x-1);
    }

}
