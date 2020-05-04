SELECT EMP_NAME FROM EMPLOYEE;

-- �� �� �ּ�

/* 
���� �ּ� 
*/ 

-- ���� ������ ����� �̸�, ������ ��ȸ�ϴ� ����
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- ��� ����� ���� ��� ���� ��ȸ
SELECT * FROM EMPLOYEE;
-- '*' �� ��θ� �ǹ��ϴ� ��ȣ

--------------------------------------------- �ǽ� ���� ---------------------------------------------------
-- 1. JOB ���̺��� ��� ���� ��ȸ
SELECT * FROM JOB;

-- 2. JOB ���̺��� ���޸� ��ȸ
SELECT JOB_NAME 
FROM JOB;

-- 3. DEPARTMENT ���̺��� ��� ���� ��ȸ
SELECT * FROM DEPARTMENT;

-- 4. EMPLOYEE ���̺��� �����, �̸���, ��ȭ��ȣ, ����� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- 5. EMPLOYEE ���̺��� �����, �����, ���� ��ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

----------------------------------------------------------------------------------------------
-- �÷� �� ��� ����
-- SELECT �� �÷� �� �Է� �κп� 
-- ��꿡 �ʿ��� �÷���, ����, ��� �����ڸ� �̿��Ͽ� 
-- ���ϴ� ������ �÷� ���� ��ȸ�� �� �ִ�.

-- EMPLOYEE ���̺��� ������ ���� ��ȸ (����=�޿�*12)
SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� 
-- �����, ����, ���ʽ��� �ݿ��� ������ ��ȸ
-- ���ʽ��� �ݿ��� ���� = (�޿�+(�޿�*���ʽ�)) * 12
SELECT EMP_NAME, SALARY * 12, (SALARY + (SALARY*BONUS))*12
FROM EMPLOYEE;

----- �ǽ� ���� -----
-- 1. EMPLOYEE ���̺��� 
-- �����, ����, ���ʽ��� �ݿ��� ����, �Ǽ��ɾ��� ��ȸ
-- (�Ǽ��ɾ� = ���ʽ��� �ݿ��� ���� - ���� 3%)
SELECT EMP_NAME, SALARY*12, (SALARY+(SALARY*BONUS))*12, (SALARY+(SALARY*BONUS))*12*0.97
FROM EMPLOYEE;

-- 2. EMPLOYEE ���̺���
-- �̸�, �����, �ٹ��ϼ�(���ó�¥-�����) ��ȸ
-- (DATE Ÿ�Գ����� ��� ������ ����)
-- ** ���� �ð�(��¥)�� ��ȸ�ϴ� Ű���� ==> SYSDATEAKF
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;

--------------------------------------------------------------------------------------------------

--   �÷� ��Ī
--      AS  ��Ī       /       "��Ī"        /      AS "��Ī"
--     Ư������ X     /                 Ư������ O
-- (Ư�����ڴ� ���� ��ȣ + ���鹮�� + ���� )

-- EMPLOYEE ���̺���
-- �����, ����, ���ʽ��� �ݿ��� ����, �Ǽ��ɾ��� ��ȸ (��Ī �ݿ�)
SELECT EMP_NAME AS �����, 
            SALARY * 12 "����(��)",
            (SALARY + (SALARY*BONUS)) *12 AS "���ʽ� ����(��)",
            ((SALARY + (SALARY*BONUS)) * 12 * 0.97) AS "�Ǽ��ɾ�"
FROM EMPLOYEE;

--------------------------------------------------------------------------------------------------

-- ���ͷ�
-- ���Ƿ� ������ ���ڿ��� SELECT���� ����ϸ�, ���̺� �����ϴ� ������ó�� ����� �� ����
-- ���ڳ� ��¥ ���ͷ��� ' '(Ȧ����ǥ) ��ȣ�� ���
-- ���ͷ��� RESULT SET (��ȸ�� ����� ����)�� ��� �࿡ �ݺ� ǥ�õ�

-- EMPLOYEE ���̺��� 
-- ������ ���, �̸�, �޿�, ����(������: ��) �� ��ȸ

SELECT EMP_ID, EMP_NAME, SALARY, '��' AS ����
FROM EMPLOYEE;


-- DISTINCT
-- �÷��� ���Ե� �ߺ����� �� ������ ǥ���ϰ��� �� �� ����ϴ� Ű����
-- (�ߺ� ����)

-- EMPLOYEE ���̺��� ������ ���� �ڵ� ������ ��ȸ
SELECT JOB_CODE FROM EMPLOYEE;

-- �� SQL������ �ߺ� ����
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- JOB_CODE�� DEPT_CODE ��ȸ (���޺� �μ� ���� ��ȸ)
SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE FROM EMPLOYEE;
--> DISTINCT�� SELECT ���� �� �ѹ��� �ۼ��� �� �ִ�. (����)

SELECT DISTINCT JOB_CODE, DEPT_CODE FROM EMPLOYEE;


--------------------------------------------------------------------------------------------------------

-- WHERE��
-- ��ȸ�� ���̺��� ������ �´� ���� ���� ���� ��󳻴� ����

/* [ǥ����]
SELECT �÷���
FROM ���̺��
WHERE ���ǽ�;
*/

-- * �񱳿�����
-- =(����), >, <, >=, <
-- !=, ^=, <>(���� �ʴ�)

-- EMPLOYEE ���̺��� �μ� �ڵ尡 'D9'�� ������ �̸�, �μ��ڵ� ��ȸ
SELECT EMP_NAME,  DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE ���̺��� �μ� �ڵ尡 'D9'�� �ƴ� ������ �̸�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE ���̺��� �޿��� 4000000 �̻��� ������ �̸�, �޿� , ���� �ڵ带 ��ȸ
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE ���̺��� ��� ���ΰ� 'N'�� ������ ��ȸ�ϰ�, 
-- �ٹ� ���� �÷��� '������'���� ǥ���Ͽ�
-- ���, �̸�, �����, �ٹ����� �� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, '������' AS "�ٹ� ����"
FROM EMPLOYEE
WHERE ENT_YN='N'; 

------------------------------------------ �ǽ����� --------------------------------------------

-- 1. EMPLOYEE ���̺��� ������ 3000000 �̻��� �����
-- �̸�, ����, ����� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. EMPLOYEE ���̺��� SAL_LEVEL�� S1�� ����� 
-- �̸�, ����, �����, ����ó ��ȸ
SELECT  EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

-- 3. EMPLOYEE���̺��� ������ 50000000�̻��� ����� 
-- �̸�, ����, ����, ����� ��ȸ
SELECT EMP_NAME AS �̸�, SALARY AS ����, SALARY*12 AS ����, HIRE_DATE AS �����
FROM EMPLOYEE
WHERE SALARY*12>=50000000;

-----------------------------------------------------------------------------------------------------------

-- �� ������(AND/OR)
-- �������� ������ ���� �� ����ϴ� ������

-- EMPLOYEE ���̺��� 
-- �μ��ڵ尡 'D6'�̰� 
-- �޿��� 200���� �̻� �޴� ������
-- �̸�, �μ��ڵ�, �޿��� ��ȸ�Ͻÿ�.

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6'
AND SALARY >= 2000000;

-- (�� �������� ��¦�� ����) EMPLOYEE ���̺��� 
-- �μ��ڵ尡 'D6' �̰ų� 
-- �޿��� 200���� �̻� �޴� ������
-- �̸�, �μ��ڵ�, �޿��� ��ȸ�Ͻÿ�.

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6'
OR SALARY >= 2000000;

-- EMPLOYEE ���̺��� 
-- �޿��� 350���� �̻�, 600���� ������ ������
-- ���, �̸�, �޿�, �μ��ڵ� ��ȸ

SELECT EMP_ID AS ���, EMP_NAME AS �̸�, SALARY AS ���޿�, DEPT_CODE AS �μ��ڵ�
FROM EMPLOYEE
WHERE SALARY >= 3500000 
AND SALARY <= 6000000;

--------------------------------------------- �ǽ� ���� ---------------------------------------------------

-- 1. EMPLOYEE���̺���
-- ������ 400���� �̻��̰� JOB_CODE�� J2�� ����� ��ü ���� ��ȸ

SELECT * FROM EMPLOYEE
WHERE SALARY>=4000000
AND JOB_CODE = 'J2';

-- 2. EMPLOYEE ���̺���
-- DEPT_CODE�� D9�̰ų� D5�� ��� ��
-- ������� 02�� 1�� 1�Ϻ��� ���� �����
-- �̸�, �μ��ڵ�, ����� ��ȸ
-- TIP. ���� ������ ��� ���� �߿�!
-- ���� ������ �˻��ؾߵǴ� ��� ��ȣ�� ���� ��

SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D5')
AND HIRE_DATE < '02/01/01';

-- BETWEEN 'A' AND 'B' (A�� B ����)
--> 'A' �̻� 'B' ����

-- EMPLOYEE ���̺��� 
-- ������ 350�� �̻�, 600�� ������ ������ 
-- ���, �̸�, �޿�, �μ��ڵ� ��ȸ

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- (���� ���� ����) EMPLOYEE ���̺��� 
-- ������ 350�� �̸�, 600�� �ʰ��� ������ (=350�� �̻�, 600�� ���ϰ� �ƴ�)
-- ���, �̸�, �޿�, �μ��ڵ� ��ȸ

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

-- EMPLOYEE ���̺���
-- ������� '90/01/01' ~ '01/01/01' �� ����� ��� �÷� ��ȸ

SELECT * FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01' ;


-- ���� ������ (||)
-- ���� �÷��� �ϳ��� �÷��� ��ó�� �����ϰų�
-- �÷��� ���ͷ��� �����ϴµ� ����ϴ� ������
-- �ڹٿ��� String �ڷ������� �̾���� �� ����ϴ� '+' �� �ش�

-- EMPLOYEE ���̺��� ���, �̸�, �޿��� �����Ͽ� �޽��� �÷� ��ȸ
-- (EX) ����� 200�� �������� ������ 8000000�� �Դϴ�.

SELECT '����� ' || EMP_ID || '�� ' || EMP_NAME || '�� ������ ' || SALARY || '�� �Դϴ�.' AS �޼���
FROM EMPLOYEE;

-----------------------------------------------------------------------------------------------------------

-- ** LIKE (~����, ~ó��)

/*

���Ϸ��� ���� ������ Ư�� ������ ������Ű���� Ȯ���� �� ���

�񱳴�� �÷��� LIKE '��������'
 
- ���� ����
'A%' (A�� �����ϴ� ��)
'%A' (A�� ������ ��)
'%A%' (A�� ���ԵǴ� ��)

- ���� ����
'_' (�� ����)
'__' (�� ����)
'____' (�� ����)

*/

-- EMPLOYEE ���̺���
-- ���� '��'���� ����� ���, �̸�, �����

SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- EMPLOYEE ���̺���
-- �̸��� '��'�� ���Ե� ����� ���, �̸�, �����, �μ��ڵ�

SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- EMPLOYEE ���̺���
-- ��ȭ��ȣ �� ��° �ڸ��� '7'�� �����ϴ� �����
-- ���, �̸�, ��ȭ��ȣ ��ȸ

SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '___7%';

-- EMPOLYEE ���̺��� 
-- �̸��� �� �� ���ڰ� 3�ڸ��� ����� 
-- ���, �̸�, �̸��� ��ȸ

SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___%';
--> ��ȸ ����� ���ϴ´�� ���� �� ����. �ֳĸ� �̸��Ͽ� _�� ���ԵǾ� ����!
--> ESCAPE OPTION�� ����ؾ� ��

SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#' ;
--> ESCAPE �ڿ� �� '����' �װ� �ٷ� ���� ����, ���ڷ� �ν��ϰڴ�. �̷� ����
--> ����ٰ� �򰥸��� �Ǽ� ������ �ɼ����� ���̴� �Ⱦ������� �˰�� �־����

-- NOT LIKE
-- LIKE�� Ư�� ������ �����ϴ� ���̾��ٸ�,
-- NOT LIKE�� Ư�� ������ �������� �ʴ� ���� ��ȸ

-- EMPLOYEE ���̺��� 
-- '��'�� ���� �ƴ� ����� ���, �̸�, ����� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '��%' ;


--------------------------------------------- �ǽ� ���� ---------------------------------------------------
-- 1. EMPLOYEE ���̺���
-- �̸� ���� '��'���� ������ ����� �̸� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- 2. EMPLOYEE ���̺���
-- ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%' ;

-- 3. EMPLOYEE ���̺���
-- �����ּ� '_'�� ���� 4���̸鼭,
-- DEPT_CODE�� D9 �Ǵ� D6�̰�
-- ������� 90/01/01~00/12/01�̰�
-- �޿��� 270�� �̻��� ����� ��ü�� ��ȸ
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '____$_%' ESCAPE '$'
AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6')
AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01'
AND SALARY >= 2700000;

/* ORACLE ������ �켱 ���� (��ȣ�� ������ �켱�̶� ����)
1. ��� ������
2. ���� ������ (||)
3. �� ������
4. IS NULL / IS NOT NULL, LIKE, NOT LIKE, IN, NOT IN
5. BETWEEN AND / NOT BETWEEN AND
6. NOT ����
7. AND
8. OR */

-----------------------------------------------------------------------------------------------------------

-- IS NULL: �÷� ���� NULL�� ���
-- IS NOT NULL: �÷� ���� NULL�� �ƴ� ���

-- EMPLOYEE ���̺���
-- ���ʽ��� �޴� �����
-- ���, �̸�, �޿�, ���ʽ� 
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- (���� ������ ���� �ٸ�) EMPLOYEE ���̺���
-- ���ʽ��� �� �޴� �����
-- ���, �̸�, �޿�, ���ʽ� 
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- EMPLOYEE ���̺���
-- �μ� ��ġ�� �޾�����
-- ���ʽ��� ���޹��� ���ϴ� ����� 
-- �̸�, ���ʽ�, �μ� �ڵ� ��ȸ
SELECT  EMP_NAME, BONUS, DEPT_CODE 
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
AND BONUS IS NULL;

-----------------------------------------------------------------------------------------------------------

-- IN ( )
-- ���Ϸ��� ���� ���()�� ��ġ�ϴ� ���� ������ TRUE, ������ FALSE ��ȯ
-- [ǥ����]
-- �񱳴���÷��� IN (��1, ��2, ��3, .... )

-- EMPLOYEE ���̺���
-- �μ��ڵ尡 D6, D8, D9�� ����� �̸�, �μ��ڵ�, �޿� ��ȸ
-- IN ������ ���� �ʰ� �غ���
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D6' 
OR DEPT_CODE = 'D8' 
OR DEPT_CODE = 'D9';

-- IN ������ ���� �غ��� (��ġ �迭�� FOR������)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6', 'D8', 'D9');

-----------------------------------------------------------------------------------------------------------

/*
*** ORDER BY ��
- SELECT�� ����� ������ �� �ۼ��ϴ� ����
- SELECT�� ���� ��������(WHERE�� �ڿ�, ; ��� ������) �ۼ�
- SELECT ���� ���� �� ���� ������

[ǥ����]
SELECT �÷��� [, �÷���, ... ]
FROM ���̺��
[WHERE ���ǽ�] 
[ORDER BY �÷���||��Ī||�÷����� ���Ĺ�� [ NULLS FIRST | LAST ] ];

NULLS FIRST: ���� ������ �÷��� NULL���� ������ �� �κп� ����
NULLS LAST: ���� ������ �÷��� NULL���� ������ �޺κп� ����
*/

-- EMPLOYEE ���̺���
-- �޿� �������� �������
-- �̸�, �޿�, �μ��ڵ�, �����ڵ� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
ORDER BY SALARY ; -- ASC�� ���������̶�� ���� (���� ����. ASC ���� �Ƚᵵ �Ȱ���)

-- (������ �ݴ��) EMPLOYEE ���̺���
-- �޿� �������� �������
-- �̸�, �޿�, �μ��ڵ�, �����ڵ� ��ȸ
SELECT EMP_NAME, SALARY AS �޿�, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
-- ORDER BY SALARY DESC ; -- DESC�� ���������̶�� ��. (�翬�� ���� �Ұ�. �ʿ� �� �ݵ�� ���.)
-- ORDER BY 2 DESC; -- 2��° �÷��� �߽�����(SQL�� 0�� �ƴ϶� 1���� ����) �������� ����.
ORDER BY �޿� DESC; -- SALARY�� ��Ī���� ������ ���Ŀ��� �����ϴ�.
