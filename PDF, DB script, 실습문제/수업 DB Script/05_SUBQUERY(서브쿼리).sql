/*
  SELECT�� �ؼ� ����
  
  5 : SELECT �÷��� AS ��Ī, ����, �Լ���
  1 : FROM ������ ���̺�� 
     + JOIN
  2 : WHERE �÷��� | �Լ��� �񱳿����� �񱳰�
  3 : GROUP BY �׷��� ���� �÷���
  4 : HAVING �׷��Լ��� �񱳿����� �񱳰�
  6 : ORDER BY �÷��� | ��Ī | �÷����� ���Ĺ�� [NULLS FIRST | LAST];
*/

----------------------------------------------------------------------------------------------------------------------------------

-- SUBQUERY(��������)
/*
- �ϳ��� SQL�� �ȿ� ���Ե� �Ǵٸ� SQL��.         // �ϳ��� sql ���ȿ� ���Ե� �Ǵٸ� select��
- ���� ����(���� ����)�� ���� ���� ������ �ϴ� ������.
*/
         
         
-- �������� ���� 1
-- �μ��ڵ尡 ���ö����� ���� �Ҽ��� ������ 
-- �̸�, �μ��ڵ� ��ȸ�ϱ�

-- 1) ������� ���ö�� ����� �μ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';
    
-- 2) �μ��ڵ尡 D9�� ������ ��ȸ
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 3) �μ��ڵ尡 ���ö����� ���� �Ҽ��� ������ 
-- �̸�, �μ��ڵ� ��ȸ�ϱ�
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                                 FROM EMPLOYEE
                                 WHERE EMP_NAME = '���ö');


-- �������� ���� 2                   
-- �� ������ ��� �޿����� ���� �޿��� �ް� �ִ� ������ 
-- ���, �̸�, �����ڵ� ,�޿� ��ȸ

-- 1) �� ������ ��� �޿� ��ȸ 
SELECT AVG(SALARY) 
FROM EMPLOYEE;

-- 2) �� �������� �޿��� 3047663�� �̻��� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY>='3047663';

-- 3) �� ������ ��� �޿����� ���� �޿��� �ް� �ִ� ������ 
-- ���, �̸�, �����ڵ� ,�޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY>=(SELECT AVG(SALARY) 
                            FROM EMPLOYEE);

----------------------------------------------------------------------------------------------------------------------------------

/*  ���������� ����
     
     - ������ �������� : ���������� ��ȸ ��� ��(��)�� ������ 1���� ��
     // ��Ʈ�� ���� ���� �� �׳� �� �ϳ��� ���� ������ ��
     // �׷��Լ��� ��µ�, �׷� ���̰� ����? --> ������ ��������
     
     - ������ �������� : ���������� ��ȸ ��� ��(��)�� ������ �������� ��
     
     - ���߿� �������� :
     
     - ������, ���߿� �������� : 
    
     - ��� �������� : 
    
     - ��Į�� �������� : 
    
     * ���������� ������ ���� 
    
*/
----------------------------------------------------------------------------------------------------------------------------------

-- 1. ������ �������� (SINGLE ROW SUBQUERY)

/*
- ���������� ��ȸ ��� ��(��)�� ������ 1���� �������� 
- ������ �������� �տ� ���Ǵ� �����ڴ� <�� ������>
- IN, BETWEEN, DECODE �̷��� ������(������ �������� �ƴ�)
- =, !=, <, >, <=, >= �̷��͵��̳� �� �� �ִٴ� ���̴�.
*/

-- ���� 1-1
-- �� ������ �޿� ��� // ���� ���� �޿��� �޴� ������ 
-- �̸�, ����, �μ�, �޿��� ���� ������ �����Ͽ� ��ȸ
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE)
ORDER BY JOB_CODE;


-- ���� 1-2                    
-- ���� ���� �޿��� �޴� ������
-- ���, �̸�, ����, �μ�, �޿�, �Ի����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

-- ���� 1-3
-- ���ö ����� �޿� // ���� ���� �޴� ������
-- ���, �̸�, �μ�, ����, �޿��� ��ȸ                 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME ='���ö');


-- ** ���������� WHERE���Ӹ� �ƴ϶� 
-- SELECT��, HAVING��, FROM�������� ��� ������ **


-- ���� 1-4
-- �μ���(�μ��� ���� ��� ����) �޿��� �հ� �� ���� ū �μ���
-- �μ���, �޿� �հ踦 ��ȸ 

-- 1) �μ��� �޿� �� �� ���� ū�� ��ȸ
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) �μ��� �޿����� 17700000�� �μ��� �μ���� �޿� �� ��ȸ
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID) 
GROUP BY DEPT_TITLE
HAVING SUM(SALARY)=17700000;

-- 3) �μ���(�μ��� ���� ��� ����) �޿��� �հ� �� ���� ū �μ���
-- �μ���, �޿� �հ踦 ��ȸ 
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID) 
GROUP BY DEPT_TITLE
HAVING SUM(SALARY)=(SELECT MAX(SUM(SALARY))
                                    FROM EMPLOYEE
                                    GROUP BY DEPT_CODE);

------------------------------------------�ǽ�����--------------------------------------------------------------

-- 1. ������ ����� �����ִ� �μ������� ��ȸ�Ͻÿ� (��, �������� ����)
-- ���, �����, ��ȭ��ȣ, �����, �μ���

SELECT DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE EMP_NAME = '������';

SELECT EMP_NO, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = (SELECT DEPT_TITLE
                                FROM EMPLOYEE
                                JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                                WHERE EMP_NAME = '������');

-- ���� ���� �Ѱ� �Ʒ��� ����  

SELECT EMP_NO, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                                 FROM EMPLOYEE 
                                 WHERE EMP_NAME ='������')
AND EMP_NAME != '������';
                            

-- 2. ������� 2000�⵵ �̻��� ����� �� �޿��� ���� ���� ����� 
-- ���, �����, ��ȭ��ȣ, �޿�, ���޸��� ��ȸ�Ͻÿ�.

SELECT EMP_ID, EMP_NAME, PHONE, SALARY, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE TO_CHAR (EXTRACT (YEAR FROM HIRE_DATE))>='2000'
AND (SELECT MAX(SALARY) FROM EMPLOYEE);

---- ������ ���� �� �� �Ʒ��� ����

SELECT MAX(SALARY)
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE)>=2000;
-- 2000 ���� �Ի��� �� ���� ���� �޴� ���� ��ȸ ������

SELECT EMP_ID, EMP_NAME, PHONE, SALARY, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SALARY = (SELECT MAX(SALARY)
                            FROM EMPLOYEE
                            WHERE EXTRACT(YEAR FROM HIRE_DATE)>=2000);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 200508 ��

-- 2. ������ ��������(MULTI ROW SUBQUERY)
-- ���������� ��ȸ ��� ��(��)�� ������ ���� ���� SELECT��

/* ������ �������� �տ��� �Ϲ� �� �����ڸ� ����� �� ����.

 - IN / NOT IN : �������� ����� �� �ϳ��� ��ġ�ϴ� ���� �ִٸ�/���ٸ� �̶�� �ǹ�
 - > ANY, < ANY : ���� ���� ����� �� 
                        - �ϳ��� ������� ���� ���� ������ ũ�ų� ���� ���
                        - (�������� ��� ��) ���� ���� ������ ũ��? / �۳�?

 - > ALL, < ALL : ���� ���� ����� �� ��� ������ ũ�ų� ���� ��� 
                    - (�������� ��� ��) ���� ū ������ ũ��? / �۳�?
  
 - EXISTS / NOT EXISTS : �������� ������� ���� �����ϳ�? �ƴϳ�?
 
*/

-- ���� 2-1
-- �μ��� �ְ� �޿��� �޴� ������ 
-- �̸�, ����, �μ�, �޿��� �μ� ������ �����Ͽ� ��ȸ

-- STEP1 �μ��� �ְ� �޿� ��ȸ
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- STEP2 STEP1���� �̹� ��ȸ�� �ڷḦ WHERE���� �־� ���� �ϼ�
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)
                            FROM EMPLOYEE
                            GROUP BY DEPT_CODE)
ORDER BY 3;

-- ���� 2-2
-- ����� �ش��ϴ� ������ ���� ��ȸ �� 
-- ���, �̸�, �μ���, ���޸�, ����(��� / ����)

-- 1) ����� �ش��ϴ� ��� ��ȣ ��ȸ
SELECT DISTINCT MANAGER_ID -- �ߺ� ��� ���ſ� DISTINCT (�� ����� ���� �Ĺ� ���� ����)
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL; -- NULL ���ſ� (����� ���� �� ���� ����� ���ſ�)

-- 2) ������ ���, �̸�, �μ���, ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- �� LEFT�߳ĸ� ��� ��� ��� ��ȸ�Ϸ��� (LEFT�� �� �� NULL �ڵ� ���� �Ǿ� 23���� �ƴ϶� 21��ۿ� �� ��)

-- 3) ����� �ش��ϴ� ������ ���� ���� ���� ��ȸ(�� ��, ������ '���'��)  -> 6��
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '���' AS "����"
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) -- ��������� 2)�� �Ȱ���
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID 
                            FROM EMPLOYEE 
                            WHERE MANAGER_ID IS NOT NULL); -- �� ���� ���� �ؼ�: "����� ��� ����� �ش��ϴ�"
-- WHERE���� IN �ڿ��� 1)���� ��� ���� ���� ���� �־���

-- 4) �Ϲ� ������ �ش��ϴ�(����� �ƴ�) ����� ���� ��ȸ (�̶�, ������ '���'����) : ���и� ��ġ�� IN�� NOT IN���� �ٲ� -> 17��
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '���' ����
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) 
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID 
                                    FROM EMPLOYEE 
                                    WHERE MANAGER_ID IS NOT NULL);   -- �̰Ŵ� �� 3)�� �ݴ���  
                        
-- 5) 3, 4�� ��ȸ ����� �ϳ��� ��ħ -> UNION : ����� ��� �Բ� ��ȸ�ϴ� 23���� ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '���' ����
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) 
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID FROM EMPLOYEE WHERE MANAGER_ID IS NOT NULL)

UNION

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '���' ����
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) 
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID FROM EMPLOYEE WHERE MANAGER_ID IS NOT NULL);     

-- ������ �� ������ �ʹ� ��ٴ� ���̴� (ª�� �� �� ����)
-- WHERE�� �ƴ϶� SELECT�����ٰ� SUBQUERY �ۼ�

-- 6) �� 3, 4�� ��ȸ ����� �ϳ��� ��ħ -> SUBQUERY�� (����� ~, ����̸� ~������ �ۼ��ؾ��ϹǷ� CASE�� �ʿ�)
SELECT EMP_ID, EMP_N��AME, DEPT_TITLE, JOB_NAME,                           -- �������� , ��� �� ���� �ʱ� ����
            CASE WHEN EMP_ID IN (SELECT DISTINCT MANAGER_ID
                                                FROM EMPLOYEE
                                                WHERE MANAGER_ID IS NOT NULL) -- ����� ����̸�
                    THEN '���'                                                               -- ������ �θ��ڴ�
                    ELSE '���'                                                                 -- �ƴϸ� ����̶�� �ϰڴ�
            END AS ����                    
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- �� LEFT�߳ĸ� ��� ��� ��� ��ȸ�Ϸ���



-- ���� 2-3
-- �븮 ������ ������ �߿��� ���� ������ �ּ� �޿����� ���� �޴� ������
-- ���, �̸�, ����, �޿��� ��ȸ�ϼ���
-- ��, > ANY Ȥ�� < ANY �����ڸ� ����ϼ���

-- 1) ������ �븮�� �������� ���, �̸�, ���޸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮';

-- 2) ������ ������ ������ �޿� ��ȸ
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '����';

-- 3) �븮 ������ ������ �߿��� ���� ������ �ּ� �޿����� ���� �޴� ����
-- MIN�� �̿��Ͽ� ������ ���������� ����� ��� (2�� ������ �������, SALARY�κ��� MIN���� �����Ͽ� ���������� ����)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > (SELECT MIN(SALARY)
                        FROM EMPLOYEE
                        JOIN JOB USING (JOB_CODE)   
                        WHERE JOB_NAME = '����');

--> ANY�� �̿��Ͽ� ������ ���������� ����� ��� (3�� ���� �״�� �����ͼ� 333�࿡�� MIN�� ���� ANY �߰�)
-- ANY �� ���� �ؼ�: �븮�� SALARY�� �� ��(334��) ����� �� � ���������ٵ�(���� ���� �����ٵ�) �� ũ��
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > ANY (SELECT SALARY
                        FROM EMPLOYEE
                        JOIN JOB USING (JOB_CODE)   
                        WHERE JOB_NAME = '����');

-- ���� 2-4
-- ���� ���� �޿��� ���� ū ������ ���� �޴� ���� ������ ����
-- ���, �̸�, ����, �޿��� ��ȸ�ϼ���
-- ��, > ALL Ȥ�� < ALL �����ڸ� ����ϼ���
-- ALL ���� �ؼ�: ������� ��� ������ �� ������ �� �� �ȿ� �ִ밪�� ���Եǰ� �Ǿ�����. �� �ִ밪���� �� ���� �޴� �� ã�� ����

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '����' 
AND SALARY > ALL (SELECT SALARY             
                              FROM EMPLOYEE
                              JOIN JOB USING(JOB_CODE)
                              WHERE JOB_NAME='����');
                              
-- ** �������� ��ø ���[����]

-- NATIONAL_CODE�� KO�� �μ����� �ٹ��ϰ� �ִ� ������ 
-- ��� ���� ��ȸ

-- 1) LOCATION ���̺��� ���� 
-- NATIONAL_CODE�� KO�� LOCAL_CODE ���� ���ϱ�
SELECT LOCAL_CODE 
FROM LOCATION
WHERE NATIONAL_CODE = 'KO';

-- 2) DEPARTMENT ���̺���
-- LOCATION_ID�� 'L1'�� �μ�(�װ� �ѱ���)�� DEPT_ID ��ȸ
SELECT DEPT_ID
FROM DEPARTMENT
WHERE LOCATION_ID='L1'; -- �ε� �׷��� L1 ���� ���� �� �ڸ��� 1)�� ���� �Ʒ�ó��

SELECT DEPT_ID
FROM DEPARTMENT
WHERE LOCATION_ID= (SELECT LOCAL_CODE 
                                    FROM LOCATION
                                    WHERE NATIONAL_CODE = 'KO');

-- 3) NATIONAL_CODE�� KO�� �μ����� �ٹ��ϰ� �ִ� ������ 
-- ��� ���� ��ȸ                     
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_ID                              -- WHY DEPT_CODE?
            FROM DEPARTMENT
            WHERE LOCATION_ID= (SELECT LOCAL_CODE 
                                               FROM LOCATION
                                               WHERE NATIONAL_CODE = 'KO'));

                              
----------------------------------------------------------------------------------------------------------------------------------

-- 3.  ���߿� ��������
-- �������� SELECT���� ������ �÷� ���� 

-- ���� 3-1
-- ����� �������� ���� �μ�, ���� ���޿� �ش��ϴ�
-- ����� �̸�, ����, �μ�, �Ի����� ��ȸ        

-- 1) ����� ������ ��ȸ
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'Y'
AND SUBSTR(EMP_NO, 8, 1) ='2';

-- 2) ����� �������� ���� �μ�,  // ���� ���� (���Ͽ� ǥ�� �� -> �ϳ��� �÷��� ��)
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE

-- ���� �μ� ( 1)���� �����ͼ� SELECT�� DEPT_CODE�� ����)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                                    FROM EMPLOYEE
                                    WHERE ENT_YN = 'Y'
                                    AND SUBSTR(EMP_NO, 8, 1) ='2' )
-- ���� ���� ( 1)���� �����ͼ� SELECT�� JOB_CODE�� ����)
AND JOB_CODE = (SELECT JOB_CODE
                            FROM EMPLOYEE
                            WHERE ENT_YN = 'Y'
                            AND SUBSTR(EMP_NO, 8, 1) ='2');
             
-- BUT �� �ʹ� ��� 
-- �Ʒ�ó�� ""���߿�""�� ���� ª������

-- 3) ����� �������� ���� �μ�, ���� ���� (���߿� ����������)
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE               -- WHERE�� ���߿� ������ ���߾� �� ��
                                                    FROM EMPLOYEE
                                                    WHERE ENT_YN = 'Y'
                                                    AND SUBSTR(EMP_NO, 8, 1) ='2');
    
             
----------------------------------------------------------------------------------------------------------------------------------        
           
-- 4. ������ ���߿� ��������
-- �������� ��ȸ ��� ��� ���� ���� ���� ���� ��

-- ���� 4-1
-- ���� ������ ��� �޿� // �� �ް� �ִ� ������
-- ���, �̸�, ����, �޿��� ��ȸ�ϼ���
-- ��, �޿��� �޿� ����� ���������� ����ϼ��� TRUNC(�÷���, -4)      

-- CF) �޿��� 200��, 600�� �޴� ������ ���, �̸�, ����, �޿� ��ȸ (200��, 600���� ��ձ޿��� ������ ���)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN ('2000000',  '6000000');

-- 1) ���޺� ��� �޿�
SELECT JOB_CODE, TRUNC(AVG(SALARY), -4)     -- ���� ���� ������ �����Ϸ���
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 2) ���� ������ ��� �޿��� �ް� �ִ� ������ ���, �̸�, ����, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, TRUNC(AVG(SALARY), -4)     
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);         -- 2)�� ������ WHERE���� ���� BUT! �� �� 
                                                                      -- WHERE SALARY�� �ϸ� ���� �ȸ¾Ƽ� �˸°� JOB_CODE �ϳ� �� �տ� ����
                                                                      -- �׸��� �׷��� WHERE �ڿ� �ΰ� ���� �Ÿ� ��ȣ�� ��������Ѵ�
                                                                      
---------------------------------------------------------------------------------------------------------------------------------- 

-- 5. ��[ȣ��]�� �������� (��� ����)      // �� SELF JOIN�̶� ���
-- ��������� ���������� ����ϴ� ���̺� ����
-- ���������� �̿��ؼ� ����� ����.

-- ���������� ���̺� ���� ����Ǹ� ���������� ����� ����

-- ��� ������ ���� ���� ������ �� ���� ��ȸ�ϰ� 
-- �ش� ���� ���������� ������ �����ϴ��� Ȯ���Ͽ�
-- ���� ���� ����� ��ȸ�� ���� ������ ����
-- �Ϲ����� ���������� �ؼ� ������ �ݴ�!
-- CF. �Ϲ����� ���������� �ؼ����� : ���갡 ���� �� ������ ����

-- ���� 5-1
-- ����� �ִ� ������ ���, �̸�, �μ���, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID
FROM EMPLOYEE E -- SELF JOIN�̶� ����ϰ� ���� ��Ī �ο�
WHERE EXISTS (SELECT EMP_ID
                       FROM EMPLOYEE M 
                       WHERE E.MANAGER_ID = M.EMP_ID); -- Ȯ���� �������� ���� �ؼ��� �� ���� ����

-- �� ��������� �ؼ��� ��
-- ���� ���� �� ���� ��ȸ�Ͽ�
-- EX. ���� ��쿡���� E.MANAGER_ID �÷� ����
-- M.EMP_ID�� �����ϴ��� Ȯ���Ͽ� (���� �ð��� ���� �ϳ��ϳ� �����ߴ� �� ����)
-- ���� ���, �ش� ���� �������� ��ȸ����� ���Խ�Ŵ.

-- ���� 5-2
-- ���޺� �޿� ��պ��� �޿��� ���� �޴� ������ 
-- �̸�, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE E
WHERE SALARY > (SELECT AVG(SALARY) 
                            FROM EMPLOYEE M
                            WHERE E.JOB_CODE = M.JOB_CODE);

---------------------------------------------------------------------------------------------------------------------------------- 

-- 6. ��Į�� ��������
-- ��Į��: SQL���� "���� ��"�� ������ ��Į�� ��� ��.
-- SELECT���� ���Ǵ� ����� 1�ุ ��ȯ�Ǵ� ��������

-- ���� 6-1
-- ��� ����� ���, �̸�, ������ ���, �����ڸ��� ��ȸ
-- �� �����ڰ� ���� ��� '����'���� ǥ�� (NVL�� ����)

SELECT EMP_ID, EMP_NAME, MANAGER_ID,
            NVL(
                   (SELECT EMP_NAME 
                    FROM EMPLOYEE M
                    WHERE E.MANAGER_ID = M.EMP_ID)      -- ������������ ���� ��������, ���� �����ϴ���
                    , '����') AS �����ڸ�
                    
            -- �� ������� ���赵 ���� 
            -- �������� ���� �� ����� �� ���� ���� --> ������ ��������
            -- ������ ���������� ����� ���ؼ� ����� �������� ��� --> �������
            -- ������ ���������̸鼭 SELECT���� ���� --> ��Į�� ��������
            
FROM EMPLOYEE E
ORDER BY EMP_ID;

-- �� �������� ���� ������ �޿� ��� ��ȸ
-- �̸�, ���� �ڵ�, ��� �޿�

SELECT EMP_NAME, JOB_CODE AS "����", 
            (SELECT FLOOR (AVG(SALARY))
            FROM EMPLOYEE M
            WHERE E.JOB_CODE = M.JOB_CODE) AS "�ش� ������ ��� �޿�"
FROM EMPLOYEE E
ORDER BY JOB_CODE;

-- ������ J1�� ������� ��� �޿�
SELECT AVG(SALARY)
FROM EMPLOYEE
WHERE JOB_CODE = 'J1';

-- ���޺� ��� �޿� ��ȸ(����������)
SELECT JOB_CODE, TRUNC(AVG(SALARY), -4)
            FROM EMPLOYEE
            GROUP BY JOB_CODE
            ORDER BY 1;
---------------------------------------------------------------------------------------------------------------------------------- 

-- 7. �ζ��� ��(INLINE-VIEW) VIEW�� �ǹ�: ���� ���̺�
-- FROM������ ���� ���������� ��� ����
--> FROM������ ���� ��������
--> LITERALLY "��ȸ�� �ϳ��� ǥ���� �� ��ȸ�ϰڴ�"

SELECT EMP_NAME
FROM (SELECT EMP_NAME, DEPT_TITLE
            FROM EMPLOYEE
            JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) ); 
            -- �� ERROR�ĸ� EMP_ID�� �����ߴµ�, FROM () ���� SELECT�� EMP_ID�� ����
            
-- ���� 7-1 : �ζ��κ並 Ȱ���� TOP-N�м�

-- �� ���� �� �޿��� ���� ���� 5����
-- ����, �̸�, �޿� ��ȸ
 SELECT EMP_NAME, SALARY
 FROM EMPLOYEE
 ORDER BY SALARY DESC;
 
-- * ROWNUM : ��ȸ�� ������� 1���� ���ʴ�� ��ȣ�� �ű� �� �ִ� �÷�
SELECT ROWNUM AS �޿�����, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC; 
-- �̻��Ұ� ���� �����ϴ´�� ������ ������

SELECT ROWNUM ����, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY
           FROM EMPLOYEE
           ORDER BY SALARY DESC)
WHERE ROWNUM<=5;
 
-- ���̰� ���� � ��� 3���� �̸�, �μ���, ���� ��ȸ
SELECT EMP_NAME AS �̸�, DEPT_TITLE AS �μ���, ����
FROM (SELECT EMP_NAME, DEPT_TITLE,
            EXTRACT(YEAR FROM SYSDATE)-
            EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) AS "����"
            FROM EMPLOYEE
            JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
            ORDER BY ����)
WHERE ROWNUM<=3;


-- ���� 7-2
-- �޿� ����� 3�� �ȿ� ��� �μ��� 
-- �μ��ڵ�� �μ���, ��ձ޿��� ��ȸ

-- 1) �μ��� ��� �޿� ��ȸ
SELECT DEPT_CODE �μ��ڵ�, DEPT_TITLE �μ���, FLOOR(AVG(SALARY)) ��ձ޿�
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
GROUP BY DEPT_TITLE, DEPT_CODE
ORDER BY 3;

-- 2) �޿� ��� ���� 3�� �μ� ��ȸ
SELECT * 
FROM (SELECT DEPT_CODE �μ��ڵ�, DEPT_TITLE �μ���, FLOOR(AVG(SALARY)) ��ձ޿�
            FROM EMPLOYEE
            JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
            GROUP BY DEPT_TITLE, DEPT_CODE
            ORDER BY 3 DESC)
WHERE ROWNUM <=3;

-- 3) ���� ���� �� �� ���� (�ٵ� �׷��� ���� 2)�� ������)
SELECT *
FROM (SELECT DEPT_CODE �μ��ڵ�, DEPT_TITLE �μ���, FLOOR(AVG(SALARY)) ��ձ޿�
            FROM EMPLOYEE
            JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
            GROUP BY DEPT_CODE, DEPT_TITLE
           ORDER BY AVG(SALARY) DESC)
WHERE ROWNUM<=3;

-- [�� ���̻����ؾߵǴ� ����� ����]
-- ���޺� �޿� ��հ� ���� ����, �޿��� ���� ���� ��ȸ
-- ��, �޿��� �޿� ����� ���������� ��� TRUNC(�÷���, -5)


---------------------------------------------------------------------------------------------------------------------------------- 


-- 8. WITH
-- ���������� ��Ī �ο� �� ��� �� �̸��� ȣ���Ͽ� ���
-- �ζ��κ�� ���� ���������� �ַ� ����.
-- ���� �ӵ��� �������ٴ� ����

-- ���� 8-1
-- �� ������ �޿� ���� 
-- ����, �̸�, �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE 
ORDER BY SALARY DESC;

WITH TOPN_SAL AS (SELECT EMP_NAME, SALARY
                                FROM EMPLOYEE 
                                ORDER BY SALARY DESC)

SELECT ROWNUM "����", EMP_NAME, SALARY
FROM (TOPN_SAL);
   
   
---------------------------------------------------------------------------------------------------------------------------------- 

-- 9. RANK() OVER / DENSE_RANK() OVER

--  RANK() OVER : ������ ���� ������ ����� ������ �ο�����ŭ �ǳ� �ٰ� ���� ���
                        -- EX. ���� ������ �� ���̸� ���� ������ 3������ ����

SELECT EMP_NAME, SALARY, 
            RANK () OVER (ORDER BY SALARY DESC) AS ����
FROM EMPLOYEE;
-- ���� 19�� ������ 21���� ��ȸ��

-- DENSE_RANK() OVER : ������ ���� ������ ����� �ǳʶ��� �ʰ� ���� ���
                        -- EX. ���� ������ �� ���̾ ���� ������ 2������ ����
SELECT EMP_NAME, SALARY, 
            DENSE_RANK () OVER (ORDER BY SALARY DESC) AS ����
FROM EMPLOYEE;

