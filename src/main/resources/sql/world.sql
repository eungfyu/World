select * from city;
select count(*) from city;
select * from country;
select * from countrylanguage;
select * from dept;
select * from emp;
-- char(10) 무조건 10자리. 넘으면 에러. 자릿수 제한 255max
-- varchar(10) 한자리 넣으면 한자리만 할당. 자릿수 제한 255max
-- longvarchar(1000) DB마다 다름. oracle일 경우 long, mysql은 text, mediumtext
-- clob 대량의 데이타. DB마다 다름. oracle일 경우 clob, mysql은 longtext. 속도면에서는 떨어짐

-- numeric(10, 2) 정수, 실수 가능. 저장방식에 차이가 있다.
-- decima(10, 2)

-- Timestamp(날짜, 시각) 오라클일 경우 date, mysql은 datetime
-- Date(날짜)
-- Time(시각)

-- blob 오라클일 경우 blob, mysql은 blob, mediumblob, longblob 크기에 따라 나뉨

--
-- dept
-- 
drop table dept ;
create table dept(
	deptno numeric(2) not null,
	dname varchar(14) ,
	loc varchar(13),
	constraint pk_dept primary key(deptno)
) engine=InnoDB default charset=utf8;

delete from dept;
--
-- emp
--
drop table emp;
create table emp(
	empno numeric(4) not null,
	ename varchar(10),
	job varchar(9),
	mgr numeric(4),
	hiredate datetime,
	sal numeric(7,2),
	comm numeric(7,2),
	deptno numeric(2),	
	constraint pk_emp primary key(empno),
	constraint fk_deptno foreign key (deptno) references dept(deptno)
) engine=InnoDB default charset=utf8;



--
-- bonus
--
drop table bonus;
create table bonus(
	ename varchar(10)	,
	job varchar(9)  ,
	sal numeric,
	comm numeric
) engine=InnoDB default charset=utf8;

--
-- salgrade
--
drop table salgrade;
create table salgrade( 
	grade numeric,
	losal numeric,
	hisal numeric 
) engine=InnoDB default charset=utf8;


select*from dept;

insert into emp
(
	empno,
	ename,
	job
)
values
(
	1000,
	'홍길22',
	'test'
);

drop table city;

create table city (
	id int(11) not null auto_increment,
	name char(35) not null default '',
	countrycode char(3) not null default '',
	district char(20) not null default '',
	population int(11) not null default '0',
	primary key (id)
	) ;
--
--	
create table city (
	id numeric(11) not null,
	name char(35) default '',
	countrycode char(3) default '',
	district char(20) default '',
	population numeric(11) default 0,
	primary key (id)
	) ;

-- totalItem
select count(*) from city;

--limit start, count==>start 0,1,2...

--? start ==>firstItem -1
--? count ==>lastItem - firstItem+1

--1 page : 1-10 ==> db에서는 0-9까지
select * from city	limit 0, 10;
--2 page : 11-20 ==> db에서는 10-19까지
select * from city	limit 10, 19;

create table filelist (
	fname 			varchar(50) primary key,
	flength			numeric(10),
	flast_modified	datetime,
	image			longblob
);

drop table filelist;

select*from filelist;

/*
 * Member Table 생성
 * email xxx@xxx.com형식으로 검증(regex)
 * password  영문 & 숫자 & 6자리 이상 & 3자리이상 반복 안됨 이어야 하는 제약사항 검.
 * 			 암호화필요==> MD5 혹은 SHA-256 방식 : 단방향, 복호화가 안되는 방식
 */

select*from member;
drop table member;
create table member (
 	id			int not null auto_increment,
 	email		varchar(64) not null,
 	password	varchar(64) not null,
 	name		varchar(12) not null,
 	regdate		timestamp not null,
 	constraint member_pk primary key(id, email),
 	constraint member_id_uq unique (id),
 	constraint member_email_uq unique (email)
 );
 
alter table member auto_increment=1000;
  
 insert into member
 (email, password, name, regdate)
 values
 ('xxxx', 'yyyy','zzz','2015/08/11');

 select last_insert_id();
 /*
  * id generator
  * nextval 시작값
  * incval 증가하기위한 범위
  */
 select * from id_generator;
 drop table id_generator;
 create table id_generator (
 	name		varchar(20) not null primary key,
 	nextval		numeric(10) not null,
 	incval		numeric(5) not null
 );
 
 insert into id_generator 
 (name, nextval, incval)
 values
 ('memberId',10000, 100 );
 
drop table member2;
create table member2 (
 	id			int not null,
 	email		varchar(64) not null,
 	password	varchar(64) not null,
 	name		varchar(12) not null,
 	regdate		timestamp not null,
 	constraint member2_pk primary key(id, email),
 	constraint member2_id_uq unique (id),
 	constraint member2_email_uq unique (email)
 );
 
 alter table member2 auto_increment=1000;
 
 select * from member2;
 
 insert into member2
 (email, password, name, regdate)
 values
 ('xxxx', 'yyyy','zzz','2015/08/11');
 
 /*
  * Pagination
  */
 select *
   from city
  where countrycode = 'KOR'
  order by name
  limit 10, 10;
  
/*
 * District 분석
 * 
 */
select *
  from city
 where countrycode ='KOR'
 
select distinct district
  from city
 where countrycode ='KOR'
 
select code, name
  from country
 