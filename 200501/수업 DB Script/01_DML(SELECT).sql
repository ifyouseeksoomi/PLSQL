SELECT EMP_NAME FROM EMPLOYEE;

-- 한 줄 주석

/* 
범위 주석 
*/ 

-- 직원 전부의 사번과 이름, 월급을 조회하는 구문
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- 모든 사원에 대한 모든 정보 조회
SELECT * FROM EMPLOYEE;
-- '*' 은 모두를 의미하는 기호

--------------------------------------------- 실습 문제 ---------------------------------------------------
-- 1. JOB 테이블의 모든 정보 조회
SELECT * FROM JOB;

-- 2. JOB 테이블의 직급명만 조회
SELECT JOB_NAME 
FROM JOB;

-- 3. DEPARTMENT 테이블의 모든 정보 조회
SELECT * FROM DEPARTMENT;

-- 4. EMPLOYEE 테이블에서 사원명, 이메일, 전화번호, 고용일 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- 5. EMPLOYEE 테이블에서 고용일, 사원명, 월급 조회
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

----------------------------------------------------------------------------------------------
-- 컬럼 값 산술 연산
-- SELECT 시 컬럼 명 입력 부분에 
-- 계산에 필요한 컬럼명, 숫자, 산술 연산자를 이용하여 
-- 원하는 형태의 컬럼 값을 조회할 수 있다.

-- EMPLOYEE 테이블에서 사원명과 연봉 조회 (연봉=급여*12)
SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 
-- 사원명, 연봉, 보너스가 반영된 연봉을 조회
-- 보너스가 반영된 연봉 = (급여+(급여*보너스)) * 12
SELECT EMP_NAME, SALARY * 12, (SALARY + (SALARY*BONUS))*12
FROM EMPLOYEE;

----- 실습 문제 -----
-- 1. EMPLOYEE 테이블에서 
-- 사원명, 연봉, 보너스가 반영된 연봉, 실수령액을 조회
-- (실수령액 = 보너스가 반영된 연봉 - 세금 3%)
SELECT EMP_NAME, SALARY*12, (SALARY+(SALARY*BONUS))*12, (SALARY+(SALARY*BONUS))*12*0.97
FROM EMPLOYEE;

-- 2. EMPLOYEE 테이블에서
-- 이름, 고용일, 근무일수(오늘날짜-고용일) 조회
-- (DATE 타입끼리는 산술 연산이 가능)
-- ** 현재 시간(날짜)를 조회하는 키워드 ==> SYSDATEAKF
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;

--------------------------------------------------------------------------------------------------

--   컬럼 별칭
--      AS  별칭       /       "별칭"        /      AS "별칭"
--     특수문자 X     /                 특수문자 O
-- (특수문자는 각종 기호 + 공백문자 + 숫자 )

-- EMPLOYEE 테이블에서
-- 사원명, 연봉, 보너스가 반영된 연봉, 실수령액을 조회 (별칭 반영)
SELECT EMP_NAME AS 사원명, 
            SALARY * 12 "연봉(원)",
            (SALARY + (SALARY*BONUS)) *12 AS "보너스 연봉(원)",
            ((SALARY + (SALARY*BONUS)) * 12 * 0.97) AS "실수령액"
FROM EMPLOYEE;

--------------------------------------------------------------------------------------------------

-- 리터럴
-- 임의로 지정한 문자열을 SELECT절에 사용하면, 테이블에 존재하는 데이터처럼 사용할 수 있음
-- 문자나 날짜 리터럴은 ' '(홀따옴표) 기호를 사용
-- 리터럴은 RESULT SET (조회한 결과의 집합)의 모든 행에 반복 표시됨

-- EMPLOYEE 테이블에서 
-- 직원의 사번, 이름, 급여, 단위(데이터: 원) 을 조회

SELECT EMP_ID, EMP_NAME, SALARY, '원' AS 단위
FROM EMPLOYEE;


-- DISTINCT
-- 컬럼에 포함된 중복값을 한 번씩만 표시하고자 할 때 사용하는 키워드
-- (중복 제거)

-- EMPLOYEE 테이블에서 직원의 직급 코드 종류를 조회
SELECT JOB_CODE FROM EMPLOYEE;

-- 위 SQL문에서 중복 제거
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- JOB_CODE와 DEPT_CODE 조회 (직급별 부서 종류 조회)
SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE FROM EMPLOYEE;
--> DISTINCT는 SELECT 절에 딱 한번만 작성할 수 있다. (에러)

SELECT DISTINCT JOB_CODE, DEPT_CODE FROM EMPLOYEE;


--------------------------------------------------------------------------------------------------------

-- WHERE절
-- 조회할 테이블에서 조건이 맞는 값을 가진 행을 골라내는 구문

/* [표현식]
SELECT 컬럼명
FROM 테이블명
WHERE 조건식;
*/

-- * 비교연산자
-- =(같다), >, <, >=, <
-- !=, ^=, <>(같지 않다)

-- EMPLOYEE 테이블에서 부서 코드가 'D9'인 직원의 이름, 부서코드 조회
SELECT EMP_NAME,  DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 테이블에서 부서 코드가 'D9'이 아닌 직원의 이름, 부서코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE 테이블에서 급여가 4000000 이상인 직원의 이름, 급여 , 직급 코드를 조회
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE 테이블에서 퇴사 여부가 'N'인 지원을 조회하고, 
-- 근무 여부 컬럼에 '재직중'으로 표시하여
-- 사번, 이름, 고용일, 근무여부 를 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, '재직중' AS "근무 여부"
FROM EMPLOYEE
WHERE ENT_YN='N'; 

------------------------------------------ 실습문제 --------------------------------------------

-- 1. EMPLOYEE 테이블에서 월급이 3000000 이상인 사원의
-- 이름, 월급, 고용일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. EMPLOYEE 테이블에서 SAL_LEVEL이 S1인 사원의 
-- 이름, 월급, 고용일, 연락처 조회
SELECT  EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

-- 3. EMPLOYEE테이블에서 연봉이 50000000이상인 사원의 
-- 이름, 월급, 연봉, 고용일 조회
SELECT EMP_NAME AS 이름, SALARY AS 월급, SALARY*12 AS 연봉, HIRE_DATE AS 고용일
FROM EMPLOYEE
WHERE SALARY*12>=50000000;

-----------------------------------------------------------------------------------------------------------

-- 논리 연산자(AND/OR)
-- 여러가지 조건이 있을 때 사용하는 연산자

-- EMPLOYEE 테이블에서 
-- 부서코드가 'D6'이고 
-- 급여를 200만원 이상 받는 직원의
-- 이름, 부서코드, 급여를 조회하시오.

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6'
AND SALARY >= 2000000;

-- (위 문제에서 살짝만 수정) EMPLOYEE 테이블에서 
-- 부서코드가 'D6' 이거나 
-- 급여를 200만원 이상 받는 직원의
-- 이름, 부서코드, 급여를 조회하시오.

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6'
OR SALARY >= 2000000;

-- EMPLOYEE 테이블에서 
-- 급여가 350만원 이상, 600만원 이하인 직원의
-- 사번, 이름, 급여, 부서코드 조회

SELECT EMP_ID AS 사번, EMP_NAME AS 이름, SALARY AS 월급여, DEPT_CODE AS 부서코드
FROM EMPLOYEE
WHERE SALARY >= 3500000 
AND SALARY <= 6000000;

--------------------------------------------- 실습 문제 ---------------------------------------------------

-- 1. EMPLOYEE테이블에서
-- 월급이 400만원 이상이고 JOB_CODE가 J2인 사원의 전체 내용 조회

SELECT * FROM EMPLOYEE
WHERE SALARY>=4000000
AND JOB_CODE = 'J2';

-- 2. EMPLOYEE 테이블에서
-- DEPT_CODE가 D9이거나 D5인 사원 중
-- 고용일이 02년 1월 1일보다 빠른 사원의
-- 이름, 부서코드, 고용일 조회
-- TIP. 다중 조건일 경우 순서 중요!
-- 먼저 조건을 검색해야되는 경우 괄호를 묶을 것

SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D5')
AND HIRE_DATE < '02/01/01';

-- BETWEEN 'A' AND 'B' (A와 B 사이)
--> 'A' 이상 'B' 이하

-- EMPLOYEE 테이블에서 
-- 월급이 350만 이상, 600만 이하인 직원의 
-- 사번, 이름, 급여, 부서코드 조회

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- (위의 문제 변형) EMPLOYEE 테이블에서 
-- 월급이 350만 미만, 600만 초과인 직원의 (=350만 이상, 600만 이하가 아닌)
-- 사번, 이름, 급여, 부서코드 조회

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

-- EMPLOYEE 테이블에서
-- 고용일이 '90/01/01' ~ '01/01/01' 인 사원의 모든 컬럼 조회

SELECT * FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01' ;


-- 연결 연산자 (||)
-- 여러 컬럼을 하나의 컬럼인 것처럼 연결하거나
-- 컬럼과 리터럴을 연결하는데 사용하는 연산자
-- 자바에서 String 자료형끼리 이어쓰기할 때 사용하는 '+' 에 해당

-- EMPLOYEE 테이블에서 사번, 이름, 급여를 연결하여 메시지 컬럼 조회
-- (EX) 사번이 200인 선동일의 월급은 8000000원 입니다.

SELECT '사번이 ' || EMP_ID || '인 ' || EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.' AS 메세지
FROM EMPLOYEE;

-----------------------------------------------------------------------------------------------------------

-- ** LIKE (~같은, ~처럼)

/*

비교하려는 값이 지정한 특정 패턴을 만족시키는지 확인할 때 사용

비교대상 컬럼명 LIKE '문자패턴'
 
- 문자 패턴
'A%' (A로 시작하는 값)
'%A' (A로 끝나는 값)
'%A%' (A가 포함되는 값)

- 문자 개수
'_' (한 글자)
'__' (두 글자)
'____' (네 글자)

*/

-- EMPLOYEE 테이블에서
-- 성이 '전'씨인 사원의 사번, 이름, 고용일

SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- EMPLOYEE 테이블에서
-- 이름에 '하'가 포함된 사원의 사번, 이름, 고용일, 부서코드

SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- EMPLOYEE 테이블에서
-- 전화번호 네 번째 자리가 '7'로 시작하는 사원의
-- 사번, 이름, 전화번호 조회

SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '___7%';

-- EMPOLYEE 테이블에서 
-- 이메일 중 앞 글자가 3자리인 사원의 
-- 사번, 이름, 이메일 조회

SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___%';
--> 조회 결과가 원하는대로 나올 수 없음. 왜냐면 이메일에 _가 포함되어 있음!
--> ESCAPE OPTION을 사용해야 함

SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#' ;
--> ESCAPE 뒤에 쓴 '문자' 그것 바로 뒤의 것은, 문자로 인식하겠다. 이런 뜻임
--> 언더바가 헷갈리게 되서 나오는 옵션으로 많이는 안쓰이지만 알고는 있어야함

-- NOT LIKE
-- LIKE는 특정 패턴을 만족하는 것이었다면,
-- NOT LIKE는 특정 패턴을 만족하지 않는 값을 조회

-- EMPLOYEE 테이블에서 
-- '김'씨 성이 아닌 사원의 사번, 이름, 고용일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '김%' ;


--------------------------------------------- 실습 문제 ---------------------------------------------------
-- 1. EMPLOYEE 테이블에서
-- 이름 끝이 '연'으로 끝나는 사원의 이름 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2. EMPLOYEE 테이블에서
-- 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%' ;

-- 3. EMPLOYEE 테이블에서
-- 메일주소 '_'의 앞이 4자이면서,
-- DEPT_CODE가 D9 또는 D6이고
-- 고용일이 90/01/01~00/12/01이고
-- 급여가 270만 이상인 사원의 전체를 조회
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '____$_%' ESCAPE '$'
AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6')
AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01'
AND SALARY >= 2700000;

/* ORACLE 연산자 우선 순위 (괄호는 무조건 우선이라 빼고)
1. 산술 연산자
2. 연결 연산자 (||)
3. 비교 연산자
4. IS NULL / IS NOT NULL, LIKE, NOT LIKE, IN, NOT IN
5. BETWEEN AND / NOT BETWEEN AND
6. NOT 단일
7. AND
8. OR */

-----------------------------------------------------------------------------------------------------------

-- IS NULL: 컬럼 값이 NULL인 경우
-- IS NOT NULL: 컬럼 값이 NULL이 아닌 경우

-- EMPLOYEE 테이블에서
-- 보너스를 받는 사원의
-- 사번, 이름, 급여, 보너스 
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- (위의 문제와 조금 다름) EMPLOYEE 테이블에서
-- 보너스를 안 받는 사원의
-- 사번, 이름, 급여, 보너스 
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- EMPLOYEE 테이블에서
-- 부서 배치를 받았지만
-- 보너스를 지급받지 못하는 사원의 
-- 이름, 보너스, 부서 코드 조회
SELECT  EMP_NAME, BONUS, DEPT_CODE 
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
AND BONUS IS NULL;

-----------------------------------------------------------------------------------------------------------

-- IN ( )
-- 비교하려는 값과 목록()에 일치하는 값이 있으면 TRUE, 없으면 FALSE 반환
-- [표현식]
-- 비교대상컬럼명 IN (값1, 값2, 값3, .... )

-- EMPLOYEE 테이블에서
-- 부서코드가 D6, D8, D9인 사원의 이름, 부서코드, 급여 조회
-- IN 연산자 쓰지 않고 해보기
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D6' 
OR DEPT_CODE = 'D8' 
OR DEPT_CODE = 'D9';

-- IN 연산자 쓰고 해보기 (마치 배열의 FOR문같군)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6', 'D8', 'D9');

-----------------------------------------------------------------------------------------------------------

/*
*** ORDER BY 절
- SELECT한 결과를 정렬할 때 작성하는 구문
- SELECT절 제일 마지막에(WHERE절 뒤에, ; 찍기 직전에) 작성
- SELECT 실행 순서 중 가장 마지막

[표현식]
SELECT 컬럼명 [, 컬럼명, ... ]
FROM 테이블명
[WHERE 조건식] 
[ORDER BY 컬럼명||별칭||컬럼순서 정렬방법 [ NULLS FIRST | LAST ] ];

NULLS FIRST: 정렬 기준인 컬럼에 NULL값이 있으면 앞 부분에 정렬
NULLS LAST: 정렬 기준인 컬럼에 NULL값이 있으면 뒷부분에 정렬
*/

-- EMPLOYEE 테이블에서
-- 급여 오름차순 순서대로
-- 이름, 급여, 부서코드, 직급코드 조회
SELECT EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
ORDER BY SALARY ; -- ASC는 오름차순이라는 뜻임 (생략 가능. ASC 굳이 안써도 똑같음)

-- (위에랑 반대로) EMPLOYEE 테이블에서
-- 급여 내림차순 순서대로
-- 이름, 급여, 부서코드, 직급코드 조회
SELECT EMP_NAME, SALARY AS 급여, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
-- ORDER BY SALARY DESC ; -- DESC는 내림차순이라는 뜻. (당연히 생략 불가. 필요 시 반드시 명시.)
-- ORDER BY 2 DESC; -- 2번째 컬럼을 중심으로(SQL은 0이 아니라 1부터 센다) 오름차순 정렬.
ORDER BY 급여 DESC; -- SALARY를 별칭으로 지정한 이후에도 가능하다.
