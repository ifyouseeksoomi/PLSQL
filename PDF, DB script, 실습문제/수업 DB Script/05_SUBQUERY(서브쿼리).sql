/*
  SELECT문 해석 순서
  
  5 : SELECT 컬럼명 AS 별칭, 계산식, 함수식
  1 : FROM 참조할 테이블명 
     + JOIN
  2 : WHERE 컬럼명 | 함수식 비교연산자 비교값
  3 : GROUP BY 그룹을 묶을 컬럼명
  4 : HAVING 그룹함수식 비교연산자 비교값
  6 : ORDER BY 컬럼명 | 별칭 | 컬럼순번 정렬방식 [NULLS FIRST | LAST];
*/

----------------------------------------------------------------------------------------------------------------------------------

-- SUBQUERY(서브쿼리)
/*
- 하나의 SQL문 안에 포함된 또다른 SQL문.         // 하나의 sql 문안에 포함된 또다른 select문
- 메인 쿼리(기존 쿼리)를 위해 보조 역할을 하는 쿼리문.
*/
         
         
-- 서브쿼리 예시 1
-- 부서코드가 노옹철사원과 같은 소속의 직원의 
-- 이름, 부서코드 조회하기

-- 1) 사원명이 노옹철인 사람의 부서 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';
    
-- 2) 부서코드가 D9인 직원을 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 3) 부서코드가 노옹철사원과 같은 소속의 직원의 
-- 이름, 부서코드 조회하기
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                                 FROM EMPLOYEE
                                 WHERE EMP_NAME = '노옹철');


-- 서브쿼리 예시 2                   
-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 
-- 사번, 이름, 직급코드 ,급여 조회

-- 1) 전 직원의 평균 급여 조회 
SELECT AVG(SALARY) 
FROM EMPLOYEE;

-- 2) 전 직원들중 급여가 3047663원 이상인 사원들의 사번, 이름, 직급코드, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY>='3047663';

-- 3) 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 
-- 사번, 이름, 직급코드 ,급여 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY>=(SELECT AVG(SALARY) 
                            FROM EMPLOYEE);

----------------------------------------------------------------------------------------------------------------------------------

/*  서브쿼리의 유형
     
     - 단일행 서브쿼리 : 서브쿼리의 조회 결과 값(행)의 개수가 1개일 때
     // 컨트롤 엔터 쳤을 때 그냥 딱 하나의 행이 나오는 것
     // 그룹함수를 썼는데, 그룹 바이가 없다? --> 무조건 단일행임
     
     - 다중행 서브쿼리 : 서브쿼리의 조회 결과 값(행)의 개수가 여러개일 때
     
     - 다중열 서브쿼리 :
     
     - 다중행, 다중열 서브쿼리 : 
    
     - 상관 서브쿼리 : 
    
     - 스칼라 서브쿼리 : 
    
     * 서브쿼리의 유형에 따라 
    
*/
----------------------------------------------------------------------------------------------------------------------------------

-- 1. 단일행 서브쿼리 (SINGLE ROW SUBQUERY)

/*
- 서브쿼리의 조회 결과 값(행)의 개수가 1개인 서브쿼리 
- 단일행 서브쿼리 앞에 사용되는 연산자는 <비교 연산자>
- IN, BETWEEN, DECODE 이런거 못쓴다(연산이 단일행이 아님)
- =, !=, <, >, <=, >= 이런것들이나 쓸 수 있다는 것이다.
*/

-- 예제 1-1
-- 전 직원의 급여 평균 // 보다 많은 급여를 받는 직원의 
-- 이름, 직급, 부서, 급여를 직급 순으로 정렬하여 조회
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE)
ORDER BY JOB_CODE;


-- 예제 1-2                    
-- 가장 적은 급여를 받는 직원의
-- 사번, 이름, 직급, 부서, 급여, 입사일을 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

-- 예제 1-3
-- 노옹철 사원의 급여 // 보다 많이 받는 직원의
-- 사번, 이름, 부서, 직급, 급여를 조회                 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME ='노옹철');


-- ** 서브쿼리는 WHERE절뿐만 아니라 
-- SELECT절, HAVING절, FROM절에서도 사용 가능함 **


-- 예제 1-4
-- 부서별(부서가 없는 사람 포함) 급여의 합계 중 가장 큰 부서의
-- 부서명, 급여 합계를 조회 

-- 1) 부서별 급여 합 중 가장 큰값 조회
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) 부서별 급여합이 17700000인 부서의 부서명과 급여 합 조회
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID) 
GROUP BY DEPT_TITLE
HAVING SUM(SALARY)=17700000;

-- 3) 부서별(부서가 없는 사람 포함) 급여의 합계 중 가장 큰 부서의
-- 부서명, 급여 합계를 조회 
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID) 
GROUP BY DEPT_TITLE
HAVING SUM(SALARY)=(SELECT MAX(SUM(SALARY))
                                    FROM EMPLOYEE
                                    GROUP BY DEPT_CODE);

------------------------------------------실습문제--------------------------------------------------------------

-- 1. 전지연 사원이 속해있는 부서원들을 조회하시오 (단, 전지연은 제외)
-- 사번, 사원명, 전화번호, 고용일, 부서명

SELECT DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE EMP_NAME = '전지연';

SELECT EMP_NO, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = (SELECT DEPT_TITLE
                                FROM EMPLOYEE
                                JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                                WHERE EMP_NAME = '전지연');

-- 까지 내가 한거 아래가 답임  

SELECT EMP_NO, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                                 FROM EMPLOYEE 
                                 WHERE EMP_NAME ='전지연')
AND EMP_NAME != '전지연';
                            

-- 2. 고용일이 2000년도 이상인 사원들 중 급여가 가장 많은 사원의 
-- 사번, 사원명, 전화번호, 급여, 직급명을 조회하시오.

SELECT EMP_ID, EMP_NAME, PHONE, SALARY, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE TO_CHAR (EXTRACT (YEAR FROM HIRE_DATE))>='2000'
AND (SELECT MAX(SALARY) FROM EMPLOYEE);

---- 까지가 내가 한 거 아래가 답임

SELECT MAX(SALARY)
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE)>=2000;
-- 2000 이후 입사자 중 가장 많이 받는 연봉 조회 끝났음

SELECT EMP_ID, EMP_NAME, PHONE, SALARY, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SALARY = (SELECT MAX(SALARY)
                            FROM EMPLOYEE
                            WHERE EXTRACT(YEAR FROM HIRE_DATE)>=2000);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 200508 금

-- 2. 다중행 서브쿼리(MULTI ROW SUBQUERY)
-- 서브쿼리의 조회 결과 값(행)의 개수가 여러 행인 SELECT문

/* 다중행 서브쿼리 앞에는 일반 비교 연산자를 사용할 수 없다.

 - IN / NOT IN : 여러개의 결과값 중 하나라도 일치하는 값이 있다면/없다면 이라는 의미
 - > ANY, < ANY : 여러 개의 결과값 중 
                        - 하나라도 결과값의 가장 작은 값보다 크거나 작은 경우
                        - (서브쿼리 결과 중) 가장 작은 값보다 크냐? / 작냐?

 - > ALL, < ALL : 여러 개의 결과값 중 모든 값보다 크거나 작은 경우 
                    - (서브쿼리 결과 중) 가장 큰 값보다 크냐? / 작냐?
  
 - EXISTS / NOT EXISTS : 서브쿼리 결과값에 값이 존재하냐? 아니냐?
 
*/

-- 예제 2-1
-- 부서별 최고 급여를 받는 직원의 
-- 이름, 직급, 부서, 급여를 부서 순으로 정렬하여 조회

-- STEP1 부서별 최고 급여 조회
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- STEP2 STEP1에서 이미 조회한 자료를 WHERE절에 넣어 쿼리 완성
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)
                            FROM EMPLOYEE
                            GROUP BY DEPT_CODE)
ORDER BY 3;

-- 예제 2-2
-- 사수에 해당하는 직원에 대해 조회 후 
-- 사번, 이름, 부서명, 직급명, 구분(사수 / 직원)

-- 1) 사수에 해당하는 사원 번호 조회
SELECT DISTINCT MANAGER_ID -- 중복 사수 제거용 DISTINCT (한 사수가 여러 후배 관리 가능)
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL; -- NULL 제거용 (사수가 없는 좀 선배 사원들 제거용)

-- 2) 직원의 사번, 이름, 부서명, 직급 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- 왜 LEFT했냐면 모든 사원 대상 조회하려고 (LEFT안 할 시 NULL 자동 제거 되어 23행이 아니라 21행밖에 안 뜸)

-- 3) 사수에 해당하는 직원에 대한 정보 추출 조회(이 때, 구분은 '사수'로)  -> 6행
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '사수' AS "구분"
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) -- 여기까지는 2)와 똑같음
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID 
                            FROM EMPLOYEE 
                            WHERE MANAGER_ID IS NOT NULL); -- 더 붙은 조건 해석: "사번이 사수 사번에 해당하는"
-- WHERE절에 IN 뒤에는 1)에서 사수 정보 뽑은 것을 넣었음

-- 4) 일반 직원에 해당하는(사수가 아님) 사원들 정보 조회 (이때, 구분은 '사원'으로) : 구분만 고치고 IN을 NOT IN으로 바꿈 -> 17행
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '사원' 구분
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) 
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID 
                                    FROM EMPLOYEE 
                                    WHERE MANAGER_ID IS NOT NULL);   -- 이거는 걍 3)의 반대임  
                        
-- 5) 3, 4의 조회 결과를 하나로 합침 -> UNION : 사수와 사원 함께 조회하는 23행이 나올 것임
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '사수' 구분
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) 
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID FROM EMPLOYEE WHERE MANAGER_ID IS NOT NULL)

UNION

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '사원' 구분
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) 
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID FROM EMPLOYEE WHERE MANAGER_ID IS NOT NULL);     

-- 문제는 이 쿼리가 너무 길다는 것이다 (짧게 할 수 있음)
-- WHERE가 아니라 SELECT절에다가 SUBQUERY 작성

-- 6) ★ 3, 4의 조회 결과를 하나로 합침 -> SUBQUERY로 (사수면 ~, 사번이면 ~식으로 작성해야하므로 CASE문 필요)
SELECT EMP_ID, EMP_NㅁAME, DEPT_TITLE, JOB_NAME,                           -- 마지막에 , 찍는 것 잊지 않기 주의
            CASE WHEN EMP_ID IN (SELECT DISTINCT MANAGER_ID
                                                FROM EMPLOYEE
                                                WHERE MANAGER_ID IS NOT NULL) -- 사번이 사수이면
                    THEN '사수'                                                               -- 사수라고 부르겠다
                    ELSE '사원'                                                                 -- 아니면 사원이라고 하겠다
            END AS 구분                    
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- 왜 LEFT했냐면 모든 사원 대상 조회하려고



-- 예제 2-3
-- 대리 직급의 직원들 중에서 과장 직급의 최소 급여보다 많이 받는 직원의
-- 사번, 이름, 직급, 급여를 조회하세요
-- 단, > ANY 혹은 < ANY 연산자를 사용하세요

-- 1) 직급이 대리인 직원들의 사번, 이름, 직급명, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '대리';

-- 2) 직급이 과장인 직원들 급여 조회
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '과장';

-- 3) 대리 직급의 직원들 중에서 과장 직급의 최소 급여보다 많이 받는 직원
-- MIN을 이용하여 단일행 서브쿼리를 만드는 방법 (2번 쿼리를 끌어오되, SALARY부분을 MIN으로 수정하여 단일행으로 수정)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > (SELECT MIN(SALARY)
                        FROM EMPLOYEE
                        JOIN JOB USING (JOB_CODE)   
                        WHERE JOB_NAME = '과장');

--> ANY를 이용하여 다중행 서브쿼리를 만드는 방법 (3번 쿼리 그대로 데려와서 333행에서 MIN을 빼고 ANY 추가)
-- ANY 들어간 구문 해석: 대리의 SALARY가 그 옆(334행) 과장들 중 어떤 셀러리보다도(가장 작은 값보다도) 더 크냐
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > ANY (SELECT SALARY
                        FROM EMPLOYEE
                        JOIN JOB USING (JOB_CODE)   
                        WHERE JOB_NAME = '과장');

-- 예제 2-4
-- 차장 직급 급여의 가장 큰 값보다 많이 받는 과장 직급의 직원
-- 사번, 이름, 직급, 급여를 조회하세요
-- 단, > ALL 혹은 < ALL 연산자를 사용하세요
-- ALL 구문 해석: 차장들의 모든 연봉을 다 뒤졌을 때 그 안에 최대값은 포함되게 되어있음. 그 최대값보다 더 많이 받는 놈 찾는 쿼리

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '과장' 
AND SALARY > ALL (SELECT SALARY             
                              FROM EMPLOYEE
                              JOIN JOB USING(JOB_CODE)
                              WHERE JOB_NAME='차장');
                              
-- ** 서브쿼리 중첩 사용[응용]

-- NATIONAL_CODE가 KO인 부서에서 근무하고 있는 직원의 
-- 모든 정보 조회

-- 1) LOCATION 테이블을 통해 
-- NATIONAL_CODE가 KO인 LOCAL_CODE 먼저 구하기
SELECT LOCAL_CODE 
FROM LOCATION
WHERE NATIONAL_CODE = 'KO';

-- 2) DEPARTMENT 테이블에서
-- LOCATION_ID가 'L1'인 부서(그게 한국임)의 DEPT_ID 조회
SELECT DEPT_ID
FROM DEPARTMENT
WHERE LOCATION_ID='L1'; -- 인데 그렇게 L1 쓰지 말고 그 자리에 1)을 넣자 아래처럼

SELECT DEPT_ID
FROM DEPARTMENT
WHERE LOCATION_ID= (SELECT LOCAL_CODE 
                                    FROM LOCATION
                                    WHERE NATIONAL_CODE = 'KO');

-- 3) NATIONAL_CODE가 KO인 부서에서 근무하고 있는 직원의 
-- 모든 정보 조회                     
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_ID                              -- WHY DEPT_CODE?
            FROM DEPARTMENT
            WHERE LOCATION_ID= (SELECT LOCAL_CODE 
                                               FROM LOCATION
                                               WHERE NATIONAL_CODE = 'KO'));

                              
----------------------------------------------------------------------------------------------------------------------------------

-- 3.  다중열 서브쿼리
-- 서브쿼리 SELECT절에 나열된 컬럼 수가 

-- 예제 3-1
-- 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는
-- 사원의 이름, 직급, 부서, 입사일을 조회        

-- 1) 퇴사한 여직원 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'Y'
AND SUBSTR(EMP_NO, 8, 1) ='2';

-- 2) 퇴사한 여직원과 같은 부서,  // 같은 직급 (단일열 표현 시 -> 하나의 컬럼만 비교)
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE

-- 같은 부서 ( 1)쿼리 가져와서 SELECT만 DEPT_CODE로 수정)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                                    FROM EMPLOYEE
                                    WHERE ENT_YN = 'Y'
                                    AND SUBSTR(EMP_NO, 8, 1) ='2' )
-- 같은 직급 ( 1)쿼리 가져와서 SELECT만 JOB_CODE로 수정)
AND JOB_CODE = (SELECT JOB_CODE
                            FROM EMPLOYEE
                            WHERE ENT_YN = 'Y'
                            AND SUBSTR(EMP_NO, 8, 1) ='2');
             
-- BUT 또 너무 길다 
-- 아래처럼 ""다중열""을 쓰면 짧아진다

-- 3) 퇴사한 여직원과 같은 부서, 같은 직급 (다중열 서브쿼리로)
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE               -- WHERE절 다중열 순서에 맞추어 쓸 것
                                                    FROM EMPLOYEE
                                                    WHERE ENT_YN = 'Y'
                                                    AND SUBSTR(EMP_NO, 8, 1) ='2');
    
             
----------------------------------------------------------------------------------------------------------------------------------        
           
-- 4. 다중행 다중열 서브쿼리
-- 서브쿼리 조회 결과 행과 열의 수가 여러 개일 때

-- 예제 4-1
-- 본인 직급의 평균 급여 // 를 받고 있는 직원의
-- 사번, 이름, 직급, 급여를 조회하세요
-- 단, 급여와 급여 평균은 만원단위로 계산하세요 TRUNC(컬럼명, -4)      

-- CF) 급여를 200만, 600만 받는 직원의 사번, 이름, 직급, 급여 조회 (200만, 600만이 평균급여라 생각할 경우)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN ('2000000',  '6000000');

-- 1) 직급별 평균 급여
SELECT JOB_CODE, TRUNC(AVG(SALARY), -4)     -- 월급 만원 단위로 절삭하려고
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 2) 본인 직급의 평균 급여를 받고 있는 직원의 사번, 이름, 직급, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, TRUNC(AVG(SALARY), -4)     
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);         -- 2)번 쿼리를 WHERE절에 넣음 BUT! 이 때 
                                                                      -- WHERE SALARY만 하면 열이 안맞아서 알맞게 JOB_CODE 하나 더 앞에 넣음
                                                                      -- 그리고 그렇게 WHERE 뒤에 두개 넣을 거면 괄호로 묶어줘야한다
                                                                      
---------------------------------------------------------------------------------------------------------------------------------- 

-- 5. 상[호연]관 서브쿼리 (상관 쿼리)      // 쫌 SELF JOIN이랑 비슷
-- 상관쿼리는 메인쿼리가 사용하는 테이블 값을
-- 서브쿼리가 이용해서 결과를 만듦.

-- 메인쿼리의 테이블 값이 변경되면 서브쿼리의 결과도 변함

-- 상관 쿼리는 먼저 메인 쿼리의 한 행을 조회하고 
-- 해당 행이 서브쿼리의 조건을 충족하는지 확인하여
-- 메인 쿼리 결과로 조회를 할지 말지를 정함
-- 일반적인 서브쿼리의 해석 순서와 반대!
-- CF. 일반적인 서브쿼리의 해석순서 : 서브가 먼저 그 다음이 메인

-- 예제 5-1
-- 사수가 있는 직원의 사번, 이름, 부서명, 사수사번 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID
FROM EMPLOYEE E -- SELF JOIN이랑 비슷하게 역시 별칭 부여
WHERE EXISTS (SELECT EMP_ID
                       FROM EMPLOYEE M 
                       WHERE E.MANAGER_ID = M.EMP_ID); -- 확실히 서브쿼리 먼저 해석할 수 없는 구조

-- ★ 상관쿼리는 해석할 때
-- 메인 쿼리 한 행을 조회하여
-- EX. 위의 경우에서는 E.MANAGER_ID 컬럼 값이
-- M.EMP_ID에 존재하는지 확인하여 (수업 시간에 샘이 하나하나 대조했던 것 생각)
-- 있을 경우, 해당 행을 메인쿼리 조회결과에 포함시킴.

-- 예제 5-2
-- 직급별 급여 평균보다 급여를 많이 받는 직원의 
-- 이름, 직급코드, 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE E
WHERE SALARY > (SELECT AVG(SALARY) 
                            FROM EMPLOYEE M
                            WHERE E.JOB_CODE = M.JOB_CODE);

---------------------------------------------------------------------------------------------------------------------------------- 

-- 6. 스칼라 서브쿼리
-- 스칼라: SQL에서 "단일 값"을 가리켜 스칼라 라고 함.
-- SELECT절에 사용되는 결과가 1행만 반환되는 서브쿼리

-- 예제 6-1
-- 모든 사원의 사번, 이름, 관리자 사번, 관리자명을 조회
-- 단 관리자가 없는 경우 '없음'으로 표시 (NVL의 느낌)

SELECT EMP_ID, EMP_NAME, MANAGER_ID,
            NVL(
                   (SELECT EMP_NAME 
                    FROM EMPLOYEE M
                    WHERE E.MANAGER_ID = M.EMP_ID)      -- 메인쿼리에서 뒤진 사수사번이, 여기 존재하느냐
                    , '없음') AS 관리자명
                    
            -- ★ 여기까지 관계도 정리 
            -- 서브쿼리 수행 시 결과가 한 개만 나옴 --> 단일행 서브쿼리
            -- 단일행 서브쿼리를 만들기 위해서 사용한 서브쿼리 방법 --> 상관쿼리
            -- 단일행 서브쿼리이면서 SELECT절에 사용됨 --> 스칼라 서브쿼리
            
FROM EMPLOYEE E
ORDER BY EMP_ID;

-- 각 직원들이 속한 직급의 급여 평균 조회
-- 이름, 직급 코드, 평균 급여

SELECT EMP_NAME, JOB_CODE AS "직급", 
            (SELECT FLOOR (AVG(SALARY))
            FROM EMPLOYEE M
            WHERE E.JOB_CODE = M.JOB_CODE) AS "해당 직급의 평균 급여"
FROM EMPLOYEE E
ORDER BY JOB_CODE;

-- 직급이 J1인 사람들의 평균 급여
SELECT AVG(SALARY)
FROM EMPLOYEE
WHERE JOB_CODE = 'J1';

-- 직급별 평균 급여 조회(만단위까지)
SELECT JOB_CODE, TRUNC(AVG(SALARY), -4)
            FROM EMPLOYEE
            GROUP BY JOB_CODE
            ORDER BY 1;
---------------------------------------------------------------------------------------------------------------------------------- 

-- 7. 인라인 뷰(INLINE-VIEW) VIEW의 의미: 가상 테이블
-- FROM절에서 사용된 서브쿼리의 결과 집합
--> FROM절에서 사용된 서브쿼리
--> LITERALLY "조회된 하나의 표에서 또 조회하겠다"

SELECT EMP_NAME
FROM (SELECT EMP_NAME, DEPT_TITLE
            FROM EMPLOYEE
            JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) ); 
            -- 왜 ERROR냐면 EMP_ID를 셀렉했는데, FROM () 안의 SELECT에 EMP_ID가 없다
            
-- 예제 7-1 : 인라인뷰를 활용한 TOP-N분석

-- 전 직원 중 급여가 높은 상위 5명의
-- 순위, 이름, 급여 조회
 SELECT EMP_NAME, SALARY
 FROM EMPLOYEE
 ORDER BY SALARY DESC;
 
-- * ROWNUM : 조회된 순서대로 1부터 차례대로 번호를 매길 수 있는 컬럼
SELECT ROWNUM AS 급여순위, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC; 
-- 이상할걸 내가 생각하는대로 나오지 않을걸

SELECT ROWNUM 순위, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY
           FROM EMPLOYEE
           ORDER BY SALARY DESC)
WHERE ROWNUM<=5;
 
-- 나이가 가장 어린 사원 3명의 이름, 부서명, 나이 조회
SELECT EMP_NAME AS 이름, DEPT_TITLE AS 부서명, 나이
FROM (SELECT EMP_NAME, DEPT_TITLE,
            EXTRACT(YEAR FROM SYSDATE)-
            EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) AS "나이"
            FROM EMPLOYEE
            JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
            ORDER BY 나이)
WHERE ROWNUM<=3;


-- 예제 7-2
-- 급여 평균이 3위 안에 드는 부서의 
-- 부서코드와 부서명, 평균급여를 조회

-- 1) 부서별 평균 급여 조회
SELECT DEPT_CODE 부서코드, DEPT_TITLE 부서명, FLOOR(AVG(SALARY)) 평균급여
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
GROUP BY DEPT_TITLE, DEPT_CODE
ORDER BY 3;

-- 2) 급여 평균 상위 3개 부서 조회
SELECT * 
FROM (SELECT DEPT_CODE 부서코드, DEPT_TITLE 부서명, FLOOR(AVG(SALARY)) 평균급여
            FROM EMPLOYEE
            JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
            GROUP BY DEPT_TITLE, DEPT_CODE
            ORDER BY 3 DESC)
WHERE ROWNUM <=3;

-- 3) 내가 먼저 한 것 수정 (근데 그러고 보니 2)와 같아짐)
SELECT *
FROM (SELECT DEPT_CODE 부서코드, DEPT_TITLE 부서명, FLOOR(AVG(SALARY)) 평균급여
            FROM EMPLOYEE
            JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
            GROUP BY DEPT_CODE, DEPT_TITLE
           ORDER BY AVG(SALARY) DESC)
WHERE ROWNUM<=3;

-- [좀 많이생각해야되는 어려운 문제]
-- 직급별 급여 평균과 같은 직급, 급여를 가진 직원 조회
-- 단, 급여와 급여 평균은 만원단위로 계산 TRUNC(컬럼명, -5)


---------------------------------------------------------------------------------------------------------------------------------- 


-- 8. WITH
-- 서브쿼리에 별칭 부여 후 사용 시 이름을 호출하여 사용
-- 인라인뷰로 사용될 서브쿼리에 주로 사용됨.
-- 실행 속도가 빨라진다는 장점

-- 예제 8-1
-- 전 직원의 급여 순위 
-- 순위, 이름, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE 
ORDER BY SALARY DESC;

WITH TOPN_SAL AS (SELECT EMP_NAME, SALARY
                                FROM EMPLOYEE 
                                ORDER BY SALARY DESC)

SELECT ROWNUM "순위", EMP_NAME, SALARY
FROM (TOPN_SAL);
   
   
---------------------------------------------------------------------------------------------------------------------------------- 

-- 9. RANK() OVER / DENSE_RANK() OVER

--  RANK() OVER : 동일한 순위 이후의 등수를 동일한 인원수만큼 건너 뛰고 순위 계산
                        -- EX. 공동 일위가 두 명이면 다음 순위는 3위부터 시작

SELECT EMP_NAME, SALARY, 
            RANK () OVER (ORDER BY SALARY DESC) AS 순위
FROM EMPLOYEE;
-- 공동 19위 다음에 21위로 조회됨

-- DENSE_RANK() OVER : 동일한 순위 이후의 등수를 건너뛰지 않고 순위 계산
                        -- EX. 공동 일위가 두 명이어도 다음 순위는 2위부터 시작
SELECT EMP_NAME, SALARY, 
            DENSE_RANK () OVER (ORDER BY SALARY DESC) AS 순위
FROM EMPLOYEE;

