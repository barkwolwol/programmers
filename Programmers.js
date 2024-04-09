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
function solution(numbers, n) {
    var answer = 0;
    
    for(i = 0; i < numbers.length; i++){
        if(answer <= n){
            answer += numbers[i];
        }
    }
    
    return answer;
}

function solution(numbers, n) {
    return numbers.reduce((a,c,i,t)=>(a<=n)?a+c:a)
}

function solution(numbers, n) {
    let sum = 0;
  
      for(let i = 0; i<numbers.length; i++) {
        sum += numbers[i]
        if(sum > n) break;
      }
      return sum;
  }

// 5명씩
// 최대 5명씩 탑승가능한 놀이기구를 타기 위해 줄을 서있는 사람들의 이름이 담긴 문자열 리스트 names가 주어질 때, 앞에서 부터 5명씩 묶은 그룹의 가장 앞에 서있는 사람들의 이름을 담은 리스트를 return하도록 solution 함수를 완성해주세요. 마지막 그룹이 5명이 되지 않더라도 가장 앞에 있는 사람의 이름을 포함합니다.
function solution(names) {
    return names.filter((_, i) => i % 5 === 0);
}

function solution(names) {
    var answer = [];
    
    for(i = 0; i < names.length; i += 5){
        answer.push(names[i])
    }
    
    return answer;
}

function solution(names) {
    var answer = [];
    
    for(i = 0; i < names.length; i++){
        if(i % 5 === 0){
            answer.push(names[i])    
        }
    }
    
    return answer;
}

// 정수 찾기
// 정수 리스트 num_list와 찾으려는 정수 n이 주어질 때, num_list안에 n이 있으면 1을 없으면 0을 return하도록 solution 함수를 완성해주세요.
function solution(num_list, n) {
    var answer = 0;
    
    for(i = 0; i < num_list.length; i++) {
        if(num_list[i] === n) {
            answer = 1;
        }
    }
    
    return answer;
}

function solution(num_list, n) {
  return num_list.includes(n) ? 1 : 0;
}