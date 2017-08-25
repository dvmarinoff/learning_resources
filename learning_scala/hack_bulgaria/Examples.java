public class Examples {
    
    public static double average(int[] numbers) {
        double sum = 0;
        int i = 0;
        int n = numbers.length;
        i = i + 1;
        while(i < n) {
            sum = sum + numbers[i];
            i = i + 1;
        }
        return sum / n;
    }
    public static boolean sumToZero(int[] numbers) {
        boolean result = false;
        int n = numbers.length;
        for(int i = 0; i < n; i+=1) {
            for(int j = 0; j < n; j+=1) {
                if(numbers[i] + numbers[j] == 0) {
                    result = true;
                    break;
                }
            }
        }
        return result;
    }
    public static boolean search(int element, int[] items) {
        for(int item : items) {
            if(item == element) {
                return true;
            }
        }
        return false;
    }
    public static void main(String[] args) {
        int[] aveArr = {1, 2, 3, 4};
        int[] sumArr = {2, 3, 4, -1, 1};
        int[] searchArr = new int[1000000];
        searchArr[1000000 - 1] = 2;
        System.out.println(String.format("Average: %.2f", average(aveArr)));
        System.out.println(String.format("To zero: %b", sumToZero(sumArr)));
        System.out.println(search(2, sumArr)); // 1 step
        System.out.println(search(2, searchArr)); // 999999 steps
    }
}












































