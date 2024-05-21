-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기
select * from post inner join author on author.id=post.author_id;
select * from author a inner join post p on a.id=p.author_id;
-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
select p.id, p.title, p.contents, a.email from post p inner join author a on p.author_id=a.id;

-- 모든 글 목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력 (p 다 나오게 하고 시프면 p.* 하면 됨)
select p.id, p.title, p.contents, a.email from post p left outer join author a on p.author_id = a.id;

-- join된 상황에서 where 조건 : on뒤에 where 조건이 나옴
-- 1) 글쓴이가 있는 글 중에 글의 title과 저자의 email을 출력, 저자의 나이는 25세 이상만
select p.title, a.email from post p inner join author a on p.author_id=a.id where a.age >=25;
-- 2) 모든 글 목록 중에 글의 title과 저자가 있다면 email을 출력,2020-05-01 이후에 만들어진 글만 출력
select p.title, ifnull(a.email) from post p left join author a on a.id=p.author_id where p.title is not null and p.created_time >='2020-05-01';

-- 조건에 맞는 도서와 저자 리스트 출력
SELECT b.BOOK_ID, a.AUTHOR_NAME, date_format(b.PUBLISHED_DATE,'%Y-%m-%d') PUBLISHED_DATE from BOOK b inner join AUTHOR a on a.AUTHOR_ID = b.AUTHOR_ID where b.CATEGORY='경제' order by b.PUBLISHED_DATE asc

-- union : 중복제외한 두 테이블의 select를 결합
-- 컬럼의 개수와 타입이 같아야함에 유의
-- union all : 중복포함
select 컬럼1, 컬럼2 from table1 union select 컬럼1, 컬럼2 from table2;
-- author 테이블의 name, email 그리고 post테이블의 title, contents union
select name, email from author union select title, contents from post;

-- 유지보수성 : 서비스를 유지하고, 서비스를 고치고
-- 코드의 간결성과 직관성이 필요 for 유지보수성

-- 서브쿼리 : select문 안에 또다른 select문을 서브쿼리라 한다.
-- select절 안에 서브쿼리
-- author email과 해당 author가 쓴 글의 개수를 출력
select a.email, (select count(*) from post p where p.author_id= a.id ) as count from author a;
-- 이거 많이 씀

-- from절 안에 서브쿼리
select a.name from (select * from author) as a;

-- where절 안에 서브쿼리
select a.* from author a inner join post p on a.id=p.author_id;
select * from author where id in (select author_id from post);
-- 이거도 많이 씀

-- 없어진 기록 찾기 문제 : join으로 풀 수 있는 문제, 서브쿼리로도 풀어보면 좋을 것
-- join
select AO.ANIMAL_ID, AO.NAME from ANIMAL_OUTS AO LEFT JOIN ANIMAL_INS AI on AO.ANIMAL_ID = AI.ANIMAL_ID
where AI.ANIMAL_ID is null order by AO.ANIMAL_ID;
-- 서브쿼리
select ANIMAL_ID, NAME from ANIMAL_OUTS WHERE ANIMAL_ID NOT IN(SELECT ANIMAL_ID FROM ANIMAL_INS) order by ANIMAL_ID;

-- 집계 합수
SELECT COUNT(*) from author;
select sum(price) from post;
select round(avg(price),0) from post;
-- count(a.id)랑 count(*) 같은 거!

-- group by와 집계 함수
select author_id from post group by author_id;
select author_id, count(*) from post group by author_id;
select author_id, count(*), sum(price), round(avg(price),0) min(price),max(price) from post group by author_id;

-- 저자 email, 해당 저자가 작성한 글 수를 출력
-- inner join? left join?
select a.id, if(p.id is null, 0, count(a.id)) from author a left join post p on a.id = p.author_id group by a.id;

-- where와 group by
-- 연도별 post 글 출력, 연도가 null인 데이터는 제외
select 연도, count(*) from where group by 연도; 이 구조로 할 것
select date_format(created_time,"%Y"), count(*) from post where created_time is not null group by date_format(created_time,"%Y");
select date_format(created_time,"%Y") as year, count(*) from post where created_time is not null group by year;

-- 자동차 종류별 특정 옵션이 포함된 자동차 수 구하기
SELECT CAR_TYPE, count(*) as CARS FROM CAR_RENTAL_COMPANY_CAR
WHERE OPTIONS like '%통풍시트%' OR OPTIONS like '%열선시트%' OR OPTIONS like '%가죽시트%'
GROUP BY CAR_TYPE ORDER BY CAR_TYPE;

-- 입양 시각 구하기(1)
SELECT CAST(DATE_FORMAT(DATETIME,"%H") AS unsigned) AS HOUR, COUNT(*) FROM ANIMAL_OUTS
WHERE DATE_FORMAT(DATETIME,'%H:%i') BETWEEN '09:00' AND '19:59'
GROUP BY HOUR
ORDER BY HOUR;

-- HAVING : group by를 통해 나온 통계에 대한 조건
select author_id, count(*) from post group by author_id;
-- 글을 2개 이상 쓴 사람에 대한 통계 정보
select author_id, count(*) from post group by author_id having count>=2;
-- (실습) 포스팅 price가 2000원 이상인 글을 대상으로, 
-- 작성자별로 몇건인지와, 평균 price를 구하되, 
-- 평균 price가 3000원 이상인 데이터를 대상으로만 통계 출력
select author_id, count(*), avg(price) as avg_price from post where price>=2000 group by author_id having avg_price>=3000;

-- 동명 동물 수 찾기
SELECT NAME, count(*) as COUNT from ANIMAL_INS WHERE NAME is not null GROUP BY NAME having COUNT >= 2 ORDER BY NAME;

-- (실습) 2건 이상의 글을 쓴 사람의 email, count값을 구할건데, 
-- 나이는 25세 이상인 사람만 통계에 사용하고,
-- 가장 나이 많은 사람 1명의 통계만 출력
select a.id, count(a.id) as count from author a inner join post p
on a.id=p.author_id 
where a.age >= 25
group by a.id
having count >= 2 order by max(a.age) limit 1;

-- 다중열 group by
select author_id, title, count(*) from post group by author_id,title;

-- 재구매가 일어난 상품과 회원 리스트 구하기