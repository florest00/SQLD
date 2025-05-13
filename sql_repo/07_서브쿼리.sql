/*
    <SUBQUERY>
        하나의 SQL 문 안에 포함된 또 다른 SQL 문을 뜻한다. 
        메인 쿼리(기존 쿼리)를 보조하는 역할을 하는 쿼리문이다.
*/

--> 쿼리 안쪽에 쿼리를 또 쓸 수 있음

-- 노옹철 사원과 같은 부서원들을 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 
(
    SELECT DEPT_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '노옹철'
)
;

/*
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'
;

-> 이 쿼리를 아래 'D9' 에 넣어서 퀴리문 안에 쿼리문을 넣는 형식으로 사용가능

SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'
;
*/



----------------------------------------------------------
/*
    <서브 쿼리 구분>
        서브 쿼리는 서브 쿼리를 수행한 결과값의 행과 열의 개수에 따라서 분류할 수 있다.
        
        1) 단일행 서브 쿼리        : 서브 쿼리의 조회 결과 값의 행과 열의 개수가 1개 일 때
        2) 다중행 서브 쿼리        : 서브 쿼리의 조회 결과 값의 행의 개수가 여러 행 일 때
        3) 다중열 서브 쿼리        : 서브 쿼리의 조회 결과 값이 한 행이지만 칼럼이 여러개 일때
        4) 다중행, 다중열 서브 쿼리 : 서브 쿼리의 조회 결과 값이 여러행, 여러열 일 때
        
        * 서브 쿼리의 유형에 따라서 서브 쿼리 앞에 붙는 연산자가 달라진다.
        
    <단일행 서브 쿼리>
        서브 쿼리의 조회 결과 값의 행과 열의 개수가 1개 일 때 (단일행, 단일열)
        비교 연산자(단일행 연산자) 사용 가능 (=, !=, <>, ^=, >, <, >=, <=, ...)
*/

-- 1) 전 직원의 평균 급여보다 급여를 적게 받는 직원들의 이름, 직급 코드, 급여 조회
--SELECT AVG(SALARY)
--FROM EMPLOYEE
--;

SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (
    SELECT AVG(SALARY)
    FROM EMPLOYEE
)
;

-- 2) 최저 급여를 받는 직원의 사번, 이름, 직급 코드, 급여, 입사일 조회

SELECT MIN(SALARY)
FROM EMPLOYEE
;

SELECT EMP_ID 사번
    , EMP_NAME 이름
    , JOB_CODE "직급 코드"
    , SALARY 급여
    , HIRE_DATE 입사일
FROM EMPLOYEE
WHERE SALARY = (
SELECT MIN(SALARY)
FROM EMPLOYEE
)
;


-- 3) 노옹철 사원의 급여보다 더 많은 급여받는 사원들의 사번, 사원명, 부서명, 직급 코드 , 급여 조회
 SELECT MAX(SALARY)
 FROM EMPLOYEE
 WHERE EMP_NAME = '노옹철';
 
 SELECT EMP_ID 사번
    , EMP_NAME 이름
--    , DEPT_TITLE 부서명
    , JOB_CODE "직급 코드"
    , SALARY 급여
    , HIRE_DATE 입사일
FROM EMPLOYEE
WHERE SALARY > (
 SELECT MAX(SALARY)
 FROM EMPLOYEE
 WHERE EMP_NAME = '노옹철'
 ) --노옹철 사원의 급여보다 더 많은 급여받는 사원
;


--4) 부서별 급여의 합이 가장 큰 부서의 부서 코드, 급여의 합 조회
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE-- 부서별 급여의 합이 가장 큰 부서
-- "~별로 나눈다" 하면 GROUP BY를 쓸 것
HAVING SUM(SALARY) = (
    SELECT MAX(SUM(SALARY))
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
)
;

-- 5) 전지연 사원이 속해있는 부서원들 조회 (단, 전지연 사원은 제외)
-- 전지연이 속한 부서
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '전지연'
;

SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = (
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '전지연'
) 
AND EMP_NAME <> '전지연'
;

/*
    <다중행 서브 쿼리>
        서브 쿼리의 조회 결과 값의 행의 개수가 여러 행 일 때
        
        IN / NOT IN (서브 쿼리) : 여러 개의 결과값 중에서 한 개라도 일치하는 값이 있다면 혹은 없다면 TRUE를 리턴한다.
        ANY : 여러 개의 값들 중에서 한 개라도 만족하면 TRUE, IN과 다른 점은 비교 연산자를 함께 사용한다는 점이다. 
            ANY(100, 200, 300)
            SALARY = ANY(...)  : IN과 같은 결과
            SALARY != ANY(...) : NOT IN과 같은 결과
            SALARY > ANY(...)  : 최소값 보다 크면 TRUE
            SALARY < ANY(...)  : 최대값 보다 작으면 TRUE
        ALL : 여러 개의 값들 모두와 비교하여 만족해야 TRUE, IN과 다른 점은 비교 연산자를 함께 사용한다는 점이다.
            ALL(100, 200, 300)
            SALARY > ALL(...)  : 최대값 보다 크면 TRUE
            SALARY < ALL(...)  : 최소값 보다 작으면 TRUE
*/

-- 1) 각 부서별 최고 급여를 받는 직원의 이름, 직급 코드, 부서 코드, 급여 조회
--SELECT *
--FROM EMPLOYEE
--WHERE SALARY = ANY(8000000, 25500000, 3900000) -- 부서별 salary의 max값 뽑음
--;
--
--SELECT MAX(SALARY)
--FROM EMPLOYEE
--GROUP BY DEPT_CODE
--;
--
--
--SELECT EMP_NAME 이름
--    , JOB_CODE "직급 코드"
--    , DEPT_CODE "부서 코드"
--    , SALARY 급여
--FROM EMPLOYEE
--WHERE SALARY = (
--    SELECT *
--    FROM EMPLOYEE
--    WHERE SALARY = ANY(8000000, 25500000, 3900000)
--)
--;

SELECT *
FROM EMPLOYEE
WHERE SALARY = ANY(
    SELECT MAX(SALARY)
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
) 
ORDER BY DEPT_CODE
;


--
--SELECT EMP_NAME 이름
--    , JOB_CODE "직급 코드"
--    , DEPT_CODE "부서 코드"
--    , SALARY 급여
--FROM EMPLOYEE
--WHERE SALARY = (
--    SELECT MAX(SALARY)
--    FROM EMPLOYEE
--)
---- 부서별
--;

SELECT *
FROM EMPLOYEE A
WHERE SALARY =  ANY (
    SELECT MAX(SALARY)
    FROM EMPLOYEE B
    WHERE B.DEPT_CODE = A.DEPT_CODE
        )
;



-- 2) 전 직원들에 대해 사번, 이름, 부서 코드, 구분(사수/사원)
-- 사수에 해당하는 사번을 조회 -- (201, 204, 100, 200, 211, 207, 214)
SELECT *
FROM EMPLOYEE
;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID --구분(사수/사원)
FROM EMPLOYEE
WHERE ANY 
-- 전 직원들에 대해..
;

-- 3) 대리 직급임에도 과장 직급들의 최소 급여보다 많이 받는 직원의 사번, 이름, 직급명, 급여 조회
SELECT *
FROM EMPLOYEE
;

SELECT *
FROM EMPLOYEE
;


/*
    <다중열 서브 쿼리>
        조회 결과 값은 한 행이지만 나열된 칼럼 수가 여러 개일 때
*/

-- 1) 하이유 사원과 같은 부서 코드, 같은 직급 코드에 해당하는 사원들 조회

SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유'
;

SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유'
;

SELECT *
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (('D5', 'J5')) -- 하이유 사원과 같은 DEPT_CODE, JOB_CODE
;

SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유'
;

SELECT *
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (
    SELECT DEPT_CODE, JOB_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '하이유'
)
;

/*
    <다중행 다중열 서브 쿼리>
        서브 쿼리의 조회 결과값이 여러 행, 여러 열일 경우
*/

-- 다중행 다중열 서브 쿼리를 사용해서 각 직급별로 최소 급여를 받는 사원의 사번, 이름, 직급 코드, 급여 조회
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE + SALARY) = ('J1', 20000000)
;

SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN ('J3', 300) -- IN(경우 1, 경우2, 경우 3) 하나라도 만족하면 
;

SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (('J1', 200), ('J2', 300), ('J7', 1380000)) 
;

SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
;

SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN 
                        (
                            SELECT JOB_CODE, MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE
                        ) 
;

-- 각 부서별 최소 급여를 받는 ㅏ사원들의 사번, 이름, 부서 코드, 급여 조회
SELECT MIN(SALARY)
FROM EMPLOYEE
;

SELECT EMP_ID 사번
    , EMP_NAME 이름
    , DEPT_CODE "부서 코드"
    , SALARY 급여
FROM EMPLOYEE
GROUP BY DEPT_CODE
;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) = (D1, 100)
;



SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN 
(
    SELECT DEPT_CODE, MIN(SALARY)
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
)
;

-- 필요성을 느껴야 공부를 하게 되는,, 

/*
    <인라인 뷰>
        FROM 절에 서브 쿼리를 제시하고, 서브 쿼리를 수행한 결과를 테이블 대신 사용한다.
*/

-- 1) 인라인 뷰를 활용한 TOP-N 분석
-- 전 직원 중 급여가 가장 높은 상위 5명의 순위, 이름, 급여 조회
SELECT EMP_NAME, SALARY, ROWNUM
FROM EMPLOYEE
ORDER BY SALARY DESC
;

SELECT EMP_NAME, SALARY, ROWNUM
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC
;

-- ROWNUM : 행 마다 번호를 붙여주는 거

SELECT EMP_NAME, SALARY, ROWNUM
FROM 
(
    SELECT EMP_NAME, SALARY
    FROM EMPLOYEE
    ORDER BY SALARY DESC
)
;

SELECT ABC.*, ROWNUM --테이블명.*
FROM 
(
    SELECT EMP_NAME, SALARY
    FROM EMPLOYEE
    ORDER BY SALARY DESC
) ABC
WHERE ROWNUM <= 5 --상위 5명만 조회
;

-- 2) 부서별 평균 급여가 높은 3개의 부서의 부서 코드, 평균 급여 조회
SELECT DEPT_CODE , AVG_SAL, ROWNUM
FROM 
(
    SELECT DEPT_CODE, AVG(SALARY) AS AVG_SAL
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
    ORDER BY AVG(SALARY) DESC
) X
WHERE ROWNUM <= 3
;

 -- SELECT X.* ~ <-대신 컬럼명
 
 --2-1) WITH를 이용한 방법
 
 WITH ABC AS 
 (
    SELECT EMP_NAME, DEPT_CODE
    FROM EMPLOYEE
 )
 SELECT * --EMP_NAME, DEPT_CODE
 FROM ABC
 ;
 
 --쿼리문의 실행결과 -> ABC
 
 SELECT EMP_NAME, DEPT_CODE
 FROM EMPLOYEE
 ;
 
 /*
    <RANK 함수>
        [문법]
            RANK() OVER(정렬 기준) / DENSE_RANK() OVER(정렬 기준)
        
         RANK() OVER(정렬 기준)         : 동일한 순위 이후의 등수를 동일한 인원수만큼 건너뛰고 순위를 계산한다.
                                         (EX. 공동 1위가 2명이면 다음 순위는 3위)
         DENSE_RANK() OVER(정렬 기준)   : 동일한 순위 이후의 등수를 무조건 1씩 증가한다.
                                         (EX. 공동 1위가 2명이면 다음 순위는 2위)
*/

-- 사원별 급여가 높은 순서대로 순위를 매겨서 순위, 사원명, 급여 조회
-- 공동 19위 2명 뒤에 순위는 21위

-- 서브쿼리 인라인뷰
SELECT
    RANK() OVER (ORDER BY SALARY DESC) 순위
    , EMP_NAME
    , SALARY
FROM EMPLOYEE
WHERE RANK() OVER (ORDER BY SALARY DESC) <= 5
;

-- DENSE_RANK() 
WITH ABC AS 
(
SELECT
    RANK() OVER (ORDER BY SALARY DESC) 순위
    , EMP_NAME
    , SALARY
FROM EMPLOYEE

)
SELECT *
FROM ABC
WHERE 순위 BETWEEN 1 AND 5
;

-- 급여 순으로 6~10등 출력
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC
;



SELECT 이름, 급여, ROWNUM
FROM 
(
    SELECT EMP_NAME 이름, SALARY 급여
    FROM EMPLOYEE
    ORDER BY SALARY DESC
)
WHERE ROWNUM >= 1
;

--> 왜 초과는 안될까? rownum >
--> 무조건 1등부터 해야됨 그래야 rownum이 1부터 차곡차곡 쌓이니까
SELECT *
FROM 
(
    SELECT 이름, 급여, ROWNUM RN
    FROM 
    (
        SELECT EMP_NAME 이름, SALARY 급여
        FROM EMPLOYEE
        ORDER BY SALARY DESC
    )
)
WHERE RN BETWEEN 6 AND 10
;

--> 사용빈도높음 : 게시글 조회할 때 항상 쓰임 ,, 게시글 최신순으로 1~10/ 11~20/ 21~30 같은 식으로 조회함
--> 새로운 방법 있긴 함
