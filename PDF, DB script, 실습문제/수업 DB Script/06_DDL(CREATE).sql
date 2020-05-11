/*
 - �ڡڡڡڡ� ������ ��ųʸ���?
   DB�� �����ϴ� �ڿ��� ȿ�������� �����ϱ� ���� �پ��� ������ �����ϴ� �ý��� ���̺�
   
   ������ ��ųʸ��� ����ڰ� ���̺��� �����ϰų�
   ����ڸ� ����, �����ϴ� ���� �۾��� �� ��
   DB �������� �ڵ����� ���ŵǴ� ���̺�

  <���� ���̺�>
  SELECT USERNAME
  FROM DBA_USERS;
  -- �ý��ۿ� ��ϵ� ����� ������ ��ȸ�� �� �ִ� ��ųʸ� ��
*/

-- DDL (DATA DEFINITION LANGUAGE): ������ ���� ���
-- ��ü (OBJECT)�� �����(CREATE), ����(ALTER), ����(DROP) �� 
-- �������� ��ü ������ �����ϴ� ���� 
-- �ַ� DB ������, �����ڰ� �����. (DATABASE ADMINISTRATOR)

-- ����Ŭ������ ��ü(OBJECT)
/* 
    TABLE, VIEW(�������̺�� �ζ��κ�, ��ųʸ��䰡 ����), SEQUENCE, 
    INDEX(����: �˻� �ӵ� ���� ��ü), PACKAGE, TRIGGER, 
    PROCEDURE, FUNCTION, SYNONYM(���Ǿ� ��ü), USER(�츮�� ���, KH)
*/

------------------------------------------------------------------------------------------------------

-- CREATE (�����ϴ�, â���ϴ�)

-- ���̺��̳� ��, �ε��� �� �پ��� DB ��ü�� �����ϴ� ����
-- CREATE�� ������ ���̺��� DROP ������ ���� ������ �� ����.

-- 1. TABLE �����
-- TABLE�̶�?
-- ��(ROW)�� ��(COLUMN)���� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
-- �����ͺ��̽� ������ ��� �����ʹ� ���̺��� ���ؼ� ����ȴ�.

/*
[ǥ����]
CREATE TABLE ���̺��(
    �÷��� ������Ÿ��(ũ��)
    �÷��� ������Ÿ��(ũ��)
    �÷��� ������Ÿ��(ũ��)
    �÷��� ������Ÿ��(ũ��)
    �÷��� ������Ÿ��(ũ��)
    .....
    
    );
*/

CREATE TABLE MEMBER (
    MEMBER_ID VARCHAR2(30), -- VARCHAR2�� ���, ���� abc�� ���� ���� 27ĭ�� �޸𸮷� �ڵ� ��ȯ�ǰ� �Ǿ�����
    MEMBER_PWD VARCHAR2(30),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_SSN CHAR(14), -- �ֹι�ȣ�� 14�ڸ� �����̴ϱ� ������ // CHAR�� ���, ���� ABC�� ���� ���� 11ĭ�� �״�� ����
    ENROLL_DATE DATE DEFAULT SYSDATE 
    -- �ԷµǴ� ���� ���ų� DEFAULT �Է½� ���� ��¥�� ��� (�Է� �⺻��)
);
-- �ӵ��� CHAR�� �������ѵ�, VARCHAR2�� �� �޸� �������� ����.

    
 -- MEMBER ���̺� ���� Ȯ��
SELECT * FROM MEMBER;

-- 2. �÷��� �ּ� �ޱ�
-- [ǥ����]
-- COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ�����';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.MEMBER_SSN IS '�ֹι�ȣ';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '��������';

-- ����: �÷��� �ּ� �� �� Ȯ���ϱ�
SELECT * FROM USER_COL_COMMENTS WHERE TABLE_NAME = 'MEMBER';
SELECT * FROM USER_TAB_COMMENTS WHERE TABLE_NAME = 'MEMBER';

-- 200511 ��

-- USER_TABLES: ����ڰ� �ۼ��� ���̺��� Ȯ���ϴ� ��ųʸ� �� (������ ���ǵǾ��ִ� ���� ���̺�)
SELECT * FROM USER_TABLES; -- KH �������� ���� ���̺�� ��ȸ

-- USER_TAB_COLUMNS: 
-- ���̺�, ��, Ŭ�������� �÷��� ���õ� ������ ��ȸ�ϴ� ��ųʸ� ��
SELECT * FROM USER_TAB_COLUMNS -- ���� ���Դ� ���̺� ���� ��� �÷��� ��� ��ȸ��
WHERE TABLE_NAME = 'MEMBER'; -- ������ �ݿ��Ͽ� ���� ����� ���õ� �÷��� ��ȸ��

-- DESC��: ���̺��� ������ ǥ���ϴ� ����
DESC MEMBER; -- JAVA �ܼ� ������� ��� (NOT LIKE RESULT SET)

-- MEMBER���̺� ���õ����� ����
INSERT INTO MEMBER VALUES('MEM01', '123ABC', 'ȫ�浿', '000101-1234567', '2020-05-11');
-- INSERT: ���̺� ������(��)�� �����ϴ� DML ���� (���� ���� MEMBER���̺�)
-- ( ) �ڸ����� �÷��� ���� ���� �������
-- ����� �� �������� '2020-05-11' �̷��� ���� ���� �˾Ƽ� ��¥ �������� ����

-- ������ ���� Ȯ��
SELECT * FROM MEMBER;

-- INSERT���� ���� ��ġ ������ �����Ͱ� �����Ȱ� �������� ����� �ƴ�. �޸� ������ �ö��� ��.
-- ���̺� ���۵� ����(DML)�� ������ DB�� �ݿ��ϴ� TCL������ �ٷ�
COMMIT; -- Ŀ�� �Ϸ�. <<- ��� ���� ������ DB�� �ݿ��ƴٴ� �Ҹ���.

-- �߰� ���õ����� ����
-- SYSDATE�� �̿��Ͽ� ������ ����
INSERT INTO MEMBER 
VALUES('MEM02', 'QWER1234', '�迵��', '971208-2123456', SYSDATE); 

-- DEFAULT�� �̿��Ͽ� ������ ����
INSERT INTO MEMBER 
VALUES('MEM03', 'ASDF9876', '��ö��', '930314-1122334', DEFAULT); 

-- ������ ���ۼ� --> DEFAULT �� �ݿ� / DEFAULT�� ���� ���, NULL ���� 
-- INSERT INTO MEMBER ���� VALUE�� ���� ���� �ʰ� ���� ���
INSERT INTO MEMBER (MEMBER_ID, MEMBER_PWD, 
                                   MEMBER_NAME, MEMBER_SSN)
VALUES ('MEM04', '1Q2W3E4R', '������', '851011-2345678');

SELECT * FROM MEMBER;
COMMIT;
-- <����> DB�� �ݿ��� ���Ŀ���(Ŀ�� ���Ŀ���) ������ ����� ���ŷο�


-- �ֹε�Ϲ�ȣ�� NUMBERŸ������ ���� ���� ������ 
CREATE TABLE MEMBER2(
    MEMBER_ID VARCHAR2(30),
    MEMBER_PWD VARCHAR2(30),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_SSN NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE
);

INSERT INTO MEMBER2 VALUES('MEM01', '123ABC', 'ȫ�浿', 0001011234567, '2020-05-11');

SELECT * FROM MEMBER2;
-- <����> NUMBERŸ�� �÷��� ������ ���� �� 
-- ���� �κ��� ���� 0�� ��� INSERT �� 0�� �����

-- <ġƮŰ>
DROP TABLE ���̺��; 
-- �ϸ� ���̺��� ������ �� �ִ�

-----------------------------------------------------------------------------------------------------------------

/* ���� ���� (CONSTRAINTS)

- ����ڰ� ���ϴ� ������ �����͸� �����ϱ� ���ؼ�
 Ư�� �÷��� �����ϴ� ����
 
- ���̺� �ۼ� �� �� �÷��� ���� 
 �� ��Ͽ� ���� ���� ������ ������ �� �ִ�.
 
- ���� ������ ���������ν� ������ ���Ἲ�� ����
-- ������ ���Ἲ: �������� ��Ȯ���� �ϰ����� �����ϴ� ��
                        --> RDBMS���� ���� �߿��� ������� ����
                        --> NULL X, �ߺ� X
                        
- ���� ���� ��� ����
 1) ������ ���Ἲ ����
 2) �Է� �����Ϳ� ������ ������ �˻�
 --> INSERT(����), UPDATE(����) �� �ڵ����� �˻簡 �����
 3) �������� ����/���� ���� �˻�
 
- ���� ���� ����
 -> NOT NULL(NULL�� X), UNIQUE(�ߺ� X), 
     PRIMARY KEY(��� ���� ������ �� �ִ� �ĺ���)
     FOREIGN KEY(���̺� �÷� ����)
     CHECK(���� ���� ������ �� ����)
                     
*/

-- USER_CONSTRAINTS
-- ����ڰ� �ۼ��� ���������� Ȯ���ϴ� ��ųʸ� ��
SELECT * FROM USER_CONSTRAINTS;

-- USER_CONS_COLUMNS
-- ���������� �ɷ��ִ� �÷��� Ȯ���ϴ� ��ųʸ� ��
SELECT * FROM USER_CONS_COLUMNS;

-----------------------------------------------------------------------------------------------------------------

-- 3. NOT NULL
-- ������ ����/���� �� NULL���� ������� �ʵ��� 
-- �÷� �������� �����ϴ� ���� ����

-- �ش� �÷��� �ݵ�� ���� ��ϵǾ�� �ϴ� ��� ���

-- NOT NULL ���� ������ ��� X
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
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_NOT_NN
VALUES(2, NULL, NULL, 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
-- �÷� ���� NULL�� �־ ���� ����
--> ������ ���Ἲ(NULL���� ������Ѵ�)�� ħ�ص� ����

-- NOT NULL ���� ������ ��� O
CREATE TABLE USER_USED_NN(
    USER_NO NUMBER NOT NULL, -- �÷� ������ �������� ����
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER CHAR(1),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_USED_NN
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_NN
VALUES(2, NULL, NULL, 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
-- ORA-01400: cannot insert NULL into ("KH"."USER_USED_NN"."USER_ID") ���� �߻�
--> USER_ID �÷��� ������ NOT NULL �������� ����� ���� �߻�

-- �ۼ��� ���� ���� Ȯ��
SELECT * 
FROM USER_CONSTRAINTS C1
JOIN USER_CONS_COLUMNS C2 USING(CONSTRAINT_NAME)
WHERE C1.TABLE_NAME = 'USER_USED_NN';

-----------------------------------------------------------------------------------------------------------------

-- 4. UNIQUE ���� ����
-- �÷��� �Է� ���� ���ؼ� �ߺ��� �����ϴ� ���� ����
-- �÷� ����, ���̺� �������� ���� ����
-- �ڡڡ� ��, UNIQUE ���� ������ ������ �÷��� NULL ���� �ߺ� ���� ���� (NULL�̴ϱ�)

-- USER_USED_NN ���̺� �ߺ� ������ ����
INSERT INTO USER_USED_NN
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
--> �ߺ��Ǵ� ȸ�� ��ȣ, ȸ�� ���̵�� �����Ͱ� ������ ��.

-- UNIQUE ���� ���� ���� ���̺� ����
CREATE TABLE USER_USED_UK( -- UNIQUE KEY�� ���Ӹ�
    USER_NO NUMBER UNIQUE, -- �÷� ������ �������� ����
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER CHAR(1),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    -- UNIQUE (USER_ID) 
    -- ���̺� ���� �Ʒ��� �ۼ��ϴ� ��: ���̺� ���� �������� ����
    CONSTRAINT UK_USER_ID UNIQUE (USER_ID) 
    -- ���������� �� �� (���� �ּ�ó�� �� �Ͱ� ���� ȿ����)
-- [CONSTRAINT �������Ǹ�] ��������Ÿ��(�÷���) --> ���� �⺻���� ���̺� ���� ���� ���� ���� ���
-- �ڡڡ� �׷���! ���� ���� Ÿ�Կ� NOT NULL�� ���� �� ����: �ֳ�, 
-- NOT NULL�� ������ �÷� ����, ���̺� ���� �Ұ�
);

INSERT INTO USER_USED_UK
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

-- ���� �Ȱ��� ��� �� ��°
INSERT INTO USER_USED_UK
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
-- ORA-00001: unique constraint (KH.SYS_C007049) violated 
-- �ߺ� ������ ���� �� UNIQUE ���� ���� ���� ���� �߻� 
-- �� �����ʹ� ������ ���� �ʴ´�. Ȯ��?

SELECT * FROM USER_USED_UK; 
-- 1��ۿ��� ������ �ʴ´� (2���� �ȵǾ���)

INSERT INTO USER_USED_UK
VALUES(2, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
-- ORA-00001: unique constraint (KH.UK_USER_ID) violated
-- 254��° �ٿ��� �� ���� ���Ǹ��� ���� ���뿡 ÷�εǴ� ���� Ȯ��


-- UNIQUE ����Ű
-- �� �� �̻��� �÷��� ��� �ϳ��� UNIQUE ���� ������ ������
CREATE TABLE USER_USED_UK2 ( 
    USER_NO NUMBER, 
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER CHAR(1),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    UNIQUE (USER_NO, USER_ID) 
    -- ����Ű�� ���̺� ���������� �������� ���� ���� 
    -- �÷������δ� X
 );

INSERT INTO USER_USED_UK2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

-- USER_NO�� �����ؼ� ���� --> ���� ���� (ID�� ������, NO�� �ٸ�)
INSERT INTO USER_USED_UK2
VALUES(2, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

-- USER_ID�� �����ؼ� ���� --> ���� ���� ���� (ID�� �ٸ���, NO�� ����)
INSERT INTO USER_USED_UK2
VALUES(1, 'user02', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

-- USER_NO, USER_ID ��� ��ġ�� �� --> ���� ����!
INSERT INTO USER_USED_UK2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
-- ORA-00001: unique constraint (KH.SYS_C007052) violated ���� �߻�!

SELECT UC.TABLE_NAME, UCC.COLUMN_NAME,
           UCC.CONSTRAINT_NAME, UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME=UCC.CONSTRAINT_NAME)
WHERE UCC.CONSTRAINT_NAME = 'SYS_C007052'; -- SYS_C007052�� ���� ���Ǹ���
-- �� ���� UNIQUE ���� ������
-- �ϳ��� ���� ���Ǹ����� �����Ǿ� �ִ� ���� Ȯ�� --> ����Ű

-- ���� ���ǿ� �̸� ����
CREATE TABLE CONST_NAME (
    DATA1 VARCHAR2(20) CONSTRAINT NN_DATA1 NOT NULL, -- �÷� ������ ����
    DATA2 VARCHAR2(20) CONSTRAINT UK_DATA2 UNIQUE, -- �÷� ������ ����
    DATA3 VARCHAR2(20),
    CONSTRAINT UK_DATA3 UNIQUE(DATA3) -- ���̺� ������ ����
);

-- ���� ���Ǹ� Ȯ��
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CONST_NAME';

-----------------------------------------------------------------------------------------------------------------

--5. PRIMARY KEY (�⺻Ű) ���� ����

-- ���̺��� �� ���� ������ ã�� ���� ����� �÷��� �ǹ�
-- ���̺��� �� �࿡ ���� �ڽĺ���(IDENTIFIER)�� ������ ��
-- * NOT NULL + UNIQUE �� ���������� �ǹ̸� �� ���� ���� (�ߺ���, NULL���� X)
-- �� ���̺� �� PK ���������� �ϳ��� ���� ����
-- ���̺�, �÷� ������ ���� ���� 
-- ����Ű�� ����

CREATE TABLE USER_USED_PK ( 
    USER_NO NUMBER CONSTRAINT PK_USER_USED_PK PRIMARY KEY, -- �÷�����: �������Ǹ�_���̺�� (�÷��� �Ⱦ��� ������ ������ PK�� ���̺�� �ϳ��� ����ϱ�)
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER CHAR(1),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50)
    -- Ȥ�ö� PRIMARY KEY�� ���̺� ������ �����ϴ� ��
    -- CONSTRAINT PK_USER_USED_PK PRIMARY KEY(USER_NO)
);

INSERT INTO USER_USED_PK
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

-- USER_NO ����, USER_ID�� ����
INSERT INTO USER_USED_PK
VALUES(1, 'user02', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
-- ORA-00001: unique constraint (KH.PK_USER_USED_PK) violated ���� �߻�

-- USER_NO���� NULL�� ����
INSERT INTO USER_USED_PK
VALUES(NULL, 'user02', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
-- ORA-01400: cannot insert NULL into ("KH"."USER_USED_PK"."USER_NO") ���� �߻�

-- �� �� ������ ����(360+364��) PRIMARY KEY�� UNIQUE+NOT NULL���� ����


-- PRIMARY KEY ����Ű ����
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
    -- ���̺����� ����Ű �����ϱ�
);

INSERT INTO USER_USED_PK2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_PK2
VALUES(2, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_PK2
VALUES(1, 'user02', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_PK2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');
-- ORA-00001: unique constraint (KH.PK_USER_USED_PK2) violated ���� �߻� 
-- ����ũ�� �Ȱ��� ����

-----------------------------------------------------------------------------------------------------------------

-- 6. FOREIGN KEY (�ܷ�Ű / �ܺ�Ű) ���� ����

-- ����(REFERENCES)�� �ٸ� ���̺��� �÷��� �����ϴ� ���� ����� �� �ְ��ϴ� ���� ����
-- FOREIGN KEY ���� ���ǿ� ���� ���̺��� ����(RELATIONSHIP)�� ������
--> RDBMS(������ �����ͺ��̽�)
-- �����Ǵ� ���̺��� �÷� �� �̿ܿ� NULL�� ����� �� �ִ�

-- �÷� ���� �ۼ���
-- �÷��� �ڷ���(ũ��) [CONSTRAINT �������Ǹ�]
--                              REFERENCES ���������̺�� [(�������÷�)] [������] 
--> [(������ �÷�)] : ������ �÷� ���� ��
--                          ������ ���̺��� PK �÷��� ������

-- ���̺� ���� �ۼ���
-- [CONSTRAINT �������Ǹ�] FOREIGN KEY (���� ���̺��� ������ �÷���)
-- REFERENCES ���������̺�� [(�������÷�)] [������]

-- * ������ �÷��� PK �Ǵ� UK �÷��� ������ �� ����
-- CF. PK�� UK�� ������: �ߺ� ������� ����

CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO USER_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE VALUES(30, 'Ư��ȸ��');

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
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr', 10);

INSERT INTO USER_USED_FK
VALUES(2, 'user02', 'pass02', 'ȫ���', 'F', '010-5678-1234', 'hong_GS@kh.or.kr', 20);

INSERT INTO USER_USED_FK
VALUES(3, 'user03', 'pass03', '�念��', 'F', '010-5555-6666', 'jang123@kh.or.kr', 30);

INSERT INTO USER_USED_FK
VALUES(4, 'user04', 'pass04', '�谳��', 'M', '010-9999-8888', 'kkd123@kh.or.kr', NULL);

SELECT * FROM USER_USED_FK;

INSERT INTO USER_USED_FK
VALUES(5, 'user05', 'pass05', '������', 'M', '010-7777-7777', 'gjs123@kh.or.kr', 50);
-- ORA-02291: integrity constraint (KH.FK_GRADE_CODE) violated - parent key not found ���� �߻�!
-- "���� �����ϰ� �ִ� �θ� ���̺��� GRADE_CODE���� 50�� ���� �������� ����"
-- ��, �ܷ�Ű ���� ���� ����� ���� �߻�

-- �ڡ� FOREIGN KEY ���� �ɼ�
-- �θ� ���̺�(������ ���ϴ� ���̺�)���� ������ ���� �� 
-- �̸� �����ϰ� �ִ� �ڽ� ���̺�(������ �ϴ� ���̺�)�� �����͸� 
-- � ������ ó�������� ���� ������ ���� �� �ִ� (ó�� ����� �� ����: NULLȭ, �ƿ� ����)

SELECT * FROM USER_GRADE;

-- GRADE_CODE �� 10�� ���� ����
DELETE FROM USER_GRADE 
WHERE GRADE_CODE = 10;
-- ORA-02292: integrity constraint (KH.FK_GRADE_CODE) violated - child record found
-- �ڽ����̺� 10�� �����ϹǷ� �׳� ������ ��ƴٴ� ��
--> FOREIGN KEY ���� �ɼ��� �������� ���� ���, �ڽ� ���̺��� ���� ����ϰ� �ִٸ� ���� �Ұ���

COMMIT;


-- 1) ON DELETE SET NULL
-- �θ�Ű ���� �� �ڽ�Ű�� NULL�� �����ϴ� �ɼ�
CREATE TABLE USER_GRADE2 (
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO USER_GRADE2 VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE2 VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE2 VALUES(30, 'Ư��ȸ��');

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
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr', 10);

SELECT * FROM USER_USED_FK2;
 
-- GRADE_CODE �� ���� ���� �ʴ� �÷����� 20�� ����
DELETE FROM USER_GRADE2
WHERE GRADE_CODE = 20;
-- �ܷ�Ű�� ���������� �ʰ��ִ� �÷��� ���� �ɼǰ� ���� ���� ���� ����
-- �� ���� ������ ȫ�浿 10�� �����ϰ� �����ϱ� 20�� ������ �����ϱ� ������ �ص� ��� ���ٴ� �Ҹ���
-- Ȯ��

SELECT * FROM USER_USED_FK2; -- ������ �Ȱ��� �����µ�
SELECT * FROM USER_GRADE2; -- ���⼭�� 20�� ����� ���� Ȯ���� �� ����

-- GRADE_CODE �� ���� �ǰ��ִ� �÷����� 10�� ����
DELETE FROM USER_GRADE2
WHERE GRADE_CODE = 10; -- �켱 ���� �Ǿ��ٰ� �ϴµ�

SELECT * FROM USER_GRADE2; -- ������ 10�� ����� ���� Ȯ���� �� ����
SELECT * FROM USER_USED_FK2; -- �׸��� �̷��� �ϸ�, ""�����ϴ� �θ� �������(10) GRADE_CODE�� NULLȭ""
-- �̰��� ON DELETE SET NULL�� ��ǥ���� ������ Ȯ���� ����


-- 2) ON DELETE CASCADE 
-- �θ�Ű ���� �� �̸� �����ϰ� �ִ� �ڽ��� ���� �Բ� ������ (�ܼ� NULLȭ�� �ƴ϶� �ƿ� �Ѹ� ����)

CREATE TABLE USER_GRADE3 (
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO USER_GRADE3 VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE3 VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE3 VALUES(30, 'Ư��ȸ��');

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
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr', 10);

SELECT * FROM USER_USED_FK3;

-- �ڽĿ��� �����ǰ� �ִ� GRADE_CODE = 10 ���� ��
-- �ڽ� ���̺� ��ȸ
DELETE FROM USER_GRADE3
WHERE GRADE_CODE = 10;

SELECT * FROM USER_USED_FK3;

-----------------------------------------------------------------------------------------------------------------

-- 7. CHECK ���� ����
-- �÷��� ��ϵǴ� ���� ������ ������ �� �ִ� ���� ����
-- (�� �÷����� � ���� ���� �� �ִ�, ��� �� �߶� �Ŵ� ��)
-- (����!) �񱳵Ǵ� ���� ���ͷ��� ����� �� �ִ�!
--> ���ϴ� �� (�������� ��), �Լ� ��� �Ұ�

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
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_CHECK
VALUES(2, 'user02', 'pass02', 'ȫ���', 'F', '010-1111-2222', 'hong_GS@kh.or.kr');

INSERT INTO USER_USED_CHECK
VALUES(3, 'user03', 'pass03', '�׷�Ʈ', 'T', '010-5555-5555', 'GROOT@kh.or.kr');
-- ORA-02290: check constraint (KH.SYS_C007083) violated 
-- üũ �������� ����� ���� �߻�

-- CHECK �������� ������ ����
CREATE TABLE USER_USED_CHECK2 (
    TEST_NUMBER NUMBER,
    CONSTRAINT CK_TEST_NUMBER CHECK (TEST_NUMBER>0)
);

INSERT INTO USER_USED_CHECK2 VALUES (10);

INSERT INTO USER_USED_CHECK2 VALUES (-10);
-- ORA-02290: check constraint (KH.CK_TEST_NUMBER) violated

INSERT INTO USER_USED_CHECK2 VALUES (0);
-- ORA-02290: check constraint (KH.CK_TEST_NUMBER) violated

-- �� ������ CHECK ���� ����
CREATE TABLE USER_USED_CHECK3(
    C_NAME VARCHAR2(15) PRIMARY KEY, 
    C_PRICE NUMBER,
    C_LEVEL CHAR(1),
    C_DATE DATE,
    CHECK(C_PRICE BETWEEN 100 AND 100000),
    CHECK(C_LEVEL NOT IN ('A', 'B', 'C')),
    CHECK(C_DATE > TO_DATE ('2020-01-01', 'YYYY-MM-DD'))
);

------------------------------------------- [�ǽ� ����] -----------------------------------------
-- ȸ�����Կ� ���̺� ����(USER_TEST)
-- �÷��� : USER_NO(ȸ����ȣ) - �⺻Ű(PK_USER_TEST), 
--         USER_ID(ȸ�����̵�) - �ߺ�����(UK_USER_ID),
--         USER_PWD(ȸ����й�ȣ) - NULL�� ������(NN_USER_PWD),
--         PNO(�ֹε�Ϲ�ȣ) - �ߺ�����(UK_PNO), NULL ������(NN_PNO),
--         GENDER(����) - '��' Ȥ�� '��'�� �Է�(CK_GENDER),
--         PHONE(����ó),
--         ADDRESS(�ּ�),
--         STATUS(Ż�𿩺�) - NOT NULL(NN_STATUS), 'Y' Ȥ�� 'N'���� �Է�(CK_STATUS)
-- �� �÷��� �������ǿ� �̸� �ο��� ��
-- 5�� �̻� INSERT�� ��

-- �� ������
DROP TABLE USER_TEST;
CREATE TABLE USER_TEST(
    USER_NO NUMBER CONSTRAINT PK_USER_TEST PRIMARY KEY,
    USER_ID VARCHAR2(20) CONSTRAINT UK_USER_TEST_ID UNIQUE,
    USER_PWD VARCHAR2(20) CONSTRAINT NN_USER_TEST_PWD NOT NULL,
    PNO VARCHAR2(20) CONSTRAINT NN_PNO NOT NULL,
    GENDER VARCHAR2(3) CONSTRAINT CK_GENDER CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(100),
    STATUS VARCHAR2(3) DEFAULT 'N' CONSTRAINT NN_STATUS NOT NULL,
    
    CONSTRAINT CK_STATUS CHECK(STATUS IN ('Y', 'N') ) ,
    CONSTRAINT UK_PNO UNIQUE (PNO)
);

-- �Ʒ��� ���� �Ѱ�
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
    CONSTRAINT CK_GENDER CHECK (GENDER IN ('��', '��')),
    CONSTRAINT CK_STATUS CHECK (STATUS IN ('Y', 'N'))
);

INSERT INTO USER_TEST
VALUES(1, 'user01', 'pass01', '971210-1212121', '��', '010-1234-5678', '����� ���빮��', 'Y');

INSERT INTO USER_TEST
VALUES(2, 'user02', 'pass02', '981210-1212123', '��', '010-1234-5478', '����� ���α�', 'N');

INSERT INTO USER_TEST
VALUES(3, 'user03', 'pass03', '991210-1212124', '��', '010-1235-5478', '����� ������', 'N');

INSERT INTO USER_TEST
VALUES(4, 'user04', 'pass04', '001210-1212124', '��', '010-1222-5478', '����� ���ʱ�', 'N');

INSERT INTO USER_TEST
VALUES(5, 'user05', 'pass05', '011210-1212124', '��', '010-2222-5478', '����� ���۱�', 'Y');


COMMENT ON COLUMN USER_TEST.USER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN USER_TEST.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN USER_TEST.USER_PWD IS 'ȸ�����';
COMMENT ON COLUMN USER_TEST.PNO IS '�ֹι�ȣ';
COMMENT ON COLUMN USER_TEST.GENDER IS 'ȸ������';
COMMENT ON COLUMN USER_TEST.PHONE IS '����ó';
COMMENT ON COLUMN USER_TEST.ADDRESS IS '�ּ�';
COMMENT ON COLUMN USER_TEST.STATUS IS 'Ż�𿩺�';

-- ���̺� Ȯ��
SELECT * FROM USER_TEST;

-- ���̺� �ּ� Ȯ��
SELECT * FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'USER_TEST';

-- ���̺� ���� ���� Ȯ��
SELECT * FROM USER_CONSTRAINTS C1
JOIN USER_CONS_COLUMNS C2 USING(CONSTRAINT_NAME)
WHERE C1.TABLE_NAME='USER_TEST';

------------------------------------------------------------------------------------------------------------------------------------

-- 8. SUBQUERY�� �̿��� ���̺� ����

-- ���������� ���(RESULT SET)�� 
-- �÷���, ������ Ÿ��, ���� �̿��Ͽ�
-- ���̺� ���� �� �����͸� ������.
-- ���� ������ NOT NULL�� �����.

-- EMPLOYEE ���̺� ���纻 EMPLOYEE_COPY ����

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

-- 9. �̹� ������� ���̺� ���� ���� �߰� (ALTER��� DDL ����)
-- ALTER TABLE ���̺�� ADD [CONSTRAINT �������Ǹ�] PRIMARY KEY (�÷���)

-- ALTER TABLE ���̺�� ADD [CONSTRAINT �������Ǹ�] UNIQUE (�÷���)

-- ALTER TABLE ���̺�� ADD [CONSTRAINT �������Ǹ�] CHECK (�÷��� �񱳿����� �񱳰�)

-- ALTER TABLE ���̺�� ADD [CONSTRAINT �������Ǹ�] 
-- FOREIGN KEY(�÷���) REFERENCES �������̺��(�����÷���)
    --> ���� �÷��� ���� �� ���� ���̺��� PK�� �����ϰ� ��
    
-- �� ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL;

-- EMPLOYEE_COPY ���̺��� NOT NULL �������Ǹ� ����Ǿ� ����.
--> EMP_ID �÷��� PK ���� ������ �����ϱ�
ALTER TABLE EMPLOYEE_COPY
ADD CONSTRAINT PK_EMP_COPY PRIMARY KEY (EMP_ID);

-- EMPLOYEE ���̺� DEPT_CODE�� �ܷ�Ű ���� ���� �߰�
-- �����ϴ� ���̺�� �÷��� DEPARTMENT - DEPT_ID
ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_DEPT_CODE 
FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT; 
-- ���� �÷����� DEPT_ID�� ���� == ���� ���̺� PK �÷� ����

-- EMPLOYEE ���̺� JOB_CODE�� �ܷ�Ű ���� ���� �߰�
-- �����ϴ� ���̺�� �÷��� JOB - JOB_CODE
ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_JOB_CODE
FOREIGN KEY(JOB_CODE) REFERENCES JOB; 
-- ���� �÷��� ���� == ���� ���̺� PK �÷� ����

-- EMPLOYEE ���̺� SAL_LEVEL�� �ܷ�Ű ���� ���� �߰�
-- �����ϴ� ���̺�� �÷��� SAL_GRADE - SAL_LEVEL
ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_SAL_LEVEL
FOREIGN KEY(SAL_LEVEL) REFERENCES SAL_GRADE; 
-- ���� �÷��� ���� == ���� ���̺� PK �÷� ����

-- DEPARTMENT ���̺� LOCATION_ID�� �ܷ�Ű ���� ���� �߰�
-- �����ϴ� ���̺�� �÷��� LOCATION - LOCAL_CODE
ALTER TABLE DEPARTMENT
ADD CONSTRAINT FK_LOCATION_ID
FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION; 
-- ���� �÷��� ���� == ���� ���̺� PK �÷� ����

-- LOCATION ���̺� NATIONAL_CODE�� �ܷ�Ű ���� ���� �߰�
-- �����ϴ� ���̺�� �÷��� NATIONAL - NATIONAL_CODE
ALTER TABLE LOCATION
ADD CONSTRAINT FK_NATIONAL_CODE
FOREIGN KEY(NATIONAL_CODE) REFERENCES NATIONAL; 
-- ���� �÷��� ���� == ���� ���̺� PK �÷� ����

