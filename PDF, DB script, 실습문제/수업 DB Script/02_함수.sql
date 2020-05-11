UPDATE EMPLOYEE SET EMP_NO = '621225-1985634' WHERE EMP_ID = '200'; 
UPDATE EMPLOYEE SET EMP_NO = '631116-1548654' WHERE EMP_ID = '201'; 
UPDATE EMPLOYEE SET EMP_NO = '850705-1313513' WHERE EMP_ID = '214'; 
COMMIT;

-- 함수: 컬럼의 값을 읽어서 계산한 결과를 리턴

-- 단일행(SINGLE ROW) 함수: 
--> 컬럼에 기록된 N개의 값을 읽어서 N개의 결과를 리턴 
-- (어떤 행이 3행이라면, 똑같이 3행의 결과가 나옴)

-- 그룹(GROUP) 함수:
--> 컬럼에 기록된 N개의 값을 읽어서 한 개의 결과를 리턴

-- (주의) SELECT 절에 단일행 함수와 그룹함수는 함께 사용 못함
--> 결과 행의 개수가 다르기 때문 (하나는 세 개나오고 하나는 하나 나오고 이러니까)

-- 함수를 사용할 수 있는 위치
-- SELECT 절, WHERE 절, ORDER BY 절, 
-- GROUP BY 절, HAVING 절

------------------------------------------------------------------------------------------------------------------

-- <단일행 함수> --

-- 1. 문자 관련 함수

-- 1) LENGTH / LENGTHB
-- LENGTH: 주어진 컬럼 값의 길이
-- LENGTHB: B는 바이트를 의미. 주어진 컬럼의 BYTE길이

SELECT LENGTH ('오라클') FROM DUAL;
-- DU+AL (DUMMY TABLE: 가상테이블)

SELECT LENGTHB ('오라클') FROM DUAL;
-- CHAR가 2바이튼데 왜 9바이트가 나오지? 
SELECT LENGTHB ('ORACLE') FROM DUAL;
-- 영어로하니 왜 6바이트가 나오지?

/*
ORACLE Express Edition에서
VARCHAR2 데이터 타입 사용 시 한글은 3 BYTE, 영어&숫자는 1 BYTE로 인식

모든 VARCHAR2 데이터 타입 2BYTE로 통일하는 방법
--> NVARCHAR2를 사용하면 모두 2BYTE(유니코드)로 인식
*/

-- EMPLOYEE 테이블에서 
-- 모든 사원의 이메일, 이메일 길이, 이메일 바이트 길이 조회

SELECT EMAIL, LENGTH(EMAIL) AS 길이, LENGTHB(EMAIL) AS 바이트
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------

-- 2) INSTR
-- 지정한 위치부터 지정한 숫자 번째로 나타나는 문자의 시작 위치 반환

-- [표현식] 
-- INSTR('문자열' | 컬럼명, '문자'[,찾을 위치의 시작값, [, 순번]])
-- 대괄호의 의미: 해도 되고 안해도 되고(생략)

-- 첫 번째 문자(문자열 시작이 0번째 아니고 ""1번째""임)부터 검색하여 'B'가 처음(1ST) 나오는 위치
-- (해당 문자열에서 내가 찾고 싶은 문자가 몇번째에 있는지 찾기)
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;

-- 해당 문자열에서 내가 찾고 싶은 문자가 A번째 숫자부터 B번째로 나오는지 (문자열, 문자, A, B)
SELECT INSTR('AABAACAABBAA', 'B', 1, 1) FROM DUAL; 
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;

-- 마지막(-1) 문자부터 검색하여 처음(1) 'B'가 나오는 위치 
SELECT INSTR('AABAACAABBAA', 'B', -1, 1) FROM DUAL;

-- EMPLOYEE 테이블에서
-- 사원의 이메일, 이메일에서 '@'가 위치하는 인덱스 조회
SELECT EMAIL, INSTR (EMAIL, '@', 1, 1) "@ 위치" 
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------

-- 3)  ★ TRIM (모든 프로그래밍 언어에서 사용)
-- 주어진 문자열이나 컬럼값의 앞/뒤/양쪽에 있는 지정한 문자 제거
-- 지정 문자가 없을 경우 기본값으로 공백 제거

SELECT TRIM('       KH      ') FROM DUAL;
SELECT TRIM('-' FROM '----KH-----') FROM DUAL;

-- TRIM할 CHAR 위치 지정
-- 앞(LEADING)
SELECT TRIM (LEADING '-' FROM '-------KH------') FROM DUAL;
-- 뒤(TRAILING)
SELECT TRIM (TRAILING '-' FROM '-------------KH-----') FROM DUAL;
-- 양쪽(BOTH) : 사실 기본값과 같아 안써도 그만
SELECT TRIM (BOTH '-' FROM '-----------KH-------') FROM DUAL;

------------------------------------------------------------------------------------------------------------------

-- 4) SUBSTR 
-- 컬럼이나 문자열에서 지정한 위치부터 지정한 개수의 문자열을
-- 잘라내어 반환

-- [표현식]
-- SUBSTR(컬럼|'문자열', POSITION [, LENGTH])
-- POSITION: 잘라내기 시작 위치
-- (양수 입력 시 앞쪽부터 절대값 만큼, 
--  음수 입력 시 뒤쪽부터 절대값 만큼 떨어진 곳에서 시작)

SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
-- 5번째부터 두 글자를 자르겠다

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
-- 7번째부터 모두 자르겠다

SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

-- EMPLOYEE 테이블에서
-- 사원의 이름, 이메일, 이메일 아이디(@ 이후를 제거) 조회
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS 아이디
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 사원의 이름, 주민등록번호, 주민등록번호의 성별 부분 조회
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, INSTR(EMP_NO, '-')+1, 1) AS 성별
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 성별이 남자인 사원만 조회
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, INSTR(EMP_NO, '-')+1, 1) AS 성별
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, INSTR(EMP_NO, '-')+1, 1)='1';

-- EMPLOYEE 테이블에서 
-- 사원들의 주민번호를 이용하여
-- 사원명, 출생년, 출생월, 출생일을 조회하시오.

SELECT EMP_NAME "사원명", 
        SUBSTR(EMP_NO, 1, 2) "출생년", 
        SUBSTR(EMP_NO, 3, 2) "출생월",
        SUBSTR(EMP_NO, 5, 2) "출생일"
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------

-- 5) LPAD / RPAD 
-- 주어진 컬럼이나 문자열에 임의의 문자열을 왼쪽/오른쪽에
-- 덧붙여서 길이 N인 문자열을 반환

-- [표현식]
-- LPAD | RPAD (컬럼명 | '문자열', 반환할 문자열의 길이 [, 덧붙일 문자])

SELECT LPAD (EMAIL, 20, '#') FROM EMPLOYEE;
-- 스무 칸에 이메일을 오른쪽 정렬 후 나머지 왼쪽 빈칸 공백에는 #을 채워라 는 뜻

SELECT RPAD (EMAIL, 20, '#') FROM EMPLOYEE;
-- 스무 칸에 이메일을 왼쪽 정렬 후 나머지 오른쪽 빈칸 공백에는 #를 채워라 는 뜻

-- LPAD, RPAD
--> 조회되는 내용의 통일성을 위해서 주로 사용(보기 좋게 하기 위해)
-- 마치 자바에서 %2D 이런것과 효과가 같음

-- EMPLOYEE 테이블에서
-- 사원명, 주민등록번호 조회
-- 단, 주민등록번호 뒷자리는 성별만 보이고 나머지는 '*'로 처리

SELECT EMP_NAME, 
        RPAD (SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;
-- SUBSTR를 이용하여 주민번호 900206-2 까지만 따고, 
-- RPAD를 이용하여 900206-2를 왼쪽으로 밀어넣은 후, 그 뒤에는 모두 *로 처리하는 것

------------------------------------------------------------------------------------------------------------------

-- 6) REPLACE
-- 컬럼 또는 문자열에서 특정 문자(열)을 지정한 문자(열)로 바꾼 후 반환

-- [표현식]
-- REPLACE (컬럼 | '문자열', 변경하려는 문자(열)(BEFORE), 변경하고자 하는 문자(열)(AFTER))

SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동' ) AS 주소
FROM DUAL;

-- EMPLOYEE 테이블에서 
-- 사원들의 이메일 주소를 'kh.or.kr' 에서 'gmail.com'으로 변경하여
-- 사원명, 기존 이메일, 바뀐 이메일 조회

SELECT EMP_NAME, EMAIL AS "기존 이메일",
        REPLACE(EMAIL, 'kh.or.kr', 'gmail.com') AS "바뀐 이메일"
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------

-- 2. 숫자 처리 함수

-- ** ABS(NUMBER) 절대값 구하기 (너무 쉽다고 그냥 넘어갔음)

-- 1) MOD(NUMBER) 두 수를 나누어 나머지 구하기

-- [표현식]
-- MOD(숫자|숫자로 된 컬럼명, 숫자|숫자로 된 컬럼명)
-- 첫 번째 인자: 나누어 지는 수 (몸체)
-- 두 번째 인자: 나눌 수 (안 몸체)

SELECT MOD(10,3) FROM DUAL;
SELECT MOD(-10,3) FROM DUAL; -- 출력값 -1
SELECT MOD(10.9, 3) FROM DUAL; -- 출력값 1.9
SELECT MOD(-10.9, 3) FROM DUAL; -- 출력값 -1.9

------------------------------------------------------------------------------------------------------------------

-- 2) ROUND (반올림)

-- [표현식]
-- ROUND (숫자 | 숫자로 된 컬럼명 [, 반올림 위치])

SELECT ROUND(123.456) FROM DUAL;
--> ROUND 기본값은 소수점 첫번째 자리에서 반올림하여 정수를 반환

SELECT ROUND(123.456, 1) FROM DUAL;
--> 여기서 1은 첫번째 자리에서 반올림을 한다는게 아니라, 첫번째 자리""까지"" 표현임

SELECT ROUND(123.456, 0) FROM DUAL;
--> 여기서 0은 소수점 0번째까지 표현: 즉 소수점 모두 없어져서 123 출력

SELECT ROUND(123.456, -2) FROM DUAL;
--> 1     2    3   .   4   5   6 
--> -2,   -1,    0,      1,  2,  3 
-- 따라서 -2는 123.456에서 맨 앞에 1 내리고 싹다 반올림하는거여서 100

------------------------------------------------------------------------------------------------------------------]

-- 3) FLOOR (내림)

SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;
--> 기본값은 역시 소수점 첫번째 자리에서 내리므로 정수 반환

------------------------------------------------------------------------------------------------------------------]

-- 4) TRUNC (버림, 절삭)
-- 내림과의 차이는 진짜로 없애버림

-- [표현식]
-- TRUNC (숫자 | 숫자로 된 컬럼명 [, 위치] )

SELECT TRUNC (123.456) FROM DUAL;
SELECT TRUNC (123.678) FROM DUAL;
--> 역시 기본값으로 하면 소수점 이하 모두 버린 후 정수 반환. ROUND, FLOOR와 차이가 아직 X

--* FLOOR VS. TRUNC 그 차이는 ""음수""에서 확인 가능
SELECT TRUNC(-10.123) FROM DUAL; -- 소수점 부분을 '삭제하여' 남은 값을 출력: -10
SELECT FLOOR(-10.123) FROM DUAL; -- 소수점 부분을 '내리어' -10의 더 아래의 값을 출력: -11

SELECT TRUNC(123.456, 1) FROM DUAL; -- 123.4
SELECT TRUNC(123.456, 2) FROM DUAL; -- 123.45

SELECT TRUNC(123.456, -1) FROM DUAL; -- 120

------------------------------------------------------------------------------------------------------------------]

-- 5) CEIL (올림) : 무조건 올림. FLOOR와 반대.

SELECT CEIL(123.5) FROM DUAL; --124
SELECT CEIL(123.1) FROM DUAL; --124

------------------------------------------------------------------------------------------------------------------]

-- 3. 날짜 처리 함수

-- 1) SYSDATE : 시스템에 저장되어있는 현재 날짜(시간)을 반환하는 함수
SELECT SYSDATE FROM DUAL;

-- 2) MONTHS_BETWEEN (날짜, 날짜)
-- 두 날짜의 개월 수 차이를 숫자로 리턴하는 함수

-- EMPLOYEE 테이블에서 
-- 사원명, 입사일, 근무 개월 수 조회

SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE 
FROM EMPLOYEE; -- 근무 일수로 표현됨.
--> 먼쓰비트윈 쓰지 않고 하는 방법
--> 정수부분은 ""일"", 그 이하는 시/분/초

SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEE; -- 근무 개월수로 표현됨.
--> 정수부분이 ""달""

SELECT EMP_NAME, HIRE_DATE, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS 근무개월수
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------]

-- 3) ADD_MONTHS (날짜, 숫자): 
-- 날짜에 숫자만큼의 개월수를 더하여 반환

SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- EMPLOYEE 테이블에서 
-- 사원의 이름, 입사일, 입사일로부터 6개월이 된 날짜 조회

SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------]

-- 4) LAST_DAY (날짜) : 해당 월의 마지막 날짜를 구하여 리턴

SELECT SYSDATE, LAST_DAY (SYSDATE) AS "이 달의 마지막 날" FROM DUAL;

------------------------------------------------------------------------------------------------------------------]

-- 5) EXTRACT : 날짜 데이터에서 년, 월, 일 정보를 추출하여 리턴

-- EXTRACT(YEAR FROM 날짜) : 년도만 추출
-- EXTRACT(MONTH FROM 날짜) : 월 추출
-- EXTRACT(DAY FROM 날짜) : 일 추출

-- EMPLOYEE 테이블에서
-- 사원의 이름, 입사 년도, 입사 월, 입사 일 조회

SELECT EMP_NAME "사원 이름", 
    EXTRACT(YEAR FROM HIRE_DATE) "입사 년도",
    EXTRACT(MONTH FROM HIRE_DATE) "입사 월",
    EXTRACT(DAY FROM HIRE_DATE) "입사 일"
FROM EMPLOYEE
ORDER BY "입사 년도" DESC, "입사 월" DESC, "입사 일" DESC ;


-- EMPLOYEE 테이블에서
-- 사원명, 입사일, 근무 년수를 조회
-- 단, 근무 년수는 (현재 년도 - 입사 년도)로 조회

SELECT EMP_NAME, HIRE_DATE,
        EXTRACT (YEAR FROM SYSDATE)- EXTRACT (YEAR FROM HIRE_DATE) AS "근무 년수"
FROM EMPLOYEE;
-- 근데 이거 너무 K-AGE랑 셈 방법이 비슷해서 좋지 않다 더 정확한 것은
-- MONTHS BETWEEN + CEIL 사용 (근무 연차이므로)

SELECT EMP_NAME, HIRE_DATE, 
    CEIL ((MONTHS_BETWEEN(SYSDATE, HIRE_DATE))/12) AS "근무 연차"
FROM EMPLOYEE;

--------------------------------------------------실 습 문 제 ---------------------------------------------------]

-- 1. EMPLOYEE 테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
-- 단, 입사일-오늘의 별칭은 "근무일수1", 
-- 오늘-입사일의 별칭은 "근무일수2"로 하고
-- 모두 정수(내림)처리, 양수가 되도록 처리

SELECT EMP_NAME,
    FLOOR(ABS(HIRE_DATE-SYSDATE)) AS 근무일수1, 
    FLOOR(ABS(SYSDATE-HIRE_DATE)) AS 근무일수2
FROM EMPLOYEE;


-- 2. EMPLOYEE 테이블에서 사번이 홀수인 직원들의 정보 모두 조회

SELECT * FROM EMPLOYEE
WHERE MOD(EMP_ID,2)=1;
-- EMP_ID는 VARCHAR2 데이터 타입이나, 숫자처럼 연산이 가능하다
-- 왜냐하면 저장된 문자열 값이 모두 숫자로만 이루어져 있기 때문에 
-- 자동으로 NUMBER 타입으로 형변환되어 산술 연산이 이루어지는 것이다.


-- 3. EMPLOYEE 테이블에서 근무 년수가 20년 이상인 직원 정보 조회

/*SELECT * FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12>=20;*/

-- OR

SELECT * FROM EMPLOYEE
WHERE ADD_MONTHS(HIRE_DATE, 240)<SYSDATE;
    
    
-- 4. EMPLOYEE 테이블에서 사원명, 입사일, 입사한 월의 근무일수를 조회

SELECT EMP_NAME, HIRE_DATE, 
    LAST_DAY(HIRE_DATE) - HIRE_DATE AS "입사한 월의 근무 일수"
FROM EMPLOYEE;


------------------------------------------------------------------------------------------------------------------]

-- 4. 형변환 함수

-- 1) TO_CHAR (날짜|숫자 [,포맷])
-- 날짜 또는 숫자형 데이터를 포맷에 맞는 문자형 데이터로 변경하여 반환

SELECT TO_CHAR(1234) FROM DUAL; -- '1234'

-- 5칸 오른쪽 정렬, 빈칸은 공백 
SELECT TO_CHAR(1234, '99999') FROM DUAL; --'_1234'

-- 5칸 오른쪽 정렬, 빈칸은 숫자 0 
SELECT TO_CHAR(1234, '00000') FROM DUAL; --'01234'

-- 현재 설정된 나라의 화폐 단위 붙이기
SELECT TO_CHAR(10000, 'L99999') FROM DUAL; -- \10000
SELECT TO_CHAR(10000, '$99999') FROM DUAL; -- $10000

-- 자릿수를 구분해주는 콤마(,) 추가
SELECT TO_CHAR(10000, 'L99,999') FROM DUAL; -- \10,000
SELECT TO_CHAR(1000, '9.9EEEE') FROM DUAL; -- 부동소수점 방식으로 표현됨

-- 설정한 포맷의 범위를 지정된 값이 넘어서면, 모두 #으로 표현됨 (TO_CHAR 사용 시 가장 유의할 점)
SELECT TO_CHAR(1234, '999') FROM DUAL;


-- EMPLOYEE 테이블에서
-- 사원명, 급여 조회
-- 단, 급여는 '\9,000,000' 형식으로 조회

SELECT EMP_NAME, TO_CHAR (SALARY, 'L999,999,999')
FROM EMPLOYEE;


-- 날짜 데이터 포맷 적용
SELECT TO_CHAR (SYSDATE, 'PM HH:MI:SS') FROM DUAL; -- 12시간 체제
SELECT TO_CHAR (SYSDATE, 'HH24:MI:SS') FROM DUAL; -- 24시간 체제

SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL; -- 2020-05-04 월요일
SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD DY') FROM DUAL; -- 2020-05-04 월

SELECT TO_CHAR (SYSDATE, 'YEAR, Q') || '분기' FROM DUAL; -- TWENTY TWENTY, 2분기

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 고용일을 조회
-- 단, 고용일은 '2020-05-04' 형식으로 조회

SELECT EMP_NAME, 
    TO_CHAR (HIRE_DATE, 'YYYY-MM-DD') 
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 고용일을 조회
-- 단, 고용일은 '2020년 05월 04일' 형식으로 조회

SELECT EMP_NAME,
    TO_CHAR (HIRE_DATE, 'YYYY"년" MM"월" DD"일"') 
FROM EMPLOYEE;
-- 패턴 이외의 글자를 추가하는 경우는 쌍따옴표를 내부에 작성

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 고용일을 조회
-- 단, 고용일은 '2020년 05월 04일 (월)' 형식으로 조회

SELECT EMP_NAME,
    TO_CHAR (HIRE_DATE, 'YYYY"년" MM"월" DD"일" "("DY")"')
FROM EMPLOYEE;


------------------------------------------------------------------------------------------------------------------]

-- 2) TO_DATE 
-- 문자 또는 숫자형 데이터를 날짜형으로 변환하여 반환(리턴)하는 함수

-- [표현식]
-- TO_DATE(문자|숫자형 데이터 [, 포맷])

SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE(20100101, 'YYYYMMDD') FROM DUAL;

-- WHAT IF 20100101이라고 들어온 자료를 2010-01-01 로 바꾼다면?
--> TO_DATE (작은 괄호속) + TO_CHAR (좀 더 큰 괄호)

SELECT TO_CHAR( TO_DATE('20100101', 'YYYYMMDD'), 'YYYY-MM-DD' )
FROM DUAL;

SELECT TO_CHAR ( TO_DATE('980630', 'RRMMDD'), 'RRRR-MM-DD' )
FROM DUAL;  
-- 왜 YY가 아니라 RR이냐면 YY로 하면 1998이 아니라 2098 나옴

SELECT TO_CHAR ( TO_DATE('140918', 'RRMMDD'), 'RRRR-MM-DD' )
FROM DUAL;  
-- 이거는 YY하든 RR하든 똑같다.

-- TO_DATE의 패턴 중 년도를 바꾸기 위한 Y와 R의 차이점
-- Y: 현 세기를 적용 (현재 21세기이니 21세기)
-- R: 사용 연도가 50년 이상이면 이전(19XX) 세기, 미만이면 현재(20XX) 세기를 적용


-- EMPLOYEE 테이블에서
-- 2000년도 이후에 입사한 사원의 사번, 이름, 입사일을 조회

SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE >= TO_DATE ('20000101', 'RRRRMMDD');
--> 명시적으로 데이터 타입을 맞춰주는 것이 좋음.


------------------------------------------------------------------------------------------------------------------]

-- TO_NUMBER(문자 데이터 [, 포맷]) : 문자형 데이터를 숫자 데이터로 변환

-- 명시적으로 문자 -> 숫자로 변환 (BEST SOLUTION)
SELECT TO_NUMBER ('100') + TO_NUMBER('200') FROM DUAL;

-- 오라클에 의한 자동 형변환(문자값 내부에 숫자만 있으므로 가능)
SELECT '100' + '200' FROM DUAL;

-- 숫자가 아닌 데이터가 포함되면 에러 발생
SELECT TO_NUMBER ('100A') + TO_NUMBER('200B') FROM DUAL;

SELECT TO_NUMBER('1,000,000', '9,999,999') FROM DUAL; 
-- 1,000,000가 9,999,999 형식에 들어가니까 완전 형식 일치해버려서 
-- 아 원래 이런 숫자구나, 하고 그냥 컴마 모두 빼고 1000000 반환


------------------------------------------------------------------------------------------------------------------]

-- 5. NULL 처리 함수

-- 1) NVL (NULL VALUE) : 컬럼명, 컬럼값이 NULL일 때 대체할 값

-- EMPLOYEE 테이블에서
-- BONUS가 NULL인 사원의 BONUS 컬럼값을 0으로 변환하여
-- 사원명, 보너스 조회

SELECT EMP_NAME, NVL(BONUS, 0) -- 보너스 컬럼에서 NULL이 있으면 0으로 대체하겠다
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사원명, 부서코드 조회
-- 단, 부서코드가 NULL인 사원은 '00'으로 조회

SELECT EMP_NAME, NVL(DEPT_CODE, '00')
FROM EMPLOYEE;

-- 2) NVL2 (NULL VALUE 2) : 컬럼명, 컬럼값이 NULL이 아닌 경우를 대체할 값, 컬럼값이 NULL인 경우를 대체할 값

-- EMPLOYEE 테이블에서
-- 기존에 보너스를 받던 사원의 보너스를 0.8로
-- 받지 못하던 사원의 보너스를 0.3으로 변경하여
-- 사원명, 기존 보너스, 변경된 보너스 조회

SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.8, 0.3) AS "변경된 보너스"
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------]

-- 단일행 함수 연습 문제

--1. EMPLOYEE 테이블에서
--  직원명과 주민번호를 조회
--  단, 주민번호 9번째 자리부터 끝까지는 '*'문자로 채움
--  예 : 홍길동 771120-1******

SELECT EMP_NAME, 
        RPAD (SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;


--2. EMPLOYEE 테이블에서
--  직원명, 직급코드, 연봉(원) 조회
--  단, 총수령액은 ￦57,000,000 으로 표시
--  (총수령액은 보너스가 적용된 1년치 급여)

SELECT EMP_NAME, JOB_CODE, TO_CHAR (SALARY*12*BONUS, 'L999,999,999')
FROM EMPLOYEE;


-- 3. EMPLOYEE 테이블에서
--   부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원의 
--	 사번 사원명 부서코드 입사일 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D9';


-- 4. EMPLOYEE 테이블에서
--   직원명, 입사일, 입사한 달의 근무일수 조회
--   단, 입사한 날도 근무일수에 포함해서 +1 할 것

SELECT  EMP_NAME, HIRE_DATE, (LAST_DAY(HIRE_DATE) - HIRE_DATE +1) AS "입사한 달 근무일수(+1)"
FROM EMPLOYEE;


--5. EMPLOYEE 테이블에서
--  직원명, 부서코드, 생년월일, 나이(만) 조회
--  단, 생년월일은 주민번호에서 추출해서, 
--  ㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--  나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산.

SELECT  
    EMP_NAME AS "직원명", 
    DEPT_CODE AS "부서 코드",
    SUBSTR(EMP_NO, 1, 2) || '년 ' || SUBSTR(EMP_NO, 3, 2) || '월 ' || SUBSTR(EMP_NO, 5, 2) || '일' AS "생년월일",
    (EXTRACT (YEAR FROM SYSDATE)) -  (EXTRACT (YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 6)))) AS "만 나이"
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------]

-- 6. 선택함수
-- 여러 가지 경우에 따라 선택을 할 수 있는 기능을 제공하는 함수

-- DECODE (계산식|컬럼명, 조건값1, 선택값1, 조건값2, 선택값2, ..., 나머지) : 자바의 switch문과 비슷
-- 비교하고자 하는 값 또는 컬럼이 조건값과 일치하면 해당 선택값을 반환

-- EMPLOYEE 테이블에서 
-- 사원의 사번, 이름, 주민번호, 성별(남/여)을 조회

SELECT EMP_ID, EMP_NAME, EMP_NO, 
    DECODE ( SUBSTR (EMP_NO, 8, 1), 1, '남', 2, '여' ) AS "성별"
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원의 급여를 인상하고자 한다.
-- 직급 코드가 J7인 직원은 10% 인상, 
-- 직급 코드가 J6인 직원은 15% 인상,
-- 직급 코드가 J5인 직원은 20% 인상
-- 그 외 직급은 5% 인상
-- 사원명, 직급코드, 기존 급여, 인상 급여를 조회하시오.

SELECT EMP_NAME, JOB_CODE, SALARY AS "기존 급여", 
    DECODE (JOB_CODE, 'J7', 1.1*SALARY, 
                                  'J6', 1.15*SALARY, 
                                  'J5', 1.2*SALARY, 
                                  1.05*SALARY) AS "인상 급여"       
                                  -- 나머지 처리가 어려울텐데, 이 때는 조건값을 아예 적지 않고 선택값을 적으면 됨.
FROM EMPLOYEE;

-- CASE문 : java의 if-else문과 비슷
-- [표현식] 
/*
    CASE WHEN 조건식 THEN 결과값
            WHEN 조건식2 THEN 결과값2
            ... 
            ELSE 나머지 결과값 
    END
*/

-- EMPLOYEE 테이블에서 
-- 사번, 사원의 이름, 주민번호, 성별(남/여) 조회

SELECT EMP_ID, EMP_NAME, EMP_NO,
    CASE WHEN SUBSTR(EMP_NO, 8, 1) = '1' THEN '남'
            -- WHEN SUBSTR(EMP_NO, 8, 1) = '2' THEN '여'
            ELSE '여'
    END AS 성별 
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원의 급여를 인상하고자 한다.
-- 직급 코드가 J7인 직원은 10% 인상, 
-- 직급 코드가 J6인 직원은 15% 인상,
-- 직급 코드가 J5인 직원은 20% 인상
-- 그 외 직급은 5% 인상
-- 사원명, 직급코드, 기존 급여, 인상 급여를 조회하시오.

SELECT EMP_NAME AS "이름", JOB_CODE AS "직급 코드", SALARY AS "기존 급여",
    CASE WHEN JOB_CODE = 'J7' THEN 1.1 * SALARY
            WHEN JOB_CODE = 'J6' THEN 1.15 * SALARY
            WHEN JOB_CODE = 'J5' THEN 1.2 * SALARY
            ELSE 1.05 * SALARY
    END AS "인상 급여"
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사번, 이름, 급여, 개발자 등급 조회
-- 개발자 등급 기준
-- 급여가 500만 이상이면 '고급' 
-- 급여가 500만 미만, 300만 이상이면 '중급'
-- 급여가 300만 미만은 '초급'

SELECT EMP_ID, EMP_NAME, SALARY, 
    CASE WHEN SALARY >=5000000 THEN '고급' 
            WHEN SALARY >=3000000 THEN '중급'
            ELSE '초급'
    END AS "개발자 등급"
FROM EMPLOYEE;

------------------------------------------------------------------------------------------------------------------]

-- 7. 그룹 함수
-- 하나 이상의 행을 그룹으로 묶어 연산하여, 하나의 결과행을 반환하는 함수

-- SUM(숫자가 기록된 컬럼명) : 해당 컬럼의 총합을 구하여 반환

-- EMPLOYEE 테이블에서 전 사원의 급여 총합 조회 
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 여자 사원의 급여 총합 조회 
SELECT SUM(SALARY) FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

-- EMPLOYEE 테이블에서 
-- 부서코드가 'D5'인 직원의 보너스 포함 연봉 총합 조회
SELECT SUM(SALARY * (1+ NVL(BONUS, 0)) * 12 ) AS "D5 보너스 포함 연봉"
-- ★ 산술 연산에 NULL값이 포함되면 결과는 무조건 NULL --> NVL 함수 사용
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

------------------------------------------------------------------------------------------------------------------]

-- AVG (숫자가 기록된 컬럼명) : 그룹의 평균을 구하여 반환

-- EMPLOYEE 테이블에서 전 사원의 급여 평균 조회 (소수점 절삭)
SELECT TRUNC(AVG(SALARY)) FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 전 사원의 보너스 평균 조회 (소수점 둘째자리까지 반올림)
SELECT ROUND(AVG(NVL(BONUS, 0)), 2) FROM EMPLOYEE;
-- NULL 처리 -> 평균 -> 소수점 둘째자리까지 반올림

------------------------------------------------------------------------------------------------------------------]

-- MIN (컬럼값) : 그룹 중 지정된 컬럼에서 가장 작은 값 반환
-- 취급하는 컬럼의 자료형은 ANY TYPE(모든 타입)

-- EMPLOYEE 테이블에서 
-- 알파벳 순서가 제일 빠른 이메일, 
-- 가장 빠른 입사일,
-- 가장 낮은 급여를 한번에 조회

SELECT MIN (EMAIL), MIN (HIRE_DATE), MIN(SALARY)
FROM EMPLOYEE;

-- MAX (컬럼명) : 그룹 중 지정된 컬럼에서 가장 큰 값 반환

-- EMPLOYEE 테이블에서 
-- 알파벳 순서가 제일 느린 이메일, 
-- 가장 늦은 입사일,
-- 가장 높은 급여를 한번에 조회

SELECT  MAX(EMAIL), MAX (HIRE_DATE), MAX(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 부서코드 D5인 직원 중 가장 높은 급여, 가장 낮은 급여, 부서 
-- 전체 급여 합, 부서 전체 급여 평균

SELECT MAX (SALARY), MIN(SALARY), SUM(SALARY), AVG(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

------------------------------------------------------------------------------------------------------------------]

-- COUNT (* | [DISTINCT] 컬럼명) : 조회되는 행의 개수를 헤아려서 반환
-- COUNT (*) : 제일 많이 사용 / NULL을 포함한 모든 (전체) 행 개수 반환
-- COUNT (컬럼) : 해당 컬럼에서 NULL값을 제외한 행 개수 반환
-- COUNT (DISTINCT 컬럼명) : 중복을 제거한 행 개수 반환 + NULL 제외

-- EMPLOYEE 테이블에서 
-- 모든 사원의 수, 부서 코드가 있는 사원의 수, 사원이 속한 부서의 수 조회

SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 부서코드가 'D5'인 사원의 수 ----------------------------------------------------------------------------------------------------------------------

SELECT COUNT (DEPT_CODE) 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

------------------------------------------------------------------------------------------------------------------]

-- 실습 문제

-- 1. 직원들의 입사일로부터 년도만 가지고, 각 년도별 입사인원수를 구하시오.
--  아래의 년도에 입사한 인원수를 조회하시오.
--  => TO_CHAR, DECODE, SUM 또는 COUNT 사용
--	-------------------------------------------------------------
--	전체직원수   2001년   2002년   2003년   2004년

SELECT COUNT(EMP_NAME) AS "전체 직원수"
           COUNT(SUBSTR(HIRE_DATE, 1, 2)='01') AS "2001년",  
           COUNT(SUBSTR(HIRE_DATE, 1, 2)='02') AS "2002년",  
           COUNT(SUBSTR(HIRE_DATE, 1, 2)='03') AS "2003년",
           COUNT(SUBSTR(HIRE_DATE, 1, 2)='04') AS "2004년"
FROM EMPLOYEE;

-- 는 실행이 안됐고 (내가 한 것)

SELECT 
    COUNT(*) AS 전체직원수,
    -- COUNT(CASE WHEN EXTRACT(YEAR FROM HIRE_DATE) = '2001' THEN '2001년' END)
    COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2001', 1)) AS "2001년",
    COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2002', 1)) AS "2002년",
    COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2003', 1)) AS "2003년",
    COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2004', 1)) AS "2004년"
    -- COUNT 없이 숫자를 세려면 SUM을 쓰는데 NVL도 넣어야 한다
FROM EMPLOYEE;


--2.  부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.
--   단, 부서코드가 D5, D6, D9 인 직원의 사원명, 부서코드, 부서명 조회함

SELECT EMP_NAME, DEPT_CODE, 
    CASE WHEN DEPT_CODE = 'D5' THEN '총무부'
            WHEN DEPT_CODE = 'D6' THEN '기획부'
            WHEN DEPT_CODE = 'D9' THEN '영업부'
    END AS "부서명"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D6' OR DEPT_CODE= 'D9';

-- OR

SELECT EMP_NAME, DEPT_CODE,
    DECODE (DEPT_CODE, 'D5', '총무부',
                                    'D6', '기획부',
                                    'D9', '영업부') AS 부서명
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D6', 'D9');


