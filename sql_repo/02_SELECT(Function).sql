--춘 대학교 워크북 과제
--SQL02_SELECT(Function)

-- 1번
-- 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른 순으로 표시하는 SQL문장을 작성하시오.
-- (단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)
    SELECT
        STUDENT_NO
        , STUDENT_NAME
        , ENTRANCE_DATE
    FROM TB_STUDENT
    WHERE DEPARTMENT_NO LIKE '002'
    ORDER BY ENTRANCE_DATE ASC
    ;
    
--정답
SELECT STUDENT_NO AS 학번, STUDENT_NAME AS 이름, TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') AS 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE;

-- 2번
-- 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다. 그 교수의 이름과 주민번호를 화면에 출력하는 SQL문장을 작성해보자.
-- (*이때 올바르게 작성한 SQL 문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇인지 생각해볼 것) 
SELECT
    PROFESSOR_NAME
    , PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) <> 3 --세 글자
;

--정답

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

-- 결과 동일

-- 3번
-- 춘 기술대학교의 남자 교수들의 이름을 출력하는 SQL 문장을 작성하시오. 단 이때 나이가 적은 사람에서 많은 사람 순서
-- (나이가 같다면 이름의 가나다 순서)로 화면에 출력되도록 만드시오.
-- (단, 교수 중 2000년 이후 출생자는 없으며 출력 헤더는 "교수이름"으로 한다. 나이는 '만'으로 계산한다.)
-- 실행 월에 따라 결과 값 다를 수 있으므로 PROFESSOR_SSN 같이 SELECT 해서 확인해보기!!
SELECT
    PROFESSOR_NAME 교수명
    , '만 '
    , FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(
    CASE
    WHEN TO_NUMBER(SUBSTR(PROFESSOR_SSN, 1, 2)) < 30 THEN
    '20' || SUBSTR(PROFESSOR_SSN, 1, 2)
    ELSE
    '19' || SUBSTR(PROFESSOR_SSN, 1, 2)
    END
    || SUBSTR(PROFESSOR_SSN, 3, 4), 'YYYYMMDD'))/12) AS 나이
    , '세'
FROM TB_PROFESSOR
ORDER BY 나이 DESC 
, PROFESSOR_NAME ASC
;

-- 정답
SELECT
    PROFESSOR_NAME "교수이름",
    TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE('19'||SUBSTR(PROFESSOR_SSN, 1, 2), 'YYYY'))/12) "나이"
    FROM TB_PROFESSOR
    WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY 2, 1; -- 나이가 동일하면 이름 가지고 정렬 -- ASC 생략됨

-- 25-05-12 다시풀어봄

SELECT PROFESSOR_NAME 이름
       , TRUNC((SYSDATE - TO_DATE(SUBSTR('19' || PROFESSOR_SSN, 1, 8) , 'YYYYMMDD')) / 365) 만나이
FROM TB_PROFESSOR
ORDER BY 2, 1;


/* 
교수 나이 (별칭)
, (SUBSTR(SYSDATE, 'YYYY/') - SUBSTR(PROFESSOR_SSN, 1, 6)) AS PROFESSOR_AGE 
, FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6), 'YYMMDD')) / 12) AS 나이
*/




-- 4번
-- 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오. 출력 헤더는 "이름"이 찍히도록 한다.
-- (성이 2자인 경우의 교수는 없다고 가정하시오)
SELECT
    STUDENT_NO
    , STUDENT_NAME
FROM TB_STUDENT
WHERE
    (TO_NUMBER(TO_CHAR(ENTRANCE_DATE, 'YYYY')) -
        CASE
            WHEN SUBSTR(STUDENT_SSN, 1, 2) <= '23' THEN 2000 + TO_NUMBER(SUBSTR(STUDENT_SSN, 1, 2))
            ELSE 1900 + TO_NUMBER(SUBSTR(STUDENT_SSN, 1, 2))
        END
    ) = 20;

SELECT
    SUBSTR(PROFESSOR_NAME, 2) AS 이름
FROM TB_PROFESSOR;

-- 5번
-- 춘 기술대학교의 재수생 입학자 학번과 이름을 표시하시오.(이때, 19살에 입학하면 재수를 하지 않은 것으로 간주)
-- 문제에서 요구하는 내용은 현역과 삼수생을 모두 제외한 재수생만 추려내는 것 (삼수생도 포함한 결과는 245행)
-- 0301생인 김정현 학생을 제외시키기 위해 19 초과 20 이하라는 조건식 사용
SELECT
    STUDENT_NO
    , STUDENT_NAME
FROM TB_STUDENT
;

/*
WHERE 19 < 나이 <= 20 -- (입학 년도 - 주민번호 앞글자 = 입학 년도 기준 나이 MUST BE 재수생 IS (19 < 나이 <= 20) )
ENTRANCE_DATE - SUBSTR(STUDENT_SSN, 1, 2) --> YYYY 형태로 변환해서 계산해야할듯 OR 다른방법?

*/


-- 6번
-- 2020년 크리스마스는 무슨 요일인가?
--'DAY': 금요일 'DY': 금 'D': 6
SELECT
    TO_CHAR(TO_DATE('2020-12-25', 'YYYY-MM-DD'), 'DAY') AS "요일"
FROM DUAL
;

-- 7번
-- TO_DATE('99/10/11', 'YY/MM/DD'), TO_DATE('49/10/11', 'YY/MM/DD')은 각각 몇 년 몇 월 몇 일을 의미할까?
-- 또 TO_DATE('99/10/11', 'RR/MM/DD'), TO_DATE('49/10/11', 'RR/MM/DD')은 각각 몇 년 몇 월 몇 일을 의미할까?
-- YY는 모두 2000년대
-- RR은 49이하는 2000년대 50이상은 1900년대
SELECT
    TO_DATE('99/10/11', 'YY/MM/DD')
    , TO_DATE('49/10/11', 'YY/MM/DD')
    , TO_DATE('99/10/11', 'RR/MM/DD')
    , TO_DATE('49/10/11', 'RR/MM/DD')
FROM DUAL
;

-- 정답
SELECT TO_CHAR(TO_DATE('99/10/11', 'YY/MM/DD'),'YYYY'), 
       TO_CHAR(TO_DATE('49/10/11', 'YY/MM/DD'),'YYYY'),
       TO_CHAR(TO_DATE('99/10/11', 'RR/MM/DD'), 'RRRR'), 
       TO_CHAR(TO_DATE('49/10/11', 'RR/MM/DD'), 'RRRR')
FROM DUAL;



-- 8번
-- 춘 기술대학교의 2000년도 이후 입학자들은 학번이 A로 시작하게 되어있다. 
-- 2000년도 이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.
SELECT
    STUDENT_NO
    , STUDENT_NAME
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO, 1, 1) <> 'A'
;

-- 정답
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- 9번
-- 학번이 A517178인 한아름 학생의 학점 총 평점을 구하는 SQL문을 작성하시오.
-- 단, 이때 출력 화면의 헤더는 "평점"이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
SELECT
    ROUND(AVG(POINT), 1) AS 평점
FROM TB_GRADE
WHERE STUDENT_NO LIKE 'A517178'
;

-- 10번
-- 학과별 학생 수를 구하여 "학과번호", "학생수(명)"의 형태로 칼럼명을 만들어 결과값이 출력되도록 하시오.
SELECT
    DEPARTMENT_NO AS "학과번호"
    , CAPACITY AS "학생수(명)" -- 정원이 아니라 "학생수"
FROM TB_DEPARTMENT
ORDER BY DEPARTMENT_NO
;

-- 정답
SELECT DEPARTMENT_NO 학과번호, COUNT(*) 학생수
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 11번
-- 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는지 알아내는 SQL문을 작성하시오
SELECT
    COUNT(STUDENT_NO) 학생수
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL
;

-- 정답
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 결과동일

-- 12번
-- 학번이 A112113인 김고운 학생의 년도 별 평점을 구하는 SQL문을 작성하시오.
-- 단, 이때 출력화면의 헤더는 "년도", "년도 별 평점"이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
SELECT
    SUBSTR(TERM_NO, -6, 4) AS "년도"
    , ROUND(AVG(POINT), 1) AS "년도 별 평점"
FROM TB_GRADE 
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, -6, 4)
;

-- 정답
SELECT SUBSTR(TERM_NO, 1, 4) AS 년도, ROUND(AVG(POINT), 1) AS "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1;

-- 결과동일

-- 13번
-- 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL문장을 작성하시오.
SELECT
    COUNT(STUDENT_NO) AS "휴학생 수"
    , DEPARTMENT_NO AS "학과 번호"
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
GROUP BY DEPARTMENT_NO
;
-- WHERE쓰는 것도 맞음.. 그러나 휴학생이 안나올 때 문제 있다.. 그래서 아래처럼 DECODE 써야됨

-- 정답
SELECT DEPARTMENT_NO 학과코드명, COUNT(DECODE(ABSENCE_YN, 'Y', 1, NULL)) "휴학생 수" -- 휴학생이면 1, 아니면 NULL
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;
-- count 그룹함수는 null값을 취급 x -- 휴학생이면 값 냅두고 휴학생이 아니면 null로 바꿈
--결과다름

-- COUNT(DECODE(ABSENCE_YN, 'Y', 1, NULL)) 의 부연설명
-- 만일 ABSENCE_YN의 값이 'Y'였을 경우 COUNT(1)이 되어 갯수를 세게 되고
--     ABSENCE_YN의 값이 'Y'가 아니였을 경우 COUNT(NULL)이 되어 갯수를 세지 않게되는 원리!!

-- 14번
-- 춘 대학교에 다니는 동명이인 학생들의 이름을 찾고자 한다.
-- 어떤 SQL 문장을 사용하면 가능하겠는가?
-- 어떤 SQL 문장을 사용하면 가능하겠는가?

SELECT
    STUDENT_NAME AS 동일인물
    , COUNT(*) AS "동명인 수"
FROM TB_STUDENT
HAVING COUNT(*) >= 2
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1 -- 1명이면 안보이게
ORDER BY 1;

-- 정답, 결과 동일

-- 15번
-- 학번이 A112113인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점, 총 평점을 구하는 SQL문을 작성하시오.
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)
SELECT
    SUBSTR(TERM_NO, -6, 4) AS "년도"
    , SUBSTR(TERM_NO, 5, 2) AS "학기"
    , ROUND(AVG(POINT), 1) AS "학기 별 평점"
    -- 년도 별 누적 평점 -- ROUND(AVG(POINT), 1) AS "누적 평점"
    -- 총 평점 -- ROUND((AVG(POINT), 1) + (AVG(POINT), 1)) AS "총 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, -6, 4), SUBSTR(TERM_NO, 5, 2)
ORDER BY 1
;

-- 정답
SELECT SUBSTR(TERM_NO, 1, 4) AS 년도,
       SUBSTR(TERM_NO, 5, 2) AS 학기,
       ROUND(AVG(POINT),1) AS 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2))
ORDER BY SUBSTR(TERM_NO,1,4);

-- ROLLUP : 통계를 낼 수 있는 함수 