mvn install:install-file -Dfile=ojdbc6.jar -DartifactId=ojdbc6 -DgroupId=com.oracle -Dversion=11.2.0 -Dpackaging=jar

select * from DEPT;
select * from EMP;
select * from BONUS;
select * from SALGRADE;
--
-- Inner Join 1
--
select *
  from dept inner join emp
    on dept.deptno=emp.deptno;
--
-- Inner Join 2. 
--  
select * 
  from dept, emp
 where DEPT.deptno=emp.deptno;
 
--원하는 col만 지정, sort 추가
 select dept.deptno, dept.dname, emp.ename, emp.hiredate
  from dept inner join emp
    on dept.deptno=emp.deptno
 order by dept.deptno asc;
   
--별칭 지정
 select d.deptno, d.dname, e.ename, e.hiredate
  from dept d, emp e
 where d.deptno=e.deptno
 order by d.deptno desc;
 --
 -- Left Outer Join
 --
 select d.deptno, d.dname, e.ename, e.hiredate
   from dept d left outer join emp e
     on d.deptno=e.deptno;
 --
 --1.emp에 직원 추가
 --empno = 8000
 --ename = 홍길동
 --job = developer
 -- ...
 --deptno = 80
 --dname = 총무부
 --dloc = 서울
 insert into DEPT (deptno, dname, loc)
  values (80, '총무부', '서울');
 insert into emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
  values (7901, '홍길동','developer', 7900,null,2000,null,80);
 --2.dept정보를 수정 update
 --deptno = 20 인 
 --dname = 개발부 로 수정
 --loc = 부산
 update dept 
 	set dname='개발부', loc='부산' 
  where deptno = 20;
 --3.직원정보 삭제 delete
 --empno >= 7300 and empno <=7600 인
 delete from emp 
  where empno >= 7300 and empno <=7600;
 --4.부서별 직원정보 출력(단 모든 부서를 출력)
 select e.empno, e.ename, e.job, e.mgr, e.sal, e.comm, e.deptno
   from emp e right outer join dept d
     on e.deptno=d.deptno;
commit   
rollback
select*from emp where empno=9110;
select*from emp;
insert into emp
(
	empno,
	ename,
	job,
	mgr,
	hiredate,
	sal,
	deptno
)
values
(
	'9500',
	'홍길동2',
	'mana''xxx''',
	7000,
	'2015/09/10',
	300.2,
	10
);

--
--
-- test
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
/*
 * City
 */
drop table city;

create table city (
	id 			numeric(11) not null,
	name 		char(35) 	default '',
	countrycode char(3) 	default '',
	district 	char(20) 	default '',
	population 	numeric(11) default 0,
	constraint pk_city primary key (id),
	constraint fk_country foreign key (countrycode) references country(code)   
	);
	
/*
 * Country
 */	
drop table country;
create table country (
	code 			char(3) 		default '',
	name 			char(52) 		default '',
	continent 		char(20) 		default 'Asia',
	region 			char(26)  		default '',
	surfacearea		numeric(10,2) 	default '0.00',
	indepyear 		numeric(6) 		default null,
	population 		numeric(11) 	de                      fault 0,
	lifeexpectancy 	numeric(3,1) 	default null,
	gnp 			numeric(10,2) 	default null,
	gnpold 			numeric(10,2) 	default null,
	localname 		char(45) 		default '',
	governmentform 	char(45) 		default '',
	headofstate		char(60) 		default null,
	capital			numeric(11) 	default null,
	code2 			char(2) 		default '',
	constraint ck_continent check (continent in ('Asia','Europe','North America','Africa','Oceania','Antarctica','South America')),
	constraint pk_country primary key (code)
);

select * from country;
select * from city;
/*
 * CountryLanguage
 */
drop table countrylanguage;
create table countrylanguage (
  countrycode 	char(3) 		default '',
  language 		char(30)		default '',
  isofficial 	char(1) 		default 'f',
  percentage 	numeric(4,1) 	default '0.0',
  constraint ck_isofficial check (isofficial in ('t','f')),
  constraint pk_countrylanguage primary key (countrycode,language)
) ;

create table filelist (
	fname 			varchar(50) primary key,
	flength			numeric(10),
	flast_modified	date,
	image			blob
);

delete  from dept where deptno = 1;
select * from dept;

update DEPT 
   set dname='PPPP', 
       loc='JJJJJ' 
 where deptno =11;
 
 /*
  * Member Table 생성
  */
 select * from member;
 drop table member;
 create table member (
 	id			int not null,
 	email		varchar(64) not null,
 	password	varchar(64) not null,
 	name		varchar(12) not null,
 	regdate		timestamp not null,
 	constraint member_pk primary key(id, email),
 	constraint member_id_uq unique (id),
 	constraint member_email_uq unique (email)
 );
 
 select * from member2;
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
 
 
 /*
  * sequence: 번호를 발급하는 기능. 채번, 발번
  */
 drop sequence member_id_seq;
 create sequence member_id_seq
 start with 1000;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
 select member_id_seq.nextval from dual;
 select member_id_seq.currval from dual;
 
 select * from member; 
 insert into member
 (id, email, password, name, regdate)
 values
 (1002, 'xxxx', 'yyyy','zz''z','2015/08/11');
 
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
 
 /*
  * update 고려사항
  */
select * from member; 
update member
   set email    = null,
       password = 'qwer1234',
 	   name	    = null,
 	   regdate  = null
 where id	    = 1040;
 
 update member
   set password = 'qwer1234'
 where id	    = 1040;
 
  update member
   set name = '피닉스'
 where id	    = 1040;
 
 /*
  * Pagination
  */
select outer.rn,
	   outer.id,
	   outer.email,
	   outer.password,
	   outer.name,
	   outer.regdate 
  from (select rownum rn, inner.*
	      from (select m.* 
	              from member m
	             order by m.id desc
	           ) inner
	   ) outer
  where outer.rn >= 11
    and outer.rn <= 20
        
select rownum, e.*
  from emp e
 order by e.ename
	  ) inner
