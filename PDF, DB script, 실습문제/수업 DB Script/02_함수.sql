UPDATE EMPLOYEE SET EMP_NO = '621225-1985634' WHERE EMP_ID = '200'; 
UPDATE EMPLOYEE SET EMP_NO = '631116-1548654' WHERE EMP_ID = '201'; 
UPDATE EMPLOYEE SET EMP_NO = '850705-1313513' WHERE EMP_ID = '214'; 
COMMIT;

-- �Լ�: �÷��� ���� �о ����� ����� ����

-- ������(SINGLE ROW) �Լ�: 
--> �÷��� ��ϵ� N���� ���� �о N���� ����� ���� 
-- (� ���� 3���̶��, �Ȱ��� 3���� ����� ����)

-- �׷�(GROUP) �Լ�:
--> �÷��� ��ϵ� N���� ���� �о �� ���� ����� ����

-- (����) SELECT ���� ������ �Լ��� �׷��Լ��� �Բ� ��� ����
--> ��� ���� ������ �ٸ��� ���� (�ϳ��� �� �������� �ϳ��� �ϳ� ������ �̷��ϱ�)

-- �Լ��� ����� �� �ִ� ��ġ
-- SELECT ��, WHERE ��, ORDER BY ��, 
-- GROUP BY ��, HAVING ��

------------------------------------------------------------------------------------------------------------------

-- <������ �Լ�> --

-- 1. ���� ���� �Լ�

-- 1) LENGTH / LENGTHB
-- LENGTH: �־��� �÷� ���� ����
-- LENGTHB: B�� ����Ʈ�� �ǹ�. �־��� �÷��� BYTE����

SELECT LENGTH ('����Ŭ') FROM DUAL;
-- DU+AL (DUMMY TABLE: �������̺�)

SELECT LENGTHB ('����Ŭ') FROM DUAL;
-- CHAR�� 2����ư�� �� 9����Ʈ�� ������? 
SELECT LENGTHB ('ORACLE') FROM DUAL;
-- ������ϴ� �� 6����Ʈ�� ������?

/*
ORACLE Express Edition����
VARCHAR2 ������ Ÿ�� ��� �� �ѱ��� 3 BYTE, ����&���ڴ� 1 BYTE�� �ν�

��� VARCHAR2 ������ Ÿ�� 2BYTE�� �����ϴ� ���
--> NVARCHAR2�� ����ϸ� ��� 2BYTE(�����ڵ�)�� �ν�
*/

-- EMPLOYEE ���̺��� 
-- ��� ����� �̸���, �̸��� ����, �̸��� ����Ʈ ���� ��ȸ

SELECT EMAIL, LENGTH(EMAIL) AS ����, LENGTHB(EMAIL) AS ����Ʈ
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------

-- 2) INSTR
-- ������ ��ġ���� ������ ���� ��°�� ��Ÿ���� ������ ���� ��ġ ��ȯ

-- [ǥ����] 
-- INSTR('���ڿ�' | �÷���, '����'[,ã�� ��ġ�� ���۰�, [, ����]])
-- ���ȣ�� �ǹ�: �ص� �ǰ� ���ص� �ǰ�(����)

-- ù ��° ����(���ڿ� ������ 0��° �ƴϰ� ""1��°""��)���� �˻��Ͽ� 'B'�� ó��(1ST) ������ ��ġ
-- (�ش� ���ڿ����� ���� ã�� ���� ���ڰ� ���°�� �ִ��� ã��)
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;

-- �ش� ���ڿ����� ���� ã�� ���� ���ڰ� A��° ���ں��� B��°�� �������� (���ڿ�, ����, A, B)
SELECT INSTR('AABAACAABBAA', 'B', 1, 1) FROM DUAL; 
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;

-- ������(-1) ���ں��� �˻��Ͽ� ó��(1) 'B'�� ������ ��ġ 
SELECT INSTR('AABAACAABBAA', 'B', -1, 1) FROM DUAL;

-- EMPLOYEE ���̺���
-- ����� �̸���, �̸��Ͽ��� '@'�� ��ġ�ϴ� �ε��� ��ȸ
SELECT EMAIL, INSTR (EMAIL, '@', 1, 1) "@ ��ġ" 
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------

-- 3)  �� TRIM (��� ���α׷��� ���� ���)
-- �־��� ���ڿ��̳� �÷����� ��/��/���ʿ� �ִ� ������ ���� ����
-- ���� ���ڰ� ���� ��� �⺻������ ���� ����

SELECT TRIM('       KH      ') FROM DUAL;
SELECT TRIM('-' FROM '----KH-----') FROM DUAL;

-- TRIM�� CHAR ��ġ ����
-- ��(LEADING)
SELECT TRIM (LEADING '-' FROM '-------KH------') FROM DUAL;
-- ��(TRAILING)
SELECT TRIM (TRAILING '-' FROM '-------------KH-----') FROM DUAL;
-- ����(BOTH) : ��� �⺻���� ���� �Ƚᵵ �׸�
SELECT TRIM (BOTH '-' FROM '-----------KH-------') FROM DUAL;

------------------------------------------------------------------------------------------------------------------

-- 4) SUBSTR 
-- �÷��̳� ���ڿ����� ������ ��ġ���� ������ ������ ���ڿ���
-- �߶󳻾� ��ȯ

-- [ǥ����]
-- SUBSTR(�÷�|'���ڿ�', POSITION [, LENGTH])
-- POSITION: �߶󳻱� ���� ��ġ
-- (��� �Է� �� ���ʺ��� ���밪 ��ŭ, 
--  ���� �Է� �� ���ʺ��� ���밪 ��ŭ ������ ������ ����)

SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
-- 5��°���� �� ���ڸ� �ڸ��ڴ�

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
-- 7��°���� ��� �ڸ��ڴ�

SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

-- EMPLOYEE ���̺���
-- ����� �̸�, �̸���, �̸��� ���̵�(@ ���ĸ� ����) ��ȸ
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS ���̵�
FROM EMPLOYEE;

-- EMPLOYEE ���̺���
-- ����� �̸�, �ֹε�Ϲ�ȣ, �ֹε�Ϲ�ȣ�� ���� �κ� ��ȸ
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, INSTR(EMP_NO, '-')+1, 1) AS ����
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ������ ������ ����� ��ȸ
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, INSTR(EMP_NO, '-')+1, 1) AS ����
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, INSTR(EMP_NO, '-')+1, 1)='1';

-- EMPLOYEE ���̺��� 
-- ������� �ֹι�ȣ�� �̿��Ͽ�
-- �����, �����, �����, ������� ��ȸ�Ͻÿ�.

SELECT EMP_NAME "�����", 
        SUBSTR(EMP_NO, 1, 2) "�����", 
        SUBSTR(EMP_NO, 3, 2) "�����",
        SUBSTR(EMP_NO, 5, 2) "�����"
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------

-- 5) LPAD / RPAD 
-- �־��� �÷��̳� ���ڿ��� ������ ���ڿ��� ����/�����ʿ�
-- ���ٿ��� ���� N�� ���ڿ��� ��ȯ

-- [ǥ����]
-- LPAD | RPAD (�÷��� | '���ڿ�', ��ȯ�� ���ڿ��� ���� [, ������ ����])

SELECT LPAD (EMAIL, 20, '#') FROM EMPLOYEE;
-- ���� ĭ�� �̸����� ������ ���� �� ������ ���� ��ĭ ���鿡�� #�� ä���� �� ��

SELECT RPAD (EMAIL, 20, '#') FROM EMPLOYEE;
-- ���� ĭ�� �̸����� ���� ���� �� ������ ������ ��ĭ ���鿡�� #�� ä���� �� ��

-- LPAD, RPAD
--> ��ȸ�Ǵ� ������ ���ϼ��� ���ؼ� �ַ� ���(���� ���� �ϱ� ����)
-- ��ġ �ڹٿ��� %2D �̷��Ͱ� ȿ���� ����

-- EMPLOYEE ���̺���
-- �����, �ֹε�Ϲ�ȣ ��ȸ
-- ��, �ֹε�Ϲ�ȣ ���ڸ��� ������ ���̰� �������� '*'�� ó��

SELECT EMP_NAME, 
        RPAD (SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;
-- SUBSTR�� �̿��Ͽ� �ֹι�ȣ 900206-2 ������ ����, 
-- RPAD�� �̿��Ͽ� 900206-2�� �������� �о���� ��, �� �ڿ��� ��� *�� ó���ϴ� ��

------------------------------------------------------------------------------------------------------------------

-- 6) REPLACE
-- �÷� �Ǵ� ���ڿ����� Ư�� ����(��)�� ������ ����(��)�� �ٲ� �� ��ȯ

-- [ǥ����]
-- REPLACE (�÷� | '���ڿ�', �����Ϸ��� ����(��)(BEFORE), �����ϰ��� �ϴ� ����(��)(AFTER))

SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��' ) AS �ּ�
FROM DUAL;

-- EMPLOYEE ���̺��� 
-- ������� �̸��� �ּҸ� 'kh.or.kr' ���� 'gmail.com'���� �����Ͽ�
-- �����, ���� �̸���, �ٲ� �̸��� ��ȸ

SELECT EMP_NAME, EMAIL AS "���� �̸���",
        REPLACE(EMAIL, 'kh.or.kr', 'gmail.com') AS "�ٲ� �̸���"
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------

-- 2. ���� ó�� �Լ�

-- ** ABS(NUMBER) ���밪 ���ϱ� (�ʹ� ���ٰ� �׳� �Ѿ��)

-- 1) MOD(NUMBER) �� ���� ������ ������ ���ϱ�

-- [ǥ����]
-- MOD(����|���ڷ� �� �÷���, ����|���ڷ� �� �÷���)
-- ù ��° ����: ������ ���� �� (��ü)
-- �� ��° ����: ���� �� (�� ��ü)

SELECT MOD(10,3) FROM DUAL;
SELECT MOD(-10,3) FROM DUAL; -- ��°� -1
SELECT MOD(10.9, 3) FROM DUAL; -- ��°� 1.9
SELECT MOD(-10.9, 3) FROM DUAL; -- ��°� -1.9

------------------------------------------------------------------------------------------------------------------

-- 2) ROUND (�ݿø�)

-- [ǥ����]
-- ROUND (���� | ���ڷ� �� �÷��� [, �ݿø� ��ġ])

SELECT ROUND(123.456) FROM DUAL;
--> ROUND �⺻���� �Ҽ��� ù��° �ڸ����� �ݿø��Ͽ� ������ ��ȯ

SELECT ROUND(123.456, 1) FROM DUAL;
--> ���⼭ 1�� ù��° �ڸ����� �ݿø��� �Ѵٴ°� �ƴ϶�, ù��° �ڸ�""����"" ǥ����

SELECT ROUND(123.456, 0) FROM DUAL;
--> ���⼭ 0�� �Ҽ��� 0��°���� ǥ��: �� �Ҽ��� ��� �������� 123 ���

SELECT ROUND(123.456, -2) FROM DUAL;
--> 1     2    3   .   4   5   6 
--> -2,   -1,    0,      1,  2,  3 
-- ���� -2�� 123.456���� �� �տ� 1 ������ �ϴ� �ݿø��ϴ°ſ��� 100

------------------------------------------------------------------------------------------------------------------]

-- 3) FLOOR (����)

SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;
--> �⺻���� ���� �Ҽ��� ù��° �ڸ����� �����Ƿ� ���� ��ȯ

------------------------------------------------------------------------------------------------------------------]

-- 4) TRUNC (����, ����)
-- �������� ���̴� ��¥�� ���ֹ���

-- [ǥ����]
-- TRUNC (���� | ���ڷ� �� �÷��� [, ��ġ] )

SELECT TRUNC (123.456) FROM DUAL;
SELECT TRUNC (123.678) FROM DUAL;
--> ���� �⺻������ �ϸ� �Ҽ��� ���� ��� ���� �� ���� ��ȯ. ROUND, FLOOR�� ���̰� ���� X

--* FLOOR VS. TRUNC �� ���̴� ""����""���� Ȯ�� ����
SELECT TRUNC(-10.123) FROM DUAL; -- �Ҽ��� �κ��� '�����Ͽ�' ���� ���� ���: -10
SELECT FLOOR(-10.123) FROM DUAL; -- �Ҽ��� �κ��� '������' -10�� �� �Ʒ��� ���� ���: -11

SELECT TRUNC(123.456, 1) FROM DUAL; -- 123.4
SELECT TRUNC(123.456, 2) FROM DUAL; -- 123.45

SELECT TRUNC(123.456, -1) FROM DUAL; -- 120

------------------------------------------------------------------------------------------------------------------]

-- 5) CEIL (�ø�) : ������ �ø�. FLOOR�� �ݴ�.

SELECT CEIL(123.5) FROM DUAL; --124
SELECT CEIL(123.1) FROM DUAL; --124

------------------------------------------------------------------------------------------------------------------]

-- 3. ��¥ ó�� �Լ�

-- 1) SYSDATE : �ý��ۿ� ����Ǿ��ִ� ���� ��¥(�ð�)�� ��ȯ�ϴ� �Լ�
SELECT SYSDATE FROM DUAL;

-- 2) MONTHS_BETWEEN (��¥, ��¥)
-- �� ��¥�� ���� �� ���̸� ���ڷ� �����ϴ� �Լ�

-- EMPLOYEE ���̺��� 
-- �����, �Ի���, �ٹ� ���� �� ��ȸ

SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE 
FROM EMPLOYEE; -- �ٹ� �ϼ��� ǥ����.
--> �վ���Ʈ�� ���� �ʰ� �ϴ� ���
--> �����κ��� ""��"", �� ���ϴ� ��/��/��

SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEE; -- �ٹ� �������� ǥ����.
--> �����κ��� ""��""

SELECT EMP_NAME, HIRE_DATE, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS �ٹ�������
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------]

-- 3) ADD_MONTHS (��¥, ����): 
-- ��¥�� ���ڸ�ŭ�� �������� ���Ͽ� ��ȯ

SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- EMPLOYEE ���̺��� 
-- ����� �̸�, �Ի���, �Ի��Ϸκ��� 6������ �� ��¥ ��ȸ

SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------]

-- 4) LAST_DAY (��¥) : �ش� ���� ������ ��¥�� ���Ͽ� ����

SELECT SYSDATE, LAST_DAY (SYSDATE) AS "�� ���� ������ ��" FROM DUAL;

------------------------------------------------------------------------------------------------------------------]

-- 5) EXTRACT : ��¥ �����Ϳ��� ��, ��, �� ������ �����Ͽ� ����

-- EXTRACT(YEAR FROM ��¥) : �⵵�� ����
-- EXTRACT(MONTH FROM ��¥) : �� ����
-- EXTRACT(DAY FROM ��¥) : �� ����

-- EMPLOYEE ���̺���
-- ����� �̸�, �Ի� �⵵, �Ի� ��, �Ի� �� ��ȸ

SELECT EMP_NAME "��� �̸�", 
    EXTRACT(YEAR FROM HIRE_DATE) "�Ի� �⵵",
    EXTRACT(MONTH FROM HIRE_DATE) "�Ի� ��",
    EXTRACT(DAY FROM HIRE_DATE) "�Ի� ��"
FROM EMPLOYEE
ORDER BY "�Ի� �⵵" DESC, "�Ի� ��" DESC, "�Ի� ��" DESC ;


-- EMPLOYEE ���̺���
-- �����, �Ի���, �ٹ� ����� ��ȸ
-- ��, �ٹ� ����� (���� �⵵ - �Ի� �⵵)�� ��ȸ

SELECT EMP_NAME, HIRE_DATE,
        EXTRACT (YEAR FROM SYSDATE)- EXTRACT (YEAR FROM HIRE_DATE) AS "�ٹ� ���"
FROM EMPLOYEE;
-- �ٵ� �̰� �ʹ� K-AGE�� �� ����� ����ؼ� ���� �ʴ� �� ��Ȯ�� ����
-- MONTHS BETWEEN + CEIL ��� (�ٹ� �����̹Ƿ�)

SELECT EMP_NAME, HIRE_DATE, 
    CEIL ((MONTHS_BETWEEN(SYSDATE, HIRE_DATE))/12) AS "�ٹ� ����"
FROM EMPLOYEE;

--------------------------------------------------�� �� �� �� ---------------------------------------------------]

-- 1. EMPLOYEE ���̺��� �����, �Ի���-����, ����-�Ի��� ��ȸ
-- ��, �Ի���-������ ��Ī�� "�ٹ��ϼ�1", 
-- ����-�Ի����� ��Ī�� "�ٹ��ϼ�2"�� �ϰ�
-- ��� ����(����)ó��, ����� �ǵ��� ó��

SELECT EMP_NAME,
    FLOOR(ABS(HIRE_DATE-SYSDATE)) AS �ٹ��ϼ�1, 
    FLOOR(ABS(SYSDATE-HIRE_DATE)) AS �ٹ��ϼ�2
FROM EMPLOYEE;


-- 2. EMPLOYEE ���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ

SELECT * FROM EMPLOYEE
WHERE MOD(EMP_ID,2)=1;
-- EMP_ID�� VARCHAR2 ������ Ÿ���̳�, ����ó�� ������ �����ϴ�
-- �ֳ��ϸ� ����� ���ڿ� ���� ��� ���ڷθ� �̷���� �ֱ� ������ 
-- �ڵ����� NUMBER Ÿ������ ����ȯ�Ǿ� ��� ������ �̷������ ���̴�.


-- 3. EMPLOYEE ���̺��� �ٹ� ����� 20�� �̻��� ���� ���� ��ȸ

/*SELECT * FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12>=20;*/

-- OR

SELECT * FROM EMPLOYEE
WHERE ADD_MONTHS(HIRE_DATE, 240)<SYSDATE;
    
    
-- 4. EMPLOYEE ���̺��� �����, �Ի���, �Ի��� ���� �ٹ��ϼ��� ��ȸ

SELECT EMP_NAME, HIRE_DATE, 
    LAST_DAY(HIRE_DATE) - HIRE_DATE AS "�Ի��� ���� �ٹ� �ϼ�"
FROM EMPLOYEE;


------------------------------------------------------------------------------------------------------------------]

-- 4. ����ȯ �Լ�

-- 1) TO_CHAR (��¥|���� [,����])
-- ��¥ �Ǵ� ������ �����͸� ���˿� �´� ������ �����ͷ� �����Ͽ� ��ȯ

SELECT TO_CHAR(1234) FROM DUAL; -- '1234'

-- 5ĭ ������ ����, ��ĭ�� ���� 
SELECT TO_CHAR(1234, '99999') FROM DUAL; --'_1234'

-- 5ĭ ������ ����, ��ĭ�� ���� 0 
SELECT TO_CHAR(1234, '00000') FROM DUAL; --'01234'

-- ���� ������ ������ ȭ�� ���� ���̱�
SELECT TO_CHAR(10000, 'L99999') FROM DUAL; -- \10000
SELECT TO_CHAR(10000, '$99999') FROM DUAL; -- $10000

-- �ڸ����� �������ִ� �޸�(,) �߰�
SELECT TO_CHAR(10000, 'L99,999') FROM DUAL; -- \10,000
SELECT TO_CHAR(1000, '9.9EEEE') FROM DUAL; -- �ε��Ҽ��� ������� ǥ����

-- ������ ������ ������ ������ ���� �Ѿ��, ��� #���� ǥ���� (TO_CHAR ��� �� ���� ������ ��)
SELECT TO_CHAR(1234, '999') FROM DUAL;


-- EMPLOYEE ���̺���
-- �����, �޿� ��ȸ
-- ��, �޿��� '\9,000,000' �������� ��ȸ

SELECT EMP_NAME, TO_CHAR (SALARY, 'L999,999,999')
FROM EMPLOYEE;


-- ��¥ ������ ���� ����
SELECT TO_CHAR (SYSDATE, 'PM HH:MI:SS') FROM DUAL; -- 12�ð� ü��
SELECT TO_CHAR (SYSDATE, 'HH24:MI:SS') FROM DUAL; -- 24�ð� ü��

SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL; -- 2020-05-04 ������
SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD DY') FROM DUAL; -- 2020-05-04 ��

SELECT TO_CHAR (SYSDATE, 'YEAR, Q') || '�б�' FROM DUAL; -- TWENTY TWENTY, 2�б�

-- EMPLOYEE ���̺���
-- ��� ����� �̸�, ������� ��ȸ
-- ��, ������� '2020-05-04' �������� ��ȸ

SELECT EMP_NAME, 
    TO_CHAR (HIRE_DATE, 'YYYY-MM-DD') 
FROM EMPLOYEE;

-- EMPLOYEE ���̺���
-- ��� ����� �̸�, ������� ��ȸ
-- ��, ������� '2020�� 05�� 04��' �������� ��ȸ

SELECT EMP_NAME,
    TO_CHAR (HIRE_DATE, 'YYYY"��" MM"��" DD"��"') 
FROM EMPLOYEE;
-- ���� �̿��� ���ڸ� �߰��ϴ� ���� �ֵ���ǥ�� ���ο� �ۼ�

-- EMPLOYEE ���̺���
-- ��� ����� �̸�, ������� ��ȸ
-- ��, ������� '2020�� 05�� 04�� (��)' �������� ��ȸ

SELECT EMP_NAME,
    TO_CHAR (HIRE_DATE, 'YYYY"��" MM"��" DD"��" "("DY")"')
FROM EMPLOYEE;


------------------------------------------------------------------------------------------------------------------]

-- 2) TO_DATE 
-- ���� �Ǵ� ������ �����͸� ��¥������ ��ȯ�Ͽ� ��ȯ(����)�ϴ� �Լ�

-- [ǥ����]
-- TO_DATE(����|������ ������ [, ����])

SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE(20100101, 'YYYYMMDD') FROM DUAL;

-- WHAT IF 20100101�̶�� ���� �ڷḦ 2010-01-01 �� �ٲ۴ٸ�?
--> TO_DATE (���� ��ȣ��) + TO_CHAR (�� �� ū ��ȣ)

SELECT TO_CHAR( TO_DATE('20100101', 'YYYYMMDD'), 'YYYY-MM-DD' )
FROM DUAL;

SELECT TO_CHAR ( TO_DATE('980630', 'RRMMDD'), 'RRRR-MM-DD' )
FROM DUAL;  
-- �� YY�� �ƴ϶� RR�̳ĸ� YY�� �ϸ� 1998�� �ƴ϶� 2098 ����

SELECT TO_CHAR ( TO_DATE('140918', 'RRMMDD'), 'RRRR-MM-DD' )
FROM DUAL;  
-- �̰Ŵ� YY�ϵ� RR�ϵ� �Ȱ���.

-- TO_DATE�� ���� �� �⵵�� �ٲٱ� ���� Y�� R�� ������
-- Y: �� ���⸦ ���� (���� 21�����̴� 21����)
-- R: ��� ������ 50�� �̻��̸� ����(19XX) ����, �̸��̸� ����(20XX) ���⸦ ����


-- EMPLOYEE ���̺���
-- 2000�⵵ ���Ŀ� �Ի��� ����� ���, �̸�, �Ի����� ��ȸ

SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE >= TO_DATE ('20000101', 'RRRRMMDD');
--> ��������� ������ Ÿ���� �����ִ� ���� ����.


------------------------------------------------------------------------------------------------------------------]

-- TO_NUMBER(���� ������ [, ����]) : ������ �����͸� ���� �����ͷ� ��ȯ

-- ��������� ���� -> ���ڷ� ��ȯ (BEST SOLUTION)
SELECT TO_NUMBER ('100') + TO_NUMBER('200') FROM DUAL;

-- ����Ŭ�� ���� �ڵ� ����ȯ(���ڰ� ���ο� ���ڸ� �����Ƿ� ����)
SELECT '100' + '200' FROM DUAL;

-- ���ڰ� �ƴ� �����Ͱ� ���ԵǸ� ���� �߻�
SELECT TO_NUMBER ('100A') + TO_NUMBER('200B') FROM DUAL;

SELECT TO_NUMBER('1,000,000', '9,999,999') FROM DUAL; 
-- 1,000,000�� 9,999,999 ���Ŀ� ���ϱ� ���� ���� ��ġ�ع����� 
-- �� ���� �̷� ���ڱ���, �ϰ� �׳� �ĸ� ��� ���� 1000000 ��ȯ


------------------------------------------------------------------------------------------------------------------]

-- 5. NULL ó�� �Լ�

-- 1) NVL (NULL VALUE) : �÷���, �÷����� NULL�� �� ��ü�� ��

-- EMPLOYEE ���̺���
-- BONUS�� NULL�� ����� BONUS �÷����� 0���� ��ȯ�Ͽ�
-- �����, ���ʽ� ��ȸ

SELECT EMP_NAME, NVL(BONUS, 0) -- ���ʽ� �÷����� NULL�� ������ 0���� ��ü�ϰڴ�
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �μ��ڵ� ��ȸ
-- ��, �μ��ڵ尡 NULL�� ����� '00'���� ��ȸ

SELECT EMP_NAME, NVL(DEPT_CODE, '00')
FROM EMPLOYEE;

-- 2) NVL2 (NULL VALUE 2) : �÷���, �÷����� NULL�� �ƴ� ��츦 ��ü�� ��, �÷����� NULL�� ��츦 ��ü�� ��

-- EMPLOYEE ���̺���
-- ������ ���ʽ��� �޴� ����� ���ʽ��� 0.8��
-- ���� ���ϴ� ����� ���ʽ��� 0.3���� �����Ͽ�
-- �����, ���� ���ʽ�, ����� ���ʽ� ��ȸ

SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.8, 0.3) AS "����� ���ʽ�"
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------]

-- ������ �Լ� ���� ����

--1. EMPLOYEE ���̺���
--  ������� �ֹι�ȣ�� ��ȸ
--  ��, �ֹι�ȣ 9��° �ڸ����� �������� '*'���ڷ� ä��
--  �� : ȫ�浿 771120-1******

SELECT EMP_NAME, 
        RPAD (SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;


--2. EMPLOYEE ���̺���
--  ������, �����ڵ�, ����(��) ��ȸ
--  ��, �Ѽ��ɾ��� ��57,000,000 ���� ǥ��
--  (�Ѽ��ɾ��� ���ʽ��� ����� 1��ġ �޿�)

SELECT EMP_NAME, JOB_CODE, TO_CHAR (SALARY*12*BONUS, 'L999,999,999')
FROM EMPLOYEE;


-- 3. EMPLOYEE ���̺���
--   �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� ������ 
--	 ��� ����� �μ��ڵ� �Ի��� ��ȸ

SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D9';


-- 4. EMPLOYEE ���̺���
--   ������, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ
--   ��, �Ի��� ���� �ٹ��ϼ��� �����ؼ� +1 �� ��

SELECT  EMP_NAME, HIRE_DATE, (LAST_DAY(HIRE_DATE) - HIRE_DATE +1) AS "�Ի��� �� �ٹ��ϼ�(+1)"
FROM EMPLOYEE;


--5. EMPLOYEE ���̺���
--  ������, �μ��ڵ�, �������, ����(��) ��ȸ
--  ��, ��������� �ֹι�ȣ���� �����ؼ�, 
--  ������ ������ �����Ϸ� ��µǰ� ��.
--  ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ����, ���.

SELECT  
    EMP_NAME AS "������", 
    DEPT_CODE AS "�μ� �ڵ�",
    SUBSTR(EMP_NO, 1, 2) || '�� ' || SUBSTR(EMP_NO, 3, 2) || '�� ' || SUBSTR(EMP_NO, 5, 2) || '��' AS "�������",
    (EXTRACT (YEAR FROM SYSDATE)) -  (EXTRACT (YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 6)))) AS "�� ����"
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------]

-- 6. �����Լ�
-- ���� ���� ��쿡 ���� ������ �� �� �ִ� ����� �����ϴ� �Լ�

-- DECODE (����|�÷���, ���ǰ�1, ���ð�1, ���ǰ�2, ���ð�2, ..., ������) : �ڹ��� switch���� ���
-- ���ϰ��� �ϴ� �� �Ǵ� �÷��� ���ǰ��� ��ġ�ϸ� �ش� ���ð��� ��ȯ

-- EMPLOYEE ���̺��� 
-- ����� ���, �̸�, �ֹι�ȣ, ����(��/��)�� ��ȸ

SELECT EMP_ID, EMP_NAME, EMP_NO, 
    DECODE ( SUBSTR (EMP_NO, 8, 1), 1, '��', 2, '��' ) AS "����"
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ������ �޿��� �λ��ϰ��� �Ѵ�.
-- ���� �ڵ尡 J7�� ������ 10% �λ�, 
-- ���� �ڵ尡 J6�� ������ 15% �λ�,
-- ���� �ڵ尡 J5�� ������ 20% �λ�
-- �� �� ������ 5% �λ�
-- �����, �����ڵ�, ���� �޿�, �λ� �޿��� ��ȸ�Ͻÿ�.

SELECT EMP_NAME, JOB_CODE, SALARY AS "���� �޿�", 
    DECODE (JOB_CODE, 'J7', 1.1*SALARY, 
                                  'J6', 1.15*SALARY, 
                                  'J5', 1.2*SALARY, 
                                  1.05*SALARY) AS "�λ� �޿�"       
                                  -- ������ ó���� ������ٵ�, �� ���� ���ǰ��� �ƿ� ���� �ʰ� ���ð��� ������ ��.
FROM EMPLOYEE;

-- CASE�� : java�� if-else���� ���
-- [ǥ����] 
/*
    CASE WHEN ���ǽ� THEN �����
            WHEN ���ǽ�2 THEN �����2
            ... 
            ELSE ������ ����� 
    END
*/

-- EMPLOYEE ���̺��� 
-- ���, ����� �̸�, �ֹι�ȣ, ����(��/��) ��ȸ

SELECT EMP_ID, EMP_NAME, EMP_NO,
    CASE WHEN SUBSTR(EMP_NO, 8, 1) = '1' THEN '��'
            -- WHEN SUBSTR(EMP_NO, 8, 1) = '2' THEN '��'
            ELSE '��'
    END AS ���� 
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ������ �޿��� �λ��ϰ��� �Ѵ�.
-- ���� �ڵ尡 J7�� ������ 10% �λ�, 
-- ���� �ڵ尡 J6�� ������ 15% �λ�,
-- ���� �ڵ尡 J5�� ������ 20% �λ�
-- �� �� ������ 5% �λ�
-- �����, �����ڵ�, ���� �޿�, �λ� �޿��� ��ȸ�Ͻÿ�.

SELECT EMP_NAME AS "�̸�", JOB_CODE AS "���� �ڵ�", SALARY AS "���� �޿�",
    CASE WHEN JOB_CODE = 'J7' THEN 1.1 * SALARY
            WHEN JOB_CODE = 'J6' THEN 1.15 * SALARY
            WHEN JOB_CODE = 'J5' THEN 1.2 * SALARY
            ELSE 1.05 * SALARY
    END AS "�λ� �޿�"
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ���, �̸�, �޿�, ������ ��� ��ȸ
-- ������ ��� ����
-- �޿��� 500�� �̻��̸� '���' 
-- �޿��� 500�� �̸�, 300�� �̻��̸� '�߱�'
-- �޿��� 300�� �̸��� '�ʱ�'

SELECT EMP_ID, EMP_NAME, SALARY, 
    CASE WHEN SALARY >=5000000 THEN '���' 
            WHEN SALARY >=3000000 THEN '�߱�'
            ELSE '�ʱ�'
    END AS "������ ���"
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------]

-- 7. �׷� �Լ�
-- �ϳ� �̻��� ���� �׷����� ���� �����Ͽ�, �ϳ��� ������� ��ȯ�ϴ� �Լ�

-- SUM(���ڰ� ��ϵ� �÷���) : �ش� �÷��� ������ ���Ͽ� ��ȯ

-- EMPLOYEE ���̺��� �� ����� �޿� ���� ��ȸ 
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ���� ����� �޿� ���� ��ȸ 
SELECT SUM(SALARY) FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

-- EMPLOYEE ���̺��� 
-- �μ��ڵ尡 'D5'�� ������ ���ʽ� ���� ���� ���� ��ȸ
SELECT SUM(SALARY * (1+ NVL(BONUS, 0)) * 12 ) AS "D5 ���ʽ� ���� ����"
-- �� ��� ���꿡 NULL���� ���ԵǸ� ����� ������ NULL --> NVL �Լ� ���
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

------------------------------------------------------------------------------------------------------------------]

-- AVG (���ڰ� ��ϵ� �÷���) : �׷��� ����� ���Ͽ� ��ȯ

-- EMPLOYEE ���̺��� �� ����� �޿� ��� ��ȸ (�Ҽ��� ����)
SELECT TRUNC(AVG(SALARY)) FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �� ����� ���ʽ� ��� ��ȸ (�Ҽ��� ��°�ڸ����� �ݿø�)
SELECT ROUND(AVG(NVL(BONUS, 0)), 2) FROM EMPLOYEE;
-- NULL ó�� -> ��� -> �Ҽ��� ��°�ڸ����� �ݿø�

------------------------------------------------------------------------------------------------------------------]

-- MIN (�÷���) : �׷� �� ������ �÷����� ���� ���� �� ��ȯ
-- ����ϴ� �÷��� �ڷ����� ANY TYPE(��� Ÿ��)

-- EMPLOYEE ���̺��� 
-- ���ĺ� ������ ���� ���� �̸���, 
-- ���� ���� �Ի���,
-- ���� ���� �޿��� �ѹ��� ��ȸ

SELECT MIN (EMAIL), MIN (HIRE_DATE), MIN(SALARY)
FROM EMPLOYEE;

-- MAX (�÷���) : �׷� �� ������ �÷����� ���� ū �� ��ȯ

-- EMPLOYEE ���̺��� 
-- ���ĺ� ������ ���� ���� �̸���, 
-- ���� ���� �Ի���,
-- ���� ���� �޿��� �ѹ��� ��ȸ

SELECT  MAX(EMAIL), MAX (HIRE_DATE), MAX(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE ���̺���
-- �μ��ڵ� D5�� ���� �� ���� ���� �޿�, ���� ���� �޿�, �μ� 
-- ��ü �޿� ��, �μ� ��ü �޿� ���

SELECT MAX (SALARY), MIN(SALARY), SUM(SALARY), AVG(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

------------------------------------------------------------------------------------------------------------------]

-- COUNT (* | [DISTINCT] �÷���) : ��ȸ�Ǵ� ���� ������ ��Ʒ��� ��ȯ
-- COUNT (*) : ���� ���� ��� / NULL�� ������ ��� (��ü) �� ���� ��ȯ
-- COUNT (�÷�) : �ش� �÷����� NULL���� ������ �� ���� ��ȯ
-- COUNT (DISTINCT �÷���) : �ߺ��� ������ �� ���� ��ȯ + NULL ����

-- EMPLOYEE ���̺��� 
-- ��� ����� ��, �μ� �ڵ尡 �ִ� ����� ��, ����� ���� �μ��� �� ��ȸ

SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

-- EMPLOYEE���̺��� �μ��ڵ尡 'D5'�� ����� �� ----------------------------------------------------------------------------------------------------------------------

SELECT COUNT (DEPT_CODE) 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

------------------------------------------------------------------------------------------------------------------]

-- �ǽ� ����

-- 1. �������� �Ի��Ϸκ��� �⵵�� ������, �� �⵵�� �Ի��ο����� ���Ͻÿ�.
--  �Ʒ��� �⵵�� �Ի��� �ο����� ��ȸ�Ͻÿ�.
--  => TO_CHAR, DECODE, SUM �Ǵ� COUNT ���
--	-------------------------------------------------------------
--	��ü������   2001��   2002��   2003��   2004��

SELECT COUNT(EMP_NAME) AS "��ü ������"
           COUNT(SUBSTR(HIRE_DATE, 1, 2)='01') AS "2001��",  
           COUNT(SUBSTR(HIRE_DATE, 1, 2)='02') AS "2002��",  
           COUNT(SUBSTR(HIRE_DATE, 1, 2)='03') AS "2003��",
           COUNT(SUBSTR(HIRE_DATE, 1, 2)='04') AS "2004��"
FROM EMPLOYEE;

-- �� ������ �ȵư� (���� �� ��)

SELECT 
    COUNT(*) AS ��ü������,
    -- COUNT(CASE WHEN EXTRACT(YEAR FROM HIRE_DATE) = '2001' THEN '2001��' END)
    COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2001', 1)) AS "2001��",
    COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2002', 1)) AS "2002��",
    COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2003', 1)) AS "2003��",
    COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2004', 1)) AS "2004��"
    -- COUNT ���� ���ڸ� ������ SUM�� ���µ� NVL�� �־�� �Ѵ�
FROM EMPLOYEE;


--2.  �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ �����, �μ��ڵ�, �μ��� ��ȸ��

SELECT EMP_NAME, DEPT_CODE, 
    CASE WHEN DEPT_CODE = 'D5' THEN '�ѹ���'
            WHEN DEPT_CODE = 'D6' THEN '��ȹ��'
            WHEN DEPT_CODE = 'D9' THEN '������'
    END AS "�μ���"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D6' OR DEPT_CODE= 'D9';

-- OR

SELECT EMP_NAME, DEPT_CODE,
    DECODE (DEPT_CODE, 'D5', '�ѹ���',
                                    'D6', '��ȹ��',
                                    'D9', '������') AS �μ���
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D6', 'D9');


