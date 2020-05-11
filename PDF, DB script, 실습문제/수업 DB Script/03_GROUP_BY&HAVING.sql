/* 
��(����): ���ۺ��� �����ݷб����� �θ��� ����
��: Ư�� ����(���� �� ��)

EX) SELECT EMP_NAME                 -- SELECT��
     FROM EMPLOYEE                    -- FROM��
     WHERE DEPT_CODE ='D5'         -- WHERE��
    -- �׸��� �� ���� ��ü�� �ϳ��� SELECT��
    
***** SELECT�� �ؼ� ���� *****
5: SELECT �÷��� AS ��Ī, ����, �Լ���                             
1: FROM ������ ���̺��                                                   
2: WHERE �÷���|�Լ��� �񱳿����� �񱳰�                           
3: GROUP BY �׷��� ���� �÷���                                         
4: HAVING �׷��Լ��� �񱳿����� �񱳰�                             
6: ORDER BY �÷���|��Ī|���� ���Ĺ�� [NULLS FIRST | LAST];  

----------------------------------------------------------------------------------------------------------------------

/* GROUP BY ��
- ���� ������ ������ ��ϵ� �÷��� ������
- ���� ������ �ϳ��� �׷����� ����
EX. EMPLOYEE ���̺��� ������� �μ����� ��� ������
*/

-- EMPLOYEE ���̺��� �μ��� �޿� �հ� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE;
-- not a single-group group function ���� �߻�!

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- EMPLOYEE ���̺��� 
-- �μ��� �޿� ��, �޿� ���(�Ҽ��� ����), ���� �� ��ȸ
SELECT DEPT_CODE, SUM(SALARY) AS "�հ�", 
                             FLOOR(AVG(SALARY)) AS "���",
                             COUNT(*) AS "������"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- EMPLOYEE ���̺���
-- �μ��� ���ʽ��� �޴� ����� �� ��ȸ�ϰ� 
-- �μ� �ڵ� ������������ ��ȸ(NULL ������)
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC NULLS LAST;
-- ORDER BY������ ASC NULLS LAST�� �⺻������ ���� ����

-- EMPLOYEE ���̺���
-- ���� �� �޿� ���(�ݿø�), �޿� ��, �ο� �� ��ȸ
-- �ο��� �������� ����
SELECT DECODE (SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��') AS "����",
           ROUND (AVG(SALARY)) AS "���",
           SUM (SALARY) AS "�հ�",
           COUNT(*) AS "�ο���"
FROM EMPLOYEE
-- GROUP BY ����; --> ���� SELECT���� �ؼ����� �ʾ�(�ؼ� ������ �ڿ� ����) ��� �Ұ�
GROUP BY DECODE (SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��')
ORDER BY "�ο���" DESC;

-- WHERE�� + GROUP BY �� ȥ�� SQL��
-- ** WHERE���� �� �÷� ���� ���� �����̶�� ���� ��!��!��!��!

-- EMPLOYEE ���̺��� 
-- �μ� �ڵ尡 'D5' �Ǵ� 'D6'�� �μ��� ��� �޿� ��ȸ
SELECT DEPT_CODE, AVG(SALARY)                   -- 4����
FROM EMPLOYEE                                           -- 1����
WHERE DEPT_CODE IN ('D5', 'D6')                    -- 2����
GROUP BY DEPT_CODE;                                  -- 3����

-- EMPLOYEE ���̺���
-- ���޺� 2000�⵵ ���� �Ի��ڵ��� �޿� �� ��ȸ
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE HIRE_DATE >= TO_DATE ('20000101', 'YYYYMMDD')
GROUP BY JOB_CODE;

-- ���� �÷��� ��� �׷����� ���� ����
-- ** ���� ����
-- SELECT���� GRUOP BY�� ��� ��,
-- SELECT���� ����� ��ȸ�� �÷� �� �׷� �Լ��� ������� ���� �÷���
-- ��� GROUP BY���� �ۼ��ؾ���.

-- EMPLOYEE ���̺���
-- �μ����� ���� ������ ����� �޿� �հ踦 ��ȸ�ϰ�
-- �μ��ڵ� ������������ ����

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
-- GROUP BY DEPT_CODE; --> ORA-00979: not a GROUP BY expression ���� �߻�
GROUP BY DEPT_CODE, JOB_CODE -- �μ��� ���� (�̰� ������ �ٲ�� ���޺� �μ��� �ȴ�)
--> GROUP BY ���� �ۼ��Ǵ� �÷� ������� �׷� ����ȭ �����
--> DEPT_CODE�� �׷��� ���� ��, �� �׷쿡�� JOB_CODE�� �� �׷� ����ȭ
ORDER BY DEPT_CODE;

-- EMPLOYEE ���̺���
-- �μ��� �޿� ����� ���� ������ ���� ��ȸ�ϰ� 
-- �μ��� �޿� ��� ������������ ����
SELECT DEPT_CODE, SAL_LEVEL, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, SAL_LEVEL
ORDER BY DEPT_CODE, SAL_LEVEL; -- DEPT_CODE�� ���� �����ϰ� �� �ȿ��� SAL-LEVEL�� �� ���� �ض�

----------------------------------------------------------------------------------------------------------------------

-- HAVING��: �׷��Լ��� ���ؿ� �׷쿡 ���� ������ ������ �� ���
-- [ǥ����]
-- HAVING �÷���|�Լ��� �񱳿����� �񱳰�

-- �μ��� �޿� ����� 300���� �̻��� �μ���
-- �μ��ڵ�, ��� �޿� ��ȸ
-- �μ��ڵ� �������� ����

SELECT DEPT_CODE, FLOOR(AVG(SALARY)) AS "���"
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;
--> �μ��� �޿��� 300�� �̻��� ������ �޿� ����� ���� ���̴� <WRONG>

SELECT DEPT_CODE, FLOOR(AVG(SALARY)) AS "���"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000
ORDER BY DEPT_CODE;
--> ���� �ڵ忡�� WHERE �� ���� ��, HAVING�� �߰�

-- �μ��� �޿� ���� 900������ �ʰ��ϴ� �μ��� 
-- �μ��ڵ�, �޿� �� ��ȸ�ϰ�
-- �μ��ڵ� ������������ ����
SELECT DEPT_CODE, SUM(SALARY )
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY)>9000000 
ORDER BY DEPT_CODE DESC;

----------------------------------------- GROUPBY & HAVING �ǽ����� ---------------------------------------

-- 1. EMPLOYEE ���̺��� �� �μ��� ���� ���� �޿�, ���� ���� �޿��� ��ȸ�Ͽ�
-- �μ� �ڵ� ������������ �����ϼ���.
SELECT DEPT_CODE AS "�μ� �ڵ�", MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- 2. EMPLOYEE ���̺��� �� ���޺� ���ʽ��� �޴� ����� ���� ��ȸ�Ͽ�
-- �����ڵ� ������������ �����ϼ���
SELECT JOB_CODE AS "���� �ڵ�", COUNT(BONUS) AS "���޺� ���ʽ� �ο�"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 3. EMPLOYEE ���̺��� 
-- �μ��� 70������ �޿� ����� 300�� �̻��� �μ��� ��ȸ�Ͽ�
-- �μ� �ڵ� ������������ �����ϼ���
SELECT DEPT_CODE AS "�μ� �ڵ�", 
            ROUND(AVG (SALARY)) AS "�޿� ���"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 1, 1)=7 
GROUP BY DEPT_CODE
HAVING ROUND(AVG (SALARY)) >= 3000000
ORDER BY DEPT_CODE;

----------------------------------------------------------------------------------------------------------------------

-- ���� �Լ� (ROLLUP & CUBE)
-- �׷캰 ������ ��� ���� ���踦 ����ϴ� �Լ�
-- * ������ GROUPBY�������� �ۼ� ����

-- ROLLUP �Լ�
-- �׷캰 �߰� ���� ó�� �� ��ü ���� ó���� �ϴ� �Լ�
-- * ���ڷ� ���޹��� �׷� �� ���� ���� ������ �׷캰 �հ��
-- �� �հ踦 ���ϴ� �Լ�

-- EMPLOYEE ���̺���
-- �� ���޺� �޿� �հ�� ��ü ������ �޿� �հ� ��ȸ

-- 1) �� ���޺� �޿� �հ�
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 2) ��ü ������ �޿� �հ�
SELECT SUM(SALARY) 
FROM EMPLOYEE;

-- 3) �� ���޺� �޿��� ��ü ������ �޿� �հ� (�� 1)�� 2)�� �� RESULT SET�� ��Ÿ����)
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY JOB_CODE;

-- EMPLOYEE ���̺���
-- �� �μ��� �Ҽӵ� ���޺� �޿� ��, 
-- �μ��� �޿� ��,
-- ��ü ���� �޿� ���� ��ȸ
-- �μ��ڵ� �������� ����

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP (DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

----------------------------------------------------------------------------------------------------------------------

-- CUBE �Լ�: �׷캰 ���� ����� ��� �����ϴ� �Լ�
-- * �׷����� ������ ��� �׷쿡 ���� ����� �� �հ踦 ���ϴ� �Լ�

-- EMPLOYEE ���̺���
-- �� �μ��� ������ �޿� ��,
-- �μ��� �޿� ��,
-- ���޺� �޿� ��,
-- ��ü ������ �޿� �� ��ȸ

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE (DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

----------------------------------------------------------------------------------------------------------------------

-- GROUPING : �����Լ��� ���� ���⹰��
-- ���ڷ� ���޹��� �÷� ������ ���⹰�̸� 0
-- �ƴϸ� 1�� ��ȯ�ϴ� �Լ�

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
    CASE WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE)=1 THEN '�μ�'
            WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE)=0 THEN '����'
            WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE)=1 THEN '����'
            ELSE '�μ�+����'
    END AS "����"
FROM EMPLOYEE
GROUP BY CUBE (DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;
            
----------------------------------------------------------------------------------------------------------------------

-- SET OPERATION (���� ������)

-- ���� ���� SELECT �����(RESULT SET)�� �ϳ��� ����� ����� ������
-- (SELECT �������� �ϳ��� SELECT ������ ����)
-- �ϳ��� SELECT ����� �������� ������ ���� SQL ������ ���� ���� �� ���
--> �ʺ��ڿ��� ����

-- ����: ���� ���꿡 ���Ǵ� SELECT���� SELECT���� �����ؾ� ��


-- 1. UNION (������)
-- ���� ���� SELECT ����� �ϳ��� ��ġ�� ������
-- ��, �ߺ��� ���ŵǾ� �� ���� �ۼ���.

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D5'�̰ų� �޿��� 300�� �̻��� �����
-- ���, �̸�, �μ��ڵ�, �޿� ��ȸ

-- 1)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 

UNION

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;

--2)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY >=3000000;

-- 1)�� 2)�� ��� ����
-- �� UNION ������ WHERE���� OR ������ �� �Ͱ� ����. (�̷��� �ʺ��ڿ��� ���ٰ�..)


-- 2. INTERSECT (������)
-- ���� SELECT�� ��� �� ���� �κи� ��ȯ�ϴ� ������

-- 1) 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 

INTERSECT

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY >=3000000;

-- 1)�� 2)�� ��� ����
-- �� INTERSECT ������ WHERE���� AND ������ �� �Ͱ� ����. (���� �̷��� �ʺ��ڿ��� ���ٰ�..)


-- 3. UNION ALL 
-- ���� SELECT ����� �ϳ��� ��ġ�� ������
-- UNION�� �޸� �ߺ� ���Ÿ� ���� ����
-- UNION + INTERSECT�� ����� ��ȯ

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 

UNION ALL

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;


-- 4. MINUS (������)
-- ���� SELECT ������� ���� SELECT ����� 
-- �ߺ��Ǵ� ���� �����ϴ� ������

-- EMPLOYEE ���̺��� 
-- �μ��ڵ尡 'D5'�� ���� �� �޿��� 300�� �ʰ��� ���� �����Ͽ� ��ȸ

-- 1)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'

MINUS

SELECT  EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 2)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND SALARY <= 3000000;

-- 1)�� 2)�� ���� ����� ����.


-- 5. GROUPING SETS

-- �׷캰�� ó���� �������� SELECT���� �ϳ��� ��ĥ �� ���
-- SET OPERATION ����� ����� �����ϴ�.

SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE, MANAGER_ID;

SELECT DEPT_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE, MANAGER_ID;

SELECT JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY JOB_CODE, MANAGER_ID;

SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY GROUPING SETS(
       (DEPT_CODE, JOB_CODE, MANAGER_ID),
       (DEPT_CODE, MANAGER_ID),
       (JOB_CODE, MANAGER_ID));
