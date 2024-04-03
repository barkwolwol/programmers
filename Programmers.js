// 문자열로 변환
// 정수 n이 주어질 때, n을 문자열로 변환하여 return하도록 solution 함수를 완성해주세요.
function solution(n) {
    var str = n;
    var answer = str + '';
    return answer;
}

const solution = String

// 공배수
// 정수 number와 n, m이 주어집니다. number가 n의 배수이면서 m의 배수이면 1을 아니라면 0을 return하도록 solution 함수를 완성해주세요.
function solution(number, n, m) {
    var answer = 0;
    
    if(number % n === 0 && number % m === 0){
        answer = 1;  
    } else {
        answer = 0;
    }
    
    return answer;
}

function solution(number, n, m) {
  return +!(number % n || number % m);
}

// 첫 번째로 나오는 음수
// 정수 리스트 num_list가 주어질 때, 첫 번째로 나오는 음수의 인덱스를 return하도록 solution 함수를 완성해주세요. 음수가 없다면 -1을 return합니다.
function solution(num_list) {
       
    for(i = 0; i < num_list.length; i++){
        if(num_list[i] < 0){
            return i;
        }
    }
    
    return -1;
}

function solution(num_list) {
    var answer = 0;
    
    for(i = 0; i < num_list.length; i++){
        if(num_list[i] < 0){
            answer = i;
            break;
        }else {
            answer = -1;
        }
    }
    
    return answer;
}

const solution = num_list => num_list.findIndex(v => v < 0)

function solution(num_list) {
    var answer = num_list.findIndex(x => x < 0);
    return answer;
}

function solution(num_list) {
    return num_list.findIndex((num) => num < 0);
}

// 문자열의 앞의 n글자
// 문자열 my_string과 정수 n이 매개변수로 주어질 때, my_string의 앞의 n글자로 이루어진 문자열을 return 하는 solution 함수를 작성해 주세요.
function solution(my_string, n) {
    return my_string.substr(0, n);
}

function solution(my_string, n) {
    return my_string.slice(0, n)
 }
 
// n보다 커질 때까지 더하기
// 정수 배열 numbers와 정수 n이 매개변수로 주어집니다. numbers의 원소를 앞에서부터 하나씩 더하다가 그 합이 n보다 커지는 순간 이때까지 더했던 원소들의 합을 return 하는 solution 함수를 작성해 주세요.

