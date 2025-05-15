/*
    <DDL(Data Definition Language)>
        데이터 정의 언어로 오라클에서 제공하는 객체를 만들고(CREATE), 변경하고(ALTER), 삭제하는(DROP) 등
        실제 데이터 값이 아닌 데이터의 구조 자체를 정의하는 언어로 DB 관리자, 설계자가 주로 사용한다.

    <ALTER>
        오라클에서 제공하는 객체를 수정하는 구문이다.
    
    <테이블 수정>
        [문법]
            ALTER TABLE 테이블명 수정할 내용;
            
        * 수정할 내용
            1) 칼럼 추가/수정/삭제
            2) 제약 조건 추가/삭제 --> 수정은 불가능(삭제한 후 새로 추가해야 한다.)
            3) 테이블명/ 칼럼명 / 제약조건명 변경
*/

--1) 칼럼 추가/수정/삭제 
--  1-1) 칼럼 추가(ADD) : ALTER TALBE 테이블명 ADD 칼럼명 테이터타입 [DEFAULT 기본값];
-- 기본값을 지정하지 않으면 새로 추가된 칼럼은 NULL값으로 채워진다.

INSERT INTO MEMBER(ID,PWD,NICK) VALUES('USER01','1234','홍길동');
INSERT INTO MEMBER(ID,PWD,NICK) VALUES('USER02','1234','홍길동');
INSERT INTO MEMBER(ID,PWD,NICK) VALUES('USER03','1234','홍길동');

ALTER TABLE MEMBER ADD EMAIL VARCHAR2(100);
ALTER TABLE MEMBER ADD LOCAL VARCHAR2(100) DEFAULT '한국';


--  1-2) 칼럼 수정(MODIFY)
--    데이터 타입 변경 : ALTER TABLE 테이블명 MODIFY 컬럼명 변경할 데이터타입;
--    기본값 변경 : ALTER TABLE 테이블명 MODIFY 컬럼명 DEFALUT 변경할 기본값;

ALTER TABLE MEMBER MODIFY ID VARCHAR2(50);
ALTER TABLE MEMBER MODIFY ID VARCHAR2(5);

-- ALTER 이용하여 다중 수정 또한 가능하다

--   1-3) 칼럼 삭제 (DROP COLUMN) : ALTER TABLE 테이블명 DROP COLUMN 칼럼명;
--     데이터 값이 기록되어 있어도 같이 삭제된다. (단, 삭제된 칼럼 복구는 불가능)
--     테이블에는 최소 한 개의 칼럼은 존재해야 한다.
--     참조되고 있는 칼럼이 있다면 삭제가 불가능하다.

ALTER TABLE MEMBER DROP COLUMN EMAIL;
ALTER TABLE MEMBER DROP COLUMN LOCAL;

---------------------------
-- 2) 제약조건 추가/삭제
--  2-1) 제약조건 추가
--      PRIMARY KEY : ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] PRIMARY KEY(칼럼명);
--      FOREIGN KEY : ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] FOREIGN KEY(칼럼명) REFERENCES 테이블명 [(칼럼명)];
--      UNIQUE      : ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] UNIQUE(칼럼명);
--      CHECK       : ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] CHECK(칼럼에 대한 조건);
--      NOT NULL    : ALTER TABLE 테이블명 MODIFY 칼럼명 [CONSTRAINT 제약조건명] NOT NULL;

-- 3) 테이블명/칼럼명/제약조건명 변경
--  3-1) 칼럼명 변경 : ALTER TABLE 테이블명 RENAME COLUMN 기존칼럼명 TO 변경할칼럼명;

--  3-2) 제약조건명 변경 : ALTER TABLE 테이블명 RENAME CONSTRAINT 기존제약조건명 TO 변경할제약조건명;

--  3-3) 테이블명 변경

--------------------------------------------------
/*
    <DROP>
        오라클에서 제공하는 객체를 삭제하는 구문이다.
        
    * 단, 참조되고 있는 부모 테이블은 함부로 삭제가 되지 않는다.
      만약에 삭제하고자 한다면
      
      1) 자식 테이블 먼저 삭제한 후 부모 테이블을 삭제하는 방법
      2) 부모 테이블을 삭제할 때 제약조건도 함께 삭제하는 방법
      DROP TABLE STUDENT CASCADE CONSTRAINTS;
*/


--   1-3) 칼럼 삭제 (DROP COLUMN) : ALTER TABLE 테이블명 DROP COLUMN 칼럼명;
--     데이터 값이 기록되어 있어도 같이 삭제된다. (단, 삭제된 칼럼 복구는 불가능)
--     테이블에는 최소 한 개의 칼럼은 존재해야 한다.
--     참조되고 있는 칼럼이 있다면 삭제가 불가능하다.

DROP TABLE STUDENT CASCADE CONSTRAINTS;
DROP TABLE GRADE;