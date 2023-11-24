-- **String, Date**


-- 자동차 대여 기록에서 장기/단기 대여 구분하기 (LEVEL 1)
SELECT HISTORY_ID, CAR_ID, 
TO_CHAR(START_DATE, 'YYYY-MM-DD') AS START_DATE, 
TO_CHAR(END_DATE, 'YYYY-MM-DD') AS END_DATE, 
CASE WHEN (END_DATE - START_DATE) + 1 >= 30 THEN '장기 대여' 
ELSE '단기 대여' END AS RENT_TYPE
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE EXTRACT(MONTH FROM START_DATE) = 9
ORDER BY 1 DESC;

/*
GPT
두 번째 쿼리에서 (END_DATE - START_DATE) + 1을 사용한 이유는 대여 기간을 계산할 때, 시작일과 종료일을 모두 포함하는 것이기 때문입니다.
보통 날짜 간의 차이를 계산할 때, 종료일을 포함하지 않고 계산하는 경우가 많습니다. 
예를 들어, 2022-09-01부터 2022-09-30까지의 차이를 계산하면 29일이 나올 것입니다. 
그러나 대여 기간은 시작일과 종료일을 모두 포함해야 하므로, 30일을 원한다면 (END_DATE - START_DATE) + 1을 사용하여 1을 더해줍니다.
즉, 대여 시작일과 종료일이 같은 경우에도 1일을 대여한 것으로 처리하기 위해서입니다. 이렇게 하면 정확한 대여 기간을 구할 수 있습니다.
*/


-- 특정 옵션이 포함된 자동차 리스트 구하기 (LEVEL 1)
SELECT *
FROM CAR_RENTAL_COMPANY_CAR
WHERE OPTIONS LIKE '%네비게이션%'
ORDER BY CAR_ID DESC;


-- 조건에 부합하는 중고거래 상태 조회하기 (LEVEL 2)
SELECT BOARD_ID, WRITER_ID, TITLE, PRICE, 
DECODE(STATUS, 'SALE', '판매중', 'RESERVED', '예약중', '거래완료') AS STATUS
FROM USED_GOODS_BOARD
WHERE TO_CHAR(CREATED_DATE, 'YYYY-MM-DD') = '2022-10-05'
ORDER BY 1 DESC;

SELECT BOARD_ID, WRITER_ID, TITLE, PRICE, 
CASE WHEN STATUS = 'SALE' THEN '판매중'
WHEN STATUS = 'RESERVED' THEN '예약중'
ELSE '거래완료' END AS STATUS
FROM USED_GOODS_BOARD
WHERE TO_CHAR(CREATED_DATE, 'YYYY-MM-DD') = '2022-10-05'
ORDER BY 1 DESC;


-- 자동차 평균 대여 기간 구하기 (LEVEL 2)
SELECT CAR_ID,
ROUND(AVG(END_DATE - START_DATE + 1), 1) AS AVERAGE_DURATION
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY CAR_ID
HAVING AVG(END_DATE - START_DATE + 1) >= 7
ORDER BY 2 DESC, 1 DESC;


-- 루시와 엘라 찾기 (LEVEL 2)
SELECT ANIMAL_ID, NAME, SEX_UPON_INTAKE
FROM ANIMAL_INS
WHERE NAME IN ('Lucy', 'Ella', 'Pickle', 'Rogan', 'Sabrina', 'Mitty')
-- WHERE REGEXP_LIKE(NAME, '^(Lucy|Ella|Pickle|Rogan|Sabrina|Mitty)$') -- 정규표현식
ORDER BY 1;


-- 이름에 el이 들어가는 동물 찾기 (LEVEL 2)
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE ANIMAL_TYPE = 'Dog' 
AND (NAME LIKE '%el%' OR NAME LIKE '%EL%' OR NAME LIKE '%El%' OR NAME LIKE '%eL%')
-- AND LOWER(NAME) LIKE '%el%'
-- AND UPPER(NAME) LIKE '%EL%'
-- AND REGEXP_LIKE (NAME,'El','i')
ORDER BY 2;


-- 중성화 여부 파악하기 (LEVEL 2)
SELECT ANIMAL_ID, NAME, 
CASE WHEN SEX_UPON_INTAKE LIKE 'Neutered%' THEN 'O' 
WHEN SEX_UPON_INTAKE LIKE 'Spayed%' THEN 'O'
-- CASE WHEN SEX_UPON_INTAKE LIKE '%Neutered%' OR SEX_UPON_INTAKE LIKE '%Spayed%' THEN 'O'
-- CASE WHEN REGEXP_LIKE(SEX_UPON_INTAKE,'^Neutered|^Spayed') THEN 'O'
-- CASE WHEN SEX_UPON_INTAKE IN ('Spayed Female','Neutered Male') THEN 'O' 
ELSE 'X' END AS 중성화
FROM ANIMAL_INS
ORDER BY 1;
-- CASE WHEN INSTR(SEX_UPON_INTAKE, 'Intact') > 0 THEN 'X'
-- ELSE 'O' END AS 중성화
FROM ANIMAL_INS
ORDER BY 1;


-- 카테고리 별 상품 개수 구하기 (LEVEL 2)
SELECT SUBSTR(PRODUCT_CODE, 1, 2) AS CATEGORY, COUNT(PRODUCT_ID) AS PRODUCTS
FROM PRODUCT
GROUP BY SUBSTR(PRODUCT_CODE, 1, 2)
ORDER BY 1;


-- DATETIME에서 DATE로 형 변환 (LEVEL 2)
SELECT ANIMAL_ID, NAME, TO_CHAR(DATETIME, 'YYYY-MM-DD') AS 날짜
FROM ANIMAL_INS
ORDER BY 1;


-- 대여 기록이 존재하는 자동차 리스트 구하기 (LEVEL 3)
SELECT DISTINCT CAR_ID
FROM CAR_RENTAL_COMPANY_CAR
JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY USING (CAR_ID)
WHERE CAR_TYPE = '세단' AND TO_CHAR(START_DATE, 'MM') = '10'
-- WHERE CAR_TYPE = '세단' AND EXTRACT (MONTH FROM START_DATE) = 10
ORDER BY 1 DESC;


