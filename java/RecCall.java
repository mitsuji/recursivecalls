
public class RecCall {

    public static void main (String [] args) {
        ffor(0);
//        frec(0);
    }

    private static void ffor(int x) {
        for (;;) {
            System.out.println(String.format("x: %d",x));
            x ++;
        }
    }
    
    private static void frec(int x) {
        System.out.println(String.format("x: %d",x));
        frec(x+1);
    }
    
}
