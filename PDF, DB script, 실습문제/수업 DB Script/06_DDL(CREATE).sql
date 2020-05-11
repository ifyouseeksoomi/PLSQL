/*
 - ★★★★★ 데이터 딕셔너리란?
   DB가 제공하는 자원을 효율적으로 관리하기 위한 다양한 정보를 저장하는 시스템 테이블
   
   데이터 딕셔너리는 사용자가 테이블을 생성하거나
   사용자를 생성, 수정하는 등의 작업을 할 때
   DB 서버에서 자동으로 갱신되는 테이블

  <예시 테이블>
  SELECT USERNAME
  FROM DBA_USERS;
  -- 시스템에 등록된 사용자 정보를 조회할 수 있는 딕셔너리 뷰
*/

-- DDL (DATA DEFINITION LANGUAGE): 데이터 정의 언어
-- 객체 (OBJECT)를 만들고(CREATE), 수정(ALTER), 삭제(DROP) 등 
-- 데이터의 전체 구조를 정의하는 언어로 
-- 주로 DB 관리자, 설계자가 사용함. (DATABASE ADMINISTRATOR)

-- 오라클에서의 객체(OBJECT)
/* 
    TABLE, VIEW(가상테이블로 인라인뷰, 딕셔너리뷰가 있음), SEQUENCE, 
    INDEX(색인: 검색 속도 향상용 객체), PACKAGE, TRIGGER, 
    PROCEDURE, FUNCTION, SYNONYM(동의어 객체), USER(우리의 경우, KH)
*/

------------------------------------------------------------------------------------------------------

-- CREATE (생성하다, 창조하다)

-- 테이블이나 뷰, 인덱스 등 다양한 DB 객체를 생성하는 구문
-- CREATE로 생성된 테이블은 DROP 구문을 통해 제거할 수 있음.

-- 1. TABLE 만들기
-- TABLE이란?
-- 행(ROW)과 열(COLUMN)으로 구성되는 가장 기본적인 데이터베이스 객체
-- 데이터베이스 내에서 모든 데이터는 테이블을 통해서 저장된다.

/*
[표현식]
CREATE TABLE 테이블명(
    컬럼명 데이터타입(크기)
    컬럼명 데이터타입(크기)
    컬럼명 데이터타입(크기)
    컬럼명 데이터타입(크기)
    컬럼명 데이터타입(크기)
    .....
    
    );
*/

CREATE TABLE MEMBER (
    MEMBER_ID VARCHAR2(30), -- VARCHAR2의 경우, 만일 abc만 들어가고 남는 27칸은 메모리로 자동 반환되게 되어있음
    MEMBER_PWD VARCHAR2(30),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_SSN CHAR(14), -- 주민번호는 14자리 고정이니깐 괜찮음 // CHAR의 경우, 만일 ABC만 들어가고 남은 11칸은 그대로 공백
    ENROLL_DATE DATE DEFAULT SYSDATE 
    -- 입력되는 값이 없거나 DEFAULT 입력시 오늘 날짜를 기록 (입력 기본값)
);
-- 속도는 CHAR가 빠르긴한데, VARCHAR2가 더 메모리 관리에는 좋음.

    
 -- MEMBER 테이블 생성 확인
SELECT * FROM MEMBER;

-- 2. 컬럼에 주석 달기
-- [표현식]
-- COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비번';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.MEMBER_SSN IS '주민번호';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '가입일자';

-- 번외: 컬럼에 주석 단 것 확인하기
SELECT * FROM USER_COL_COMMENTS WHERE TABLE_NAME = 'MEMBER';
SELECT * FROM USER_TAB_COMMENTS WHERE TABLE_NAME = 'MEMBER';

-- 200511 월

-- USER_TABLES: 사용자가 작성한 테이블을 확인하는 딕셔너리 뷰 (사전에 정의되어있는 가상 테이블)
SELECT * FROM USER_TABLES; -- KH 계정으로 만든 테이블들 조회

-- USER_TAB_COLUMNS: 
-- 테이블, 뷰, 클러스터의 컬럼과 관련된 정보를 조회하는 딕셔너리 뷰
SELECT * FROM USER_TAB_COLUMNS -- 위에 나왔던 테이블에 대한 모든 컬럼이 모두 조회됨
WHERE TABLE_NAME = 'MEMBER'; -- 지난주 금요일에 만든 멤버에 관련된 컬럼만 조회됨

-- DESC문: 테이블의 구조를 표시하는 구문
DESC MEMBER; -- JAVA 콘솔 모양으로 출력 (NOT LIKE RESULT SET)

-- MEMBER테이블에 샘플데이터 삽입
INSERT INTO MEMBER VALUES('MEM01', '123ABC', '홍길동', '000101-1234567', '2020-05-11');
-- INSERT: 테이블에 데이터(행)를 삽입하는 DML 구문 (위의 경우는 MEMBER테이블에)
-- ( ) 자리에는 컬럼에 넣을 값을 순서대로
-- 참고로 맨 마지막에 '2020-05-11' 이렇게 넣은 것은 알아서 날짜 포맷으로 들어간다

-- 데이터 삽입 확인
SELECT * FROM MEMBER;

-- INSERT까지 쓰면 마치 정말로 데이터가 생성된것 같겠지만 사실은 아님. 메모리 영역에 올라갔을 뿐.
-- 테이블에 조작된 내용(DML)을 실제로 DB에 반영하는 TCL구문은 바로
COMMIT; -- 커밋 완료. <<- 라고 떠야 실제로 DB에 반영됐다는 소리임.

-- 추가 샘플데이터 삽입
-- SYSDATE를 이용하여 가입일 저장
INSERT INTO MEMBER 
VALUES('MEM02', 'QWER1234', '김영희', '971208-2123456', SYSDATE); 

-- DEFAULT를 이용하여 가입일 저장
INSERT INTO MEMBER 
VALUES('MEM03', 'ASDF9876', '박철수', '930314-1122334', DEFAULT); 

-- 가입일 미작성 --> DEFAULT 값 반영 / DEFAULT가 없을 경우, NULL 삽입 
-- INSERT INTO MEMBER 이후 VALUE를 곧장 쓰지 않고 쓰는 방법
INSERT INTO MEMBER (MEMBER_ID, MEMBER_PWD, 
                                   MEMBER_NAME, MEMBER_SSN)
VALUES ('MEM04', '1Q2W3E4R', '이지연', '851011-2345678');

SELECT * FROM MEMBER;
COMMIT;
-- <주의> DB에 반영된 이후에는(커밋 이후에는) 수정이 상당히 번거로움


-- 주민등록번호를 NUMBER타입으로 했을 때의 문제점 
CREATE TABLE MEMBER2(
    MEMBER_ID VARCHAR2(30),
    MEMBER_PWD VARCHAR2(30),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_SSN NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE
);

INSERT INTO MEMBER2 VALUES('MEM01', '123ABC', '홍길동', 0001011234567, '2020-05-11');

SELECT * FROM MEMBER2;
-- <주의> NUMBER타입 컬럼에 데이터 삽입 시 
-- 시작 부분이 숫자 0인 경우 INSERT 시 0이 사라짐

-- <치트키>
DROP TABLE 테이블명; 
-- 하면 테이블을 삭제할 수 있다

-----------------------------------------------------------------------------------------------------------------

/* 제약 조건 (CONSTRAINTS)

- 사용자가 원하는 조건의 데이터만 유지하기 위해서
 특정 컬럼에 설정하는 제약
 
- 테이블 작성 시 각 컬럼에 대해 
 값 기록에 대한 제약 조건을 설정할 수 있다.
 
- 제약 조건을 설정함으로써 데이터 무결성을 보장
-- 데이터 무결성: 데이터의 정확성과 일관성을 유지하는 것
                        --> RDBMS에서 가장 중요한 기능이자 개념
                        --> NULL X, 중복 X
                        
- 제약 조건 사용 목적
 1) 데이터 무결성 보장
 2) 입력 데이터에 문제가 없는지 검사
 --> INSERT(삽입), UPDATE(수정) 시 자동으로 검사가 진행됨
 3) 데이터의 수정/삭제 여부 검사
 
- 제약 조건 종류
 -> NOT NULL(NULL값 X), UNIQUE(중복 X), 
     PRIMARY KEY(모든 행을 구별할 수 있는 식별자)
     FOREIGN KEY(테이블 컬럼 참조)
     CHECK(지정 값만 삽입할 수 있음)
                     
*/

-- USER_CONSTRAINTS
-- 사용자가 작성한 제약조건을 확인하는 딕셔너리 뷰
SELECT * FROM USER_CONSTRAINTS;

-- USER_CONS_COLUMNS
-- 제약조건이 걸려있는 컬럼을 확인하는 딕셔너리 뷰
SELECT * FROM USER_CONS_COLUMNS;

-----------------------------------------------------------------------------------------------------------------

-- 3. NOT NULL
-- 데이터 삽입/수정 시 NULL값을 허용하지 않도록 
-- 컬럼 레벨에서 제한하는 제약 조건

-- 해당 컬럼에 반드시 값이 기록되어야 하는 경우 사용

-- NOT NULL 제약 조건을 사용 X
CREATE TABLE USER_NOT_NN(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20),
    USER_NAME VARCHAR2(20),
    GENDER CHAR(1),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_NOT_NN
VALUES(1, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_NOT_NN
VALUES(2, NULL, NULL, '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
-- 컬럼 값에 NULL이 있어도 삽입 성공
--> 데이터 무결성(NULL값이 없어야한다)이 침해된 상태

-- NOT NULL 제약 조건을 사용 O
CREATE TABLE USER_USED_NN(
    USER_NO NUMBER NOT NULL, -- 컬럼 레벨로 제약조건 설정
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER CHAR(1),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_USED_NN
VALUES(1, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_NN
VALUES(2, NULL, NULL, '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
-- ORA-01400: cannot insert NULL into ("KH"."USER_USED_NN"."USER_ID") 에러 발생
--> USER_ID 컬럼에 설정된 NOT NULL 제약조건 위배로 오류 발생

-- 작성한 제약 조건 확인
SELECT * 
FROM USER_CONSTRAINTS C1
JOIN USER_CONS_COLUMNS C2 USING(CONSTRAINT_NAME)
WHERE C1.TABLE_NAME = 'USER_USED_NN';

-----------------------------------------------------------------------------------------------------------------

-- 4. UNIQUE 제약 조건
-- 컬럼의 입력 값에 대해서 중복을 제한하는 제약 조건
-- 컬럼 레벨, 테이블 레벨에서 설정 가능
-- ★★★ 단, UNIQUE 제약 조건이 설정된 컬럼에 NULL 값은 중복 삽입 가능 (NULL이니까)

-- USER_USED_NN 테이블에 중복 데이터 삽입
INSERT INTO USER_USED_NN
VALUES(1, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
--> 중복되는 회원 번호, 회원 아이디로 데이터가 삽입이 됨.

-- UNIQUE 제약 조건 설정 테이블 생성
CREATE TABLE USER_USED_UK( -- UNIQUE KEY의 줄임말
    USER_NO NUMBER UNIQUE, -- 컬럼 레벨로 제약조건 설정
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER CHAR(1),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    -- UNIQUE (USER_ID) 
    -- 테이블 가장 아래에 작성하는 것: 테이블 레벨 제약조건 설정
    CONSTRAINT UK_USER_ID UNIQUE (USER_ID) 
    -- 제약조건을 준 것 (위에 주석처리 한 것과 같은 효과다)
-- [CONSTRAINT 제약조건명] 제약조건타입(컬럼명) --> 가장 기본적인 테이블 레벨 제약 조건 설정 방법
-- ★★★ 그러나! 제약 조건 타입에 NOT NULL은 넣을 수 없다: 왜냐, 
-- NOT NULL은 오로지 컬럼 레벨, 테이블 레벨 불가
);

INSERT INTO USER_USED_UK
VALUES(1, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

-- 위와 똑같은 명령 두 번째
INSERT INTO USER_USED_UK
VALUES(1, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
-- ORA-00001: unique constraint (KH.SYS_C007049) violated 
-- 중복 데이터 삽입 시 UNIQUE 제약 조건 위배 에러 발생 
-- 이 데이터는 삽입이 되지 않는다. 확인?

SELECT * FROM USER_USED_UK; 
-- 1행밖에는 나오지 않는다 (2행은 안되었음)

INSERT INTO USER_USED_UK
VALUES(2, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
-- ORA-00001: unique constraint (KH.UK_USER_ID) violated
-- 254번째 줄에서 건 제약 조건명이 오류 내용에 첨부되는 것을 확인


-- UNIQUE 복합키
-- 두 개 이상의 컬럼을 묶어서 하나의 UNIQUE 제약 조건을 설정함
CREATE TABLE USER_USED_UK2 ( 
    USER_NO NUMBER, 
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER CHAR(1),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    UNIQUE (USER_NO, USER_ID) 
    -- 복합키는 테이블 레벨에서만 제약조건 설정 가능 
    -- 컬럼레벨로는 X
 );

INSERT INTO USER_USED_UK2
VALUES(1, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

-- USER_NO만 변경해서 삽입 --> 삽입 성공 (ID는 같으나, NO가 다름)
INSERT INTO USER_USED_UK2
VALUES(2, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

-- USER_ID만 변경해서 삽입 --> 역시 삽입 성공 (ID만 다르고, NO는 같음)
INSERT INTO USER_USED_UK2
VALUES(1, 'user02', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

-- USER_NO, USER_ID 모두 일치할 때 --> 삽입 실패!
INSERT INTO USER_USED_UK2
VALUES(1, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
-- ORA-00001: unique constraint (KH.SYS_C007052) violated 오류 발생!

SELECT UC.TABLE_NAME, UCC.COLUMN_NAME,
           UCC.CONSTRAINT_NAME, UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME=UCC.CONSTRAINT_NAME)
WHERE UCC.CONSTRAINT_NAME = 'SYS_C007052'; -- SYS_C007052가 제약 조건명임
-- 두 개의 UNIQUE 제약 조건이
-- 하나의 제약 조건명으로 설정되어 있는 것을 확인 --> 복합키

-- 제약 조건에 이름 설정
CREATE TABLE CONST_NAME (
    DATA1 VARCHAR2(20) CONSTRAINT NN_DATA1 NOT NULL, -- 컬럼 레벨로 설정
    DATA2 VARCHAR2(20) CONSTRAINT UK_DATA2 UNIQUE, -- 컬럼 레벨로 설정
    DATA3 VARCHAR2(20),
    CONSTRAINT UK_DATA3 UNIQUE(DATA3) -- 테이블 레벨로 설정
);

-- 제약 조건명 확인
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CONST_NAME';

-----------------------------------------------------------------------------------------------------------------

--5. PRIMARY KEY (기본키) 제약 조건

-- 테이블에서 한 행의 정보를 찾기 위해 사용할 컬럼을 의미
-- 테이블의 각 행에 대한 ★식별자(IDENTIFIER)★ 역할을 함
-- * NOT NULL + UNIQUE 두 제약조건의 의미를 한 번에 가짐 (중복도, NULL값도 X)
-- 한 테이블 당 PK 제약조건은 하나만 설정 가능
-- 테이블, 컬럼 레벨로 설정 가능 
-- 복합키도 가능

CREATE TABLE USER_USED_PK ( 
    USER_NO NUMBER CONSTRAINT PK_USER_USED_PK PRIMARY KEY, -- 컬럼레벨: 제약조건명_테이블명 (컬럼명 안쓰는 이유는 어차피 PK는 테이블당 하나만 만드니깐)
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER CHAR(1),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50)
    -- 혹시라도 PRIMARY KEY를 테이블 레벨로 선언하는 법
    -- CONSTRAINT PK_USER_USED_PK PRIMARY KEY(USER_NO)
);

INSERT INTO USER_USED_PK
VALUES(1, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

-- USER_NO 같고, USER_ID만 변경
INSERT INTO USER_USED_PK
VALUES(1, 'user02', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
-- ORA-00001: unique constraint (KH.PK_USER_USED_PK) violated 에러 발생

-- USER_NO에는 NULL값 지정
INSERT INTO USER_USED_PK
VALUES(NULL, 'user02', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
-- ORA-01400: cannot insert NULL into ("KH"."USER_USED_PK"."USER_NO") 에러 발생

-- 위 두 오류를 통해(360+364줄) PRIMARY KEY가 UNIQUE+NOT NULL임을 증명


-- PRIMARY KEY 복합키 설정
DROP TABLE USER_USED_PK2;

CREATE TABLE USER_USED_PK2 ( 
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER CHAR(1),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    CONSTRAINT PK_USER_USED_PK2 PRIMARY KEY(USER_NO, USER_ID)
    -- 테이블레벨로 복합키 지정하기
);

INSERT INTO USER_USED_PK2
VALUES(1, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_PK2
VALUES(2, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_PK2
VALUES(1, 'user02', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_PK2
VALUES(1, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
-- ORA-00001: unique constraint (KH.PK_USER_USED_PK2) violated 에러 발생 
-- 유니크와 똑같이 동작

-----------------------------------------------------------------------------------------------------------------

-- 6. FOREIGN KEY (외래키 / 외부키) 제약 조건

-- 참조(REFERENCES)된 다른 테이블의 컬럼이 제공하는 값만 사용할 수 있게하는 제약 조건
-- FOREIGN KEY 제약 조건에 의해 테이블간의 관계(RELATIONSHIP)가 형성됨
--> RDBMS(관계형 데이터베이스)
-- 참조되는 테이블의 컬럼 값 이외에 NULL을 사용할 수 있다

-- 컬럼 레벨 작성법
-- 컬럼명 자료형(크기) [CONSTRAINT 제약조건명]
--                              REFERENCES 참조할테이블명 [(참조할컬럼)] [삭제룰] 
--> [(참조할 컬럼)] : 참조할 컬럼 생략 시
--                          참조한 테이블의 PK 컬럼이 참조됨

-- 테이블 레벨 작성법
-- [CONSTRAINT 제약조건명] FOREIGN KEY (현재 테이블에서 적용할 컬럼명)
-- REFERENCES 참조할테이블명 [(참조할컬럼)] [삭제룰]

-- * 참조할 컬럼은 PK 또는 UK 컬럼만 지정할 수 있음
-- CF. PK와 UK의 공통점: 중복 허용하지 않음

CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO USER_GRADE VALUES(10, '일반회원');
INSERT INTO USER_GRADE VALUES(20, '우수회원');
INSERT INTO USER_GRADE VALUES(30, '특별회원');

SELECT * FROM USER_GRADE;

CREATE TABLE USER_USED_FK ( 
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER CHAR(1),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER CONSTRAINT FK_GRADE_CODE
                                       REFERENCES USER_GRADE(GRADE_CODE)
);

INSERT INTO USER_USED_FK
VALUES(1, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr', 10);

INSERT INTO USER_USED_FK
VALUES(2, 'user02', 'pass02', '홍길순', 'F', '010-5678-1234', 'hong_GS@kh.or.kr', 20);

INSERT INTO USER_USED_FK
VALUES(3, 'user03', 'pass03', '장영인', 'F', '010-5555-6666', 'jang123@kh.or.kr', 30);

INSERT INTO USER_USED_FK
VALUES(4, 'user04', 'pass04', '김개똥', 'M', '010-9999-8888', 'kkd123@kh.or.kr', NULL);

SELECT * FROM USER_USED_FK;

INSERT INTO USER_USED_FK
VALUES(5, 'user05', 'pass05', '개진상', 'M', '010-7777-7777', 'gjs123@kh.or.kr', 50);
-- ORA-02291: integrity constraint (KH.FK_GRADE_CODE) violated - parent key not found 에러 발생!
-- "현재 참조하고 있는 부모 테이블인 GRADE_CODE에는 50에 대한 지정값이 없다"
-- 즉, 외래키 제약 조건 위배로 오류 발생

-- ★★ FOREIGN KEY 삭제 옵션
-- 부모 테이블(참조를 당하는 테이블)에서 데이터 삭제 시 
-- 이를 참조하고 있는 자식 테이블(참조를 하는 테이블)의 데이터를 
-- 어떤 식으로 처리할지에 대한 내용을 정할 수 있다 (처리 방법은 두 가지: NULL화, 아예 제거)

SELECT * FROM USER_GRADE;

-- GRADE_CODE 중 10인 값을 삭제
DELETE FROM USER_GRADE 
WHERE GRADE_CODE = 10;
-- ORA-02292: integrity constraint (KH.FK_GRADE_CODE) violated - child record found
-- 자식테이블에 10이 존재하므로 그냥 삭제는 어렵다는 뜻
--> FOREIGN KEY 삭제 옵션이 지정되지 않은 경우, 자식 테이블에서 값을 사용하고 있다면 삭제 불가능

COMMIT;


-- 1) ON DELETE SET NULL
-- 부모키 삭제 시 자식키를 NULL로 변경하는 옵션
CREATE TABLE USER_GRADE2 (
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO USER_GRADE2 VALUES(10, '일반회원');
INSERT INTO USER_GRADE2 VALUES(20, '우수회원');
INSERT INTO USER_GRADE2 VALUES(30, '특별회원');

DROP TABLE USER_USED_FK2;

CREATE TABLE USER_USED_FK2 ( 
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER CHAR(1),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER CONSTRAINT FK_GRADE_CODE2
                        REFERENCES USER_GRADE2(GRADE_CODE) ON DELETE SET NULL
);

INSERT INTO USER_USED_FK2
VALUES(1, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr', 10);

SELECT * FROM USER_USED_FK2;
 
-- GRADE_CODE 중 참조 되지 않는 컬럼값인 20을 삭제
DELETE FROM USER_GRADE2
WHERE GRADE_CODE = 20;
-- 외래키로 참조당하지 않고있는 컬럼은 삭제 옵션과 관계 없이 삭제 가능
-- 즉 현재 까지는 홍길동 10만 참조하고 있으니까 20은 어차피 없으니까 저렇게 해도 상관 없다는 소리임
-- 확인

SELECT * FROM USER_USED_FK2; -- 위에랑 똑같이 나오는데
SELECT * FROM USER_GRADE2; -- 여기서는 20이 사라진 것을 확인할 수 있음

-- GRADE_CODE 중 참조 되고있는 컬럼값인 10을 삭제
DELETE FROM USER_GRADE2
WHERE GRADE_CODE = 10; -- 우선 삭제 되었다고 하는데

SELECT * FROM USER_GRADE2; -- 실제로 10도 사라진 것을 확인할 수 있음
SELECT * FROM USER_USED_FK2; -- 그리고 이렇게 하면, ""참조하던 부모가 사라지니(10) GRADE_CODE가 NULL화""
-- 이것이 ON DELETE SET NULL의 대표적인 예이자 확실한 설명


-- 2) ON DELETE CASCADE 
-- 부모키 삭제 시 이를 참조하고 있는 자식의 행이 함께 삭제됨 (단순 NULL화가 아니라 아예 뿌리 뽑음)

CREATE TABLE USER_GRADE3 (
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO USER_GRADE3 VALUES(10, '일반회원');
INSERT INTO USER_GRADE3 VALUES(20, '우수회원');
INSERT INTO USER_GRADE3 VALUES(30, '특별회원');

CREATE TABLE USER_USED_FK3 ( 
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER CHAR(1),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER CONSTRAINT FK_GRADE_CODE3
                        REFERENCES USER_GRADE3(GRADE_CODE) ON DELETE CASCADE
);

INSERT INTO USER_USED_FK3
VALUES(1, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr', 10);

SELECT * FROM USER_USED_FK3;

-- 자식에게 참조되고 있는 GRADE_CODE = 10 삭제 후
-- 자식 테이블 조회
DELETE FROM USER_GRADE3
WHERE GRADE_CODE = 10;

SELECT * FROM USER_USED_FK3;

-----------------------------------------------------------------------------------------------------------------

-- 7. CHECK 제약 조건
-- 컬럼에 기록되는 값에 조건을 설정할 수 있는 제약 조건
-- (이 컬럼에는 어떤 값만 들어올 수 있다, 라고 딱 잘라 거는 것)
-- (주의!) 비교되는 값은 리터럴만 사용할 수 있다!
--> 변하는 값 (서브쿼리 등), 함수 사용 불가

CREATE TABLE USER_USED_CHECK ( 
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER CHAR(1) CHECK(GENDER IN ('M', 'F')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_USED_CHECK
VALUES(1, 'user01', 'pass01', '홍길동', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_CHECK
VALUES(2, 'user02', 'pass02', '홍길순', 'F', '010-1111-2222', 'hong_GS@kh.or.kr');

INSERT INTO USER_USED_CHECK
VALUES(3, 'user03', 'pass03', '그루트', 'T', '010-5555-5555', 'GROOT@kh.or.kr');
-- ORA-02290: check constraint (KH.SYS_C007083) violated 
-- 체크 제약조건 위배로 오류 발생

-- CHECK 제약조건 범위로 설정
CREATE TABLE USER_USED_CHECK2 (
    TEST_NUMBER NUMBER,
    CONSTRAINT CK_TEST_NUMBER CHECK (TEST_NUMBER>0)
);

INSERT INTO USER_USED_CHECK2 VALUES (10);

INSERT INTO USER_USED_CHECK2 VALUES (-10);
-- ORA-02290: check constraint (KH.CK_TEST_NUMBER) violated

INSERT INTO USER_USED_CHECK2 VALUES (0);
-- ORA-02290: check constraint (KH.CK_TEST_NUMBER) violated

-- 더 복잡한 CHECK 제약 조건
CREATE TABLE USER_USED_CHECK3(
    C_NAME VARCHAR2(15) PRIMARY KEY, 
    C_PRICE NUMBER,
    C_LEVEL CHAR(1),
    C_DATE DATE,
    CHECK(C_PRICE BETWEEN 100 AND 100000),
    CHECK(C_LEVEL NOT IN ('A', 'B', 'C')),
    CHECK(C_DATE > TO_DATE ('2020-01-01', 'YYYY-MM-DD'))
);

------------------------------------------- [실습 문제] -----------------------------------------
-- 회원가입용 테이블 생성(USER_TEST)
-- 컬럼명 : USER_NO(회원번호) - 기본키(PK_USER_TEST), 
--         USER_ID(회원아이디) - 중복금지(UK_USER_ID),
--         USER_PWD(회원비밀번호) - NULL값 허용안함(NN_USER_PWD),
--         PNO(주민등록번호) - 중복금지(UK_PNO), NULL 허용안함(NN_PNO),
--         GENDER(성별) - '남' 혹은 '여'로 입력(CK_GENDER),
--         PHONE(연락처),
--         ADDRESS(주소),
--         STATUS(탈퇴여부) - NOT NULL(NN_STATUS), 'Y' 혹은 'N'으로 입력(CK_STATUS)
-- 각 컬럼의 제약조건에 이름 부여할 것
-- 5명 이상 INSERT할 것

-- 답 베낀거
DROP TABLE USER_TEST;
CREATE TABLE USER_TEST(
    USER_NO NUMBER CONSTRAINT PK_USER_TEST PRIMARY KEY,
    USER_ID VARCHAR2(20) CONSTRAINT UK_USER_TEST_ID UNIQUE,
    USER_PWD VARCHAR2(20) CONSTRAINT NN_USER_TEST_PWD NOT NULL,
    PNO VARCHAR2(20) CONSTRAINT NN_PNO NOT NULL,
    GENDER VARCHAR2(3) CONSTRAINT CK_GENDER CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(100),
    STATUS VARCHAR2(3) DEFAULT 'N' CONSTRAINT NN_STATUS NOT NULL,
    
    CONSTRAINT CK_STATUS CHECK(STATUS IN ('Y', 'N') ) ,
    CONSTRAINT UK_PNO UNIQUE (PNO)
);

-- 아래는 내가 한거
DROP TABLE USER_TEST;
CREATE TABLE USER_TEST (
    USER_NO NUMBER,
    USER_ID VARCHAR2 (10),
    USER_PWD VARCHAR2 (10) CONSTRAINT NN_USER_TEST_PWD NOT NULL,
    PNO VARCHAR2 (20) CONSTRAINT NN_PNO NOT NULL,
    GENDER CHAR (3),
    PHONE VARCHAR2 (15),
    ADDRESS VARCHAR2 (50),
    STATUS CHAR (1) CONSTRAINT NN_STATUS NOT NULL,   
    
    CONSTRAINT PK_USER_TEST PRIMARY KEY (USER_NO),
    CONSTRAINT UK_USER_TEST_ID UNIQUE (USER_ID),
    CONSTRAINT UK_PNO UNIQUE (PNO),
    CONSTRAINT CK_GENDER CHECK (GENDER IN ('남', '여')),
    CONSTRAINT CK_STATUS CHECK (STATUS IN ('Y', 'N'))
);

INSERT INTO USER_TEST
VALUES(1, 'user01', 'pass01', '971210-1212121', '남', '010-1234-5678', '서울시 동대문구', 'Y');

INSERT INTO USER_TEST
VALUES(2, 'user02', 'pass02', '981210-1212123', '남', '010-1234-5478', '서울시 구로구', 'N');

INSERT INTO USER_TEST
VALUES(3, 'user03', 'pass03', '991210-1212124', '남', '010-1235-5478', '서울시 강남구', 'N');

INSERT INTO USER_TEST
VALUES(4, 'user04', 'pass04', '001210-1212124', '남', '010-1222-5478', '서울시 서초구', 'N');

INSERT INTO USER_TEST
VALUES(5, 'user05', 'pass05', '011210-1212124', '남', '010-2222-5478', '서울시 동작구', 'Y');


COMMENT ON COLUMN USER_TEST.USER_NO IS '회원번호';
COMMENT ON COLUMN USER_TEST.USER_ID IS '회원아이디';
COMMENT ON COLUMN USER_TEST.USER_PWD IS '회원비번';
COMMENT ON COLUMN USER_TEST.PNO IS '주민번호';
COMMENT ON COLUMN USER_TEST.GENDER IS '회원성별';
COMMENT ON COLUMN USER_TEST.PHONE IS '연락처';
COMMENT ON COLUMN USER_TEST.ADDRESS IS '주소';
COMMENT ON COLUMN USER_TEST.STATUS IS '탈퇴여부';

-- 테이블 확인
SELECT * FROM USER_TEST;

-- 테이블 주석 확인
SELECT * FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'USER_TEST';

-- 테이블 제약 조건 확인
SELECT * FROM USER_CONSTRAINTS C1
JOIN USER_CONS_COLUMNS C2 USING(CONSTRAINT_NAME)
WHERE C1.TABLE_NAME='USER_TEST';

------------------------------------------------------------------------------------------------------------------------------------

-- 8. SUBQUERY를 이용한 테이블 생성

-- 서브쿼리의 결과(RESULT SET)의 
-- 컬럼명, 데이터 타입, 값을 이용하여
-- 테이블 생성 및 데이터를 삽입함.
-- 제약 조건은 NOT NULL만 복사됨.

-- EMPLOYEE 테이블 복사본 EMPLOYEE_COPY 생성

CREATE TABLE EMPLOYEE_COPY 
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY;

DROP TABLE EMPLOYEE_COPY2;

CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
JOIN JOB USING(JOB_CODE);

SELECT * FROM EMPLOYEE_COPY2; 

------------------------------------------------------------------------------------------------------------------------------------

-- 9. 이미 만들어진 테이블에 제약 조건 추가 (ALTER라는 DDL 구문)
-- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] PRIMARY KEY (컬럼명)

-- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] UNIQUE (컬럼명)

-- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] CHECK (컬럼명 비교연산자 비교값)

-- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] 
-- FOREIGN KEY(컬럼명) REFERENCES 참조테이블명(참조컬럼명)
    --> 참조 컬럼명 생략 시 참조 테이블의 PK를 참조하게 됨
    
-- ★ ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL;

-- EMPLOYEE_COPY 테이블은 NOT NULL 제약조건만 복사되어 있음.
--> EMP_ID 컬럼에 PK 제약 조건을 설정하기
ALTER TABLE EMPLOYEE_COPY
ADD CONSTRAINT PK_EMP_COPY PRIMARY KEY (EMP_ID);

-- EMPLOYEE 테이블 DEPT_CODE에 외래키 제약 조건 추가
-- 참조하는 테이블과 컬럼은 DEPARTMENT - DEPT_ID
ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_DEPT_CODE 
FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT; 
-- 참조 컬럼명인 DEPT_ID를 생략 == 참조 테이블 PK 컬럼 참조

-- EMPLOYEE 테이블 JOB_CODE에 외래키 제약 조건 추가
-- 참조하는 테이블과 컬럼은 JOB - JOB_CODE
ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_JOB_CODE
FOREIGN KEY(JOB_CODE) REFERENCES JOB; 
-- 참조 컬럼명 생략 == 참조 테이블 PK 컬럼 참조

-- EMPLOYEE 테이블 SAL_LEVEL에 외래키 제약 조건 추가
-- 참조하는 테이블과 컬럼은 SAL_GRADE - SAL_LEVEL
ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_SAL_LEVEL
FOREIGN KEY(SAL_LEVEL) REFERENCES SAL_GRADE; 
-- 참조 컬럼명 생략 == 참조 테이블 PK 컬럼 참조

-- DEPARTMENT 테이블 LOCATION_ID에 외래키 제약 조건 추가
-- 참조하는 테이블과 컬럼은 LOCATION - LOCAL_CODE
ALTER TABLE DEPARTMENT
ADD CONSTRAINT FK_LOCATION_ID
FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION; 
-- 참조 컬럼명 생략 == 참조 테이블 PK 컬럼 참조

-- LOCATION 테이블 NATIONAL_CODE에 외래키 제약 조건 추가
-- 참조하는 테이블과 컬럼은 NATIONAL - NATIONAL_CODE
ALTER TABLE LOCATION
ADD CONSTRAINT FK_NATIONAL_CODE
FOREIGN KEY(NATIONAL_CODE) REFERENCES NATIONAL; 
-- 참조 컬럼명 생략 == 참조 테이블 PK 컬럼 참조

