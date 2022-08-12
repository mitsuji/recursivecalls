
public class FRec {

    public static void main (String [] args) {
        frec(0);
    }

	// java.lang.StackOverflowError
    private static void frec(int x) {
        System.out.println(String.format("x: %d",x));
        frec(x+1);
    }

}
