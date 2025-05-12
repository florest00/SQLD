-- 사용자 계정 생성
/*
여러줄 주석 ~~~
ㅋㅋㅋ
*/

-- 사용자 계정 생성 구문 (관리자만 가능)
-- [문법] CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER C##KH IDENTIFIED BY 1234;

-- 권한 부여
-- GRANT 권한1, 권한2, ... TO 계정명;
GRANT CONNECT, RESOURCE TO C##KH;

ALTER USER C##KH DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

