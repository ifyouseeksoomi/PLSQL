/*
* JOIN (��ġ��, ���̴�)
-- �ϳ� �̻��� ���̺��� ���ļ� �����͸� ��ȸ�ϱ� ���� ���
-- ���� ����� �ϳ��� RESULT SET(��ȸ ����� ����)���� ����

-- <������ ������ ���̽� (RDBMS)���� SQL�� �̿��� ���̺� ���踦 �δ� ���>
   ������ ���̺��� ���踦 ����� ���� �ƴ� 
   ""���̺� ������� �ξ��� �����͸� ����""�ؾ� ���踦 �δ´�. 
   (= � Ư�� �� �÷��� ���� ���� �������Ѵ�)
   
   --> JOIN�� ���� ���� ����
   --> ���� ���� ��, �� ���̺��� ���� ���� �÷����� ���� �÷��� ������� �����.
*/

---------------------------------------------------------------------------------------------------------------------------

/* [JOIN ��� ����]
JOIN �ۼ� �� �� ��� ��, �ƹ� ����̳� ��� �����ѵ� 
ANSI�� �� ���� ���           

           ����Ŭ                                          SQL: 1999 ǥ�� (ANSI)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -         
         � ����                                       ���� ����(INNER JOIN)
                                                              JOIN ON / JOIN USING
                                                          + �ڿ� ����(NATURAL JOIN)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
         ���� ����                                  ���� �ܺ� ����(LEFT OUTER JOIN)
                                                     ������ �ܺ� ����(RIGHT OUTER JOIN)
                                                     + ��ü �ܺ� ���� (FULL OUTER JOIN)
                                                        --> ����Ŭ ������δ� ��� ����
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
         ��ü ����(SELF JOIN)                                JOIN ON
         �� ����
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
         īƼ�� ��                                        ���� ����(CROSS JOIN)
         (CARTESIAN PRODUCT)
*/

---------------------------------------------------------------------------------------------------------------------------

-- ������ ���� �ٸ� ���̺��� �����͸� ��ȸ�� ���
-- SELECT ������ ���� �ۼ��ؾ� ����.

-- EMPLOYEE ���̺�� DEPARTMENT ���̺��� �����Ͽ�
-- ���, �̸�, �μ��ڵ�, �μ��� ��ȸ

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

---------------------------------------------------------------------------------------------------------------------------

-- 1. ���� ���� (INNER JOIN) (== ����Ŭ�� � ����(EQUAL JOIN))
--> ����Ǵ� �÷��� ���� ��ġ�ϴ� ��鸸 ����
-- (== ��ġ�ϴ� ���� ���� ��(EX. NULL�̾ �����Ұ� ���� ��)�� ���ο��� ���ܵ�) 

-- 1) ���ῡ ���Ǵ� �÷����� �ٸ� ���

-- ANSI ���
-- ���ῡ ����� �÷����� �ٸ� ���, JOIN ___ ON ������ �����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- ����Ŭ ��� (Ư¡: JOIN X, WHERE�� O)
SELECT EMP_IN, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
-- ����Ŭ ����� JOIN ������ ������� �ʰ� WHERE���� �̿��� JOIN�� ������
-- EQUAL ǥ���Ͽ� '�' �������� ǥ��

-- DEPARTMENT ���̺�, LOCATION ���̺��� �����Ͽ�
-- �μ���, ������ ��ȸ

-- ANSI ���
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE);

-- ����Ŭ ���
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID= LOCAL_CODE;


-- 2) ���ῡ ����� �� �÷����� ���� ���
-- EMPLOYEE ���̺�, JOB ���̺��� �����Ͽ�
-- ���, �̸�, �����ڵ�, ���޸� ��ȸ

-- ANSI ���
-- ���ῡ ����� �÷����� ���� ���, JOIN ___ USING ���� ���
-- CF. �޶��� ���� JOIN ON �̾���.
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- ����Ŭ ���
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
-- ����Ŭ ������� ���� �÷��� JOIN ��, ���̺���� �ۼ��Ͽ� �������־�� ��.

-- ����Ŭ �� ��Ī ��� ���(ª����) -- ȿ�� GOOD
-- ���̺��� ��Ī ��� ����
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;
-- JOB_CODE �÷��� JOB ���̺�� EMPLOYEE ���̺��� ��ġ�� ������ �տ� E�� J�� �������� ��


---------------------------------------------------------------------------------------------------------------------------

-- 2. �ܺ� ����(OUTER JOIN)
-- INNER JOIN�� �ݴ�Ǵ� Ư¡�� ����.
-- �� ���̺��� �����ϴ� �÷� ���� ��ġ���� �ʴ� �൵ ���ο� ����.
-- �� OUTER JOIN�� �ݵ�� SQL���� ����ؾ� �� // �׳� JOIN�� ���� INNER JOIN���� �ν��ϹǷ�

-- �����, �μ��� ��ȸ
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- 1) LEFT [OUTER] JOIN
-- JOIN�� ����� �� ���̺� �� 
-- ���� ����� ���̺� �÷� ���� �������� JOIN ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- 23�� ��� (INNER: 21��)

-- ����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);
-- ����Ŭ ��� LEFT JOIN �� (+) ��ȣ��
-- ������ ���̺��� �÷��� �ۼ�

-- 2) RIGHT [OUTER] JOIN
-- JOIN�� ���� �� ���̺� ��, ������ ����� ���̺��� �÷����� �������� JOIN
-- ANSI ���
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 24�� (�̿���, �ϵ��� ���� + NULL�� �� �� ����)

-- ����Ŭ ���
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [OUTER] JOIN
-- JOIN�� ���� �� ���̺��� ���� ��� ���� ����� ���Խ�Ų��
-- ANSI ���
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- �̿���, �ϵ��� �� �߰�, NULL�� �� �� �߰� (��� ����� �� �� ����)

---------------------------------------------------------------------------------------------------------------------------

-- 3. ���� JOIN (CROSS JOIN) (CARTESIAN PRODUCT)

-- JOIN�� ���Ǵ� ���̺��� �� ����� 
-- ��� ���ε� �����Ͱ� �˻��Ǵ� ��� (�������� ����)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

---------------------------------------------------------------------------------------------------------------------------

-- 4. �� JOIN (NON EQUAL JOIN)
-- '=' (E��ȣ)�� ������� �ʴ� JOIN������
-- ������ �÷� ���� ��ġ�ϴ� ���� JOIN �� �������� �ʰ�
-- ������ �÷� ���� Ư�� ���� ���� ���ԵǴ� ���̸�
-- �ش� ���� ����(JOIN)�ϴ� ���

-- EMPLOYEE ���̺�� SAL_GRADE ���̺��� �����Ͽ�
-- ��� �� �ڽ��� SAL_LEVEL�� �´� �޿��� �ް� �ִ� ����� 
-- �̸�, �޿�, SAL_LEVEL ��ȸ

SELECT  EMP_NAME, SALARY, E.SAL_LEVEL
FROM EMPLOYEE E
JOIN SAL_GRADE S ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);


---------------------------------------------------------------------------------------------------------------------------

-- 5. ��ü ����(SELF JOIN)
-- ���� ���̺��� JOIN�� ����
--> �ڱ� �ڽŰ� JOIN

-- EMPLOYEE ���̺��� �����Ͽ�
-- ���, �̸�, �μ��ڵ�, ���ӻ�� ���, ���ӻ�� �̸� ��ȸ

-- ANSI ���
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, E.MANAGER_ID, 
           M.EMP_NAME "���� ��� �̸�"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);

-- ����Ŭ ���
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, E.MANAGER_ID, 
           M.EMP_NAME "���� ��� �̸�"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+);

---------------------------------------------------------------------------------------------------------------------------

-- 6. �ڿ� ����(NATURAL JOIN)
-- ������ Ÿ�԰� �÷����� ���� ���̺��� JOIN ��
-- JOIN USING�� ������� �ʰ� ������ JOIN���� �ۼ��ϴ� ���
--> ���� �÷����� ���µ� �ڿ� ���� �� ���� ������ �����
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

---------------------------------------------------------------------------------------------------------------------------

-- 7. ���� ����
-- N���� ���̺��� JOIN�Ͽ� ��ȸ�� �� ���
-- �ڡڡڡڡ� JOIN ������ �ſ� �߿���!

-- EMPLOYEE, DEPARTMENT, LOCATION ���̺��� �����Ͽ�
-- ���, �̸�, �μ���, ������ ��ȸ

-- ���� ������ ��Ű�� ���� ���, ���� �߻�
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_MENU
FROM EMPLOYEE
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID);
-- EMPLOYEE�� LOCATION JOIN ��
-- EMPLOYEE ���̺� LOCATION_ID��� �÷��� �������� ����.

-- ANSI ���
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- ����Ŭ ���
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID (+)
AND LOCATION_ID = LOCAL_CODE(+);
-- ����Ŭ ��� ���� ������ AND�� �̿���

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME = 'ASIA1';

-- ������ '�븮'�̸鼭 
-- �ƽþ� ������ �ٹ��ϴ� ������
-- ���, �̸�, ���޸�, �μ���, ������, �޿� ��ȸ

-- ANSI ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE) -- EMPLOYEE�� JOB�̶� ���� �÷� �����ϹǷ�
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID) -- DEPARTMENT�� EMPLOYEE���� �÷����� �ٸ�
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)  -- ���� LOCATION�� EMPLOYEE���� �÷����� �ٸ�
WHERE JOB_NAME= '�븮'
AND LOCAL_NAME LIKE 'ASIA%';

-- ����Ŭ ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
FROM EMPLOYEE E, JOB J, DEPARTMENT, LOCATION
WHERE E.JOB_CODE = J.JOB_CODE
AND DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE -- ������� JOIN
-- ������� ��ȸ ����
AND JOB_NAME = '�븮'
AND LOCAL_NAME LIKE 'ASIA%';

----------------------------------------------------�� �� �� �� ------------------------------------------------------------

-- Q1.
-- �ֹι�ȣ�� 70��� ���̸鼭 ������ �����̰�, ���� ���������� ��������
-- �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�

-- ANSI ���
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
JOIN JOB USING (JOB_CODE)
WHERE SUBSTR(EMP_NO, 1, 1)='7' 
AND SUBSTR(EMP_NO, 8, 1)='2'
AND EMP_NAME LIKE '��%';

-- ORACLE ���
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE, DEPARTMENT, JOB
WHERE DEPT_CODE = DEPT_ID
AND EMPLOYEE.JOB_CODE = JOB.JOB_CODE
AND SUBSTR(EMP_NO, 1, 1)='7' 
AND SUBSTR(EMP_NO, 8, 1)='2'
AND EMP_NAME LIKE '��%';


-- Q2.
-- �̸��� '��'�ڰ� ���� �������� ���, �����, ���޸��� ��ȸ�Ͻÿ�

-- ANSI ���
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE  
JOIN JOB USING (JOB_CODE)
WHERE EMP_NAME LIKE '%��%';


-- Q3.
-- �ؿܿ��� 1��, 2�ο� �ٹ��ϴ� �����
-- �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�

-- ANSI ���
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE) -- �÷����� ���Ƽ� 
JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE) -- �÷����� �޶�
WHERE DEPT_TITLE IN ('�ؿܿ���1��', '�ؿܿ���2��');


-- Q4.
-- ���ʽ�����Ʈ�� �޴� �������� �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.

SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) -- �÷����� �޶�
JOIN LOCATION ON(LOCATION_ID= LOCAL_CODE)
WHERE BONUS IS NOT NULL;


-- Q5. 
-- �μ��� �ִ� ����� �����, ���޸�, �μ���, ������ ��ȸ

SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);  
-- �� ���Ŀ� DEPT_CODE IS NOT NULL ���� �Ƚᵵ �Ǵ°�, ���� INNER JOIN�̱� ������ 
-- NULL�� ���ܰ� �˾Ƽ� �ȴ�. (������ ���̸� ���̴� ���� ����)


-- Q6.
-- �޿���޺� �ּұ޿�(MIN_SAL)���� ���� �޴� ��������
-- �����, ���޸�, �޿�, ����(���ʽ�����)�� ��ȸ�Ͻÿ�.
-- ������ ���ʽ�����Ʈ�� �����Ͻÿ�

SELECT EMP_NAME, JOB_NAME, SALARY, SALARY*(1+NVL(BONUS,0))*12 AS ����
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN SAL_GRADE USING(SAL_LEVEL)
WHERE SALARY > MIN_SAL;


-- Q7. 
-- �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� ��������
-- �����, �μ���, ������, �������� ��ȸ�Ͻÿ�.

SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('�ѱ�', '�Ϻ�');


-- �ڡڡڡ� Q8. 
-- ���� �μ��� �ٹ��ϴ� �������� �����, �μ��ڵ�, �����̸��� ��ȸ�Ͻÿ�.
-- SELF JOIN ���
-- // SELF JOIN ����ϰڴ� : EMPLOYEE �� �� ���ڴٴ� ���� --> �ϳ��� EMPLOYEE E, �ϳ��� EMPLOYEE M ��Ī �ο��ؼ�

SELECT E.EMP_NAME, E.DEPT_CODE, M.EMP_NAME
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.DEPT_CODE = M.DEPT_CODE) -- ON�� �ٸ� �� ���� ��. E,M���� ������� �ٸ� ������ ������
WHERE E.EMP_NAME != M.EMP_NAME
ORDER BY 1;


-- Q9.
-- ���ʽ�����Ʈ�� ���� ������ �߿��� �����ڵ尡 J4 �� J7 �� �������� 
-- �����, ���޸�, �޿��� ��ȸ�Ͻÿ�.
-- ��, JOIN, IN ����� ��

SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE BONUS IS NULL
AND JOB_CODE IN ('J4', 'J7');







