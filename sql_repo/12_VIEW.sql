/*
    <VIEW>
        SELECT 문을 저장할 수 있는 객체이다.(논리적인 가상 테이블)
        데이터를 저장하고 있지 않으며 테이블에 대한 SQL만 저장되어 있어 VIEW 접근할 때 SQL을 수행하면서 결과값을 가져온다.
        
        [문법]
            CREATE [OR REPLACE] VIEW 뷰명
            AS 서브 쿼리;
*/

--> 오라클 장점
--> 

CREATE OR REPLACE VIEW ABC
AS SELECT NICK FROM MEMBER;

SELECT *
FROM ABC
;

-- KH 계정에 VIEW 객체를 생성할 수 있는 권한을 부여
-- SYSTEM 계정으로 실행할 것
--GRANT CREATE VIEW TO C##KH;