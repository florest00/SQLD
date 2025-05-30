-- JOIN

/*
    <JOIN>
        두 개의 이상의 테이블에서 데이터를 조회하고자 할 때 사용하는 구문이다.
        
        1. 등가 조인(EQUAL JOIN) / 내부 조인(INNER JOIN)
            연결시키는 칼럼의 값이 일치하는 행들만 조인되서 조회한다.(일치하는 값이 없는 행은 조회 X)
            
            1) 오라클 전용 구문
                [문법]
                    SELECT 칼럼, 칼럼, ...
                    FROM 테이블1, 테이블2
                    WHERE 테이블1.칼럼명 = 테이블2.칼럼명;
                
                - FROM 절에 조회하고자 하는 테이블들을 콤마(,)로 구분하여 나열한다.
                - WHERE 절에 매칭 시킬 칼럼명에 대한 조건을 제시한다.
            
            2) ANSI 표준 구문
                [문법]
                    SELECT 칼럼, 칼럼, ...
                    FROM 테이블1
                    [INNER] JOIN 테이블2 ON (테이블1.칼럼명 = 테이블2.칼럼명);
                
                - FROM 절에 기준이 되는 테이블을 기술한다.
                - JOIN 절에 같이 조회하고자 하는 테이블을 기술 후 매칭 시킬 칼럼에 대한 조건을 기술한다.
                - 연결에 사용하려는 칼럼명이 같은 경우 ON 구문 대신에 USING(칼럼명) 구문을 사용한다.
*/

-- 각 사원들의 사번, 사원명, 부서 코드, 부서명을 조회
SELECT
    EMP_ID,
    EMP_NAME,
    DEPT_CODE
FROM
    EMPLOYEE;

SELECT
    *
FROM
    DEPARTMENT; -- 부서 테이블 정보

SELECT
    EMP_ID,
    EMP_NAME,
    DEPT_CODE,
    DEPT_TITLE
FROM
         EMPLOYEE E --테이블명 그대로 써서 빨간줄 뜨는듯 -- 테이블명에도 별칭 달 수 있음
    JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID -- EMPLOYEE랑 부서테이블 합칠거다-- 사원.부서코드 = 부서.부서아이디 일치하는 걸 찾아서 연결해라
    ; -- ON : 연결기준, 어떻게 연결할건지 적으면 됨

/*
SELECT *
FROM EMPLOYEE E --테이블명 그대로 써서 빨간줄 뜨는듯 -- 테이블명에도 별칭 달 수 있음
JOIN DEPARTMENT D ON EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID -- EMPLOYEE랑 부서테이블 합칠거다-- 사원.부서코드 = 부서.부서아이디 일치하는 걸 찾아서 연결해라
; -- ON : 연결기준, 어떻게 연결할건지 적으면 됨
*/

-- 각 사원들의 사번, 사원명, 직급 코드 , 직급명을 조회

SELECT
    E.EMP_ID,
    E.EMP_NAME,
    E.JOB_CODE,
    J.JOB_NAME -- JOB_CODE => 칼럼의 정의가 애매해서 나타나는 에러.. JOB_CODE가 뭔데?함
FROM
         EMPLOYEE E -- 컬럼 별칭 안달아주면 에러남
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;

/*

SELECT E.EMP_ID, E.EMP_NAME, JOB_CODE, J.JOB_NAME -- JOB_CODE => 칼럼의 정의가 애매해서 나타나는 에러.. JOB_CODE가 뭔데?함
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
;

SELECT E.EMP_ID, E.EMP_NAME, JOB_CODE, JOB_NAME -- JOB_CODE => 칼럼의 정의가 애매해서 나타나는 에러.. JOB_CODE가 뭔데?함
FROM EMPLOYEE E
NATURAL JOIN JOB
;

*/

-- 컬럼명 겹칠 때

-- EMPLOYEE 테이블과 JOB 테이블을 조인하여 직급이 대리인 사원의 사번, 사원명, 직급명, 급여를 조회
SELECT
    E.EMP_NO,
    E.EMP_NAME,
    J.JOB_NAME,
    E.SALARY
FROM
         EMPLOYEE E
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE
    J.JOB_NAME = '대리'; -- 테이블명을 구분하는 이유는 서로 다른 테이블의 똑같은 컬럼명이 있으면 에러남

/*
    2. 다중 JOIN
        여러 개의 테이블 조인하는 경우에 사용한다.
*/

-- EMPLOYEE, DEPARTMENT, LOCATION 테이블을 다중 JOIN 하여 사번, 사원명, 부서명, 지역명 조회
SELECT
    E.EMP_NO,
    E.EMP_NAME,
    D.DEPT_TITLE,
    L.LOCAL_NAME
FROM
         EMPLOYEE E
    JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    JOIN LOCATION   L ON D.LOCATION_ID = L.LOCAL_CODE;

/*
    3. 외부 조인 (OUTER JOIN)
        != 내부 조인 (INNER JOIN)
        테이블 간의 JOIN 시 일치하지 않는 행도 포함시켜서 조회가 가능하다.
        단, 반드시 기준이되는 테이블(컬럼)을 지정해야 한다. (LEFT/RIGHT/(+))
*/

--> 값이 일치하는 것끼리 연결해주겠다

-- 사원명, 부서코드, 부서명 조회
SELECT
    E.EMP_NAME,
    E.DEPT_CODE,
    D.DEPT_ID,
    D.DEPT_TITLE
FROM
    EMPLOYEE   E
    FULL OUTER JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID -- OUTER : 일치하지 않아도 살리겠다
    ;

-- OUTER 조인은 사실 안 써도 된다? LEFT/RIGHT/FULL -> 전부 OUTER JOIN이라서 OUTER없이 LEFT JOIN/ RIGHT JOIN/ FULL JOIN 하면 알아먹음

/*
    4. 카테시안곱(CARTESIAN PRODUCT) / 교차 조인(CROSS JOIN)
        조인되는 모든 테이블의 각 행들이 서로서로 모두 매핑된 데이터가 검색된다.
        테이블의 행들이 모두 곱해진 행들의 조합이 출력 -> 과부화의 위험
*/

SELECT
    *
FROM
         EMPLOYEE E
    CROSS JOIN DEPARTMENT D;

------------------ equal join : 값이 일치할 때 JOIN 처리하는 -------------

/*
    5. 비등가 조인(NON EQUAL JOIN)
        조인 조건에 등호(=)를 사용하지 않는 조인문을 비등가 조인이라고 한다.
        지정한 칼럼 값이 일치하는 경우가 아닌, 값의 범위에 포함되는 행들을 연결하는 방식이다.
        ( = 이외에 비교 연산자 >, <, >=, <=, BETWEEN AND, IN, NOT IN 등을 사용한다.)
        ANSI 구문으로는 JOIN ON 구문으로만 사용이 가능하다. (USING 사용 불가)
*/

--사원이름, 급여조회
SELECT
    EMP_NAME,
    SALARY,
    SAL_LEVEL
FROM
         EMPLOYEE E
    JOIN SAL_GRADE S ON SALARY BETWEEN MIN_SAL AND MAX_SAL -- 등호 말고도 범위로도 JOIN 가능
ORDER BY
    SALARY DESC;

--1, 4, 5, 6 : 특, 고, 중, 초
-- CASE WHEN THEN / DECODE

SELECT
    EMP_NAME,
    SALARY,
    CASE SAL_LEVEL
        WHEN 'S1' THEN
            '특급'
        WHEN 'S4' THEN
            '고급'
        WHEN 'S5' THEN
            '중급'
        WHEN 'S6' THEN
            '초급'
    END AS 등급
FROM
         EMPLOYEE E
    JOIN SAL_GRADE S ON SALARY BETWEEN MIN_SAL AND MAX_SAL
ORDER BY
    SALARY DESC;

--SELECT EMP_NAME
--    , SALARY
--    , CASE SAL_LEBEL
--        WHEN SAL_LEVEL = 'S1' THEN '특급'
--        WHEN SAL_LEVEL = 'S4' THEN '고급'
--        WHEN ~~~ THEN ~~~
--FROM EMPLOYEE E
--JOIN SAL_GRADE S ON SALARY BETWEEN MIN_SAL AND MAX_SAL
--ORDER BY SALARY DESC
--;
    


--SELECT 
--    EMP_ID
--    , EMP_NAME
--    , EMP_NO
--    , CASE 
--    -- 변수를 쓸 수 있는 PLSQL? 서브쿼리..? -> SUBSTR 반복해서 쓰지 않는 방법 (?)
--        WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '남' -- 8번째 위치에서 1글자를 잘라오겠다
--        WHEN SUBSTR(EMP_NO, 8, 1) = 2 THEN '여'
--        WHEN SUBSTR(EMP_NO, 8, 1) = 3 THEN '남'
--        WHEN SUBSTR(EMP_NO, 8, 1) = 4 THEN '여'
--    ELSE '외국인' -- 5
--    END AS 성별
--FROM EMPLOYEE
--;

/*
    6. 자체 조인 (SELF JOIN)
        같은 테이블을 다시 한번 조인하는 경우에 사용한다.
*/

-- EMPLOYEE 테이블을 SELF JOIN 하여 사번, 사원명, 부서 코드, 사수 사번, 사수 이름 조회
SELECT
    EMP_NO,
    A.EMP_NAME,
    A.DEPT_CODE,
    B.EMP_ID --사수 아이디 self join
    ,
    B.EMP_NAME -- 사수 이름
FROM
         EMPLOYEE A
    JOIN EMPLOYEE B ON A.MANAGER_ID = B.EMP_ID;

-- 과제 25-05-13 (내일)

---------------- 실습 문제 ----------------

-- 1. DEPARTMENT 테이블과 LOCATION 테이블의 조인하여 부서 코드, 부서명, 지역 코드, 지역명을 조회

SELECT
    D.DEPT_ID,
    D.DEPT_TITLE,
    D.LOCATION_ID,
    L.LOCAL_NAME
FROM
         DEPARTMENT D
    JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE;


-- ANSI 구문 (정답)
SELECT D.DEPT_ID, D.DEPT_TITLE, D.LOCATION_ID, L.NATIONAL_CODE
FROM DEPARTMENT D
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);

-- 결과동일

-- 2. EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인해서 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명을 조회

SELECT
    E.EMP_ID, -- EMP_NO는 주민번호.. 사번은 EMP_ID
    E.EMP_NAME,
    E.BONUS,
    D.DEPT_TITLE
FROM
         EMPLOYEE E
--    JOIN DEPARTMENT D ON D.DEPT_ID = E.DEPT_CODE;
      JOIN DEPARTMENT D ON  E.DEPT_CODE =  D.DEPT_ID
      WHERE BONUS IS NOT NULL; -- 결과가 달랐던 이유 : "보너스를 받는 사원" 이라는 조건이 빠짐
    
-- ANSI 구문 (정답)
SELECT E.EMP_ID, E.EMP_NAME, E.BONUS, D.DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
WHERE BONUS IS NOT NULL;

--결과다름 (고침)


-- 3. EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인해서 인사관리부가 아닌 사원들의 사원명, 부서명, 급여를 조회

SELECT
    E.EMP_NAME,
    D.DEPT_TITLE,
    E.SALARY
FROM
         EMPLOYEE E
    JOIN DEPARTMENT D ON D.DEPT_ID = E.DEPT_CODE
WHERE
    D.DEPT_TITLE <> '인사관리부'; -- 인사관리부가 아닌 사원

-- ANSI 구문 (정답)
SELECT E.EMP_NAME, D.DEPT_TITLE, E.SALARY
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID) -- 순서의 기준은 뭘까?
WHERE D.DEPT_ID != 'D1';

-- 결과동일


-- 4. EMPLOYEE 테이블, DEPARTMENT 테이블, LOCATION 테이블의 조인해서 사번, 사원명, 부서명, 지역명 조회

SELECT
    E.EMP_ID, -- EMP_NO는 주민번호 
    E.EMP_NAME,
    E.DEPT_CODE,
    L.LOCAL_NAME
FROM
         EMPLOYEE E
    JOIN DEPARTMENT D ON D.DEPT_ID = E.DEPT_CODE
    JOIN LOCATION   L ON L.LOCAL_CODE = D.LOCATION_ID;


-- ANSI 구문 (정답)
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON( D.LOCATION_ID = L.LOCAL_CODE);

-- 결과동일.. 근데 EMP_ID랑 EMP_NO랑 헷갈림


-- 5. 사번, 사원명, 부서명, 지역명, 국가명 조회

SELECT
    E.EMP_ID,
    E.EMP_NAME,
    L.LOCAL_NAME,
    L.NATIONAL_CODE
FROM
         EMPLOYEE E
    JOIN DEPARTMENT D ON D.DEPT_ID = E.DEPT_CODE
    JOIN LOCATION   L ON L.LOCAL_CODE = D.LOCATION_ID;
    
    
    -- ANSI 구문
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME, N.NATIONAL_NAME
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
INNER JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
INNER JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE);


-- 6. 사번, 사원명, 부서명, 지역명, 국가명, 급여 등급 조회 (NON EQUAL JOIN 후에 실습 진행)

SELECT
    E.EMP_ID,
    E.EMP_NAME,
    D.DEPT_TITLE,
    L.LOCAL_NAME,
    N.NATIONAL_NAME,
    E.SALARY,
    CASE S.SAL_LEVEL
        WHEN 'S1' THEN
            '특급'
        WHEN 'S4' THEN
            '고급'
        WHEN 'S5' THEN
            '중급'
        WHEN 'S6' THEN
            '초급'
        ELSE
            '기타'
    END AS 등급
FROM
         EMPLOYEE E
    JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    JOIN LOCATION   L ON D.LOCATION_ID = L.LOCAL_CODE
    JOIN NATIONAL   N ON L.NATIONAL_CODE = N.NATIONAL_CODE
    JOIN SAL_GRADE  S ON E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL
ORDER BY
    E.SALARY DESC;
    
    
    -- ANSI 구문
SELECT E.EMP_ID AS "사번", 
       E.EMP_NAME AS "사원명", 
       D.DEPT_TITLE AS "부서명",
       L.LOCAL_NAME AS "근무지역명",
       N.NATIONAL_NAME AS "근무국가명",
       S.SAL_LEVEL AS "급여등급"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
JOIN SAL_GRADE S ON(E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);
    
    


------------------------- 종합 실습 문제 -------------------------


-- 1. 직급이 대리이면서 ASIA 지역에서 근무하는 직원들의 사번, 사원명, 직급명, 부서명, 근무지역, 급여를 조회하세요.

SELECT
    E.EMP_ID,
    E.EMP_NAME,
    J.JOB_NAME,
    D.DEPT_TITLE,
    L.LOCAL_NAME,
    E.SALARY
FROM
         EMPLOYEE E
    JOIN JOB        J ON E.JOB_CODE = J.JOB_CODE --> 일치하는 걸 연결해주겠다         잘못쓴거 J.JOB_NAME = E.JOB_CODE
    JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    JOIN LOCATION   L ON D.LOCATION_ID = L.LOCAL_CODE
--    JOIN NATIONAL   N ON L.NATIONAL_CODE = N.NATIONAL_CODE
WHERE
        J.JOB_NAME = '대리'
    AND L.LOCAL_NAME LIKE 'ASIA%'; -- 특정패턴일땐 대소비교 연산자를 사용할 게 아니라 LIKE를 사용해야함
    
    
    -- ANSI 구문 (정답)
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "사원명", 
       J.JOB_NAME AS "직급명", 
       D.DEPT_TITLE AS "부서명", 
       L.LOCAL_NAME AS "근무지역", 
       E.SALARY AS "급여"
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
WHERE J.JOB_NAME = '대리' 
  AND L.LOCAL_NAME LIKE 'ASIA%';
  
  -- 결과 다름 (고침)


-- 2. 70년대생 이면서 여자이고, 성이 전 씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하세요.

SELECT
    E.EMP_NAME,
    E.EMP_NO,
    D.DEPT_TITLE,
    J.JOB_NAME
FROM
         EMPLOYEE E
    JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    JOIN JOB        J ON J.JOB_CODE = E.JOB_CODE
WHERE
    SUBSTR(E.EMP_NO, 1, 2) BETWEEN '70' AND '79'
    AND SUBSTR(E.EMP_NO, 8, 1) IN ( '2', '4' )
    AND E.EMP_NAME LIKE '전%';
    
-- ANSI 구문 (정답)
SELECT E.EMP_NAME AS "사원명",
       E.EMP_NO AS "주민번호",
       D.DEPT_TITLE AS "부서명",
       J.JOB_NAME AS "직급명"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
--WHERE SUBSTR(E.EMP_NO, 1, 1) = '7'
WHERE E.EMP_NO LIKE '7%'
  AND SUBSTR(E.EMP_NO, 8, 1) = '2'
  AND E.EMP_NAME LIKE '전%';

-- 결과동일

-- 3. 보너스를 받는 직원들의 사원명, 보너스, 연봉, 부서명, 근무지역을 조회하세요.

SELECT
    E.EMP_NAME,
    E.BONUS,
    ( E.SALARY + NVL(E.BONUS, 0) ) * 12 연봉,
    D.DEPT_TITLE,
    L.LOCAL_NAME
FROM
         EMPLOYEE E
    JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    JOIN LOCATION   L ON D.LOCATION_ID = L.LOCAL_CODE
WHERE
    E.BONUS IS NOT NULL
    AND E.BONUS > 0;

-- ANSI 구문 (정답)
SELECT E.EMP_NAME AS "사원명",
       NVL(E.BONUS, 0) AS "보너스",
       TO_CHAR(E.SALARY * 12, '99,999,999') AS "연봉", -- 헐 왜 99,....?
       D.DEPT_TITLE AS "부서명",
       L.LOCAL_NAME AS "근무지역"
FROM EMPLOYEE E
LEFT OUTER JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT OUTER JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

-- 결과다름

-- 4. 한국과 일본에서 근무하는 직원들의 사원명, 부서명, 근무지역, 근무 국가를 조회하세요.

SELECT
    E.EMP_NAME,
    D.DEPT_TITLE,
    L.LOCAL_NAME,
    N.NATIONAL_NAME
FROM
         EMPLOYEE E
    JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    JOIN LOCATION   L ON D.LOCATION_ID = L.LOCAL_CODE
    JOIN NATIONAL   N ON L.NATIONAL_CODE = N.NATIONAL_CODE
WHERE
    N.NATIONAL_NAME IN ( '한국', '일본' );
    
    -- ANSI 구문 (정답)
SELECT E.EMP_NAME AS "사원명", 
       D.DEPT_TITLE AS "부서명", 
       L.LOCAL_NAME AS "근무지역", 
       N.NATIONAL_NAME AS "근무국가"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME IN ('한국', '일본');

-- 결과 동일

-- 5. 각 부서별 평균 급여를 조회하여 부서명, 평균 급여(정수 처리)를 조회하세요.

SELECT
    D.DEPT_TITLE         부서명,
    FLOOR(AVG(E.SALARY)) 평균급여
FROM
         EMPLOYEE E
    JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
GROUP BY
    D.DEPT_TITLE;
    
    -- ANSI 구문 (정답)
SELECT NVL(D.DEPT_TITLE, '부서없음') AS "부서명", 
       TO_CHAR(ROUND(AVG(NVL(SALARY, 0))), '99,999,999') AS "급여평균"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
GROUP BY D.DEPT_TITLE
ORDER BY D.DEPT_TITLE;

-- 결과다름



-- 6. 각 부서별 총 급여의 합이 1000만원 이상인 부서명, 급여의 합을 조회하시오.

SELECT
    D.DEPT_TITLE  부서명,
    SUM(E.SALARY) 총급여
FROM
         EMPLOYEE E
    JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
GROUP BY
    D.DEPT_TITLE
HAVING
    SUM(E.SALARY) >= 10000000;
    
    
-- ANSI 구문 (정답)
SELECT D.DEPT_TITLE AS "부서명", 
       TO_CHAR(SUM(SALARY), '99,999,999') AS "급여의 합"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
GROUP BY D.DEPT_TITLE
HAVING SUM(SALARY) >= 10000000
ORDER BY D.DEPT_TITLE;

-- 결과 거의 동일하긴 한데 포멧이 좀 다름


-- 7. 사번, 사원명, 직급명, 급여 등급, 구분을 조회 (NON EQUAL JOIN 후에 실습 진행)

SELECT
    E.EMP_ID    사번,
    E.EMP_NAME  사원명,
    J.JOB_NAME  직급명,
    S.SAL_LEVEL 급여등급,
    CASE S.SAL_LEVEL
        WHEN 'S1' THEN
            '특급'
        WHEN 'S2' THEN
            '고급'
        WHEN 'S3' THEN
            '중급'
        WHEN 'S4' THEN
            '초급'
        ELSE
            '기타'
    END         구분
FROM
         EMPLOYEE E
    JOIN JOB       J ON E.JOB_CODE = J.JOB_CODE
    JOIN SAL_GRADE S ON E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL
ORDER BY
    E.EMP_ID;

-- ANSI 구문 (정답)
SELECT E.EMP_ID AS "사번", 
       E.EMP_NAME AS "사원명", 
       J.JOB_NAME AS "직급명",
       S.SAL_LEVEL AS "급여 등급",
       CASE 
            WHEN S.SAL_LEVEL IN ('S1', 'S2') THEN '고급' 
            WHEN S.SAL_LEVEL IN ('S3', 'S4') THEN '중급'
            WHEN S.SAL_LEVEL IN ('S5', 'S6') THEN '초급'
       END AS "구분"
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN SAL_GRADE S ON(E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);

-- 8. 보너스를 받지 않는 직원들 중 직급 코드가 J4 또는 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.

SELECT
    E.EMP_NAME 사원,
    J.JOB_NAME 직급,
    E.SALARY   급여
FROM
         EMPLOYEE E
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE
    E.BONUS IS NULL
    AND E.JOB_CODE IN ( 'J4', 'J7' );
    
    -- ANSI 구문 (정답)
SELECT E.EMP_NAME AS "사원명", 
       J.JOB_NAME AS "직급명", 
       E.SALARY AS "급여"
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE E.BONUS IS NULL
  AND E.JOB_CODE IN ('J4', 'J7');



-- 9. 부서가 있는 직원들의 사원명, 직급명, 부서명, 근무 지역을 조회하시오.

SELECT
    E.EMP_NAME   사원명,
    J.JOB_NAME   직급명,
    D.DEPT_TITLE 부서명,
    L.LOCAL_NAME 근무지역
FROM
         EMPLOYEE E
    JOIN JOB        J ON E.JOB_CODE = J.JOB_CODE
    JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    JOIN LOCATION   L ON D.LOCATION_ID = L.LOCAL_CODE
WHERE
    E.DEPT_CODE IS NOT NULL;

-- ANSI 구문 (정답)
SELECT EMP_NAME  AS "사원명", 
       JOB_NAME  AS "직급명", 
       DEPT_TITLE  AS "부서명", 
       LOCAL_NAME  AS "근무 지역"
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);

-- 결과동일

-- 10. 해외영업팀에 근무하는 직원들의 사원명, 직급명, 부서 코드, 부서명을 조회하시오

SELECT
    E.EMP_NAME   AS 사원명,
    J.JOB_NAME   AS 직급명,
    E.DEPT_CODE  AS 부서코드,
    D.DEPT_TITLE AS 부서명
FROM
         EMPLOYEE E
    JOIN JOB        J ON E.JOB_CODE = J.JOB_CODE
    JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
WHERE
    D.DEPT_TITLE = '해외영업팀';

-- ANSI 구문 (정답)
SELECT E.EMP_NAME AS "사원명", 
       J.JOB_NAME AS "직급명", 
       E.DEPT_CODE AS "부서 코드", 
       D.DEPT_TITLE AS "부서명"
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
WHERE D.DEPT_TITLE LIKE '해외영업%'
ORDER BY E.EMP_NAME;

-- 결과 다름

-- 11. 이름에 '형'자가 들어있는 직원들의 사번, 사원명, 직급명을 조회하시오. 

SELECT
    E.EMP_ID   사번,
    E.EMP_NAME 사원명,
    J.JOB_NAME 직급명
FROM
         EMPLOYEE E
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE
    E.EMP_NAME LIKE '%형%';
    
    -- ANSI 구문 (정답)
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "사원명",
       J.JOB_NAME AS "직급명"
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE E.EMP_NAME LIKE '%형%';

-- 결과동일


----- JOIN sql문 60%

