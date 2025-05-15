
/*
    <DML(Data Manipulation Language)>
        데이터 조작 언어로 테이블에 값을 삽입(INSERT)하거나, 수정(UPDATE), 삭제(DELETE)하는 구문이다.
    
    <INSERT>
        테이블에 새로운 행을 추가하는 구문이다.
        
        [문법]
            1) INSERT INTO 테이블명 VALUES(값, 값, 값, ..., 값);
                테이블에 모든 칼럼에 값을 INSERT 하고자 할 때 사용한다.
                칼럼 순번을 지켜서 VALUES에 값을 나열해야 한다.
            2) INSERT INTO 테이블명(칼럼명, 칼럼명, ..., 칼럼명) VALUES(값, 값, ..., 값);
                테이블에 내가 선택한 칼럼에 대한 값만 INSERT 하고자 할 때 사용한다.
                선택이 안된 칼럼들은 기본적으로 NULL 값이 들어간다. (NOT NULL 제약조건이 걸려있는 칼럼은 반드시 선택해서 값을 제시해야 한다.)
                단, 기본값(DEFAULT)이 지정되어 있으면 NULL이 아닌 기본값이 들어간다.
            3) INSERT INTO 테이블명 (서브쿼리);
                VALUES를 대신해서 서브 쿼리로 조회한 결과값을 통채로 INSERT 한다.(즉, 여러행을 INSERT 시킬 수 있다.)
                서브 쿼리의 결과값이 INSERT 문에 지정된 칼럼의 개수와 데이터 타입이 같아야 한다.
*/

-- MEMBER 테이블에 유저 추가하기 (USER0515, 1234, NICK0515) -- ID, PWD, NICK

INSERT INTO MEMBER(ID, PWD, NICK) VALUES('USER0515','1234','NICK0515');

SELECT *
FROM MEMBER;

-- EMPLOYEE 테이블에 사원 추가
--'900'

/*
EMP_ID      '900'
EMP_NAME    '공유'
EMP_NO      '901008-1080503'
EMAIL       'you@kh.or.kr'
PHONE       '01055556666'
DEPT_CODE   'D1'
JOB_CODE    'J7'
SALARY      4000000
BONUS       0.2
MANAGER_ID  '200'
HIRE_DATE   SYSDATE
ENT_DATE    NULL
ENT_YN      DEFAULT
*/

DROP TABLE "EMPLOYEE";
 CREATE TABLE "EMPLOYEE"
   (   EMP_ID, 
   EMP_NAME, 
   EMP_NO, 
    EMAIL, 
   PHONE, 
   DEPT_CODE, 
   JOB_CODE, 
   SALARY, 
   BONUS, 
   MANAGER_ID, 
   HIRE_DATE, 
   ENT_DATE, 
   ENT_YN
   )
   VALUES
   (
   '900'
    , '공유'
    , '901008-1080503'
    , 'you@kh.or.kr'
    , '01055556666'
    , 'D1'
    , 'J7'
    , 4000000
    , 0.2
    , '200'
    , SYSDATE
    , NULL
    , DEFAULT
   )
   
   DROP TABLE EMPLOYEE;
   CREATE TABLE "EMPLOYEE";
   INSERT INTO EMPLOYEE (
   EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE, 
   SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN
)
VALUES (
   '900',
   '공유',
   '901008-1080503',
   'you@kh.or.kr',
   '01055556666',
   'D1',
   'J7',
   4000000,
   0.2,
   '200',
   SYSDATE,
   NULL,
   DEFAULT
);

SELECT *
FROM EMPLOYEE;
   
   
   
   
   
   
   
   
   
   
   
   
   
   CREATE TABLE EMPLOYEE (
   EMP_ID      VARCHAR2(10),
   EMP_NAME    VARCHAR2(50),
   EMP_NO      VARCHAR2(20),
   EMAIL       VARCHAR2(100),
   PHONE       VARCHAR2(20),
   DEPT_CODE   VARCHAR2(10),
   JOB_CODE    VARCHAR2(10),
   SALARY      NUMBER(10),
   BONUS       NUMBER(4,2),
   MANAGER_ID  VARCHAR2(10),
   HIRE_DATE   DATE,
   ENT_DATE    DATE,
   ENT_YN      CHAR(1) DEFAULT 'N'
);

   
   
   
   
   
   
   
   
   
   
   INSERT INTO EMPLOYEE (
   EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE, 
   SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN
)
VALUES (
   '900',
   '공유',
   '901008-1080503',
   'you@kh.or.kr',
   '01055556666',
   'D1',
   'J7',
   4000000,
   0.2,
   '200',
   SYSDATE,
   NULL,
   DEFAULT
);

   
   
   
   
   /*
    <INSERT ALL>
        두 개 이상의 테이블에 INSERT 하는데 동일한 서브 쿼리가 사용되는 경우
        INSERT ALL을 이용해서 여러 테이블에 한 번에 데이터 삽입이 가능하다.
        
        [문법]
            1) INSERT ALL
               INTO 테이블명1[(칼럼, 칼럼, ...)] VALUES(값, 값, ...)
               INTO 테이블명2[(칼럼, 칼럼, 칼럼, ...)] VALUES(값, 값, 값, ...)
               서브 쿼리;
               
            2) INSERT ALL
               WHEN 조건1 THEN 
                   INTO 테이블명1[(칼럼, 칼럼, ...)] VALUES(값, 값, ...)
               WHEN 조건2 THEN     
                   INTO 테이블명2[(칼럼, 칼럼, ...)] VALUES(값, 값, ...)
               서브 쿼리;
*/









/*
    <UPDATE>
        테이블에 기록된 데이터를 수정하는 구문이다.
         
        [문법]
            UPDATE 테이블명
            SET 칼럼명 = 변경하려는 값,
                칼럼명 = 변경하려는 값,
                ...
            [WHERE 조건];

            UPDATE 테이블명
            SET 칼럼명 = (서브 쿼리),
                칼럼명 = (서브 쿼리),
                ...
            [WHERE 조건];

        - SET 절에서 여러 개의 칼럼을 콤마(,)로 나열해서 값을 동시에 변경할 수 있다.
        - WHERE 절을 생략하면 모든 행의 데이터가 변경된다.
        - UPDATE 시에 서브 쿼리를 사용해서 서브 쿼리를 수행한 결과값으로 칼럼의 값을 변경할 수 있다.
*/

-- 모든 유저의 닉네임을 게스트로 변경 ('GUEST')
UPDATE MEMBER
    SET
        NICK = 'GUEST'
;

-- ID가 USER02 인 유저의 비밀번호를 0000 으로 변경
UPDATE MEMBER
    SET
        PWD = '0000'
    WHERE ID = 'USER02'
;


/*
    <DELETE>
        테이블에 기록 된 데이터를 삭제하는 구문이다. (행 단위로 삭제한다.)
        
        [문법]
            DELETE FROM 테이블명
            [WHERE 조건식];
            
        - WHERE 절을 제시하지 않으면 전체 행이 삭제된다.
*/


-- ID가 USER02인 회원 삭제
DELETE FROM MEMBER -- FROM 생략 가능
WHERE ID = 'USER02'
;

-- 칼럼 전체 삭제는 테이블 구조가 변경되어서 ALT 이용해서 칼럼 삭제 가능

COMMIT;

DELETE MEMBER;

ROLLBACK; --데이터 살림 -- 마지막 커밋 시점으로 돌아감

-- 멤버 테이블의 모든 데이터를 다 자르게 됨 -- 실행하면 DELETE처럼 테이블의 데이터가 사라짐
TRUNCATE TABLE MEMBER;