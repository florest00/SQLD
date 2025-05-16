/*
    <PROCEDURE>
        PL/SQL 문을 저장하는 객체이다.
        필요할 때마다 복잡한 구문을 다시 입력할 필요 없이 간단하게 호출해서 실행 결과를 얻을 수 있다.
        특정 로직을 처리하기만 하고 결과값을 반환하지 않는다.
        
        [문법]
            CREATE PROCEDURE 프로시저명
            (
                매개변수 1 [IN/OUT] 테이터타입 [:=DEFAULT 값],
                매개변수 2 [IN/OUT] 테이터타입 [:=DEFAULT 값],
                ...
            )
            IS [or AS] -- IS 아니면 AS 둘다 써도 ok
                선언부
            BEGIN
                실행부
            EXCEPTION
                예외처리부
            END [프로시저명];
            /
            
        [실행방법]
            EXECUTE(EXEC) 프로시저명[(매개값1, 매개값2, ...)];
*/
--DROP VIEW ABC;

CREATE OR REPLACE PROCEDURE ABC -- REPLACE는 덮어쓰기함
-- ABC는 프로시저가 아님
(
    X EMPLOYEE.EMP_ID%TYPE
) -- 파라미터
IS
BEGIN
    DELETE FROM EMPLOYEE
    WHERE EMP_ID = X;
END;
/

-- EXECUTE ABC(&ID); --대체변수
EXECUTE ABC(200);  -- 여기 있는 값이 위 파라미터에 전달이 됨


/*
    <FUNCTION>
        프로시저와 사용 용도가 비슷하지만
        프로시저와 다르게 OUT 변수를 사용하지 않아도 실행 결과를 되돌려 받을 수 있다.(RETURN )
        
        [문법]
            CREATE FUNCTION 함수명
            (
                매개변수 1 타입,
                매개변수 2 타입,
                ...
            )
            RETURN 데이터타입
            IS
                선언부
            BEGIN
                실행부
                
                RETRUN 반환값; -- 프로시저랑 다르게 RETURN 구문이 추가된다.
            EXCEPTION
                예외처리부
            END [함수명];
            /
*/

-- 사번을 입력받아 해당 사원의 보너스를 포함하는 연봉을 계산하고 리턴하는 함수 생성
CREATE FUNCTION F01( X EMPLOYEE.EMP_ID%TYPE ) RETURN NUMBER
IS
    A
    B
BEGIN
    --보너스포함 연봉 계싼
    SELECT SALARY + ((SALARY * NVL(BONUS,0))) * 12 AS 연봉
    FROM EMPLOYEE
    WHERE EMP_ID = '201';
    
    RETURN ~~~; 
END;
/

SELECT EMP_NAME, (SALARY + (SALARY * NVL(BONUS , 0))) * 12 보너스포함연봉
FROM EMPLOYEE
WHERE EMP_ID = '201'
;

CREATE OR REPLACE FUNCTION BONUS_CALC
(
    V_EMP_ID EMPLOYEE.EMP_ID%TYPE
)
RETURN NUMBER
IS
    V_SAL EMPLOYEE.SALARY%TYPE;
    V_BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT SALARY, NVL(BONUS, 0)
    INTO V_SAL, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
    
    RETURN (V_SAL + (V_SAL * V_BONUS)) * 12;
END;
/


SELECT BONUS_CALC(201)
FROM DUAL
;

/*
    <CURSOR>
        SQL 문의 처리 결과(처리 결과가 여러 행(ROW))를 담고 있는 객체이다.
        커서 사용 시 여러 행으로 나타난 처리 결과에 순차적으로 접근이 가능하다.
        
        [커서 속성]
            커서명%NOTFOUND : 커서 영역에 남아있는 ROW 수가 없다면 TURE, 아니면 FALSE
            커서명%FOUND    : 커서 영역에 남아있는 ROW 수가 한 개 이상일 경우 TRUE, 아니면 FALSE
            커서명%ISOPEN   : 커서가 OPEN 상태인 경우 TRUE, 아니면 FALSE
            커서명%ROWCOUNT : SQL 처리 결과로 얻어온 행(ROW)의 수
        
        [사용 방법]
            1) CURSOR 커서명 IS ..     : 커서 선언
            2) OPEN 커서명;            : 커서 오픈
            3) FETCH 커서명 INTO 변수, ...   : 커서에서 데이터 추출(한 행씩 데이터를 가져온다.)
            4) CLOSE 커서명            : 커서 닫기
        
        [문법]
            CURSOR 커서명 IS [SELECT 문]
            
            OPEN 커서명;
            FETCH 커서명 INTO 변수;
            ...
            
            CLOSE 커서명;
*/

--> 99.9% 커서를 다룰 일 없어서 실습 無