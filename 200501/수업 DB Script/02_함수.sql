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

-- SUBSTR 










