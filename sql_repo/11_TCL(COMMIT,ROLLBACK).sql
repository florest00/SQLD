/*
    <TCL(Transaction Control Language)>
        트랜잭션을 제어하는 언어이다.
        
        * 트랜잭션
          - 하나의 논리적인 작업 단위를 트랜잭션이라고 한다.
            ATM에서 현금 출금
              1. 카드 삽입
              2. 메뉴 선택
              3. 금액 확인 및 인증
              4. 실제 계좌에서 금액만큼 차감
              5. 실제 현금 인출
              6. 완료
          - 각각의 작업들을 묶어서 하나의 작업 단위로 만들어 버리는 것을 트랜잭션이라고 한다.
          - 하나의 트랜잭션으로 이루어진 작업들은 반드시 한꺼번에 완료가 되어야 하며, 그렇지 않을 경우에는 한꺼번에 취소되어야 한다.
          - 데이터의 변경 사항(DML(INSERT, UPDATE, DELETE))들을 묶어서 하나에 트랜잭션에 담아 처리한다.
          - COMMIT(트랜잭션 종료 처리 후 저장), ROLLBACK(트랜잭션 취소), SAVEPOINT(임시저장)를 통해서 트랜잭션을 제어한다.
          
          --> ROLLBACK은 마지막 커밋 지점으로 돌아감
          --> commit 작업 내용 저장
          --> 적절한 단위(6번 완료까지 오면)마다 커밋 찍어줘라. 매번 찍는 게 아니라
          --> savepoint는 잘 안씀
          
          -- DDL 구문을 실행하는 순간 기존에 메모리 버퍼에 임시 저장된 변경사항들이 무조건 DB에 반영된다.(COMMIT 시켜버린다.)
          -- DDL 실행하면 커밋 자동으로 실행됨
*/


INSERT INTO MEMBER(ID,PWD,NICK) VALUES('USER01','1234','홍길동');
INSERT INTO MEMBER(ID,PWD,NICK) VALUES('USER02','1234','홍길동');
INSERT INTO MEMBER(ID,PWD,NICK) VALUES('USER03','1234','홍길동');

SELECT * FROM MEMBER;
--> 실제로 오라클에 반영되어 있진 않고, SQLD에서 어떤 통로?에 반영이 된것뿐

COMMIT;
--> 얘 해주면 오라클에 반영됨

DELETE MEMBER;
ROLLBACK;

DELETE MEMBER WHERE ID = 'USER01';
COMMIT;

DELETE MEMBER WHERE ID = 'USER02';
COMMIT;

DELETE MEMBER WHERE ID = 'USER03';
ROLLBACK;

SAVEPOINT ABC;
ROLLBACK TO ABC;
--> 이렇게 쓸 수도 있긴한데 사용 x
--> 임시저장 포인트를 만들 필요 x -> 자바에서 뭘 하기 땜시

