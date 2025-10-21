import java.util.Scanner;

public class Sieve {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int num = 0;

        // prompt for input and validate
        while (num < 1 || num > 100) {
            System.out.println("Enter a number between 1 and 100:");
            if (sc.hasNextInt()) {
                num = sc.nextInt();
                if (num < 1 || num > 100) {
                    System.out.println("Number needs to be between 1 and 100.");
                }
            } else {
                System.out.println("Number needs to be an integer.");
                sc.next(); 
            }
        }

        // initialize the sieve array
        boolean[] bool = new boolean[num + 1];
        for (int i = 2; i <= num; i++) {
            bool[i] = true;
        }

        // perform the Sieve of Eratosthenes algorithm
        for (int p = 2; p * p <= num; p++) { // loop through numbers up to the square root of 'num'
            if (bool[p]) { // only mark false if 'p' is still true 
                for (int i = p * p; i <= num; i += p) { // Mark all multiples of 'p' starting from p^2 as false
                    bool[i] = false; // Mark 'i' as not prime
                }
            }
        }

        // print prime numbers
        System.out.println("List of prime numbers up to " + num + ":");
        int count = 0;
        for (int i = 2; i <= num; i++) {
            if (bool[i]) {
                System.out.print(i + " ");
                count++;
                if (count % 10 == 0) {
                    System.out.println();
                }
            }
        }
        System.out.println();

        sc.close();
    }
}