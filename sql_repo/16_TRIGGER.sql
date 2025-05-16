/*
    <TRIGGER>
        테이블이 INSERT, UPDATE, DELETE 등 DML 구문에 의해서 변경될 경우
        자동으로 실행될 내용을 정의해놓는 객체이다.
        
        * 트리거의 종류
          1) SQL 문의 실행 시기에 따른 분류
            - BEFORE TRIGGER : 해당 SQL 문장 실행 전에 트리거를 실행한다.
            - AFTER TRIGGER : 해당 SQL 문장 실행 후에 트리거를 실행한다.
          
          2) SQL 문에 의해 영향을 받는 행에 따른 분류
            - 문장 트리거 : 해당 SQL 문에 한 번만 트리거를 실행한다.
            - 행 트리거 : 해당 SQL 문에 영향을 받는 행마다 트리거를 실행한다.
            
        [문법]
            CREATE OR REPLACE TRIGGER 트리거명
            BEFORE|AFTER INSERT|UPDATE|DELETE ON 테이블명
            [FOR EACH ROW]
            DECLARE
                선언부
            BEGIN
                실행부
            EXCEPTION
                예외처리부
            END;
            /
*/

--> 주문에 어떤 데이터가 insert가 되었을 때 상품 테이블에도 업데이트/변화가 생겨야 한다.
--> 비즈니스 로직은 트리거로 처리하지 않아서 쓸일이 거의 없다, 쓸일이 있다면 로그 남기는 정도,, 여기 insert가 됐다, update가 됐다 할 때
--> 비즈니스 관점에서는 트리거가 손해일 수 있음

CREATE TABLE PRODUCT (
    NAME VARCHAR2(100)
    , STOCK NUMBER
);

INSERT INTO PRODUCT(NAME, STOCK) VALUES('우산', 100);
INSERT INTO PRODUCT(NAME, STOCK) VALUES('키보드', 100);
INSERT INTO PRODUCT(NAME, STOCK) VALUES('갤럭시', 100);

DROP TABLE "ORDER";
CREATE TABLE PRODUCT_ORDER(
    NAME    VARCHAR2(100)
    ,CNT    NUMBER
);

INSERT INTO PRODUCT_ORDER(NAME, CNT) VALUES('우산', 5);
INSERT INTO PRODUCT_ORDER(NAME, CNT) VALUES('키보드', 3);
INSERT INTO PRODUCT_ORDER(NAME, CNT) VALUES('갤럭시', 1);

SELECT * FROM PRODUCT;
SELECT * FROM PRODUCT_ORDER;

UPDATE PRODUCT
    SET 
        STOCK = STOCK - 5
    WHERE NAME = '우산'
;

CREATE OR REPLACE TRIGGER T01
AFTER INSERT ON PRODUCT_ORDER
FOR EACH ROW
BEGIN
    UPDATE PRODUCT
        SET
            STOCK = STOCK - :NEW.CNT
        WHERE NAME = :NEW.NAME;
END;
/
--행 트리거 / 문장 트리거