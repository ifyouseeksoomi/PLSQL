/* 
문(문장): 시작부터 세미콜론까지를 부르는 단위
절: 특정 구문(보통 한 줄)

EX) SELECT EMP_NAME                 -- SELECT절
     FROM EMPLOYEE                    -- FROM절
     WHERE DEPT_CODE ='D5'         -- WHERE절
    -- 그리고 이 위의 전체는 하나의 SELECT문
    
***** SELECT문 해석 순서 *****
5: SELECT 컬럼명 AS 별칭, 계산식, 함수식                             
1: FROM 참조할 테이블명                                                   
2: WHERE 컬럼명|함수식 비교연산자 비교값                           
3: GROUP BY 그룹을 묶을 컬럼명                                         
4: HAVING 그룹함수식 비교연산자 비교값                             
6: ORDER BY 컬럼명|별칭|순서 정렬방식 [NULLS FIRST | LAST];  

----------------------------------------------------------------------------------------------------------------------

/* GROUP BY 절
- 같은 값들이 여러개 기록된 컬럼을 가지고
- 같은 값들을 하나의 그룹으로 묶음
EX. EMPLOYEE 테이블에서 사원들을 부서별로 묶어서 나누면
*/

-- EMPLOYEE 테이블에서 부서별 급여 합계 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE;
-- not a single-group group function 오류 발생!

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- EMPLOYEE 테이블에서 
-- 부서별 급여 합, 급여 평균(소수점 내림), 직원 수 조회
SELECT DEPT_CODE, SUM(SALARY) AS "합계", 
                             FLOOR(AVG(SALARY)) AS "평균",
                             COUNT(*) AS "직원수"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- EMPLOYEE 테이블에서
-- 부서별 보너스를 받는 사원의 수 조회하고 
-- 부서 코드 오름차순으로 조회(NULL 마지막)
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC NULLS LAST;
-- ORDER BY절에서 ASC NULLS LAST는 기본값으로 생략 가능

-- EMPLOYEE 테이블에서
-- 성별 별 급여 평균(반올림), 급여 합, 인원 수 조회
-- 인원수 내림차순 정렬
SELECT DECODE (SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') AS "성별",
           ROUND (AVG(SALARY)) AS "평균",
           SUM (SALARY) AS "합계",
           COUNT(*) AS "인원수"
FROM EMPLOYEE
-- GROUP BY 성별; --> 아직 SELECT절이 해석되지 않아(해석 순서상 뒤에 있음) 사용 불가
GROUP BY DECODE (SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여')
ORDER BY "인원수" DESC;

-- WHERE절 + GROUP BY 절 혼합 SQL문
-- ** WHERE절은 각 컬럼 값에 대한 조건이라는 것을 명!심!할!것!

-- EMPLOYEE 테이블에서 
-- 부서 코드가 'D5' 또는 'D6'인 부서의 평균 급여 조회
SELECT DEPT_CODE, AVG(SALARY)                   -- 4순위
FROM EMPLOYEE                                           -- 1순위
WHERE DEPT_CODE IN ('D5', 'D6')                    -- 2순위
GROUP BY DEPT_CODE;                                  -- 3순위

-- EMPLOYEE 테이블에서
-- 직급별 2000년도 이후 입사자들의 급여 합 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE HIRE_DATE >= TO_DATE ('20000101', 'YYYYMMDD')
GROUP BY JOB_CODE;

-- 여러 컬럼을 묶어서 그룹으로 지정 가능
-- ** 주의 사항
-- SELECT문에 GRUOP BY절 사용 시,
-- SELECT절에 명시한 조회할 컬럼 중 그룹 함수가 적용되지 않은 컬럼은
-- 모두 GROUP BY절에 작성해야함.

-- EMPLOYEE 테이블에서
-- 부서별로 같은 직급인 사원의 급여 합계를 조회하고
-- 부서코드 오름차순으로 정렬

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
-- GROUP BY DEPT_CODE; --> ORA-00979: not a GROUP BY expression 에러 발생
GROUP BY DEPT_CODE, JOB_CODE -- 부서별 직급 (이게 순서가 바뀌면 직급별 부서가 된다)
--> GROUP BY 절에 작성되는 컬럼 순서대로 그룹 세분화 진행됨
--> DEPT_CODE로 그룹을 나눈 후, 각 그룹에서 JOB_CODE로 또 그룹 세분화
ORDER BY DEPT_CODE;

-- EMPLOYEE 테이블에서
-- 부서별 급여 등급이 같은 직원의 수를 조회하고 
-- 부서별 급여 등급 오름차순으로 정렬
SELECT DEPT_CODE, SAL_LEVEL, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, SAL_LEVEL
ORDER BY DEPT_CODE, SAL_LEVEL; -- DEPT_CODE로 일차 정렬하고 그 안에서 SAL-LEVEL로 또 정렬 해라

----------------------------------------------------------------------------------------------------------------------

-- HAVING절: 그룹함수로 구해올 그룹에 대한 조건을 설정할 때 사용
-- [표현식]
-- HAVING 컬럼명|함수식 비교연산자 비교값

-- 부서별 급여 평균이 300만원 이상인 부서의
-- 부서코드, 평균 급여 조회
-- 부서코드 오름차순 정렬

SELECT DEPT_CODE, FLOOR(AVG(SALARY)) AS "평균"
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;
--> 부서별 급여가 300만 이상인 직원의 급여 평균을 구한 것이다 <WRONG>

SELECT DEPT_CODE, FLOOR(AVG(SALARY)) AS "평균"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000
ORDER BY DEPT_CODE;
--> 위의 코드에서 WHERE 절 지운 후, HAVING절 추가

-- 부서별 급여 합이 900만원을 초과하는 부서를 
-- 부서코드, 급여 합 조회하고
-- 부서코드 내림차순으로 정렬
SELECT DEPT_CODE, SUM(SALARY )
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY)>9000000 
ORDER BY DEPT_CODE DESC;

----------------------------------------- GROUPBY & HAVING 실습문제 ---------------------------------------

-- 1. EMPLOYEE 테이블에서 각 부서별 가장 높은 급여, 가장 낮은 급여를 조회하여
-- 부서 코드 오름차순으로 정렬하세요.
SELECT DEPT_CODE AS "부서 코드", MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- 2. EMPLOYEE 테이블에서 각 직급별 보너스를 받는 사원의 수를 조회하여
-- 직급코드 오름차순으로 정렬하세요
SELECT JOB_CODE AS "직급 코드", COUNT(BONUS) AS "직급별 보너스 인원"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 3. EMPLOYEE 테이블에서 
-- 부서별 70년대생의 급여 평균이 300만 이상인 부서를 조회하여
-- 부서 코드 오름차순으로 정렬하세요
SELECT DEPT_CODE AS "부서 코드", 
            ROUND(AVG (SALARY)) AS "급여 평균"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 1, 1)=7 
GROUP BY DEPT_CODE
HAVING ROUND(AVG (SALARY)) >= 3000000
ORDER BY DEPT_CODE;

----------------------------------------------------------------------------------------------------------------------

-- 집계 함수 (ROLLUP & CUBE)
-- 그룹별 산출한 결과 값의 집계를 계산하는 함수
-- * 오로지 GROUPBY절에서만 작성 가능

-- ROLLUP 함수
-- 그룹별 중간 집계 처리 및 전체 집계 처리를 하는 함수
-- * 인자로 전달받은 그룹 중 가장 먼저 지정한 그룹별 합계와
-- 총 합계를 구하는 함수

-- EMPLOYEE 테이블에서
-- 각 직급별 급여 합계와 전체 직원의 급여 합계 조회

-- 1) 각 직급별 급여 합계
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 2) 전체 직원의 급여 합계
SELECT SUM(SALARY) 
FROM EMPLOYEE;

-- 3) 각 직급별 급여와 전체 직원의 급여 합계 (즉 1)과 2)를 한 RESULT SET에 나타내기)
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY JOB_CODE;

-- EMPLOYEE 테이블에서
-- 각 부서에 소속된 직급별 급여 합, 
-- 부서별 급여 합,
-- 전체 직원 급여 총합 조회
-- 부서코드 오름차순 정렬

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP (DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

----------------------------------------------------------------------------------------------------------------------

-- CUBE 함수: 그룹별 산출 결과를 모두 집계하는 함수
-- * 그룹으로 지정된 모든 그룹에 대한 집계와 총 합계를 구하는 함수

-- EMPLOYEE 테이블에서
-- 각 부서별 직급의 급여 합,
-- 부서별 급여 합,
-- 직급별 급여 합,
-- 전체 직원의 급여 합 조회

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE (DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

----------------------------------------------------------------------------------------------------------------------

-- GROUPING : 집계함수에 의한 산출물이
-- 인자로 전달받은 컬럼 집합의 산출물이면 0
-- 아니면 1을 반환하는 함수

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
    CASE WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE)=1 THEN '부서'
            WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE)=0 THEN '직급'
            WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE)=1 THEN '총합'
            ELSE '부서+직급'
    END AS "구분"
FROM EMPLOYEE
GROUP BY CUBE (DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;
            
----------------------------------------------------------------------------------------------------------------------

-- SET OPERATION (집합 연산자)

-- 여러 개의 SELECT 결과물(RESULT SET)을 하나의 결과로 만드는 연산자
-- (SELECT 여러개를 하나의 SELECT 문으로 만듦)
-- 하나의 SELECT 결과에 여러가지 조건이 엮여 SQL 구문이 보기 힘들 때 사용
--> 초보자에게 좋음

-- 주의: 집합 연산에 사용되는 SELECT문은 SELECT절이 동일해야 함


-- 1. UNION (합집합)
-- 여러 개의 SELECT 결과를 하나로 합치는 연산자
-- 단, 중복은 제거되어 한 번만 작성됨.

-- EMPLOYEE 테이블에서 부서코드가 'D5'이거나 급여가 300만 이상인 사원의
-- 사번, 이름, 부서코드, 급여 조회

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

-- 1)과 2)의 결과 동일
-- 즉 UNION 연산은 WHERE절에 OR 연산을 한 것과 같다. (이래서 초보자에게 좋다고..)


-- 2. INTERSECT (교집합)
-- 여러 SELECT의 결과 중 공통 부분만 반환하는 연산자

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

-- 1)과 2)의 결과 동일
-- 즉 INTERSECT 연산은 WHERE절에 AND 연산을 한 것과 같다. (역시 이래서 초보자에게 좋다고..)


-- 3. UNION ALL 
-- 여러 SELECT 결과를 하나로 합치는 연산자
-- UNION과 달리 중복 제거를 하지 않음
-- UNION + INTERSECT의 결과를 반환

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 

UNION ALL

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;


-- 4. MINUS (차집합)
-- 선행 SELECT 결과에서 다음 SELECT 결과와 
-- 중복되는 행을 제거하는 연산자

-- EMPLOYEE 테이블에서 
-- 부서코드가 'D5'인 직원 중 급여가 300만 초과인 직원 제외하여 조회

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

-- 1)과 2)의 연산 결과는 같다.


-- 5. GROUPING SETS

-- 그룹별로 처리된 여러개의 SELECT문을 하나로 합칠 때 사용
-- SET OPERATION 사용한 결과와 동일하다.

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
