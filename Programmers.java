import java.util.ArrayList;
import java.util.List;

// 콜라츠 수열 만들기
class Solution {
    public int[] solution(int n) {
        List<Integer> list = new ArrayList<>();
        list.add(n);
        
        while(n != 1){
            if(n % 2 == 0) { // 짝수
                n = n / 2;
            } else { // 홀수
                n = 3 * n + 1;
            }
            // n = (n % 2 == 0) ? n / 2 : 3 * n + 1; // 삼항연산자
            list.add(n);
        }
        
        int[] answer =  new int[list.size()];
        for(int i = 0; i < list.size(); i++) {
            answer[i] = list.get(i);
        }
        
        return answer;
    }
}


// 배열 만들기 4
import java.util.ArrayList;
import java.util.List;
class Solution {
    public int[] solution(int[] arr) {
        List<Integer> stk = new ArrayList<>();
        for(int i = 0; i < arr.length;){
            if(stk.size() == 0){
                stk.add(arr[i]); i++;
            } else if(stk.size() != 0 && stk.get(stk.size() - 1) < arr[i]){
                stk.add(arr[i]); i++;
            } else {
                stk.remove(stk.size() - 1);
            }
        }
        return stk.stream().mapToInt(i -> i).toArray();
    }
}


// 간단한 논리 연산
class Solution {
    public boolean solution(boolean x1, boolean x2, boolean x3, boolean x4) {
        boolean answer = true;
        answer = (x1 || x2) && (x3 || x4);
        return answer;
    }
}


// 글자 이어 붙여 문자열 만들기
class Solution {
    public String solution(String my_string, int[] index_list) {
        StringBuilder answer = new StringBuilder();
        
        for(int i = 0; i < index_list.length; i++) {
            int index = index_list[i];
            answer.append(my_string.charAt(index));
        }
                
        return answer.toString();
    }
}


// 글자 이어 붙여 문자열 만들기
class Solution {
    public String solution(String my_string, int[] index_list) {
        String answer = "";
        
        for(int i = 0; i < index_list.length; i++) {
            answer += my_string.charAt(index_list[i]);
        }
        
        return answer;
    }
}


// 9로 나눈 나머지
class Solution {
    public int solution(String number) {
        int answer = 0;
        
        for(int i = 0; i < number.length(); i++) {
            answer += number.charAt(i) - '0';
        }
        
        return answer % 9;
    }
}


// 9로 나눈 나머지
class Solution {
    public int solution(String number) {
        int answer = 0;
        
        for(char i : number.toCharArray()) {
            int sum = Integer.parseInt(String.valueOf(i));
            answer += sum;
        }
        
        return (answer % 9);
    }
}


// 문자열 여러 번 뒤집기
class Solution {
    public String solution(String my_string, int[][] queries) {
        String answer = "";
        char[] charArr = my_string.toCharArray();
        
        for(int i = 0; i < queries.length; i++) {
            int start =  queries[i][0];
            int end = queries[i][1];
            
            for (int j = start; j <= (start + end)/2; j++) {
                char temp = charArr[start];
                charArr[start] = charArr[end];
                charArr[end] = temp;
                start++;
                end--;
            }
        }
        
        return new String(charArr);
    }
}


// 문자열 여러 번 뒤집기
class Solution {
    public String solution(String my_string, int[][] queries) {
        String answer = "";
        char[] charArr = my_string.toCharArray();
        
        for(int i = 0; i < queries.length; i++) {
            int start =  queries[i][0];
            int end = queries[i][1];
            
            while (start < end) {
                char temp = charArr[start];
                charArr[start] = charArr[end];
                charArr[end] = temp;
                start++;
                end--;
            }
        }
        
        return new String(charArr);
    }
}


// 문자열 여러 번 뒤집기
class Solution {
    public String solution(String my_string, int[][] queries) {
        char[] charArray = my_string.toCharArray(); // 문자열을 문자 배열로 변환
        
        for (int[] query : queries) {
            int start = query[0];
            int end = query[1];
            
            // start부터 end까지의 부분 문자열을 뒤집는 작업
            while (start < end) {
                char temp = charArray[start];
                charArray[start] = charArray[end];
                charArray[end] = temp;
                start++;
                end--;
            }
        }
        
        // 문자 배열을 다시 문자열로 변환
        return new String(charArray);
    }
}


// 배열 만들기 5
class Solution {
    public int[] solution(String[] intStrs, int k, int s, int l) {
        List<Integer> resultList = new ArrayList<>();

        for (String str : intStrs) {
            if (str.length() >= s + l) {
                String substring = str.substring(s, s + l);
                int num = Integer.parseInt(substring);
                if (num > k) {
                    resultList.add(num);
                }
            }
        }

        int[] answer = new int[resultList.size()];
        for (int i = 0; i < resultList.size(); i++) {
            answer[i] = resultList.get(i);
        }
        
        return answer;
    }
}


// 배열 만들기 5
class Solution {
    public int[] solution(String[] intStrs, int k, int s, int l) {
        List<Integer> result = new ArrayList<>();
        
        for (String str : intStrs) {
            int i = Integer.parseInt(str.substring(s, s + l));
            if (i > k) {
                result.add(i);
            }
        }
        
        return result.stream().mapToInt(i->i).toArray();
    }
}


// 배열 만들기 5
class Solution {
    public int[] solution(String[] intStrs, int k, int s, int l) {
        List<Integer> list = new ArrayList<>();

        for(String str : intStrs) {
            int num = Integer.parseInt(str.substring(s, s + l));
            if(num > k) {
                list.add(num);
            }
        }
        
        int[] answer = new int[list.size()];
        
        for (int i = 0; i < list.size(); i++) {
            answer[i] = list.get(i);
        }
        
        return answer;
    }
}


// 배열 만들기 5
class Solution {
    public int[] solution(String[] intStrs, int k, int s, int l) {
        return Arrays.stream(intStrs).mapToInt(value -> Integer.parseInt(value.substring(s, s + l))).filter(value -> value > k).toArray();
    }
}