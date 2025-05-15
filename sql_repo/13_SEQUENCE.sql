/*
    <SEQUENCE>
        정수값을 순차적으로 생성하는 역할을 하는 객체이다.
        -> 1씩 증가하는 값을 만들어준다,
        
    <SEQUENCE 생성>
        [문법]
            CREATE SEQUNCE 시퀀스명
            [START WITH 숫자]
            [INCREMENT BY 숫자]
            [MAXVALUE 숫자]
            [MINVALUE 숫자]
            [CYCLE | NOCYCLE] --> 다음값 다음값 ., 최대값 다시 맨 앞으로 돌아와서 1부터... 회원 한명한명 식별해야하니까.. NOCYCLE 옵션 씀,, 시퀀스 마지막에 도달했을때
            [CACHE 바이트크기 | NOCACHE]; (기본값 20 바이트) --> 캐싱되지 말라고 NOCACHE를 쓰는데 캐싱이 뭐여? 미리 가져오는거 -> 데이터를 미리 가져오는 걸 캐싱이라고 함.. 창고에서 꺼내오기 귀찮고 미리 손에 들고 있으면 그때그때 주면되니까.. 캐싱을 하다가 서버?가 죽으면 데이터도 같이 죽어서 NOCACHE하는거
            
        [사용 구문]
            시퀀스명.CURRVAL : 현재 시퀀스의 값
            시퀀스명.NEXTVAL : 시퀀스 값을 증가시키고 증가된 시퀀스 값
                              (기존 시퀀스 값에서 INCREAMENT 값 만큼 증가된 값)
                              
        * 캐시메모리
          - 미리 다음 값들을 생성해서 저장해둔다.
          - 매번 호출할 때마다 시퀀스 값을 새로 생성을 하는 것이 아닌 캐시 메모리 공간에 미리 생성된 값들을 사용한다.
*/


-- 멤버테이블 기본키.. ID

CREATE SEQUENCE SEQ_MEMBER;

--시퀀스.NEXTVAL --> 다음 값을 나오게 함
SEQ_MEMBER.NEXTVAL

SELECT SEQ_MEMBER.NEXTVAL
FROM DUAL; --> 이거 실행하면 숫자 1씩 증가함
SELECT SEQ_MEMBER.CURRVAL
FROM DUAL; --> CURRVAL은 현재값 확인가능

DROP SEQUENCE SEQ_MEMBER;
CREATE SEQUENCE SEQ_MEMBER 
NOCACHE NOCYCLE; -- 엔터키 상관 x

DROP TABLE MEMBER CASCADE CONSTRAINTS;

DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    NO              NUMBER          DEFAULT SEQ_MEMBER.NEXTVAL PRIMARY KEY
    , ID            VARCHAR2(100)   NOT NULL UNIQUE
    , PWD           VARCHAR2(100)   CHECK( LENGTH(PWD) >= 4 )
    , NICK          VARCHAR2(100)   
    , ENROLL_DATE   TIMESTAMP       DEFAULT SYSDATE
);

INSERT INTO MEMBER (
    --NO
    ID
    , PWD
    , NICK
)
VALUES
(
    --SEQ_MEMBER.NEXTVAL
    'USER04'
    , '1234'
    , 'HELLO'
)
;