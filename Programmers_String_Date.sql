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


