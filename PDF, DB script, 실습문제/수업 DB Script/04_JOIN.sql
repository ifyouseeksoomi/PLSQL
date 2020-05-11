/*
* JOIN (합치다, 붙이다)
-- 하나 이상의 테이블을 합쳐서 데이터를 조회하기 위해 사용
-- 수행 결과는 하나의 RESULT SET(조회 결과의 집합)으로 나옴

-- <관계형 데이터 베이스 (RDBMS)에서 SQL을 이용해 테이블간 관계를 맺는 방법>
   무작정 테이블간의 관계를 만드는 것이 아닌 
   ""테이블간 연결고리로 맺어진 데이터를 추출""해야 관계를 맺는다. 
   (= 어떤 특정 두 컬럼이 같은 값을 가져야한다)
   
   --> JOIN을 통해 관계 형성
   --> 관계 형성 시, 각 테이블은 서로 같은 컬럼값을 가진 컬럼을 연결고리로 사용함.
*/

---------------------------------------------------------------------------------------------------------------------------

/* [JOIN 용어 정리]
JOIN 작성 시 두 방식 중, 아무 방식이나 사용 가능한데 
ANSI를 더 많이 사용           

           오라클                                          SQL: 1999 표준 (ANSI)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -         
         등가 조인                                       내부 조인(INNER JOIN)
                                                              JOIN ON / JOIN USING
                                                          + 자연 조인(NATURAL JOIN)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
         포괄 조인                                  왼쪽 외부 조인(LEFT OUTER JOIN)
                                                     오른쪽 외부 조인(RIGHT OUTER JOIN)
                                                     + 전체 외부 조인 (FULL OUTER JOIN)
                                                        --> 오라클 방식으로는 사용 못함
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
         자체 조인(SELF JOIN)                                JOIN ON
         비등가 조인
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
         카티션 곱                                        교차 조인(CROSS JOIN)
         (CARTESIAN PRODUCT)
*/

---------------------------------------------------------------------------------------------------------------------------

-- 기존에 서로 다른 테이블의 데이터를 조회할 경우
-- SELECT 구문의 따로 작성해야 했음.

-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 참조하여
-- 사번, 이름, 부서코드, 부서명 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

---------------------------------------------------------------------------------------------------------------------------

-- 1. 내부 조인 (INNER JOIN) (== 오라클의 등가 조인(EQUAL JOIN))
--> 연결되는 컬럼의 값이 일치하는 행들만 조인
-- (== 일치하는 값이 없는 행(EX. NULL이어서 연결할게 없을 때)은 조인에서 제외됨) 

-- 1) 연결에 사용되는 컬럼명이 다른 경우

-- ANSI 방법
-- 연결에 사용할 컬럼명이 다른 경우, JOIN ___ ON 구문을 사용함
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- 오라클 방식 (특징: JOIN X, WHERE절 O)
SELECT EMP_IN, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
-- 오라클 방식은 JOIN 구문을 사용하지 않고 WHERE절을 이용해 JOIN을 진행함
-- EQUAL 표현하여 '등가' 조인임을 표현

-- DEPARTMENT 테이블, LOCATION 테이블을 참조하여
-- 부서명, 지역명 조회

-- ANSI 방법
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE);

-- 오라클 방법
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID= LOCAL_CODE;


-- 2) 연결에 사용할 두 컬럼명이 같은 경우
-- EMPLOYEE 테이블, JOB 테이블을 참조하여
-- 사번, 이름, 직급코드, 직급명 조회

-- ANSI 방법
-- 연결에 사용할 컬럼명이 같은 경우, JOIN ___ USING 구문 사용
-- CF. 달랐을 때는 JOIN ON 이었음.
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- 오라클 방법
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
-- 오라클 방식으로 같은 컬럼명 JOIN 시, 테이블명을 작성하여 구분해주어야 함.

-- 오라클 중 별칭 사용 방법(짧아짐) -- 효율 GOOD
-- 테이블별로 별칭 등록 가능
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;
-- JOB_CODE 컬럼만 JOB 테이블과 EMPLOYEE 테이블에서 겹치기 때문에 앞에 E나 J로 구분해준 것


---------------------------------------------------------------------------------------------------------------------------

-- 2. 외부 조인(OUTER JOIN)
-- INNER JOIN과 반대되는 특징을 가짐.
-- 두 테이블의 지정하는 컬럼 값이 일치하지 않는 행도 조인에 포함.
-- ★ OUTER JOIN은 반드시 SQL문에 명시해야 함 // 그냥 JOIN만 쓰면 INNER JOIN으로 인식하므로

-- 사원명, 부서명 조회
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- 1) LEFT [OUTER] JOIN
-- JOIN에 사용한 두 테이블 중 
-- 왼편에 기술된 테이블 컬럼 수를 기준으로 JOIN 진행
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- 23행 출력 (INNER: 21행)

-- 오라클 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);
-- 오라클 방식 LEFT JOIN 시 (+) 기호를
-- 오른쪽 테이블의 컬럼명에 작성

-- 2) RIGHT [OUTER] JOIN
-- JOIN에 사용된 두 테이블 중, 오른편에 기술된 테이블의 컬럼수를 기준으로 JOIN
-- ANSI 방법
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 24행 (이오리, 하동운 누락 + NULL값 세 개 존재)

-- 오라클 방법
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [OUTER] JOIN
-- JOIN에 사용된 두 테이블이 가진 모든 행을 결과에 포함시킨다
-- ANSI 방법
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 이오리, 하동운 둘 추가, NULL값 세 개 추가 (모든 경우의 수 다 나옴)

---------------------------------------------------------------------------------------------------------------------------

-- 3. 교차 JOIN (CROSS JOIN) (CARTESIAN PRODUCT)

-- JOIN에 사용되는 테이블의 각 행들이 
-- 모두 매핑된 데이터가 검색되는 방법 (곱집합의 개념)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

---------------------------------------------------------------------------------------------------------------------------

-- 4. 비등가 JOIN (NON EQUAL JOIN)
-- '=' (E등호)를 사용하지 않는 JOIN문으로
-- 지정한 컬럼 값이 일치하는 경우로 JOIN 을 진행하지 않고
-- 지정한 컬럼 값이 특정 범위 내에 포함되는 값이면
-- 해당 행을 연결(JOIN)하는 방식

-- EMPLOYEE 테이블과 SAL_GRADE 테이블을 참조하여
-- 사원 중 자신의 SAL_LEVEL에 맞는 급여를 받고 있는 사원의 
-- 이름, 급여, SAL_LEVEL 조회

SELECT  EMP_NAME, SALARY, E.SAL_LEVEL
FROM EMPLOYEE E
JOIN SAL_GRADE S ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);


---------------------------------------------------------------------------------------------------------------------------

-- 5. 자체 조인(SELF JOIN)
-- 같은 테이블끼리 JOIN을 진행
--> 자기 자신과 JOIN

-- EMPLOYEE 테이블을 참조하여
-- 사번, 이름, 부서코드, 직속상사 사번, 직속상사 이름 조회

-- ANSI 방법
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, E.MANAGER_ID, 
           M.EMP_NAME "직속 상사 이름"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);

-- 오라클 방식
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, E.MANAGER_ID, 
           M.EMP_NAME "직속 상사 이름"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+);

---------------------------------------------------------------------------------------------------------------------------

-- 6. 자연 조인(NATURAL JOIN)
-- 동일한 타입과 컬럼명을 가진 테이블간의 JOIN 시
-- JOIN USING을 사용하지 않고 간단히 JOIN문을 작성하는 방법
--> 같은 컬럼명이 없는데 자연 조인 시 교차 조인이 진행됨
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

---------------------------------------------------------------------------------------------------------------------------

-- 7. 다중 조인
-- N개의 테이블을 JOIN하여 조회할 때 사용
-- ★★★★★ JOIN 순서가 매우 중요함!

-- EMPLOYEE, DEPARTMENT, LOCATION 테이블을 참조하여
-- 사번, 이름, 부서명, 지역명 조회

-- 조인 순서를 지키지 않은 경우, 에러 발생
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_MENU
FROM EMPLOYEE
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID);
-- EMPLOYEE와 LOCATION JOIN 시
-- EMPLOYEE 테이블에 LOCATION_ID라는 컬럼이 존재하지 않음.

-- ANSI 방법
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- 오라클 방법
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID (+)
AND LOCATION_ID = LOCAL_CODE(+);
-- 오라클 방식 다중 조인은 AND를 이용함

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME = 'ASIA1';

-- 직급이 '대리'이면서 
-- 아시아 지역에 근무하는 직원의
-- 사번, 이름, 직급명, 부서명, 지역명, 급여 조회

-- ANSI 방법
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE) -- EMPLOYEE랑 JOB이랑 동일 컬럼 존재하므로
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID) -- DEPARTMENT와 EMPLOYEE랑은 컬럼명이 다름
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)  -- 역시 LOCATION과 EMPLOYEE랑은 컬럼명이 다름
WHERE JOB_NAME= '대리'
AND LOCAL_NAME LIKE 'ASIA%';

-- 오라클 방법
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
FROM EMPLOYEE E, JOB J, DEPARTMENT, LOCATION
WHERE E.JOB_CODE = J.JOB_CODE
AND DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE -- 여기까지 JOIN
-- 여기부터 조회 조건
AND JOB_NAME = '대리'
AND LOCAL_NAME LIKE 'ASIA%';

----------------------------------------------------실 습 문 제 ------------------------------------------------------------

-- Q1.
-- 주민번호가 70년대 생이면서 성별이 여자이고, 성이 ‘전’씨인 직원들의
-- 사원명, 주민번호, 부서명, 직급명을 조회하시오

-- ANSI 방식
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
JOIN JOB USING (JOB_CODE)
WHERE SUBSTR(EMP_NO, 1, 1)='7' 
AND SUBSTR(EMP_NO, 8, 1)='2'
AND EMP_NAME LIKE '전%';

-- ORACLE 방식
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE, DEPARTMENT, JOB
WHERE DEPT_CODE = DEPT_ID
AND EMPLOYEE.JOB_CODE = JOB.JOB_CODE
AND SUBSTR(EMP_NO, 1, 1)='7' 
AND SUBSTR(EMP_NO, 8, 1)='2'
AND EMP_NAME LIKE '전%';


-- Q2.
-- 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 직급명을 조회하시오

-- ANSI 방법
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE  
JOIN JOB USING (JOB_CODE)
WHERE EMP_NAME LIKE '%형%';


-- Q3.
-- 해외영업 1부, 2부에 근무하는 사원의
-- 사원명, 직급명, 부서코드, 부서명을 조회하시오

-- ANSI 방법
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE) -- 컬럼명이 같아서 
JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE) -- 컬럼명이 달라서
WHERE DEPT_TITLE IN ('해외영업1부', '해외영업2부');


-- Q4.
-- 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.

SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) -- 컬럼명이 달라서
JOIN LOCATION ON(LOCATION_ID= LOCAL_CODE)
WHERE BONUS IS NOT NULL;


-- Q5. 
-- 부서가 있는 사원의 사원명, 직급명, 부서명, 지역명 조회

SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);  
-- 이 이후에 DEPT_CODE IS NOT NULL 조건 안써도 되는게, 현재 INNER JOIN이기 때문에 
-- NULL은 제외가 알아서 된다. (쿼리의 길이를 줄이는 것이 좋음)


-- Q6.
-- 급여등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉(보너스포함)을 조회하시오.
-- 연봉에 보너스포인트를 적용하시오

SELECT EMP_NAME, JOB_NAME, SALARY, SALARY*(1+NVL(BONUS,0))*12 AS 연봉
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN SAL_GRADE USING(SAL_LEVEL)
WHERE SALARY > MIN_SAL;


-- Q7. 
-- 한국(KO)과 일본(JP)에 근무하는 직원들의
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.

SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('한국', '일본');


-- ★★★★ Q8. 
-- 같은 부서에 근무하는 직원들의 사원명, 부서코드, 동료이름을 조회하시오.
-- SELF JOIN 사용
-- // SELF JOIN 사용하겠다 : EMPLOYEE 두 개 쓰겠다는 것임 --> 하나는 EMPLOYEE E, 하나는 EMPLOYEE M 별칭 부여해서

SELECT E.EMP_NAME, E.DEPT_CODE, M.EMP_NAME
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.DEPT_CODE = M.DEPT_CODE) -- ON은 다를 때 쓰는 것. E,M으로 구분지어서 다른 것으로 보나봄
WHERE E.EMP_NAME != M.EMP_NAME
ORDER BY 1;


-- Q9.
-- 보너스포인트가 없는 직원들 중에서 직급코드가 J4 와 J7 인 직원들의 
-- 사원명, 직급명, 급여를 조회하시오.
-- 단, JOIN, IN 사용할 것

SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE BONUS IS NULL
AND JOB_CODE IN ('J4', 'J7');







