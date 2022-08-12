
public class FFor {

    public static void main (String [] args) {
        ffor(0);
    }

    private static void ffor(int x) {
        for (;;) {
            System.out.println(String.format("x: %d",x));
            x++;
        }
    }

}
