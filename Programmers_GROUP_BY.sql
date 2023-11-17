-- **GROUP BY**


-- 동명 동물 수 찾기 (LEVEL 2)
SELECT NAME, COUNT(NAME) AS "COUNT"
FROM ANIMAL_INS
WHERE NAME IS NOT NULL
GROUP BY NAME
HAVING COUNT(NAME) > 1
ORDER BY 1;


-- 고양이와 개는 몇 마리 있을까 (LEVEL 2)
SELECT ANIMAL_TYPE, COUNT(ANIMAL_TYPE) AS "COUNT"
FROM ANIMAL_INS
GROUP BY ANIMAL_TYPE
ORDER BY 1;


-- 고양이와 개는 몇 마리 있을까 (LEVEL 2)
SELECT ANIMAL_TYPE, COUNT(ANIMAL_TYPE) AS "COUNT"
FROM ANIMAL_INS
WHERE REGEXP_LIKE(ANIMAL_TYPE, 'Cat|Dog')
GROUP BY ANIMAL_TYPE
ORDER BY 1;


-- 진료과별 총 예약 횟수 출력하기 (LEVEL 2)
SELECT MCDP_CD AS "진료과코드", COUNT(MCDP_CD) AS "5월예약건수"
FROM APPOINTMENT
WHERE TO_CHAR(APNT_YMD, 'MM') = '05'
GROUP BY MCDP_CD
ORDER BY 2, 1;


-- 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기 (LEVEL 2)
SELECT CAR_TYPE, COUNT(*) AS "CARS"
FROM CAR_RENTAL_COMPANY_CAR
WHERE OPTIONS LIKE '%시트%'
GROUP BY CAR_TYPE
ORDER BY 1;


-- 가격대 별 상품 개수 구하기 (LEVEL 2)
SELECT TRUNC(PRICE, -4) AS "PRICE_GROUP", COUNT(PRODUCT_ID) AS "PRODUCTS"
FROM PRODUCT
GROUP BY TRUNC(PRICE, -4)
ORDER BY 1;


-- 성분으로 구분한 아이스크림 총 주문량 (LEVEL 2)
SELECT INGREDIENT_TYPE, SUM(TOTAL_ORDER) AS "TOTAL_ORDER"
FROM FIRST_HALF
JOIN ICECREAM_INFO USING (FLAVOR)
GROUP BY INGREDIENT_TYPE
ORDER BY 2;


-- 입양 시각 구하기(1) (LEVEL 2)
SELECT TO_NUMBER(TO_CHAR(DATETIME, 'HH24')) AS "HOUR", COUNT(ANIMAL_ID) AS "COUNT"
FROM ANIMAL_OUTS
GROUP BY TO_NUMBER(TO_CHAR(DATETIME, 'HH24'))
HAVING TO_NUMBER(TO_CHAR(DATETIME, 'HH24')) BETWEEN 9 AND 19
ORDER BY 1;


-- 입양 시각 구하기(2) (LEVEL 4)
SELECT A.HOUR, COUNT(B.HOUR) AS "COUNT"
FROM (SELECT LEVEL - 1 AS HOUR FROM DUAL CONNECT BY LEVEL < 25) A
LEFT JOIN (SELECT TO_NUMBER(TO_CHAR(DATETIME, 'HH24')) AS "HOUR" FROM ANIMAL_OUTS) B ON (A.HOUR = B.HOUR)
GROUP BY A.HOUR
ORDER BY 1;


-- 즐겨찾기가 가장 많은 식당 정보 출력하기 (LEVEL 3)
SELECT FOOD_TYPE, REST_ID, REST_NAME, FAVORITES
FROM REST_INFO
WHERE (FOOD_TYPE, FAVORITES) 
IN (SELECT FOOD_TYPE, MAX(FAVORITES)
    FROM REST_INFO
    GROUP BY FOOD_TYPE)
ORDER BY 1 DESC;


-- 즐겨찾기가 가장 많은 식당 정보 출력하기 (LEVEL 3)
SELECT B.FOOD_TYPE, B.REST_ID, B.REST_NAME, B.FAVORITES
FROM (SELECT FOOD_TYPE, MAX(FAVORITES) FAVORITES
      FROM REST_INFO
      GROUP BY FOOD_TYPE) A, REST_INFO B
WHERE A.FOOD_TYPE = B.FOOD_TYPE
AND A.FAVORITES = B.FAVORITES
ORDER BY 1 DESC;


-- 즐겨찾기가 가장 많은 식당 정보 출력하기 (GPT) (LEVEL 3)
SELECT FOOD_TYPE, REST_ID, REST_NAME, FAVORITES
FROM (SELECT FOOD_TYPE, REST_ID, REST_NAME, FAVORITES, ROW_NUMBER() OVER (PARTITION BY FOOD_TYPE ORDER BY FAVORITES DESC) AS rnk
      FROM REST_INFO)
WHERE rnk = 1
ORDER BY 1 DESC;


-- 자동차 대여 기록에서 대여중 / 대여 가능 여부 구분하기 (LEVEL 3)
SELECT CAR_ID, 
  CASE WHEN RENT = 0 THEN '대여 가능' 
       ELSE '대여중' 
       END AS AVAILABILITY
 FROM (SELECT CAR_ID, 
              SUM(CASE WHEN TO_DATE('2022-10-16', 'YYYY-MM-DD') 
              BETWEEN START_DATE AND END_DATE THEN 1 ELSE 0 END) AS RENT
         FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
        GROUP BY CAR_ID
       )
 ORDER BY 1 DESC;

SELECT HISTORY_ID, CAR_ID, START_DATE, END_DATE,
CASE WHEN TO_DATE('2022-10-16', 'YYYY-MM-DD') 
BETWEEN START_DATE AND END_DATE THEN 1 ELSE 0 END AS RENT
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
ORDER BY CAR_ID DESC;


-- 조건에 맞는 사용자와 총 거래금액 조회하기 (LEVEL 3)
SELECT USER_ID, NICKNAME, SUM(PRICE) AS TOTAL_SALES
FROM (SELECT *
     FROM USED_GOODS_BOARD
     WHERE STATUS = 'DONE')
JOIN USED_GOODS_USER ON (WRITER_ID = USER_ID)
GROUP BY USER_ID, NICKNAME
HAVING SUM(PRICE) >= 700000
ORDER BY 3;

SELECT USER_ID, NICKNAME, TOTAL_SALES
FROM USED_GOODS_USER A 
JOIN (SELECT WRITER_ID, SUM(PRICE) AS TOTAL_SALES
     FROM USED_GOODS_BOARD
     WHERE STATUS = 'DONE'
     GROUP BY WRITER_ID) B
ON WRITER_ID = USER_ID
WHERE TOTAL_SALES >= 700000
ORDER BY TOTAL_SALES ASC;


-- 카테고리 별 도서 판매량 집계하기 (LEVEL 3)
SELECT CATEGORY, SUM(SALES) AS TOTAL_SALES
FROM BOOK
JOIN (SELECT * 
      FROM BOOK_SALES
      WHERE TO_CHAR(SALES_DATE, 'YYYY-MM') = '2022-01')
USING (BOOK_ID)
GROUP BY CATEGORY
ORDER BY 1;

SELECT CATEGORY, SUM(SALES) AS TOTAL_SALES
FROM BOOK B, BOOK_SALES I
WHERE B.BOOK_ID = I.BOOK_ID
AND TO_CHAR(SALES_DATE, 'YYYY-MM') = '2022-01'
GROUP BY CATEGORY
ORDER BY 1;

SELECT B.CATEGORY, SUM(I.SALES)
FROM BOOK_SALES I, BOOK B
WHERE B.BOOK_ID = I.BOOK_ID
AND TO_CHAR(SALES_DATE, 'MM') = '01'
GROUP BY B.CATEGORY
ORDER BY B.CATEGORY


-- 대여 횟수가 많은 자동차들의 월별 대여 횟수 구하기 (LEVEL 3)
SELECT EXTRACT(MONTH FROM START_DATE) AS MONTH, CAR_ID, COUNT(*) AS RECORDS
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE CAR_ID 
IN (SELECT CAR_ID
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    WHERE START_DATE BETWEEN TO_DATE('2022-08-01', 'YYYY-MM-DD') AND TO_DATE('2022-10-31', 'YYYY-MM-DD')
    GROUP BY CAR_ID
    HAVING COUNT(*) >= 5)
AND START_DATE BETWEEN TO_DATE('2022-08-01', 'YYYY-MM-DD') AND TO_DATE('2022-10-31', 'YYYY-MM-DD')
GROUP BY EXTRACT(MONTH FROM START_DATE), CAR_ID
HAVING COUNT(*) > 0
ORDER BY 1, 2 DESC;


-- 저자 별 카테고리 별 매출액 집계하기 (LEVEL 4)
SELECT A.AUTHOR_ID, AUTHOR_NAME, CATEGORY, SUM(SALES * PRICE) AS TOTAL_SALES
FROM BOOK B, BOOK_SALES S, AUTHOR A
WHERE B.BOOK_ID = S.BOOK_ID
AND A.AUTHOR_ID = B.AUTHOR_ID
AND SALES_DATE BETWEEN TO_DATE('2022-01-01', 'YYYY-MM-DD') AND TO_DATE('2022-01-31', 'YYYY-MM-DD')
GROUP BY A.AUTHOR_ID, A.AUTHOR_NAME, CATEGORY
ORDER BY 1, 3 DESC;

-- 저자 별 카테고리 별 매출액 집계하기 (LEVEL 4)
SELECT AUTHOR_ID, AUTHOR_NAME, CATEGORY, SUM(SALES * PRICE) AS TOTAL_SALES
FROM (SELECT *
       FROM BOOK_SALES A
       NATURAL JOIN BOOK B
       WHERE TO_CHAR(SALES_DATE, 'MM') = '01')
INNER JOIN AUTHOR
USING (AUTHOR_ID)
GROUP BY AUTHOR_ID, AUTHOR_NAME, CATEGORY
ORDER BY AUTHOR_ID ASC, CATEGORY DESC;

/*
SELECT A.AUTHOR_ID, AUTHOR_NAME, CATEGORY, SUM(SALES) * PRICE AS TOTAL_SALES
FROM BOOK B, BOOK_SALES S, AUTHOR A
WHERE B.BOOK_ID = S.BOOK_ID
AND A.AUTHOR_ID = B.AUTHOR_ID
AND SALES_DATE BETWEEN TO_DATE('2022-01-01', 'YYYY-MM-DD') AND TO_DATE('2022-01-31', 'YYYY-MM-DD')
GROUP BY A.AUTHOR_ID, A.AUTHOR_NAME, CATEGORY, PRICE
ORDER BY 1, 3 DESC;

두 쿼리 간에 주된 차이는 SUM(SALES * PRICE)와 SUM(SALES) * PRICE 부분에 있습니다.

첫 번째 쿼리 (SUM(SALES * PRICE)):
이 쿼리는 각 판매 건에 대한 가격을 곱한 후에 합산합니다. 즉, 판매 수량과 가격을 각각 계산한 후에 더합니다.

두 번째 쿼리 (SUM(SALES) * PRICE):
이 쿼리는 판매 수량의 합을 먼저 계산하고, 그 후에 가격을 곱합니다. 즉, 가격을 한 번만 곱합니다.

이로 인해 결과에 차이가 발생할 수 있습니다. 만약 한 권의 책이 여러 번 팔렸다면, 두 번째 쿼리에서는 판매 수량의 합을 구한 후에 가격을 곱하기 때문에 총 매출이 더 높게 나타날 것입니다.

예를 들어, 가정해보겠습니다:

책 A의 가격이 20이고, 2번 팔렸다고 가정합니다.
책 B의 가격이 30이고, 3번 팔렸다고 가정합니다.
첫 번째 쿼리 결과:

책 A: (2 * 20) = 40
책 B: (3 * 30) = 90
두 번째 쿼리 결과:

책 A: (2 + 2) * 20 = 80
책 B: (3 + 3) * 30 = 180
따라서 같은 기간 동안 같은 판매 내역이라도 두 쿼리의 결과는 다를 수 있습니다.

두 번째 쿼리에서 결과가 중복으로 나오는 이유는 GROUP BY 절에 PRICE가 추가되었기 때문입니다. 두 번째 쿼리의 GROUP BY 절은 다음과 같습니다:

GROUP BY A.AUTHOR_ID, A.AUTHOR_NAME, CATEGORY, PRICE
이렇게 되면 같은 저자, 같은 카테고리, 같은 가격인 항목들은 서로 다른 행으로 취급됩니다. 즉, 동일한 판매 건이라도 가격이 다르면 각각 별도의 행으로 나타나게 됩니다.

예를 들어, 두 번째 쿼리 결과에서 "홍길동"의 "경제" 카테고리는 두 번 중복되어 나타납니다. 이는 같은 카테고리이지만 가격이 다르기 때문입니다. 따라서 중복된 결과가 나타나게 됩니다.

첫 번째 쿼리에서는 GROUP BY에 PRICE가 없으므로 같은 저자, 같은 카테고리인 항목들은 모두 하나의 행으로 표시됩니다.
*/


-- 식품분류별 가장 비싼 식품의 정보 조회하기 (LEVEL 4)
SELECT A.CATEGORY, A.MAX_PRICE, B.PRODUCT_NAME
FROM (
    SELECT CATEGORY, MAX(PRICE) AS MAX_PRICE
    FROM FOOD_PRODUCT
    WHERE CATEGORY IN ('과자', '국', '김치', '식용유')
    GROUP BY CATEGORY
) A
JOIN FOOD_PRODUCT B ON A.CATEGORY = B.CATEGORY AND A.MAX_PRICE = B.PRICE
ORDER BY 2 DESC;;

-- 식품분류별 가장 비싼 식품의 정보 조회하기 (LEVEL 4)
SELECT CATEGORY, PRICE AS MAX_PRICE, PRODUCT_NAME
FROM (SELECT CATEGORY, PRICE, PRODUCT_NAME,
                RANK() OVER(PARTITION BY CATEGORY ORDER BY PRICE DESC) AS RANK
          FROM FOOD_PRODUCT
          WHERE CATEGORY IN ('과자', '국', '김치', '식용유'))
WHERE RANK = 1
ORDER BY PRICE DESC;
/*
서브쿼리 (A): FOOD_PRODUCT 테이블에서 각 식품분류별로 최대 가격을 구합니다. 이때 CATEGORY와 해당 카테고리의 최대 가격인 MAX_PRICE를 선택합니다.

SELECT CATEGORY, MAX(PRICE) AS MAX_PRICE
FROM FOOD_PRODUCT
WHERE CATEGORY IN ('과자', '국', '김치', '식용유')
GROUP BY CATEGORY

메인쿼리 (B): 앞서 얻은 서브쿼리(A)의 결과를 이용하여 원본 테이블과 조인합니다. 이때 CATEGORY와 MAX_PRICE가 일치하는 행을 찾아 해당 식품의 이름(PRODUCT_NAME)을 선택합니다.

SELECT A.CATEGORY, A.MAX_PRICE, B.PRODUCT_NAME
FROM (서브쿼리) A
JOIN FOOD_PRODUCT B ON A.CATEGORY = B.CATEGORY AND A.MAX_PRICE = B.PRICE;

결과적으로, 서브쿼리에서는 각 식품분류별로 최대 가격을 찾고, 메인쿼리에서는 해당 가격에 맞는 제품 정보를 선택하여 최종 결과를 얻습니다. 이를 통해 중복 문제를 피하고 원하는 결과를 얻을 수 있습니다.
*/


-- 년, 월, 성별 별 상품 구매 회원 수 구하기 (LEVEL 4)
SELECT YEAR, MONTH, GENDER, COUNT(DISTINCT USER_ID) AS USERS
FROM (SELECT EXTRACT (YEAR FROM SALES_DATE) AS YEAR,
      EXTRACT (MONTH FROM SALES_DATE) AS MONTH,
      GENDER, 
      USER_ID 
      FROM USER_INFO
      JOIN ONLINE_SALE USING (USER_ID)
      WHERE GENDER IS NOT NULL)
GROUP BY YEAR, MONTH, GENDER
ORDER BY 1, 2, 3;

-- 년, 월, 성별 별 상품 구매 회원 수 구하기 (LEVEL 4)
SELECT YEAR, MONTH, GENDER, COUNT(DISTINCT USER_ID) AS USERS
FROM (SELECT TO_CHAR(SALES_DATE,'YYYY') AS YEAR,
             TO_NUMBER(TO_CHAR(SALES_DATE,'MM')) AS MONTH, 
             GENDER, 
             USER_INFO.USER_ID 
      FROM USER_INFO, ONLINE_SALE
      WHERE USER_INFO.USER_ID = ONLINE_SALE.USER_ID AND GENDER IS NOT NULL)
GROUP BY YEAR, MONTH, GENDER
ORDER BY YEAR, MONTH, GENDER