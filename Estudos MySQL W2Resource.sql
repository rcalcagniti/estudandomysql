#exercicios: https://www-w3resource-com.translate.goog/mysql-exercises/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=pt&_x_tr_pto=tc
-- base dos exercicios: https://www-w3resource-com.translate.goog/mysql-exercises/create-table-exercises/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=pt&_x_tr_pto=tc

-- Criar tabela chamada "countries" 

CREATE TABLE w3resources_exercises.countries(
    -- Coluna com codigo do pais
    COUNTRY_ID varchar(2),

    -- Coluna com nome do pais
    COUNTRY_NAME varchar(40),

    -- Coluna com codigo do pais com precisao decimal de 10,0 (pode ter até 10 caracteres, e nenhum decimal)
    REGION_ID decimal(10,0)
);

Select *
from w3resources_exercises.countries;

-- cria a tabela caso ja nao existe
CREATE TABLE IF NOT EXISTS w3resources_exercises.countries(
    COUNTRY_ID varchar(2),
    COUNTRY_NAME varchar(40),
    REGION_ID decimal(10,0)
); # vai retornar que ja existe uma tabela, porque foi criada anteriormente

-- criar uma tabela copia / tabela staging
CREATE table if not exists w3resources_exercises.countries_staging
LIKE w3resources_exercises.countries;

Select *
from w3resources_exercises.countries_staging;

-- criar uma tabela copia com todos os dados da orignal
CREATE table if not exists w3resources_exercises.countries_staging2
AS SELECT * FROM w3resources_exercises.countries_staging;

Select *
from w3resources_exercises.countries_staging;

-- criar uma tabela com restriçao para nao ter NULL
CREATE TABLE IF NOT EXISTS w3resources_exercises.countries_no_null(
    COUNTRY_ID varchar(2) NOT NULL,
    COUNTRY_NAME varchar(40) NOT NULL,
    REGION_ID decimal(10,0) NOT NULL
);

select*
from w3resources_exercises.countries_no_null; 

-- crie uma tabela chamada JOBS, com as colunas: job_id, job_title, min_salary, max_salary e verifique se max_salary nao é maior que 25000
CREATE TABLE IF NOT EXISTS w3resources_exercises.job(
    JOB_ID varchar(2) NOT NULL,
    JOB_TITLE varchar(40) NOT NULL,
    MIN_SALARY decimal(6,0),
    MAX_SALARY decimal (6,0),
    CHECK (MAX_SALARY <= 25000) #CHECK bloqueia que valores acima de 25000 sejam adicionados
);

SELECT *
FROM w3resources_exercises.job;

-- cria uma tabela chama countries, com as colunas: country_id, country_name and region_id e verifique se os paises adicionados sejam apenas: Italy, India e China

create table if not exists w3resources_exercises.countries_limited(
COUNTRY_ID varchar(2),
COUNTRY_NAME varchar(40),
	CHECK (COUNTRY_NAME IN ('Italy', 'China', 'India')),
REGION_ID decimal(10,0)
);

select *
from w3resources_exercises.countries_limited;

-- cria uma tabela chamada job_histry, com as colunas: employee_id, start_date, end_date, job_id and department_id e tenha certeza que end_date tenha formato de data ('--/--/----')

CREATE TABLE IF NOT EXISTS w3resources_exercises.job_histry(
    EMPLOYEE_ID varchar(2) NOT NULL,
    JOB_ID varchar(2) NOT NULL,
    DEPARTMENT_ID varchar(2) NOT NULL,
    start_date date, #date vai ter o formato YYYY-MM-DD
    end_date date
		Check (end_date like '--/--/----')
);

select *
from w3resources_exercises.job_histry;

-- criar uma tablea com nome countries_, com as colunas: country_id,country_name e region_id e que bloqueie a entrada de dados duplicados em countri_id
create table if not exists w3resources_exercises.countries_no_duplicated_id(
COUNTRY_ID varchar(2),
COUNTRY_NAME varchar(40),
	CHECK (COUNTRY_NAME IN ('Italy', 'China', 'India')),
REGION_ID decimal(10,0),
UNIQUE (country_id) #bloqueia a entrada de valores iguais
);

select *
from w3resources_exercises.countries_no_duplicated_id;

-- cria uma tabela jobs_default_values, com as colunas:   columns job_id, job_title, min_salary e max_salary - no uqal job_title tenha como default BLANK, o min_salary seja 8000 e o max_salary seja NULL
CREATE TABLE IF NOT EXISTS w3resources_exercises.job_default_values(
    JOB_ID varchar(2) NOT NULL UNIQUE, #unique garante que nao vai ter dois IDs iguais
    JOB_TITLE varchar(40) NOT NULL DEFAULT '',
    MIN_SALARY decimal(6,0) DEFAULT '8000',
    MAX_SALARY decimal (6,0) DEFAULT NULL
    );

INSERT INTO w3resources_exercises.job_default_values (JOB_ID)
VALUE (1);

select *
from w3resources_exercises.job_default_values;

-- crie uma tabela countried_auto_increment, com as colunas: country_id, country_name e region_id - no qual countri_id seja unico e com tenha o proprio increment key
create table if not exists w3resources_exercises.countries_auto_increment(
COUNTRY_ID integer NOT NULL UNIQUE auto_increment primary key,
COUNTRY_NAME varchar(40),
	CHECK (COUNTRY_NAME IN ('Italy', 'China', 'India')),
REGION_ID decimal(10,0)
);

INSERT INTO w3resources_exercises.countries_auto_increment (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
VALUES (2, 'Italy', 12);


INSERT INTO w3resources_exercises.countries_auto_increment (COUNTRY_NAME, REGION_ID)
VALUES ('China', 13); #aqui vai auto preencher o country_id, mesmo eu nao colocando nada

select *
from w3resources_exercises.countries_auto_increment;

-- crie uma tabela country_unique, com as colunas: country_id, country_name e region_id - no qual a combinaçao de country_id e region_id seja unica (nao repete)
create table if not exists w3resources_exercises.country_unique(
COUNTRY_ID varchar(2) NOT NULL DEFAULT '',
COUNTRY_NAME varchar(40),
	CHECK (COUNTRY_NAME IN ('Italy', 'China', 'India')),
REGION_ID decimal(10,0),
primary key (country_id, REGION_ID) 
);


#exercicios de mudar os dados nas tabelas
-- base dos exercicios de modificar dados de uma tabela: https://www.w3resource.com/mysql-exercises/alter-table-statement/


-- mude o nome da tabela de countries para countries_new
ALTER TABLE w3resources_exercises.countries 
RENAME w3resources_exercises.countries_new;

select *
from w3resources_exercises.countries_new;

-- adicione a coluna region_id a tabela tabela de location (precisa primeiro criar a tabela)
create table if not exists w3resources_exercises.location(
LOCATION_ID decimal (4,0) DEFAULT NULL,
STREET_ADDRESS varchar (40) DEFAULT NULL,
POSTAL_CODE varchar(12) DEFAULT NULL,
CITY varchar (30) DEFAULT NULL,
STATE_PROVINCE varchar (25) DEFAULT NULL,
COUNTRY_ID varchar(2) DEFAULT NULL
);

select *
from w3resources_exercises.location;

ALTER TABLE w3resources_exercises.location
ADD REGION_ID INT;

select *
from w3resources_exercises.location;

-- agora adicione IDs como uma nova coluna, mas no inicio da tabela (nao no final)
ALTER TABLE w3resources_exercises.location
ADD ID INT FIRST;

select *
from w3resources_exercises.location;

-- adicione uma nova coluna depois de state_province
ALTER TABLE w3resources_exercises.location
ADD REGION_ID2 INT 
AFTER STATE_PROVINCE;

select *
from w3resources_exercises.location;

-- mude o tipo de coluna de country_id para um integer
ALTER TABLE  w3resources_exercises.location
MODIFY COUNTRY_ID INT;

select *
from  w3resources_exercises.location;

-- remover/excluir a coluna region_id2 de location
ALTER TABLE w3resources_exercises.location
DROP REGION_ID2;

select *
from  w3resources_exercises.location;

-- mude o nome da coluna de state_province para state
ALTER TABLE w3resources_exercises.location
CHANGE STATE_PROVINCE STATE varchar(25);

select *
from  w3resources_exercises.location;

-- adicione primary key para location_id
INSERT INTO w3resources_exercises.location (ID, LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE, COUNTRY_ID)
VALUES (1, 1000, '1297 VIA COLA DI RIE', 989, 'ROMA', '', 'IT'),
(NULL, 1100, '93091 CALLE DELLA TE', 10934, 'VENICE', '', 'IT'),
(NULL, 1200, '2017 shinjuku-ku', 1689, 'TOKYO', 'TOKYO PREFECTU', 'JP')
;

select *
from  w3resources_exercises.location;

INSERT INTO w3resources_exercises.location (ID)
VALUES (4), (2), (3);

select *
from  w3resources_exercises.location;

ALTER TABLE w3resources_exercises.location
ADD PRIMARY KEY (ID);

## Exercicios de insert
-- base dos exercicios: https://www.w3resource.com/mysql-exercises/insert-into-statement/


-- adicionar valores a tablea countries_new
INSERT INTO w3resources_exercises.countries_new
VALUES ('C1', 'India', 1001);

select *
from w3resources_exercises.countries_new;

-- escreva uma query para adicionar uma linha com valores especificamente para country_id e country_name

INSERT INTO w3resources_exercises.countries_new (COUNTRY_ID, COUNTRY_NAME)
VALUES ('C2', 'INDIA');

select *
from w3resources_exercises.countries_new;

-- duplique a tabela countries_new com todos os dados

CREATE TABLE IF NOT EXISTS w3resources_exercises.countries_new2
AS SELECT * FROM w3resources_exercises.countries_new;

select *
from w3resources_exercises.countries_new2;

-- coloque NULL nos valores de region_id
INSERT INTO w3resources_exercises.countries_new
VALUES ('C3', 'Italia', NULL);

select *
from w3resources_exercises.countries_new;

-- adicione 3 valores a tabela em um unico query
INSERT INTO w3resources_exercises.countries_new
VALUES ('C4', 'Italia', 1005),
('C5', 'Italia', 1007),
('C6', 'Italia', 1008);

select *
from w3resources_exercises.countries_new;

-- adicione os novos valores de countries_new para countries_new2
INSERT INTO w3resources_exercises.countries_new2
SELECT * FROM w3resources_exercises.countries_new;

select *
from w3resources_exercises.countries_new2;  #obs: os valores que ja estavam la, ficam duplicados

-- crie uma tabela de jobs com job_id, job_title e min_salary tendo job_id como valor unico - e coloque valores na tabela
CREATE TABLE IF NOT EXISTS w3resources_exercises.jobs_new ( 
JOB_ID integer NOT NULL UNIQUE , 
JOB_TITLE varchar(35) NOT NULL, 
MIN_SALARY decimal(6,0)
);

INSERT INTO w3resources_exercises.jobs_new 
VALUES(1001, 'OFFICER', 8000);

select *
from w3resources_exercises.jobs_new;

INSERT INTO w3resources_exercises.jobs_new 
VALUES(1001, 'OFFICER2', 8002); #gera erro porque o job_id está repetido

-- cria uma nova tabela de jobs com job-id como unique primary key que é gerada sozinha

CREATE TABLE IF NOT EXISTS w3resources_exercises.jobs_unique ( 
JOB_ID integer NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY, 
JOB_TITLE varchar(35) NOT NULL, 
MIN_SALARY decimal(6,0)
);

INSERT INTO w3resources_exercises.jobs_unique (JOB_TITLE, MIN_SALARY)
VALUES('OFFICER', 8000),
('INDUSTRY', 5000);

select *
from w3resources_exercises.jobs_unique; #job_id foi gerado a partir de 1, deu certo

## Exercicios de update
-- base dos exercicios: https://www.w3resource.com/mysql-exercises/update-table-statement/index.php

-- criando as tabelas antes de fazer os exercicios:
DROP TABLE IF EXISTS w3resources_exercises.regions_final;
CREATE TABLE w3resources_exercises.regions_final (
 REGION_ID decimal(5,0) NOT NULL PRIMARY KEY,
  REGION_NAME varchar(25) DEFAULT NULL
);


DROP TABLE IF EXISTS w3resources_exercises.countries_final;
CREATE TABLE w3resources_exercises.countries_final    (
  COUNTRY_ID varchar(2) NOT NULL,
  COUNTRY_NAME varchar(40) DEFAULT NULL,
  REGION_ID decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (COUNTRY_ID),
  KEY COUNTR_REG_FK (REGION_ID)
) ;


DROP TABLE IF EXISTS w3resources_exercises.locations_final;
CREATE TABLE w3resources_exercises.locations_final (
  LOCATION_ID decimal(4,0) NOT NULL DEFAULT 0,
  STREET_ADDRESS varchar(40) DEFAULT NULL,
  POSTAL_CODE varchar(12) DEFAULT NULL,
  CITY varchar(30) NOT NULL,
  STATE_PROVINCE varchar(25) DEFAULT NULL,
  COUNTRY_ID varchar(2) DEFAULT NULL,
  PRIMARY KEY (LOCATION_ID),
  KEY LOC_CITY_IX (CITY),
  KEY LOC_COUNTRY_IX (COUNTRY_ID),
  KEY LOC_STATE_PROVINCE_IX (STATE_PROVINCE)
);


DROP TABLE IF EXISTS w3resources_exercises.jobs_final;
CREATE TABLE w3resources_exercises.jobs_final (
  JOB_ID varchar(10) NOT NULL DEFAULT '',
  JOB_TITLE varchar(35) NOT NULL,
  MIN_SALARY decimal(6,0) DEFAULT NULL,
  MAX_SALARY decimal(6,0) DEFAULT NULL,
  PRIMARY KEY (JOB_ID)
) ;


DROP TABLE IF EXISTS w3resources_exercises.job_history_final;
CREATE TABLE w3resources_exercises.job_history_final (
  EMPLOYEE_ID decimal(6,0) NOT NULL,
  START_DATE date NOT NULL,
  END_DATE date NOT NULL,
  JOB_ID varchar(10) NOT NULL,
  DEPARTMENT_ID decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (EMPLOYEE_ID,START_DATE),
  KEY JHIST_DEPARTMENT_IX (DEPARTMENT_ID),
  KEY JHIST_EMPLOYEE_IX (EMPLOYEE_ID),
  KEY JHIST_JOB_IX (JOB_ID)
);


DROP TABLE IF EXISTS w3resources_exercises.departments_final;
CREATE TABLE w3resources_exercises.departments_final (
  DEPARTMENT_ID decimal(4,0) NOT NULL DEFAULT '0',
  DEPARTMENT_NAME varchar(30) NOT NULL,
  MANAGER_ID decimal(6,0) DEFAULT NULL,
  LOCATION_ID decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (DEPARTMENT_ID),
  KEY DEPT_MGR_FK (MANAGER_ID),
  KEY DEPT_LOCATION_IX (LOCATION_ID)
);

DROP TABLE IF EXISTS w3resources_exercises.employees_final;
CREATE TABLE w3resources_exercises.employees_final (
 EMPLOYEE_ID decimal(6,0) NOT NULL DEFAULT '0',
 FIRST_NAME varchar(20) DEFAULT NULL,
 LAST_NAME varchar(25) NOT NULL,
 EMAIL varchar(25) NOT NULL,
 PHONE_NUMBER varchar(20) DEFAULT NULL,
 HIRE_DATE date NOT NULL,
 JOB_ID varchar(10) NOT NULL,
 SALARY decimal(8,2) DEFAULT NULL,
 COMMISSION_PCT decimal(2,2) DEFAULT NULL,
 MANAGER_ID decimal(6,0) DEFAULT NULL,
 DEPARTMENT_ID decimal(4,0) DEFAULT NULL,
 PRIMARY KEY (EMPLOYEE_ID),
 KEY EMP_DEPARTMENT_IX (DEPARTMENT_ID),
 KEY EMP_JOB_IX (JOB_ID),
 KEY EMP_MANAGER_IX (MANAGER_ID),
 KEY EMP_NAME_IX (LAST_NAME,FIRST_NAME)
);


INSERT INTO w3resources_exercises.regions_final VALUES (1,'Europe\r'),(2,'Americas\r'),(3,'Asia\r'),(4,'Middle East and Africa\r');

INSERT INTO w3resources_exercises.countries_final VALUES ('AR','Argentina',2),
('AU','Australia',3),
('BE','Belgium',1),
('BR','Brazil',2),
('CA','Canada',2),
('CH','Switzerland',1),
('CN','China',3),
('DE','Germany',1),
('DK','Denmark',1),
('EG','Egypt',4),
('FR','France',1),
('HK','HongKong',3),
('IL','Israel',4),
('IN','India',3),
('IT','Italy',1),
('JP','Japan',3),
('KW','Kuwait',4),
('MX','Mexico',2),
('NG','Nigeria',4),
('NL','Netherlands',1),
('SG','Singapore',3),
('UK','United Kingdom',1),
('US','United States of America',2),
('ZM','Zambia',4),('ZW','Zimbabwe',4);


INSERT INTO w3resources_exercises.locations_final VALUES (1000,'1297 Via Cola di Rie','989','Roma','','IT'),
(1100,'93091 Calle della Testa','10934','Venice','','IT'),
(1200,'2017 Shinjuku-ku','1689','Tokyo','Tokyo Prefecture','JP'),
(1300,'9450 Kamiya-cho','6823','Hiroshima','','JP'),
(1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US'),
(1500,'2011 Interiors Blvd','99236','South San Francisco','California','US'),
(1600,'2007 Zagora St','50090','South Brunswick','New Jersey','US'),
(1700,'2004 Charade Rd','98199','Seattle','Washington','US'),
(1800,'147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA'),
(1900,'6092 Boxwood St','YSW 9T2','Whitehorse','Yukon','CA'),
(2000,'40-5-12 Laogianggen','190518','Beijing','','CN'),
(2100,'1298 Vileparle (E)','490231','Bombay','Maharashtra','IN'),
(2200,'12-98 Victoria Street','2901','Sydney','New South Wales','AU'),
(2300,'198 Clementi North','540198','Singapore','','SG'),
(2400,'8204 Arthur St','','London','','UK'),
(2500,'Magdalen Centre',' The Oxford ','OX9 9ZB','Oxford','Ox'),
(2600,'9702 Chester Road','9629850293','Stretford','Manchester','UK'),
(2700,'Schwanthalerstr. 7031','80925','Munich','Bavaria','DE'),
(2800,'Rua Frei Caneca 1360','01307-002','Sao Paulo','Sao Paulo','BR'),
(2900,'20 Rue des Corps-Saints','1730','Geneva','Geneve','CH'),
(3000,'Murtenstrasse 921','3095','Bern','BE','CH'),
(3100,'Pieter Breughelstraat 837','3029SK','Utrecht','Utrecht','NL'),
(3200,'Mariano Escobedo 9991','11932','Mexico City','\"Distrito Federal','\"');

INSERT INTO w3resources_exercises.jobs_final VALUES ('AD_PRES','President',20000,40000),
('AD_VP','Administration Vice President',15000,30000),
('AD_ASST','Administration Assistant',3000,6000),
('FI_MGR','Finance Manager',8200,16000),
('FI_ACCOUNT','Accountant',4200,9000),
('AC_MGR','Accounting Manager',8200,16000),
('AC_ACCOUNT','Public Accountant',4200,9000),
('SA_MAN','Sales Manager',10000,20000),
('SA_REP','Sales Representative',6000,12000),
('PU_MAN','Purchasing Manager',8000,15000),
('PU_CLERK','Purchasing Clerk',2500,5500),
('ST_MAN','Stock Manager',5500,8500),
('ST_CLERK','Stock Clerk',2000,5000),
('SH_CLERK','Shipping Clerk',2500,5500),
('IT_PROG','Programmer',4000,10000),
('MK_MAN','Marketing Manager',9000,15000),
('MK_REP','Marketing Representative',4000,9000),
('HR_REP','Human Resources Representative',4000,9000),
('PR_REP','Public Relations Representative',4500,10500);

INSERT INTO w3resources_exercises.job_history_final 
VALUES (102,'1993-01-13','1998-07-24','IT_PROG',60),
(101,'1989-09-21','1993-10-27','AC_ACCOUNT',110),
(101,'1993-10-28','1997-03-15','AC_MGR',110),
(201,'1996-02-17','1999-12-19','MK_REP',20),
(114,'1998-03-24','1999-12-31','ST_CLERK',50),
(122,'1999-01-01','1999-12-31','ST_CLERK',50),
(200,'1987-09-17','1993-06-17','AD_ASST',90),
(176,'1998-03-24','1998-12-31','SA_REP',80),
(176,'1999-01-01','1999-12-31','SA_MAN',80),
(200,'1994-07-01','1998-12-31','AC_ACCOUNT',90);

INSERT INTO w3resources_exercises.departments_final VALUES (10,'Administration',200,1700),
(20,'Marketing',201,1800),(30,'Purchasing',114,1700),
(40,'Human Resources',203,2400),(50,'Shipping',121,1500),
(60,'IT',103,1400),(70,'Public Relations',204,2700),
(80,'Sales',145,2500),(90,'Executive',100,1700),
(100,'Finance',108,1700),(110,'Accounting',205,1700),
(120,'Treasury',0,1700),(130,'Corporate Tax',0,1700),
(140,'Control And Credit',0,1700),(150,'Shareholder Services',0,1700),
(160,'Benefits',0,1700),(170,'Manufacturing',0,1700),
(180,'Construction',0,1700),(190,'Contracting',0,1700),
(200,'Operations',0,1700),(210,'IT Support',0,1700),
(220,'NOC',0,1700),(230,'IT Helpdesk',0,1700),
(240,'Government Sales',0,1700),(250,'Retail Sales',0,1700),
(260,'Recruiting',0,1700),(270,'Payroll',0,1700);

INSERT INTO w3resources_exercises.employees_final VALUES (100,'Steven','King','SKING','515.123.4567','1987-06-17','AD_PRES',24000.00,0.00,0,90),
(101,'Neena','Kochhar','NKOCHHAR','515.123.4568','1987-06-18','AD_VP',17000.00,0.00,100,90),
(102,'Lex','De Haan','LDEHAAN','515.123.4569','1987-06-19','AD_VP',17000.00,0.00,100,90),
(103,'Alexander','Hunold','AHUNOLD','590.423.4567','1987-06-20','IT_PROG',9000.00,0.00,102,60),
(104,'Bruce','Ernst','BERNST','590.423.4568','1987-06-21','IT_PROG',6000.00,0.00,103,60);

-- faça com todos os dados da coluna "email" da planilha employees_final sejam 'not available'
UPDATE w3resources_exercises.employees_final
SET email = 'not available';

Select *
From w3resources_exercises.employees_final;

-- mude os dados de email e commission_pct da tabela employees_final para que sejam 'not available' e 0.1 para todos
UPDATE w3resources_exercises.employees_final
SET email = 'not available',
commission_pct = 0.1;

Select *
From w3resources_exercises.employees_final;

-- mude os dados de email e commission_pct da tabela employees_final para que sejam 'not available' e 0.05 para quem está no sdepartamento 60
UPDATE w3resources_exercises.employees_final
SET email = 'not available',
commission_pct = 0.05
WHERE department_id = 60;

Select *
From w3resources_exercises.employees_final;

-- mude os dados de email da tabela employees_final para que sejam 'N/A' para quem está no department 90 e comission_pct é menor que 0.2
UPDATE w3resources_exercises.employees_final
SET email = 'N/A'
WHERE department_id = 90 
AND commission_pct < 0.2;

Select *
From w3resources_exercises.employees_final;

-- mude os dados de email da tabela employees_final para que sejam 'N/A' para quem está no department Accounting 

Select *
from w3resources_exercises.departments_final; #accounting é department_id 110

UPDATE w3resources_exercises.employees_final
SET email = 'N/A2'
WHERE department_id = (
	select department_id
    from w3resources_exercises.departments_final
    where department_name = 'Accounting'
);

Select *
From w3resources_exercises.employees_final;

-- aumente o salario do funcionario com id 104 para 9000, se o salario atual for menor ou igual a 6000
UPDATE w3resources_exercises.employees_final
SET salary = 9000
WHERE employee_id = 104
AND salary <= 6000;

Select *
From w3resources_exercises.employees_final;

-- aumento o salario para quem esta no department_id 60 e 90, aumento 25% e 15% respectivamente
UPDATE w3resources_exercises.employees_final
SET salary = 
	CASE department_id
		WHEN 90 THEN salary*1.15
        WHEN 60 THEN salary*1.25
	END
Where department_id IN (60,90);

Select *
From w3resources_exercises.employees_final;

## Exercicios de alter table
-- link dos exercicios: https://www.w3resource.com/mysql-exercises/alter-table-statement/index.php

-- renome countries_new para country_new
ALTER TABLE w3resources_exercises.countries_new
RENAME w3resources_exercises.country_new;

## exercicios de window functions e CTE
-- link dos esecicios: https://www.w3resource.com/mysql-exercises/mysql-window-functions-and-cets_index.php

-- rankeie os funcionario de acordo com o salario de forma descendente
Select *,  #precisa dessa virgula no final, se nao, nao funciona
RANK () OVER (ORDER BY SALARY DESC) AS SalaryRank #rank precisa vir antes do FROM
FROM w3resources_exercises.employees_final;

-- separe os funcionario de acordo com departamento e os rankeie de acordo com salario
Select *,
RANK () OVER (Partition By DEPARTMENT_ID ORDER BY Salary Desc) As DeptSalaryRank
FROM w3resources_exercises.employees_final;

-- calcule a diferença de salario entre departamentos (a partir da media do salario de cada departamento)
Select *,
Salary - AVG(Salary) OVER (Partition By Department_ID) AS SalaryDifference #AVG(Salary) OVER (PARTITION BY DepartmentID) calcula a media de salario do departamento
FROM w3resources_exercises.employees_final;


##pausa nos exercicios para subir a planilha e corrigir o que precisa
-- link para tabela de sales: https://gist.github.com/denandreychuk/b9aa812f10e4b60368cff69c6384a210#file-100-sales-records-csv
-- vou arrumar a coluna de DATE para conseguirmos puxar os dados corretamente
Select *
FROM w3resources_exercises.sales;

Select STR_TO_DATE (Order_date, '%m/%d/%Y')
FROM w3resources_exercises.sales;

Update w3resources_exercises.sales
SET Order_date = STR_TO_DATE(Order_date, '%m/%d/%Y');

ALTER table w3resources_exercises.sales
modify COLUMN `Order_Date` DATE;


Select *
FROM w3resources_exercises.sales;

-- calcule o total de vendas de cada mes
Select *
FROM w3resources_exercises.sales;

Select Order_date, Total_Revenue, sum(Total_Revenue) OVER (ORDER BY Order_date) AS RunningTotal
FROM w3resources_exercises.sales;

-- calcule a media de vendas de cada mes
Select Order_date, Total_Revenue, sum(Total_Revenue) OVER (ORDER BY Order_date ROWS between 2 preceding AND current row) AS MovingAvg
FROM w3resources_exercises.sales;

-- encontre a primeira e ultima data de compra de cada regiao
Select Region, Sales_Channel, 
FIRST_VALUE(Order_date) OVER (partition by Sales_Channel ORDER BY Order_date) As FirstSaleDate,
LAST_VALUE(Order_date) OVER (partition by Sales_Channel Order By Order_Date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LastSaleDate
FROM w3resources_exercises.sales;

-- Calcule o percentual de vendas para cada Order_priority
Select Order_priority, Total_Revenue, Total_Revenue / sum(Total_Revenue) OVER () * 100 AS SalesPercentage
FROM w3resources_exercises.sales;


## Exercicios de JOIN
-- LINK dos exercicios: https://www.w3resource.com/mysql-exercises/join-exercises/index.php

-- vamos primeiro criar as tabelas que precisamos:
DROP TABLE IF EXISTS w3resources_exercises.countries_join;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.countries_join (
  `COUNTRY_ID` varchar(2) NOT NULL,
  `COUNTRY_NAME` varchar(40) DEFAULT NULL,
  `REGION_ID` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`COUNTRY_ID`),
  KEY `COUNTR_REG_FK` (`REGION_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.countries_join WRITE;
/*!40000 ALTER TABLE w3resources_exercises.countries_join DISABLE KEYS */;
INSERT INTO w3resources_exercises.countries_join VALUES ('AR','Argentina',2),('AU','Australia',3),('BE','Belgium',1),('BR','Brazil',2),('CA','Canada',2),('CH','Switzerland',1),('CN','China',3),('DE','Germany',1),('DK','Denmark',1),('EG','Egypt',4),('FR','France',1),('HK','HongKong',3),('IL','Israel',4),('IN','India',3),('IT','Italy',1),('JP','Japan',3),('KW','Kuwait',4),('MX','Mexico',2),('NG','Nigeria',4),('NL','Netherlands',1),('SG','Singapore',3),('UK','United Kingdom',1),('US','United States of America',2),('ZM','Zambia',4),('ZW','Zimbabwe',4);
/*!40000 ALTER TABLE w3resources_exercises.countries_join ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.departments_join;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.departments_join (
  `DEPARTMENT_ID` decimal(4,0) NOT NULL DEFAULT '0',
  `DEPARTMENT_NAME` varchar(30) NOT NULL,
  `MANAGER_ID` decimal(6,0) DEFAULT NULL,
  `LOCATION_ID` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`DEPARTMENT_ID`),
  KEY `DEPT_MGR_FK` (`MANAGER_ID`),
  KEY `DEPT_LOCATION_IX` (`LOCATION_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.departments_join WRITE;
/*!40000 ALTER TABLE w3resources_exercises.departments_join DISABLE KEYS */;
INSERT INTO w3resources_exercises.departments_join VALUES (10,'Administration',200,1700),(20,'Marketing',201,1800),(30,'Purchasing',114,1700),(40,'Human Resources',203,2400),(50,'Shipping',121,1500),(60,'IT',103,1400),(70,'Public Relations',204,2700),(80,'Sales',145,2500),(90,'Executive',100,1700),(100,'Finance',108,1700),(110,'Accounting',205,1700),(120,'Treasury',0,1700),(130,'Corporate Tax',0,1700),(140,'Control And Credit',0,1700),(150,'Shareholder Services',0,1700),(160,'Benefits',0,1700),(170,'Manufacturing',0,1700),(180,'Construction',0,1700),(190,'Contracting',0,1700),(200,'Operations',0,1700),(210,'IT Support',0,1700),(220,'NOC',0,1700),(230,'IT Helpdesk',0,1700),(240,'Government Sales',0,1700),(250,'Retail Sales',0,1700),(260,'Recruiting',0,1700),(270,'Payroll',0,1700);
/*!40000 ALTER TABLE w3resources_exercises.departments_join ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.employees_join;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.employees_join (
  `EMPLOYEE_ID` decimal(6,0) NOT NULL DEFAULT '0',
  `FIRST_NAME` varchar(20) DEFAULT NULL,
  `LAST_NAME` varchar(25) NOT NULL,
  `EMAIL` varchar(25) NOT NULL,
  `PHONE_NUMBER` varchar(20) DEFAULT NULL,
  `HIRE_DATE` date NOT NULL,
  `JOB_ID` varchar(10) NOT NULL,
  `SALARY` decimal(8,2) DEFAULT NULL,
  `COMMISSION_PCT` decimal(2,2) DEFAULT NULL,
  `MANAGER_ID` decimal(6,0) DEFAULT NULL,
  `DEPARTMENT_ID` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`),
  UNIQUE KEY `EMP_EMAIL_UK` (`EMAIL`),
  KEY `EMP_DEPARTMENT_IX` (`DEPARTMENT_ID`),
  KEY `EMP_JOB_IX` (`JOB_ID`),
  KEY `EMP_MANAGER_IX` (`MANAGER_ID`),
  KEY `EMP_NAME_IX` (`LAST_NAME`,`FIRST_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.employees_join WRITE;
/*!40000 ALTER TABLE w3resources_exercises.employees_join DISABLE KEYS */;
INSERT INTO w3resources_exercises.employees_join VALUES (100,'Steven','King','SKING','515.123.4567','1987-06-17','AD_PRES',24000.00,0.00,0,90),(101,'Neena','Kochhar','NKOCHHAR','515.123.4568','1987-06-18','AD_VP',17000.00,0.00,100,90),(102,'Lex','De Haan','LDEHAAN','515.123.4569','1987-06-19','AD_VP',17000.00,0.00,100,90),(103,'Alexander','Hunold','AHUNOLD','590.423.4567','1987-06-20','IT_PROG',9000.00,0.00,102,60),(104,'Bruce','Ernst','BERNST','590.423.4568','1987-06-21','IT_PROG',6000.00,0.00,103,60),(105,'David','Austin','DAUSTIN','590.423.4569','1987-06-22','IT_PROG',4800.00,0.00,103,60),(106,'Valli','Pataballa','VPATABAL','590.423.4560','1987-06-23','IT_PROG',4800.00,0.00,103,60),(107,'Diana','Lorentz','DLORENTZ','590.423.5567','1987-06-24','IT_PROG',4200.00,0.00,103,60),(108,'Nancy','Greenberg','NGREENBE','515.124.4569','1987-06-25','FI_MGR',12000.00,0.00,101,100),(109,'Daniel','Faviet','DFAVIET','515.124.4169','1987-06-26','FI_ACCOUNT',9000.00,0.00,108,100),(110,'John','Chen','JCHEN','515.124.4269','1987-06-27','FI_ACCOUNT',8200.00,0.00,108,100),(111,'Ismael','Sciarra','ISCIARRA','515.124.4369','1987-06-28','FI_ACCOUNT',7700.00,0.00,108,100),(112,'Jose Manuel','Urman','JMURMAN','515.124.4469','1987-06-29','FI_ACCOUNT',7800.00,0.00,108,100),(113,'Luis','Popp','LPOPP','515.124.4567','1987-06-30','FI_ACCOUNT',6900.00,0.00,108,100),(114,'Den','Raphaely','DRAPHEAL','515.127.4561','1987-07-01','PU_MAN',11000.00,0.00,100,30),(115,'Alexander','Khoo','AKHOO','515.127.4562','1987-07-02','PU_CLERK',3100.00,0.00,114,30),(116,'Shelli','Baida','SBAIDA','515.127.4563','1987-07-03','PU_CLERK',2900.00,0.00,114,30),(117,'Sigal','Tobias','STOBIAS','515.127.4564','1987-07-04','PU_CLERK',2800.00,0.00,114,30),(118,'Guy','Himuro','GHIMURO','515.127.4565','1987-07-05','PU_CLERK',2600.00,0.00,114,30),(119,'Karen','Colmenares','KCOLMENA','515.127.4566','1987-07-06','PU_CLERK',2500.00,0.00,114,30),(120,'Matthew','Weiss','MWEISS','650.123.1234','1987-07-07','ST_MAN',8000.00,0.00,100,50),(121,'Adam','Fripp','AFRIPP','650.123.2234','1987-07-08','ST_MAN',8200.00,0.00,100,50),(122,'Payam','Kaufling','PKAUFLIN','650.123.3234','1987-07-09','ST_MAN',7900.00,0.00,100,50),(123,'Shanta','Vollman','SVOLLMAN','650.123.4234','1987-07-10','ST_MAN',6500.00,0.00,100,50),(124,'Kevin','Mourgos','KMOURGOS','650.123.5234','1987-07-11','ST_MAN',5800.00,0.00,100,50),(125,'Julia','Nayer','JNAYER','650.124.1214','1987-07-12','ST_CLERK',3200.00,0.00,120,50),(126,'Irene','Mikkilineni','IMIKKILI','650.124.1224','1987-07-13','ST_CLERK',2700.00,0.00,120,50),(127,'James','Landry','JLANDRY','650.124.1334','1987-07-14','ST_CLERK',2400.00,0.00,120,50),(128,'Steven','Markle','SMARKLE','650.124.1434','1987-07-15','ST_CLERK',2200.00,0.00,120,50),(129,'Laura','Bissot','LBISSOT','650.124.5234','1987-07-16','ST_CLERK',3300.00,0.00,121,50),(130,'Mozhe','Atkinson','MATKINSO','650.124.6234','1987-07-17','ST_CLERK',2800.00,0.00,121,50),(131,'James','Marlow','JAMRLOW','650.124.7234','1987-07-18','ST_CLERK',2500.00,0.00,121,50),(132,'TJ','Olson','TJOLSON','650.124.8234','1987-07-19','ST_CLERK',2100.00,0.00,121,50),(133,'Jason','Mallin','JMALLIN','650.127.1934','1987-07-20','ST_CLERK',3300.00,0.00,122,50),(134,'Michael','Rogers','MROGERS','650.127.1834','1987-07-21','ST_CLERK',2900.00,0.00,122,50),(135,'Ki','Gee','KGEE','650.127.1734','1987-07-22','ST_CLERK',2400.00,0.00,122,50),(136,'Hazel','Philtanker','HPHILTAN','650.127.1634','1987-07-23','ST_CLERK',2200.00,0.00,122,50),(137,'Renske','Ladwig','RLADWIG','650.121.1234','1987-07-24','ST_CLERK',3600.00,0.00,123,50),(138,'Stephen','Stiles','SSTILES','650.121.2034','1987-07-25','ST_CLERK',3200.00,0.00,123,50),(139,'John','Seo','JSEO','650.121.2019','1987-07-26','ST_CLERK',2700.00,0.00,123,50),(140,'Joshua','Patel','JPATEL','650.121.1834','1987-07-27','ST_CLERK',2500.00,0.00,123,50),(141,'Trenna','Rajs','TRAJS','650.121.8009','1987-07-28','ST_CLERK',3500.00,0.00,124,50),(142,'Curtis','Davies','CDAVIES','650.121.2994','1987-07-29','ST_CLERK',3100.00,0.00,124,50),(143,'Randall','Matos','RMATOS','650.121.2874','1987-07-30','ST_CLERK',2600.00,0.00,124,50),(144,'Peter','Vargas','PVARGAS','650.121.2004','1987-07-31','ST_CLERK',2500.00,0.00,124,50),(145,'John','Russell','JRUSSEL','011.44.1344.429268','1987-08-01','SA_MAN',14000.00,0.40,100,80),(146,'Karen','Partners','KPARTNER','011.44.1344.467268','1987-08-02','SA_MAN',13500.00,0.30,100,80),(147,'Alberto','Errazuriz','AERRAZUR','011.44.1344.429278','1987-08-03','SA_MAN',12000.00,0.30,100,80),(148,'Gerald','Cambrault','GCAMBRAU','011.44.1344.619268','1987-08-04','SA_MAN',11000.00,0.30,100,80),(149,'Eleni','Zlotkey','EZLOTKEY','011.44.1344.429018','1987-08-05','SA_MAN',10500.00,0.20,100,80),(150,'Peter','Tucker','PTUCKER','011.44.1344.129268','1987-08-06','SA_REP',10000.00,0.30,145,80),(151,'David','Bernstein','DBERNSTE','011.44.1344.345268','1987-08-07','SA_REP',9500.00,0.25,145,80),(152,'Peter','Hall','PHALL','011.44.1344.478968','1987-08-08','SA_REP',9000.00,0.25,145,80),(153,'Christopher','Olsen','COLSEN','011.44.1344.498718','1987-08-09','SA_REP',8000.00,0.20,145,80),(154,'Nanette','Cambrault','NCAMBRAU','011.44.1344.987668','1987-08-10','SA_REP',7500.00,0.20,145,80),(155,'Oliver','Tuvault','OTUVAULT','011.44.1344.486508','1987-08-11','SA_REP',7000.00,0.15,145,80),(156,'Janette','King','JKING','011.44.1345.429268','1987-08-12','SA_REP',10000.00,0.35,146,80),(157,'Patrick','Sully','PSULLY','011.44.1345.929268','1987-08-13','SA_REP',9500.00,0.35,146,80),(158,'Allan','McEwen','AMCEWEN','011.44.1345.829268','1987-08-14','SA_REP',9000.00,0.35,146,80),(159,'Lindsey','Smith','LSMITH','011.44.1345.729268','1987-08-15','SA_REP',8000.00,0.30,146,80),(160,'Louise','Doran','LDORAN','011.44.1345.629268','1987-08-16','SA_REP',7500.00,0.30,146,80),(161,'Sarath','Sewall','SSEWALL','011.44.1345.529268','1987-08-17','SA_REP',7000.00,0.25,146,80),(162,'Clara','Vishney','CVISHNEY','011.44.1346.129268','1987-08-18','SA_REP',10500.00,0.25,147,80),(163,'Danielle','Greene','DGREENE','011.44.1346.229268','1987-08-19','SA_REP',9500.00,0.15,147,80),(164,'Mattea','Marvins','MMARVINS','011.44.1346.329268','1987-08-20','SA_REP',7200.00,0.10,147,80),(165,'David','Lee','DLEE','011.44.1346.529268','1987-08-21','SA_REP',6800.00,0.10,147,80),(166,'Sundar','Ande','SANDE','011.44.1346.629268','1987-08-22','SA_REP',6400.00,0.10,147,80),(167,'Amit','Banda','ABANDA','011.44.1346.729268','1987-08-23','SA_REP',6200.00,0.10,147,80),(168,'Lisa','Ozer','LOZER','011.44.1343.929268','1987-08-24','SA_REP',11500.00,0.25,148,80),(169,'Harrison','Bloom','HBLOOM','011.44.1343.829268','1987-08-25','SA_REP',10000.00,0.20,148,80),(170,'Tayler','Fox','TFOX','011.44.1343.729268','1987-08-26','SA_REP',9600.00,0.20,148,80),(171,'William','Smith','WSMITH','011.44.1343.629268','1987-08-27','SA_REP',7400.00,0.15,148,80),(172,'Elizabeth','Bates','EBATES','011.44.1343.529268','1987-08-28','SA_REP',7300.00,0.15,148,80),(173,'Sundita','Kumar','SKUMAR','011.44.1343.329268','1987-08-29','SA_REP',6100.00,0.10,148,80),(174,'Ellen','Abel','EABEL','011.44.1644.429267','1987-08-30','SA_REP',11000.00,0.30,149,80),(175,'Alyssa','Hutton','AHUTTON','011.44.1644.429266','1987-08-31','SA_REP',8800.00,0.25,149,80),(176,'Jonathon','Taylor','JTAYLOR','011.44.1644.429265','1987-09-01','SA_REP',8600.00,0.20,149,80),(177,'Jack','Livingston','JLIVINGS','011.44.1644.429264','1987-09-02','SA_REP',8400.00,0.20,149,80),(178,'Kimberely','Grant','KGRANT','011.44.1644.429263','1987-09-03','SA_REP',7000.00,0.15,149,0),(179,'Charles','Johnson','CJOHNSON','011.44.1644.429262','1987-09-04','SA_REP',6200.00,0.10,149,80),(180,'Winston','Taylor','WTAYLOR','650.507.9876','1987-09-05','SH_CLERK',3200.00,0.00,120,50),(181,'Jean','Fleaur','JFLEAUR','650.507.9877','1987-09-06','SH_CLERK',3100.00,0.00,120,50),(182,'Martha','Sullivan','MSULLIVA','650.507.9878','1987-09-07','SH_CLERK',2500.00,0.00,120,50),(183,'Girard','Geoni','GGEONI','650.507.9879','1987-09-08','SH_CLERK',2800.00,0.00,120,50),(184,'Nandita','Sarchand','NSARCHAN','650.509.1876','1987-09-09','SH_CLERK',4200.00,0.00,121,50),(185,'Alexis','Bull','ABULL','650.509.2876','1987-09-10','SH_CLERK',4100.00,0.00,121,50),(186,'Julia','Dellinger','JDELLING','650.509.3876','1987-09-11','SH_CLERK',3400.00,0.00,121,50),(187,'Anthony','Cabrio','ACABRIO','650.509.4876','1987-09-12','SH_CLERK',3000.00,0.00,121,50),(188,'Kelly','Chung','KCHUNG','650.505.1876','1987-09-13','SH_CLERK',3800.00,0.00,122,50),(189,'Jennifer','Dilly','JDILLY','650.505.2876','1987-09-14','SH_CLERK',3600.00,0.00,122,50),(190,'Timothy','Gates','TGATES','650.505.3876','1987-09-15','SH_CLERK',2900.00,0.00,122,50),(191,'Randall','Perkins','RPERKINS','650.505.4876','1987-09-16','SH_CLERK',2500.00,0.00,122,50),(192,'Sarah','Bell','SBELL','650.501.1876','1987-09-17','SH_CLERK',4000.00,0.00,123,50),(193,'Britney','Everett','BEVERETT','650.501.2876','1987-09-18','SH_CLERK',3900.00,0.00,123,50),(194,'Samuel','McCain','SMCCAIN','650.501.3876','1987-09-19','SH_CLERK',3200.00,0.00,123,50),(195,'Vance','Jones','VJONES','650.501.4876','1987-09-20','SH_CLERK',2800.00,0.00,123,50),(196,'Alana','Walsh','AWALSH','650.507.9811','1987-09-21','SH_CLERK',3100.00,0.00,124,50),(197,'Kevin','Feeney','KFEENEY','650.507.9822','1987-09-22','SH_CLERK',3000.00,0.00,124,50),(198,'Donald','OConnell','DOCONNEL','650.507.9833','1987-09-23','SH_CLERK',2600.00,0.00,124,50),(199,'Douglas','Grant','DGRANT','650.507.9844','1987-09-24','SH_CLERK',2600.00,0.00,124,50),(200,'Jennifer','Whalen','JWHALEN','515.123.4444','1987-09-25','AD_ASST',4400.00,0.00,101,10),(201,'Michael','Hartstein','MHARTSTE','515.123.5555','1987-09-26','MK_MAN',13000.00,0.00,100,20),(202,'Pat','Fay','PFAY','603.123.6666','1987-09-27','MK_REP',6000.00,0.00,201,20),(203,'Susan','Mavris','SMAVRIS','515.123.7777','1987-09-28','HR_REP',6500.00,0.00,101,40),(204,'Hermann','Baer','HBAER','515.123.8888','1987-09-29','PR_REP',10000.00,0.00,101,70),(205,'Shelley','Higgins','SHIGGINS','515.123.8080','1987-09-30','AC_MGR',12000.00,0.00,101,110),(206,'William','Gietz','WGIETZ','515.123.8181','1987-10-01','AC_ACCOUNT',8300.00,0.00,205,110);
/*!40000 ALTER TABLE w3resources_exercises.employees_join ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.jobhistory_join;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.jobhistory_join (
  `EMPLOYEE_ID` decimal(6,0) NOT NULL,
  `START_DATE` date NOT NULL,
  `END_DATE` date NOT NULL,
  `JOB_ID` varchar(10) NOT NULL,
  `DEPARTMENT_ID` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`,`START_DATE`),
  KEY `JHIST_DEPARTMENT_IX` (`DEPARTMENT_ID`),
  KEY `JHIST_EMPLOYEE_IX` (`EMPLOYEE_ID`),
  KEY `JHIST_JOB_IX` (`JOB_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;



LOCK TABLES w3resources_exercises.jobhistory_join WRITE;
/*!40000 ALTER TABLE w3resources_exercises.jobhistory_join DISABLE KEYS */;
INSERT INTO w3resources_exercises.jobhistory_join VALUES (102,'1993-01-13','1998-07-24','IT_PROG',60),(101,'1989-09-21','1993-10-27','AC_ACCOUNT',110),(101,'1993-10-28','1997-03-15','AC_MGR',110),(201,'1996-02-17','1999-12-19','MK_REP',20),(114,'1998-03-24','1999-12-31','ST_CLERK',50),(122,'1999-01-01','1999-12-31','ST_CLERK',50),(200,'1987-09-17','1993-06-17','AD_ASST',90),(176,'1998-03-24','1998-12-31','SA_REP',80),(176,'1999-01-01','1999-12-31','SA_MAN',80),(200,'1994-07-01','1998-12-31','AC_ACCOUNT',90),(0,'0000-00-00','0000-00-00','',0);
/*!40000 ALTER TABLE w3resources_exercises.jobhistory_join ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.jobs_join;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.jobs_join (
  `JOB_ID` varchar(10) NOT NULL DEFAULT '',
  `JOB_TITLE` varchar(35) NOT NULL,
  `MIN_SALARY` decimal(6,0) DEFAULT NULL,
  `MAX_SALARY` decimal(6,0) DEFAULT NULL,
  PRIMARY KEY (`JOB_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.jobs_join WRITE;
/*!40000 ALTER TABLE w3resources_exercises.jobs_join DISABLE KEYS */;
INSERT INTO w3resources_exercises.jobs_join VALUES ('AD_PRES','President',20000,40000),('AD_VP','Administration Vice President',15000,30000),('AD_ASST','Administration Assistant',3000,6000),('FI_MGR','Finance Manager',8200,16000),('FI_ACCOUNT','Accountant',4200,9000),('AC_MGR','Accounting Manager',8200,16000),('AC_ACCOUNT','Public Accountant',4200,9000),('SA_MAN','Sales Manager',10000,20000),('SA_REP','Sales Representative',6000,12000),('PU_MAN','Purchasing Manager',8000,15000),('PU_CLERK','Purchasing Clerk',2500,5500),('ST_MAN','Stock Manager',5500,8500),('ST_CLERK','Stock Clerk',2000,5000),('SH_CLERK','Shipping Clerk',2500,5500),('IT_PROG','Programmer',4000,10000),('MK_MAN','Marketing Manager',9000,15000),('MK_REP','Marketing Representative',4000,9000),('HR_REP','Human Resources Representative',4000,9000),('PR_REP','Public Relations Representative',4500,10500);
/*!40000 ALTER TABLE w3resources_exercises.jobs_join ENABLE KEYS */;
UNLOCK TABLES;



DROP TABLE IF EXISTS w3resources_exercises.locations_join;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.locations_join (
  `LOCATION_ID` decimal(4,0) NOT NULL DEFAULT '0',
  `STREET_ADDRESS` varchar(40) DEFAULT NULL,
  `POSTAL_CODE` varchar(12) DEFAULT NULL,
  `CITY` varchar(30) NOT NULL,
  `STATE_PROVINCE` varchar(25) DEFAULT NULL,
  `COUNTRY_ID` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`LOCATION_ID`),
  KEY `LOC_CITY_IX` (`CITY`),
  KEY `LOC_COUNTRY_IX` (`COUNTRY_ID`),
  KEY `LOC_STATE_PROVINCE_IX` (`STATE_PROVINCE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.locations_join WRITE;
/*!40000 ALTER TABLE w3resources_exercises.locations_join DISABLE KEYS */;
INSERT INTO w3resources_exercises.locations_join VALUES (1000,'1297 Via Cola di Rie','989','Roma','','IT'),(1100,'93091 Calle della Testa','10934','Venice','','IT'),(1200,'2017 Shinjuku-ku','1689','Tokyo','Tokyo Prefecture','JP'),(1300,'9450 Kamiya-cho','6823','Hiroshima','','JP'),(1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US'),(1500,'2011 Interiors Blvd','99236','South San Francisco','California','US'),(1600,'2007 Zagora St','50090','South Brunswick','New Jersey','US'),(1700,'2004 Charade Rd','98199','Seattle','Washington','US'),(1800,'147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA'),(1900,'6092 Boxwood St','YSW 9T2','Whitehorse','Yukon','CA'),(2000,'40-5-12 Laogianggen','190518','Beijing','','CN'),(2100,'1298 Vileparle (E)','490231','Bombay','Maharashtra','IN'),(2200,'12-98 Victoria Street','2901','Sydney','New South Wales','AU'),(2300,'198 Clementi North','540198','Singapore','','SG'),(2400,'8204 Arthur St','','London','','UK'),(2500,'\"Magdalen Centre',' The Oxford ','OX9 9ZB','Oxford','Ox'),(2600,'9702 Chester Road','9629850293','Stretford','Manchester','UK'),(2700,'Schwanthalerstr. 7031','80925','Munich','Bavaria','DE'),(2800,'Rua Frei Caneca 1360','01307-002','Sao Paulo','Sao Paulo','BR'),(2900,'20 Rue des Corps-Saints','1730','Geneva','Geneve','CH'),(3000,'Murtenstrasse 921','3095','Bern','BE','CH'),(3100,'Pieter Breughelstraat 837','3029SK','Utrecht','Utrecht','NL'),(3200,'Mariano Escobedo 9991','11932','Mexico City','\"Distrito Federal','\"');
/*!40000 ALTER TABLE w3resources_exercises.locations_join ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS w3resources_exercises.regions_join;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.regions_join (
  `REGION_ID` decimal(5,0) NOT NULL,
  `REGION_NAME` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`REGION_ID`),
  UNIQUE KEY `sss` (`REGION_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;



LOCK TABLES w3resources_exercises.regions_join WRITE;
/*!40000 ALTER TABLE w3resources_exercises.regions_join DISABLE KEYS */;
INSERT INTO w3resources_exercises.regions_join VALUES (1,'Europe\r'),(2,'Americas\r'),(3,'Asia\r'),(4,'Middle East and Africa\r');
/*!40000 ALTER TABLE w3resources_exercises.regions_join ENABLE KEYS */;
UNLOCK TABLES;


select *
from w3resources_exercises.regions_join;

select*
from w3resources_exercises.locations_join;

select *
from w3resources_exercises.jobs_join;

select *
from w3resources_exercises.jobhistory_join;

select *
from w3resources_exercises.employees_join;

select * 
from w3resources_exercises.departments_join;

Select *
from w3resources_exercises.countries_join;

-- Encontre todos os endereços para os departamentos

Select *
from w3resources_exercises.locations_join
Natural Join w3resources_exercises.countries_join; #natural Join junta a partir das colunas que sao iguais, pre entende o resultado

-- encontre o primeiro nome, depart id e nome do departamento de todos os funcionarios

Select first_name, Last_name, department_id, department_name
FROM w3resources_exercises.employees_join
JOIN w3resources_exercises.departments_join
USING (department_id);

-- encontre o primeiro nome, depart id e nome do departamento dos funcionarios de londres
Select em.first_name, em.Last_name, em.department_id, dep.department_name, dep.location_id, loc.city
FROM w3resources_exercises.employees_join as em
JOIN w3resources_exercises.departments_join as dep
ON (em.department_id = dep.department_id)
JOIN w3resources_exercises.locations_join as loc
ON (dep.location_id = loc.location_id)
WHERE LOWER(loc.city) = 'London';

-- encontre o nome do funcionario junto com seu gerente_id e nome do gerente
Select em1.first_name, em1.last_name, em1.manager_id, em2.first_name AS 'Manager' 
FROM w3resources_exercises.employees_join AS em1
JOIN w3resources_exercises.employees_join AS em2
ON (em1.manager_id = em2.employee_id);

-- Encontre o nome do funcionario que foram contratados após o "Jones"
Select em1.first_name, em1.last_name, em1.hire_date
FROM w3resources_exercises.employees_join as em1
JOIN w3resources_exercises.employees_join as em2
ON (em2.last_name = 'Jones')
where em1.hire_date > em2.hire_date;

-- encontre a quantidade de funcionarios por departamento
Select department_name, count(*) AS Department_employee_number
FROM w3resources_exercises.departments_join as dep
Inner Join w3resources_exercises.employees_join as em #inner join exige um group by
ON dep.department_id = em.department_id
GROUP BY dep.department_id, dep.department_name
Order By dep.department_name;

-- query que tenha employee_id, job title, e dias entre a contrataçao e a saida - dentro do departamento 90
Select em.employee_id, em.job_id, job.start_date, job.end_date, job.end_date-job.start_date AS days
FROM w3resources_exercises.employees_join AS em
JOIN w3resources_exercises.jobhistory_join AS job
ON em.employee_id = job.employee_id
WHERE em.department_id = 90;

-- query para trazer o job_title vs average salary
Select job.job_title, avg(em.salary)
FROM w3resources_exercises.employees_join AS em
JOIN w3resources_exercises.jobs_join AS job
ON em.job_id = job.job_id
GROUP BY job.job_title;

-- query com nome do funcionario, cargo, salario do funcionario e diferença do seu salario vcs o minimo do cargo
Select job.job_title, em.first_name, em.salary, em.salary - job.min_salary AS DifferenceMinSalary
FROM w3resources_exercises.employees_join AS em
JOIN w3resources_exercises.jobs_join AS job
ON em.job_id = job.job_id;

-- puxe o historico de trabalho de funcionario que hoje ganham mais de 10000 como salario
Select em.employee_id, em.first_name, jobh.job_id, jobh.start_date,jobh.end_date
FROM w3resources_exercises.employees_join AS em
JOIN w3resources_exercises.jobhistory_join AS jobh
ON em.employee_id = jobh.employee_id
where em.salary >= 10000;

-- puxe nome do departamento, nome do manager, data de contrataçao, salario para managers com mais de 15 anos na empresa
Select dep.department_name, em.first_name, em.hire_date, em.salary, (datediff(now(),em.hire_date))/365 As Experience
FROM w3resources_exercises.employees_join AS em
JOIN w3resources_exercises.departments_join as dep
ON (em.employee_id = dep.manager_id)
WHERE (datediff(now(),em.hire_date))/365 > 15; #datedif faz a diferença em dias de duas datas e now() é o dia de hoje

## exercicios de string
-- link dos exercicios: https://www.w3resource.com/mysql-exercises/string-exercises/index.php

-- primeiro vamos criar as tabelas necessarias novamente
DROP TABLE IF EXISTS w3resources_exercises.countries_string;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.countries_string (
  `COUNTRY_ID` varchar(2) NOT NULL,
  `COUNTRY_NAME` varchar(40) DEFAULT NULL,
  `REGION_ID` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`COUNTRY_ID`),
  KEY `COUNTR_REG_FK` (`REGION_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.countries_string WRITE;
/*!40000 ALTER TABLE w3resources_exercises.countries_string DISABLE KEYS */;
INSERT INTO w3resources_exercises.countries_string VALUES ('AR','Argentina',2),('AU','Australia',3),('BE','Belgium',1),('BR','Brazil',2),('CA','Canada',2),('CH','Switzerland',1),('CN','China',3),('DE','Germany',1),('DK','Denmark',1),('EG','Egypt',4),('FR','France',1),('HK','HongKong',3),('IL','Israel',4),('IN','India',3),('IT','Italy',1),('JP','Japan',3),('KW','Kuwait',4),('MX','Mexico',2),('NG','Nigeria',4),('NL','Netherlands',1),('SG','Singapore',3),('UK','United Kingdom',1),('US','United States of America',2),('ZM','Zambia',4),('ZW','Zimbabwe',4);
/*!40000 ALTER TABLE w3resources_exercises.countries_string ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.departments_string;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.departments_string (
  `DEPARTMENT_ID` decimal(4,0) NOT NULL DEFAULT '0',
  `DEPARTMENT_NAME` varchar(30) NOT NULL,
  `MANAGER_ID` decimal(6,0) DEFAULT NULL,
  `LOCATION_ID` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`DEPARTMENT_ID`),
  KEY `DEPT_MGR_FK` (`MANAGER_ID`),
  KEY `DEPT_LOCATION_IX` (`LOCATION_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.departments_string WRITE;
/*!40000 ALTER TABLE w3resources_exercises.departments_string DISABLE KEYS */;
INSERT INTO w3resources_exercises.departments_string VALUES (10,'Administration',200,1700),(20,'Marketing',201,1800),(30,'Purchasing',114,1700),(40,'Human Resources',203,2400),(50,'Shipping',121,1500),(60,'IT',103,1400),(70,'Public Relations',204,2700),(80,'Sales',145,2500),(90,'Executive',100,1700),(100,'Finance',108,1700),(110,'Accounting',205,1700),(120,'Treasury',0,1700),(130,'Corporate Tax',0,1700),(140,'Control And Credit',0,1700),(150,'Shareholder Services',0,1700),(160,'Benefits',0,1700),(170,'Manufacturing',0,1700),(180,'Construction',0,1700),(190,'Contracting',0,1700),(200,'Operations',0,1700),(210,'IT Support',0,1700),(220,'NOC',0,1700),(230,'IT Helpdesk',0,1700),(240,'Government Sales',0,1700),(250,'Retail Sales',0,1700),(260,'Recruiting',0,1700),(270,'Payroll',0,1700);
/*!40000 ALTER TABLE w3resources_exercises.departments_string ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.employees_string;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.employees_string(
  `EMPLOYEE_ID` decimal(6,0) NOT NULL DEFAULT '0',
  `FIRST_NAME` varchar(20) DEFAULT NULL,
  `LAST_NAME` varchar(25) NOT NULL,
  `EMAIL` varchar(25) NOT NULL,
  `PHONE_NUMBER` varchar(20) DEFAULT NULL,
  `HIRE_DATE` date NOT NULL,
  `JOB_ID` varchar(10) NOT NULL,
  `SALARY` decimal(8,2) DEFAULT NULL,
  `COMMISSION_PCT` decimal(2,2) DEFAULT NULL,
  `MANAGER_ID` decimal(6,0) DEFAULT NULL,
  `DEPARTMENT_ID` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`),
  UNIQUE KEY `EMP_EMAIL_UK` (`EMAIL`),
  KEY `EMP_DEPARTMENT_IX` (`DEPARTMENT_ID`),
  KEY `EMP_JOB_IX` (`JOB_ID`),
  KEY `EMP_MANAGER_IX` (`MANAGER_ID`),
  KEY `EMP_NAME_IX` (`LAST_NAME`,`FIRST_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.employees_string WRITE;
/*!40000 ALTER TABLE w3resources_exercises.employees_string DISABLE KEYS */;
INSERT INTO w3resources_exercises.employees_string VALUES (100,'Steven','King','SKING','515.123.4567','1987-06-17','AD_PRES',24000.00,0.00,0,90),(101,'Neena','Kochhar','NKOCHHAR','515.123.4568','1987-06-18','AD_VP',17000.00,0.00,100,90),(102,'Lex','De Haan','LDEHAAN','515.123.4569','1987-06-19','AD_VP',17000.00,0.00,100,90),(103,'Alexander','Hunold','AHUNOLD','590.423.4567','1987-06-20','IT_PROG',9000.00,0.00,102,60),(104,'Bruce','Ernst','BERNST','590.423.4568','1987-06-21','IT_PROG',6000.00,0.00,103,60),(105,'David','Austin','DAUSTIN','590.423.4569','1987-06-22','IT_PROG',4800.00,0.00,103,60),(106,'Valli','Pataballa','VPATABAL','590.423.4560','1987-06-23','IT_PROG',4800.00,0.00,103,60),(107,'Diana','Lorentz','DLORENTZ','590.423.5567','1987-06-24','IT_PROG',4200.00,0.00,103,60),(108,'Nancy','Greenberg','NGREENBE','515.124.4569','1987-06-25','FI_MGR',12000.00,0.00,101,100),(109,'Daniel','Faviet','DFAVIET','515.124.4169','1987-06-26','FI_ACCOUNT',9000.00,0.00,108,100),(110,'John','Chen','JCHEN','515.124.4269','1987-06-27','FI_ACCOUNT',8200.00,0.00,108,100),(111,'Ismael','Sciarra','ISCIARRA','515.124.4369','1987-06-28','FI_ACCOUNT',7700.00,0.00,108,100),(112,'Jose Manuel','Urman','JMURMAN','515.124.4469','1987-06-29','FI_ACCOUNT',7800.00,0.00,108,100),(113,'Luis','Popp','LPOPP','515.124.4567','1987-06-30','FI_ACCOUNT',6900.00,0.00,108,100),(114,'Den','Raphaely','DRAPHEAL','515.127.4561','1987-07-01','PU_MAN',11000.00,0.00,100,30),(115,'Alexander','Khoo','AKHOO','515.127.4562','1987-07-02','PU_CLERK',3100.00,0.00,114,30),(116,'Shelli','Baida','SBAIDA','515.127.4563','1987-07-03','PU_CLERK',2900.00,0.00,114,30),(117,'Sigal','Tobias','STOBIAS','515.127.4564','1987-07-04','PU_CLERK',2800.00,0.00,114,30),(118,'Guy','Himuro','GHIMURO','515.127.4565','1987-07-05','PU_CLERK',2600.00,0.00,114,30),(119,'Karen','Colmenares','KCOLMENA','515.127.4566','1987-07-06','PU_CLERK',2500.00,0.00,114,30),(120,'Matthew','Weiss','MWEISS','650.123.1234','1987-07-07','ST_MAN',8000.00,0.00,100,50),(121,'Adam','Fripp','AFRIPP','650.123.2234','1987-07-08','ST_MAN',8200.00,0.00,100,50),(122,'Payam','Kaufling','PKAUFLIN','650.123.3234','1987-07-09','ST_MAN',7900.00,0.00,100,50),(123,'Shanta','Vollman','SVOLLMAN','650.123.4234','1987-07-10','ST_MAN',6500.00,0.00,100,50),(124,'Kevin','Mourgos','KMOURGOS','650.123.5234','1987-07-11','ST_MAN',5800.00,0.00,100,50),(125,'Julia','Nayer','JNAYER','650.124.1214','1987-07-12','ST_CLERK',3200.00,0.00,120,50),(126,'Irene','Mikkilineni','IMIKKILI','650.124.1224','1987-07-13','ST_CLERK',2700.00,0.00,120,50),(127,'James','Landry','JLANDRY','650.124.1334','1987-07-14','ST_CLERK',2400.00,0.00,120,50),(128,'Steven','Markle','SMARKLE','650.124.1434','1987-07-15','ST_CLERK',2200.00,0.00,120,50),(129,'Laura','Bissot','LBISSOT','650.124.5234','1987-07-16','ST_CLERK',3300.00,0.00,121,50),(130,'Mozhe','Atkinson','MATKINSO','650.124.6234','1987-07-17','ST_CLERK',2800.00,0.00,121,50),(131,'James','Marlow','JAMRLOW','650.124.7234','1987-07-18','ST_CLERK',2500.00,0.00,121,50),(132,'TJ','Olson','TJOLSON','650.124.8234','1987-07-19','ST_CLERK',2100.00,0.00,121,50),(133,'Jason','Mallin','JMALLIN','650.127.1934','1987-07-20','ST_CLERK',3300.00,0.00,122,50),(134,'Michael','Rogers','MROGERS','650.127.1834','1987-07-21','ST_CLERK',2900.00,0.00,122,50),(135,'Ki','Gee','KGEE','650.127.1734','1987-07-22','ST_CLERK',2400.00,0.00,122,50),(136,'Hazel','Philtanker','HPHILTAN','650.127.1634','1987-07-23','ST_CLERK',2200.00,0.00,122,50),(137,'Renske','Ladwig','RLADWIG','650.121.1234','1987-07-24','ST_CLERK',3600.00,0.00,123,50),(138,'Stephen','Stiles','SSTILES','650.121.2034','1987-07-25','ST_CLERK',3200.00,0.00,123,50),(139,'John','Seo','JSEO','650.121.2019','1987-07-26','ST_CLERK',2700.00,0.00,123,50),(140,'Joshua','Patel','JPATEL','650.121.1834','1987-07-27','ST_CLERK',2500.00,0.00,123,50),(141,'Trenna','Rajs','TRAJS','650.121.8009','1987-07-28','ST_CLERK',3500.00,0.00,124,50),(142,'Curtis','Davies','CDAVIES','650.121.2994','1987-07-29','ST_CLERK',3100.00,0.00,124,50),(143,'Randall','Matos','RMATOS','650.121.2874','1987-07-30','ST_CLERK',2600.00,0.00,124,50),(144,'Peter','Vargas','PVARGAS','650.121.2004','1987-07-31','ST_CLERK',2500.00,0.00,124,50),(145,'John','Russell','JRUSSEL','011.44.1344.429268','1987-08-01','SA_MAN',14000.00,0.40,100,80),(146,'Karen','Partners','KPARTNER','011.44.1344.467268','1987-08-02','SA_MAN',13500.00,0.30,100,80),(147,'Alberto','Errazuriz','AERRAZUR','011.44.1344.429278','1987-08-03','SA_MAN',12000.00,0.30,100,80),(148,'Gerald','Cambrault','GCAMBRAU','011.44.1344.619268','1987-08-04','SA_MAN',11000.00,0.30,100,80),(149,'Eleni','Zlotkey','EZLOTKEY','011.44.1344.429018','1987-08-05','SA_MAN',10500.00,0.20,100,80),(150,'Peter','Tucker','PTUCKER','011.44.1344.129268','1987-08-06','SA_REP',10000.00,0.30,145,80),(151,'David','Bernstein','DBERNSTE','011.44.1344.345268','1987-08-07','SA_REP',9500.00,0.25,145,80),(152,'Peter','Hall','PHALL','011.44.1344.478968','1987-08-08','SA_REP',9000.00,0.25,145,80),(153,'Christopher','Olsen','COLSEN','011.44.1344.498718','1987-08-09','SA_REP',8000.00,0.20,145,80),(154,'Nanette','Cambrault','NCAMBRAU','011.44.1344.987668','1987-08-10','SA_REP',7500.00,0.20,145,80),(155,'Oliver','Tuvault','OTUVAULT','011.44.1344.486508','1987-08-11','SA_REP',7000.00,0.15,145,80),(156,'Janette','King','JKING','011.44.1345.429268','1987-08-12','SA_REP',10000.00,0.35,146,80),(157,'Patrick','Sully','PSULLY','011.44.1345.929268','1987-08-13','SA_REP',9500.00,0.35,146,80),(158,'Allan','McEwen','AMCEWEN','011.44.1345.829268','1987-08-14','SA_REP',9000.00,0.35,146,80),(159,'Lindsey','Smith','LSMITH','011.44.1345.729268','1987-08-15','SA_REP',8000.00,0.30,146,80),(160,'Louise','Doran','LDORAN','011.44.1345.629268','1987-08-16','SA_REP',7500.00,0.30,146,80),(161,'Sarath','Sewall','SSEWALL','011.44.1345.529268','1987-08-17','SA_REP',7000.00,0.25,146,80),(162,'Clara','Vishney','CVISHNEY','011.44.1346.129268','1987-08-18','SA_REP',10500.00,0.25,147,80),(163,'Danielle','Greene','DGREENE','011.44.1346.229268','1987-08-19','SA_REP',9500.00,0.15,147,80),(164,'Mattea','Marvins','MMARVINS','011.44.1346.329268','1987-08-20','SA_REP',7200.00,0.10,147,80),(165,'David','Lee','DLEE','011.44.1346.529268','1987-08-21','SA_REP',6800.00,0.10,147,80),(166,'Sundar','Ande','SANDE','011.44.1346.629268','1987-08-22','SA_REP',6400.00,0.10,147,80),(167,'Amit','Banda','ABANDA','011.44.1346.729268','1987-08-23','SA_REP',6200.00,0.10,147,80),(168,'Lisa','Ozer','LOZER','011.44.1343.929268','1987-08-24','SA_REP',11500.00,0.25,148,80),(169,'Harrison','Bloom','HBLOOM','011.44.1343.829268','1987-08-25','SA_REP',10000.00,0.20,148,80),(170,'Tayler','Fox','TFOX','011.44.1343.729268','1987-08-26','SA_REP',9600.00,0.20,148,80),(171,'William','Smith','WSMITH','011.44.1343.629268','1987-08-27','SA_REP',7400.00,0.15,148,80),(172,'Elizabeth','Bates','EBATES','011.44.1343.529268','1987-08-28','SA_REP',7300.00,0.15,148,80),(173,'Sundita','Kumar','SKUMAR','011.44.1343.329268','1987-08-29','SA_REP',6100.00,0.10,148,80),(174,'Ellen','Abel','EABEL','011.44.1644.429267','1987-08-30','SA_REP',11000.00,0.30,149,80),(175,'Alyssa','Hutton','AHUTTON','011.44.1644.429266','1987-08-31','SA_REP',8800.00,0.25,149,80),(176,'Jonathon','Taylor','JTAYLOR','011.44.1644.429265','1987-09-01','SA_REP',8600.00,0.20,149,80),(177,'Jack','Livingston','JLIVINGS','011.44.1644.429264','1987-09-02','SA_REP',8400.00,0.20,149,80),(178,'Kimberely','Grant','KGRANT','011.44.1644.429263','1987-09-03','SA_REP',7000.00,0.15,149,0),(179,'Charles','Johnson','CJOHNSON','011.44.1644.429262','1987-09-04','SA_REP',6200.00,0.10,149,80),(180,'Winston','Taylor','WTAYLOR','650.507.9876','1987-09-05','SH_CLERK',3200.00,0.00,120,50),(181,'Jean','Fleaur','JFLEAUR','650.507.9877','1987-09-06','SH_CLERK',3100.00,0.00,120,50),(182,'Martha','Sullivan','MSULLIVA','650.507.9878','1987-09-07','SH_CLERK',2500.00,0.00,120,50),(183,'Girard','Geoni','GGEONI','650.507.9879','1987-09-08','SH_CLERK',2800.00,0.00,120,50),(184,'Nandita','Sarchand','NSARCHAN','650.509.1876','1987-09-09','SH_CLERK',4200.00,0.00,121,50),(185,'Alexis','Bull','ABULL','650.509.2876','1987-09-10','SH_CLERK',4100.00,0.00,121,50),(186,'Julia','Dellinger','JDELLING','650.509.3876','1987-09-11','SH_CLERK',3400.00,0.00,121,50),(187,'Anthony','Cabrio','ACABRIO','650.509.4876','1987-09-12','SH_CLERK',3000.00,0.00,121,50),(188,'Kelly','Chung','KCHUNG','650.505.1876','1987-09-13','SH_CLERK',3800.00,0.00,122,50),(189,'Jennifer','Dilly','JDILLY','650.505.2876','1987-09-14','SH_CLERK',3600.00,0.00,122,50),(190,'Timothy','Gates','TGATES','650.505.3876','1987-09-15','SH_CLERK',2900.00,0.00,122,50),(191,'Randall','Perkins','RPERKINS','650.505.4876','1987-09-16','SH_CLERK',2500.00,0.00,122,50),(192,'Sarah','Bell','SBELL','650.501.1876','1987-09-17','SH_CLERK',4000.00,0.00,123,50),(193,'Britney','Everett','BEVERETT','650.501.2876','1987-09-18','SH_CLERK',3900.00,0.00,123,50),(194,'Samuel','McCain','SMCCAIN','650.501.3876','1987-09-19','SH_CLERK',3200.00,0.00,123,50),(195,'Vance','Jones','VJONES','650.501.4876','1987-09-20','SH_CLERK',2800.00,0.00,123,50),(196,'Alana','Walsh','AWALSH','650.507.9811','1987-09-21','SH_CLERK',3100.00,0.00,124,50),(197,'Kevin','Feeney','KFEENEY','650.507.9822','1987-09-22','SH_CLERK',3000.00,0.00,124,50),(198,'Donald','OConnell','DOCONNEL','650.507.9833','1987-09-23','SH_CLERK',2600.00,0.00,124,50),(199,'Douglas','Grant','DGRANT','650.507.9844','1987-09-24','SH_CLERK',2600.00,0.00,124,50),(200,'Jennifer','Whalen','JWHALEN','515.123.4444','1987-09-25','AD_ASST',4400.00,0.00,101,10),(201,'Michael','Hartstein','MHARTSTE','515.123.5555','1987-09-26','MK_MAN',13000.00,0.00,100,20),(202,'Pat','Fay','PFAY','603.123.6666','1987-09-27','MK_REP',6000.00,0.00,201,20),(203,'Susan','Mavris','SMAVRIS','515.123.7777','1987-09-28','HR_REP',6500.00,0.00,101,40),(204,'Hermann','Baer','HBAER','515.123.8888','1987-09-29','PR_REP',10000.00,0.00,101,70),(205,'Shelley','Higgins','SHIGGINS','515.123.8080','1987-09-30','AC_MGR',12000.00,0.00,101,110),(206,'William','Gietz','WGIETZ','515.123.8181','1987-10-01','AC_ACCOUNT',8300.00,0.00,205,110);
/*!40000 ALTER TABLE w3resources_exercises.employees_string ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.job_history_string;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.job_history_string (
  `EMPLOYEE_ID` decimal(6,0) NOT NULL,
  `START_DATE` date NOT NULL,
  `END_DATE` date NOT NULL,
  `JOB_ID` varchar(10) NOT NULL,
  `DEPARTMENT_ID` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`,`START_DATE`),
  KEY `JHIST_DEPARTMENT_IX` (`DEPARTMENT_ID`),
  KEY `JHIST_EMPLOYEE_IX` (`EMPLOYEE_ID`),
  KEY `JHIST_JOB_IX` (`JOB_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.job_history_string WRITE;
/*!40000 ALTER TABLE w3resources_exercises.job_history_string DISABLE KEYS */;
INSERT INTO w3resources_exercises.job_history_string VALUES (102,'1993-01-13','1998-07-24','IT_PROG',60),(101,'1989-09-21','1993-10-27','AC_ACCOUNT',110),(101,'1993-10-28','1997-03-15','AC_MGR',110),(201,'1996-02-17','1999-12-19','MK_REP',20),(114,'1998-03-24','1999-12-31','ST_CLERK',50),(122,'1999-01-01','1999-12-31','ST_CLERK',50),(200,'1987-09-17','1993-06-17','AD_ASST',90),(176,'1998-03-24','1998-12-31','SA_REP',80),(176,'1999-01-01','1999-12-31','SA_MAN',80),(200,'1994-07-01','1998-12-31','AC_ACCOUNT',90),(0,'0000-00-00','0000-00-00','',0);
/*!40000 ALTER TABLE w3resources_exercises.job_history_string ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.jobs_string;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.jobs_string (
  `JOB_ID` varchar(10) NOT NULL DEFAULT '',
  `JOB_TITLE` varchar(35) NOT NULL,
  `MIN_SALARY` decimal(6,0) DEFAULT NULL,
  `MAX_SALARY` decimal(6,0) DEFAULT NULL,
  PRIMARY KEY (`JOB_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.jobs_string WRITE;
/*!40000 ALTER TABLE w3resources_exercises.jobs_string DISABLE KEYS */;
INSERT INTO w3resources_exercises.jobs_string VALUES ('AD_PRES','President',20000,40000),('AD_VP','Administration Vice President',15000,30000),('AD_ASST','Administration Assistant',3000,6000),('FI_MGR','Finance Manager',8200,16000),('FI_ACCOUNT','Accountant',4200,9000),('AC_MGR','Accounting Manager',8200,16000),('AC_ACCOUNT','Public Accountant',4200,9000),('SA_MAN','Sales Manager',10000,20000),('SA_REP','Sales Representative',6000,12000),('PU_MAN','Purchasing Manager',8000,15000),('PU_CLERK','Purchasing Clerk',2500,5500),('ST_MAN','Stock Manager',5500,8500),('ST_CLERK','Stock Clerk',2000,5000),('SH_CLERK','Shipping Clerk',2500,5500),('IT_PROG','Programmer',4000,10000),('MK_MAN','Marketing Manager',9000,15000),('MK_REP','Marketing Representative',4000,9000),('HR_REP','Human Resources Representative',4000,9000),('PR_REP','Public Relations Representative',4500,10500);
/*!40000 ALTER TABLE w3resources_exercises.jobs_string ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.locations_string;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.locations_string (
  `LOCATION_ID` decimal(4,0) NOT NULL DEFAULT '0',
  `STREET_ADDRESS` varchar(40) DEFAULT NULL,
  `POSTAL_CODE` varchar(12) DEFAULT NULL,
  `CITY` varchar(30) NOT NULL,
  `STATE_PROVINCE` varchar(25) DEFAULT NULL,
  `COUNTRY_ID` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`LOCATION_ID`),
  KEY `LOC_CITY_IX` (`CITY`),
  KEY `LOC_COUNTRY_IX` (`COUNTRY_ID`),
  KEY `LOC_STATE_PROVINCE_IX` (`STATE_PROVINCE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.locations_string WRITE;
/*!40000 ALTER TABLE w3resources_exercises.locations_string DISABLE KEYS */;
INSERT INTO w3resources_exercises.locations_string VALUES (1000,'1297 Via Cola di Rie','989','Roma','','IT'),(1100,'93091 Calle della Testa','10934','Venice','','IT'),(1200,'2017 Shinjuku-ku','1689','Tokyo','Tokyo Prefecture','JP'),(1300,'9450 Kamiya-cho','6823','Hiroshima','','JP'),(1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US'),(1500,'2011 Interiors Blvd','99236','South San Francisco','California','US'),(1600,'2007 Zagora St','50090','South Brunswick','New Jersey','US'),(1700,'2004 Charade Rd','98199','Seattle','Washington','US'),(1800,'147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA'),(1900,'6092 Boxwood St','YSW 9T2','Whitehorse','Yukon','CA'),(2000,'40-5-12 Laogianggen','190518','Beijing','','CN'),(2100,'1298 Vileparle (E)','490231','Bombay','Maharashtra','IN'),(2200,'12-98 Victoria Street','2901','Sydney','New South Wales','AU'),(2300,'198 Clementi North','540198','Singapore','','SG'),(2400,'8204 Arthur St','','London','','UK'),(2500,'\"Magdalen Centre',' The Oxford ','OX9 9ZB','Oxford','Ox'),(2600,'9702 Chester Road','9629850293','Stretford','Manchester','UK'),(2700,'Schwanthalerstr. 7031','80925','Munich','Bavaria','DE'),(2800,'Rua Frei Caneca 1360','01307-002','Sao Paulo','Sao Paulo','BR'),(2900,'20 Rue des Corps-Saints','1730','Geneva','Geneve','CH'),(3000,'Murtenstrasse 921','3095','Bern','BE','CH'),(3100,'Pieter Breughelstraat 837','3029SK','Utrecht','Utrecht','NL'),(3200,'Mariano Escobedo 9991','11932','Mexico City','\"Distrito Federal','\"');
/*!40000 ALTER TABLE w3resources_exercises.locations_string ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.regions_string;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.regions_string (
  `REGION_ID` decimal(5,0) NOT NULL,
  `REGION_NAME` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`REGION_ID`),
  UNIQUE KEY `sss` (`REGION_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.regions_string WRITE;
/*!40000 ALTER TABLE w3resources_exercises.regions_string DISABLE KEYS */;
INSERT INTO w3resources_exercises.regions_string VALUES (1,'Europe\r'),(2,'Americas\r'),(3,'Asia\r'),(4,'Middle East and Africa\r');
/*!40000 ALTER TABLE w3resources_exercises.regions_string ENABLE KEYS */;
UNLOCK TABLES;

Select * 
from w3resources_exercises.countries_string;

select * 
from w3resources_exercises.departments_string;

select *
from w3resources_exercises.employees_string;

select *
from w3resources_exercises.job_history_string;

select *
from w3resources_exercises.regions_string;

select *
from w3resources_exercises.locations_string;

select *
from w3resources_exercises.jobs_string;

-- query para puxar quais funcionários há por job_id
select job_id, GROUP_CONCAT(employee_id) #group_concat vai permitir ver todos os employee_id de cada job_id
from w3resources_exercises.employees_string
GROUP BY job_id;

-- substitua 124 por 999 nos telefones dos employees
update w3resources_exercises.employees_string
set phone_number = replace(phone_number, '123', '999')
Where phone_number LIKE '%123%';

select *
from w3resources_exercises.employees_string;

-- puxe os funcionarios que o nome tem mais de 7 letras
select *
from w3resources_exercises.employees_string
Where length(first_name)>=8;

-- preencha os numeros de salary com 00 na frente para terem o mesmo tamanho
#LPAD preenche dados a esquerda de uma string
select job_id, LPAD(min_salary, 7, '0')
from w3resources_exercises.jobs_string;

-- adicione '@example.com' aos emials
select employee_id, concat(email, '@example.com') as EMAILS2 #poderia ser update employees set email = concat(email, '@example.com') se fosse atualizar os dados
from w3resources_exercises.employees_string;

-- puxe o email_id e o email - mas discarte os ultimos 3 caracteres no email
select employee_id, email, reverse(email), substr(email,4), reverse(substr(reverse(email),4)) as Email_ID #reverse reverte o dado - substr tira os caracteres determinados do inicio do campo (por isso precisa de dois reverse)
from w3resources_exercises.employees_string;

-- encontre os employees que estao com o nome está em letra maiuscula
select *
from w3resources_exercises.employees_string
where first_name = BINARY UPPER (first_name); #binary coloca o resultado como verdadeiro/falso e UPPER procura os que sao letra maiuscula

#vou tentar pegar os que tem so a primeira letra maiuscula
select *
from w3resources_exercises.employees_string
where first_name LIKE concat(BINARY UPPER (Left(first_name,1)), '%');


-- pegue os ultimos 4 numeros dos telefones
select employee_id, right(phone_number, 4) AS PhoneNumberRight
from w3resources_exercises.employees_string;

-- puxe os street_address com pelo menos 10 caracteres
select *
from w3resources_exercises.locations_string
WHERE LENGTH(street_address) >= 10;

-- encontre o endereço mais curto
    
select *
from w3resources_exercises.locations_string
where 
length(street_address) = (Select min(length(street_address)) #precisa do select, se nao, nao funciona
from w3resources_exercises.locations_string
);

-- encontre a primeira palavra de jobs_title que contenham mias de 1 palavra
select job_id,job_title, substr(job_title,1, instr(job_title, ' '))
from w3resources_exercises.jobs_string;

#faça a mesma coisa, mas para a ultima palavra
select job_id,job_title, reverse(substr(reverse(job_title),1, instr(reverse(job_title), ' ')))
from w3resources_exercises.jobs_string;

-- puxe o nome e sobrenome dos funcionarios no qual o nome tenha "c" a partir do 2 caractere
select *
from w3resources_exercises.employees_string
where last_name LIKE '_%c%';
 #podia ser tbm de outra forma
 select *
from w3resources_exercises.employees_string
where INSTR(last_name, 'c')>=2; #INSTR encontra a posiçao do item em questao

-- puxe o nome dos funcionário que começam com a Letra A,J ou M
select *
from w3resources_exercises.employees_string
where first_name LIKE 'A%' OR first_name Like 'J%' OR first_name LIKE '%M';


-- puxe os funcionarios que ganham salarios de pelo menos 8 caracteres, e coloque $ na frente
select employee_id, first_name, concat('$', salary) AS Salary
from w3resources_exercises.employees_string
where length(salary)>=8;

-- faça com que haja 10 caracteres no campo de salario para todos os funcionarios, preenchendo os espaços vazios com $
select employee_id, first_name, LPAD(salary,10,'$') As Salary
from w3resources_exercises.employees_string;

-- mostre os primeiros 8 caracteres do nome dos funcionarios e os seus salarios, coloque $ nos seus salarios (cada $ representa 10k) e organize de forma decrescente com base no salario
select employee_id, left(first_name,8) As fistname, concat('$', (round((salary/1000),1)), 'k') AS salary
from w3resources_exercises.employees_string
Order By salary DESC;
##pode troar ROUND por FORMAT (que funciona melhor que nao for numero)

-- mostre o salario de cada funcionario com a representaçao de $ para cada 1k
select EMPLOYEE_ID, repeat('$', (salary/100)) AS 'Salary$', salary
 #repeat é um loop muito mais facil
from w3resources_exercises.employees_string
Order By salary DESC;) #aqui tem um ) a mais, porque meu mysql nao estava fechando o repeat direito - retirar para rodar outros codigos

-- mostre os funcionarios que foram contratados no dia 7 de cada mes ou no mes 7 do ano
select *
from w3resources_exercises.employees_string
WHERE right(hire_date,2) = '07' or mid(hire_date, 6,2) = '07';
## outra forma de fazer
select * 
from w3resources_exercises.employees_string
where position("07" in date_format(hire_date, '%d %m %Y'));


## ecercicios de aggregate functions
-- link dos exercicios: https://www.w3resource.com/mysql-exercises/aggregate-function-exercises/index.php

-- criando database de novo
DROP TABLE IF EXISTS w3resources_exercises.countries_aggregate;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.countries_aggregate (
  `COUNTRY_ID` varchar(2) NOT NULL,
  `COUNTRY_NAME` varchar(40) DEFAULT NULL,
  `REGION_ID` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`COUNTRY_ID`),
  KEY `COUNTR_REG_FK` (`REGION_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.countries_aggregate WRITE;
/*!40000 ALTER TABLE w3resources_exercises.countries_aggregate DISABLE KEYS */;
INSERT INTO w3resources_exercises.countries_aggregate VALUES ('AR','Argentina',2),('AU','Australia',3),('BE','Belgium',1),('BR','Brazil',2),('CA','Canada',2),('CH','Switzerland',1),('CN','China',3),('DE','Germany',1),('DK','Denmark',1),('EG','Egypt',4),('FR','France',1),('HK','HongKong',3),('IL','Israel',4),('IN','India',3),('IT','Italy',1),('JP','Japan',3),('KW','Kuwait',4),('MX','Mexico',2),('NG','Nigeria',4),('NL','Netherlands',1),('SG','Singapore',3),('UK','United Kingdom',1),('US','United States of America',2),('ZM','Zambia',4),('ZW','Zimbabwe',4);
/*!40000 ALTER TABLE w3resources_exercises.countries_aggregate ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.departments_aggregate;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.departments_aggregate (
  `DEPARTMENT_ID` decimal(4,0) NOT NULL DEFAULT '0',
  `DEPARTMENT_NAME` varchar(30) NOT NULL,
  `MANAGER_ID` decimal(6,0) DEFAULT NULL,
  `LOCATION_ID` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`DEPARTMENT_ID`),
  KEY `DEPT_MGR_FK` (`MANAGER_ID`),
  KEY `DEPT_LOCATION_IX` (`LOCATION_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.departments_aggregate WRITE;
/*!40000 ALTER TABLE w3resources_exercises.departments_aggregate DISABLE KEYS */;
INSERT INTO w3resources_exercises.departments_aggregate VALUES (10,'Administration',200,1700),(20,'Marketing',201,1800),(30,'Purchasing',114,1700),(40,'Human Resources',203,2400),(50,'Shipping',121,1500),(60,'IT',103,1400),(70,'Public Relations',204,2700),(80,'Sales',145,2500),(90,'Executive',100,1700),(100,'Finance',108,1700),(110,'Accounting',205,1700),(120,'Treasury',0,1700),(130,'Corporate Tax',0,1700),(140,'Control And Credit',0,1700),(150,'Shareholder Services',0,1700),(160,'Benefits',0,1700),(170,'Manufacturing',0,1700),(180,'Construction',0,1700),(190,'Contracting',0,1700),(200,'Operations',0,1700),(210,'IT Support',0,1700),(220,'NOC',0,1700),(230,'IT Helpdesk',0,1700),(240,'Government Sales',0,1700),(250,'Retail Sales',0,1700),(260,'Recruiting',0,1700),(270,'Payroll',0,1700);
/*!40000 ALTER TABLE w3resources_exercises.departments_aggregate ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.employees_aggregate;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.employees_aggregate(
  `EMPLOYEE_ID` decimal(6,0) NOT NULL DEFAULT '0',
  `FIRST_NAME` varchar(20) DEFAULT NULL,
  `LAST_NAME` varchar(25) NOT NULL,
  `EMAIL` varchar(25) NOT NULL,
  `PHONE_NUMBER` varchar(20) DEFAULT NULL,
  `HIRE_DATE` date NOT NULL,
  `JOB_ID` varchar(10) NOT NULL,
  `SALARY` decimal(8,2) DEFAULT NULL,
  `COMMISSION_PCT` decimal(2,2) DEFAULT NULL,
  `MANAGER_ID` decimal(6,0) DEFAULT NULL,
  `DEPARTMENT_ID` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`),
  UNIQUE KEY `EMP_EMAIL_UK` (`EMAIL`),
  KEY `EMP_DEPARTMENT_IX` (`DEPARTMENT_ID`),
  KEY `EMP_JOB_IX` (`JOB_ID`),
  KEY `EMP_MANAGER_IX` (`MANAGER_ID`),
  KEY `EMP_NAME_IX` (`LAST_NAME`,`FIRST_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.employees_aggregate WRITE;
/*!40000 ALTER TABLE w3resources_exercises.employees_aggregate DISABLE KEYS */;
INSERT INTO w3resources_exercises.employees_aggregate VALUES (100,'Steven','King','SKING','515.123.4567','1987-06-17','AD_PRES',24000.00,0.00,0,90),(101,'Neena','Kochhar','NKOCHHAR','515.123.4568','1987-06-18','AD_VP',17000.00,0.00,100,90),(102,'Lex','De Haan','LDEHAAN','515.123.4569','1987-06-19','AD_VP',17000.00,0.00,100,90),(103,'Alexander','Hunold','AHUNOLD','590.423.4567','1987-06-20','IT_PROG',9000.00,0.00,102,60),(104,'Bruce','Ernst','BERNST','590.423.4568','1987-06-21','IT_PROG',6000.00,0.00,103,60),(105,'David','Austin','DAUSTIN','590.423.4569','1987-06-22','IT_PROG',4800.00,0.00,103,60),(106,'Valli','Pataballa','VPATABAL','590.423.4560','1987-06-23','IT_PROG',4800.00,0.00,103,60),(107,'Diana','Lorentz','DLORENTZ','590.423.5567','1987-06-24','IT_PROG',4200.00,0.00,103,60),(108,'Nancy','Greenberg','NGREENBE','515.124.4569','1987-06-25','FI_MGR',12000.00,0.00,101,100),(109,'Daniel','Faviet','DFAVIET','515.124.4169','1987-06-26','FI_ACCOUNT',9000.00,0.00,108,100),(110,'John','Chen','JCHEN','515.124.4269','1987-06-27','FI_ACCOUNT',8200.00,0.00,108,100),(111,'Ismael','Sciarra','ISCIARRA','515.124.4369','1987-06-28','FI_ACCOUNT',7700.00,0.00,108,100),(112,'Jose Manuel','Urman','JMURMAN','515.124.4469','1987-06-29','FI_ACCOUNT',7800.00,0.00,108,100),(113,'Luis','Popp','LPOPP','515.124.4567','1987-06-30','FI_ACCOUNT',6900.00,0.00,108,100),(114,'Den','Raphaely','DRAPHEAL','515.127.4561','1987-07-01','PU_MAN',11000.00,0.00,100,30),(115,'Alexander','Khoo','AKHOO','515.127.4562','1987-07-02','PU_CLERK',3100.00,0.00,114,30),(116,'Shelli','Baida','SBAIDA','515.127.4563','1987-07-03','PU_CLERK',2900.00,0.00,114,30),(117,'Sigal','Tobias','STOBIAS','515.127.4564','1987-07-04','PU_CLERK',2800.00,0.00,114,30),(118,'Guy','Himuro','GHIMURO','515.127.4565','1987-07-05','PU_CLERK',2600.00,0.00,114,30),(119,'Karen','Colmenares','KCOLMENA','515.127.4566','1987-07-06','PU_CLERK',2500.00,0.00,114,30),(120,'Matthew','Weiss','MWEISS','650.123.1234','1987-07-07','ST_MAN',8000.00,0.00,100,50),(121,'Adam','Fripp','AFRIPP','650.123.2234','1987-07-08','ST_MAN',8200.00,0.00,100,50),(122,'Payam','Kaufling','PKAUFLIN','650.123.3234','1987-07-09','ST_MAN',7900.00,0.00,100,50),(123,'Shanta','Vollman','SVOLLMAN','650.123.4234','1987-07-10','ST_MAN',6500.00,0.00,100,50),(124,'Kevin','Mourgos','KMOURGOS','650.123.5234','1987-07-11','ST_MAN',5800.00,0.00,100,50),(125,'Julia','Nayer','JNAYER','650.124.1214','1987-07-12','ST_CLERK',3200.00,0.00,120,50),(126,'Irene','Mikkilineni','IMIKKILI','650.124.1224','1987-07-13','ST_CLERK',2700.00,0.00,120,50),(127,'James','Landry','JLANDRY','650.124.1334','1987-07-14','ST_CLERK',2400.00,0.00,120,50),(128,'Steven','Markle','SMARKLE','650.124.1434','1987-07-15','ST_CLERK',2200.00,0.00,120,50),(129,'Laura','Bissot','LBISSOT','650.124.5234','1987-07-16','ST_CLERK',3300.00,0.00,121,50),(130,'Mozhe','Atkinson','MATKINSO','650.124.6234','1987-07-17','ST_CLERK',2800.00,0.00,121,50),(131,'James','Marlow','JAMRLOW','650.124.7234','1987-07-18','ST_CLERK',2500.00,0.00,121,50),(132,'TJ','Olson','TJOLSON','650.124.8234','1987-07-19','ST_CLERK',2100.00,0.00,121,50),(133,'Jason','Mallin','JMALLIN','650.127.1934','1987-07-20','ST_CLERK',3300.00,0.00,122,50),(134,'Michael','Rogers','MROGERS','650.127.1834','1987-07-21','ST_CLERK',2900.00,0.00,122,50),(135,'Ki','Gee','KGEE','650.127.1734','1987-07-22','ST_CLERK',2400.00,0.00,122,50),(136,'Hazel','Philtanker','HPHILTAN','650.127.1634','1987-07-23','ST_CLERK',2200.00,0.00,122,50),(137,'Renske','Ladwig','RLADWIG','650.121.1234','1987-07-24','ST_CLERK',3600.00,0.00,123,50),(138,'Stephen','Stiles','SSTILES','650.121.2034','1987-07-25','ST_CLERK',3200.00,0.00,123,50),(139,'John','Seo','JSEO','650.121.2019','1987-07-26','ST_CLERK',2700.00,0.00,123,50),(140,'Joshua','Patel','JPATEL','650.121.1834','1987-07-27','ST_CLERK',2500.00,0.00,123,50),(141,'Trenna','Rajs','TRAJS','650.121.8009','1987-07-28','ST_CLERK',3500.00,0.00,124,50),(142,'Curtis','Davies','CDAVIES','650.121.2994','1987-07-29','ST_CLERK',3100.00,0.00,124,50),(143,'Randall','Matos','RMATOS','650.121.2874','1987-07-30','ST_CLERK',2600.00,0.00,124,50),(144,'Peter','Vargas','PVARGAS','650.121.2004','1987-07-31','ST_CLERK',2500.00,0.00,124,50),(145,'John','Russell','JRUSSEL','011.44.1344.429268','1987-08-01','SA_MAN',14000.00,0.40,100,80),(146,'Karen','Partners','KPARTNER','011.44.1344.467268','1987-08-02','SA_MAN',13500.00,0.30,100,80),(147,'Alberto','Errazuriz','AERRAZUR','011.44.1344.429278','1987-08-03','SA_MAN',12000.00,0.30,100,80),(148,'Gerald','Cambrault','GCAMBRAU','011.44.1344.619268','1987-08-04','SA_MAN',11000.00,0.30,100,80),(149,'Eleni','Zlotkey','EZLOTKEY','011.44.1344.429018','1987-08-05','SA_MAN',10500.00,0.20,100,80),(150,'Peter','Tucker','PTUCKER','011.44.1344.129268','1987-08-06','SA_REP',10000.00,0.30,145,80),(151,'David','Bernstein','DBERNSTE','011.44.1344.345268','1987-08-07','SA_REP',9500.00,0.25,145,80),(152,'Peter','Hall','PHALL','011.44.1344.478968','1987-08-08','SA_REP',9000.00,0.25,145,80),(153,'Christopher','Olsen','COLSEN','011.44.1344.498718','1987-08-09','SA_REP',8000.00,0.20,145,80),(154,'Nanette','Cambrault','NCAMBRAU','011.44.1344.987668','1987-08-10','SA_REP',7500.00,0.20,145,80),(155,'Oliver','Tuvault','OTUVAULT','011.44.1344.486508','1987-08-11','SA_REP',7000.00,0.15,145,80),(156,'Janette','King','JKING','011.44.1345.429268','1987-08-12','SA_REP',10000.00,0.35,146,80),(157,'Patrick','Sully','PSULLY','011.44.1345.929268','1987-08-13','SA_REP',9500.00,0.35,146,80),(158,'Allan','McEwen','AMCEWEN','011.44.1345.829268','1987-08-14','SA_REP',9000.00,0.35,146,80),(159,'Lindsey','Smith','LSMITH','011.44.1345.729268','1987-08-15','SA_REP',8000.00,0.30,146,80),(160,'Louise','Doran','LDORAN','011.44.1345.629268','1987-08-16','SA_REP',7500.00,0.30,146,80),(161,'Sarath','Sewall','SSEWALL','011.44.1345.529268','1987-08-17','SA_REP',7000.00,0.25,146,80),(162,'Clara','Vishney','CVISHNEY','011.44.1346.129268','1987-08-18','SA_REP',10500.00,0.25,147,80),(163,'Danielle','Greene','DGREENE','011.44.1346.229268','1987-08-19','SA_REP',9500.00,0.15,147,80),(164,'Mattea','Marvins','MMARVINS','011.44.1346.329268','1987-08-20','SA_REP',7200.00,0.10,147,80),(165,'David','Lee','DLEE','011.44.1346.529268','1987-08-21','SA_REP',6800.00,0.10,147,80),(166,'Sundar','Ande','SANDE','011.44.1346.629268','1987-08-22','SA_REP',6400.00,0.10,147,80),(167,'Amit','Banda','ABANDA','011.44.1346.729268','1987-08-23','SA_REP',6200.00,0.10,147,80),(168,'Lisa','Ozer','LOZER','011.44.1343.929268','1987-08-24','SA_REP',11500.00,0.25,148,80),(169,'Harrison','Bloom','HBLOOM','011.44.1343.829268','1987-08-25','SA_REP',10000.00,0.20,148,80),(170,'Tayler','Fox','TFOX','011.44.1343.729268','1987-08-26','SA_REP',9600.00,0.20,148,80),(171,'William','Smith','WSMITH','011.44.1343.629268','1987-08-27','SA_REP',7400.00,0.15,148,80),(172,'Elizabeth','Bates','EBATES','011.44.1343.529268','1987-08-28','SA_REP',7300.00,0.15,148,80),(173,'Sundita','Kumar','SKUMAR','011.44.1343.329268','1987-08-29','SA_REP',6100.00,0.10,148,80),(174,'Ellen','Abel','EABEL','011.44.1644.429267','1987-08-30','SA_REP',11000.00,0.30,149,80),(175,'Alyssa','Hutton','AHUTTON','011.44.1644.429266','1987-08-31','SA_REP',8800.00,0.25,149,80),(176,'Jonathon','Taylor','JTAYLOR','011.44.1644.429265','1987-09-01','SA_REP',8600.00,0.20,149,80),(177,'Jack','Livingston','JLIVINGS','011.44.1644.429264','1987-09-02','SA_REP',8400.00,0.20,149,80),(178,'Kimberely','Grant','KGRANT','011.44.1644.429263','1987-09-03','SA_REP',7000.00,0.15,149,0),(179,'Charles','Johnson','CJOHNSON','011.44.1644.429262','1987-09-04','SA_REP',6200.00,0.10,149,80),(180,'Winston','Taylor','WTAYLOR','650.507.9876','1987-09-05','SH_CLERK',3200.00,0.00,120,50),(181,'Jean','Fleaur','JFLEAUR','650.507.9877','1987-09-06','SH_CLERK',3100.00,0.00,120,50),(182,'Martha','Sullivan','MSULLIVA','650.507.9878','1987-09-07','SH_CLERK',2500.00,0.00,120,50),(183,'Girard','Geoni','GGEONI','650.507.9879','1987-09-08','SH_CLERK',2800.00,0.00,120,50),(184,'Nandita','Sarchand','NSARCHAN','650.509.1876','1987-09-09','SH_CLERK',4200.00,0.00,121,50),(185,'Alexis','Bull','ABULL','650.509.2876','1987-09-10','SH_CLERK',4100.00,0.00,121,50),(186,'Julia','Dellinger','JDELLING','650.509.3876','1987-09-11','SH_CLERK',3400.00,0.00,121,50),(187,'Anthony','Cabrio','ACABRIO','650.509.4876','1987-09-12','SH_CLERK',3000.00,0.00,121,50),(188,'Kelly','Chung','KCHUNG','650.505.1876','1987-09-13','SH_CLERK',3800.00,0.00,122,50),(189,'Jennifer','Dilly','JDILLY','650.505.2876','1987-09-14','SH_CLERK',3600.00,0.00,122,50),(190,'Timothy','Gates','TGATES','650.505.3876','1987-09-15','SH_CLERK',2900.00,0.00,122,50),(191,'Randall','Perkins','RPERKINS','650.505.4876','1987-09-16','SH_CLERK',2500.00,0.00,122,50),(192,'Sarah','Bell','SBELL','650.501.1876','1987-09-17','SH_CLERK',4000.00,0.00,123,50),(193,'Britney','Everett','BEVERETT','650.501.2876','1987-09-18','SH_CLERK',3900.00,0.00,123,50),(194,'Samuel','McCain','SMCCAIN','650.501.3876','1987-09-19','SH_CLERK',3200.00,0.00,123,50),(195,'Vance','Jones','VJONES','650.501.4876','1987-09-20','SH_CLERK',2800.00,0.00,123,50),(196,'Alana','Walsh','AWALSH','650.507.9811','1987-09-21','SH_CLERK',3100.00,0.00,124,50),(197,'Kevin','Feeney','KFEENEY','650.507.9822','1987-09-22','SH_CLERK',3000.00,0.00,124,50),(198,'Donald','OConnell','DOCONNEL','650.507.9833','1987-09-23','SH_CLERK',2600.00,0.00,124,50),(199,'Douglas','Grant','DGRANT','650.507.9844','1987-09-24','SH_CLERK',2600.00,0.00,124,50),(200,'Jennifer','Whalen','JWHALEN','515.123.4444','1987-09-25','AD_ASST',4400.00,0.00,101,10),(201,'Michael','Hartstein','MHARTSTE','515.123.5555','1987-09-26','MK_MAN',13000.00,0.00,100,20),(202,'Pat','Fay','PFAY','603.123.6666','1987-09-27','MK_REP',6000.00,0.00,201,20),(203,'Susan','Mavris','SMAVRIS','515.123.7777','1987-09-28','HR_REP',6500.00,0.00,101,40),(204,'Hermann','Baer','HBAER','515.123.8888','1987-09-29','PR_REP',10000.00,0.00,101,70),(205,'Shelley','Higgins','SHIGGINS','515.123.8080','1987-09-30','AC_MGR',12000.00,0.00,101,110),(206,'William','Gietz','WGIETZ','515.123.8181','1987-10-01','AC_ACCOUNT',8300.00,0.00,205,110);
/*!40000 ALTER TABLE w3resources_exercises.employees_aggregate ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.job_history_aggregate;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.job_history_aggregate (
  `EMPLOYEE_ID` decimal(6,0) NOT NULL,
  `START_DATE` date NOT NULL,
  `END_DATE` date NOT NULL,
  `JOB_ID` varchar(10) NOT NULL,
  `DEPARTMENT_ID` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`,`START_DATE`),
  KEY `JHIST_DEPARTMENT_IX` (`DEPARTMENT_ID`),
  KEY `JHIST_EMPLOYEE_IX` (`EMPLOYEE_ID`),
  KEY `JHIST_JOB_IX` (`JOB_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.job_history_aggregate WRITE;
/*!40000 ALTER TABLE w3resources_exercises.job_history_aggregate DISABLE KEYS */;
INSERT INTO w3resources_exercises.job_history_aggregate VALUES (102,'1993-01-13','1998-07-24','IT_PROG',60),(101,'1989-09-21','1993-10-27','AC_ACCOUNT',110),(101,'1993-10-28','1997-03-15','AC_MGR',110),(201,'1996-02-17','1999-12-19','MK_REP',20),(114,'1998-03-24','1999-12-31','ST_CLERK',50),(122,'1999-01-01','1999-12-31','ST_CLERK',50),(200,'1987-09-17','1993-06-17','AD_ASST',90),(176,'1998-03-24','1998-12-31','SA_REP',80),(176,'1999-01-01','1999-12-31','SA_MAN',80),(200,'1994-07-01','1998-12-31','AC_ACCOUNT',90),(0,'0000-00-00','0000-00-00','',0);
/*!40000 ALTER TABLE w3resources_exercises.job_history_aggregate ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.jobs_aggregate;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.jobs_aggregate (
  `JOB_ID` varchar(10) NOT NULL DEFAULT '',
  `JOB_TITLE` varchar(35) NOT NULL,
  `MIN_SALARY` decimal(6,0) DEFAULT NULL,
  `MAX_SALARY` decimal(6,0) DEFAULT NULL,
  PRIMARY KEY (`JOB_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.jobs_aggregate WRITE;
/*!40000 ALTER TABLE w3resources_exercises.jobs_aggregate DISABLE KEYS */;
INSERT INTO w3resources_exercises.jobs_aggregate VALUES ('AD_PRES','President',20000,40000),('AD_VP','Administration Vice President',15000,30000),('AD_ASST','Administration Assistant',3000,6000),('FI_MGR','Finance Manager',8200,16000),('FI_ACCOUNT','Accountant',4200,9000),('AC_MGR','Accounting Manager',8200,16000),('AC_ACCOUNT','Public Accountant',4200,9000),('SA_MAN','Sales Manager',10000,20000),('SA_REP','Sales Representative',6000,12000),('PU_MAN','Purchasing Manager',8000,15000),('PU_CLERK','Purchasing Clerk',2500,5500),('ST_MAN','Stock Manager',5500,8500),('ST_CLERK','Stock Clerk',2000,5000),('SH_CLERK','Shipping Clerk',2500,5500),('IT_PROG','Programmer',4000,10000),('MK_MAN','Marketing Manager',9000,15000),('MK_REP','Marketing Representative',4000,9000),('HR_REP','Human Resources Representative',4000,9000),('PR_REP','Public Relations Representative',4500,10500);
/*!40000 ALTER TABLE w3resources_exercises.jobs_aggregate ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.locations_aggregate;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.locations_aggregate (
  `LOCATION_ID` decimal(4,0) NOT NULL DEFAULT '0',
  `STREET_ADDRESS` varchar(40) DEFAULT NULL,
  `POSTAL_CODE` varchar(12) DEFAULT NULL,
  `CITY` varchar(30) NOT NULL,
  `STATE_PROVINCE` varchar(25) DEFAULT NULL,
  `COUNTRY_ID` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`LOCATION_ID`),
  KEY `LOC_CITY_IX` (`CITY`),
  KEY `LOC_COUNTRY_IX` (`COUNTRY_ID`),
  KEY `LOC_STATE_PROVINCE_IX` (`STATE_PROVINCE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.locations_aggregate WRITE;
/*!40000 ALTER TABLE w3resources_exercises.locations_aggregate DISABLE KEYS */;
INSERT INTO w3resources_exercises.locations_aggregate VALUES (1000,'1297 Via Cola di Rie','989','Roma','','IT'),(1100,'93091 Calle della Testa','10934','Venice','','IT'),(1200,'2017 Shinjuku-ku','1689','Tokyo','Tokyo Prefecture','JP'),(1300,'9450 Kamiya-cho','6823','Hiroshima','','JP'),(1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US'),(1500,'2011 Interiors Blvd','99236','South San Francisco','California','US'),(1600,'2007 Zagora St','50090','South Brunswick','New Jersey','US'),(1700,'2004 Charade Rd','98199','Seattle','Washington','US'),(1800,'147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA'),(1900,'6092 Boxwood St','YSW 9T2','Whitehorse','Yukon','CA'),(2000,'40-5-12 Laogianggen','190518','Beijing','','CN'),(2100,'1298 Vileparle (E)','490231','Bombay','Maharashtra','IN'),(2200,'12-98 Victoria Street','2901','Sydney','New South Wales','AU'),(2300,'198 Clementi North','540198','Singapore','','SG'),(2400,'8204 Arthur St','','London','','UK'),(2500,'\"Magdalen Centre',' The Oxford ','OX9 9ZB','Oxford','Ox'),(2600,'9702 Chester Road','9629850293','Stretford','Manchester','UK'),(2700,'Schwanthalerstr. 7031','80925','Munich','Bavaria','DE'),(2800,'Rua Frei Caneca 1360','01307-002','Sao Paulo','Sao Paulo','BR'),(2900,'20 Rue des Corps-Saints','1730','Geneva','Geneve','CH'),(3000,'Murtenstrasse 921','3095','Bern','BE','CH'),(3100,'Pieter Breughelstraat 837','3029SK','Utrecht','Utrecht','NL'),(3200,'Mariano Escobedo 9991','11932','Mexico City','\"Distrito Federal','\"');
/*!40000 ALTER TABLE w3resources_exercises.locations_aggregate ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.regions_aggregate;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.regions_aggregate (
  `REGION_ID` decimal(5,0) NOT NULL,
  `REGION_NAME` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`REGION_ID`),
  UNIQUE KEY `sss` (`REGION_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.regions_aggregate WRITE;
/*!40000 ALTER TABLE w3resources_exercises.regions_aggregate DISABLE KEYS */;
INSERT INTO w3resources_exercises.regions_aggregate VALUES (1,'Europe\r'),(2,'Americas\r'),(3,'Asia\r'),(4,'Middle East and Africa\r');
/*!40000 ALTER TABLE w3resources_exercises.regions_aggregate ENABLE KEYS */;
UNLOCK TABLES;

Select * 
from w3resources_exercises.countries_aggregate;

select * 
from w3resources_exercises.departments_aggregate;

select *
from w3resources_exercises.employees_aggregate;

select *
from w3resources_exercises.job_history_aggregate;

select *
from w3resources_exercises.regions_aggregate;

select *
from w3resources_exercises.locations_aggregate;

select *
from w3resources_exercises.jobs_aggregate;

-- mostre quantos jobs estao registrados na planilha employees
select count(distinct job_id), count(job_id)
from w3resources_exercises.employees_aggregate;

-- some todos os salarios dos funcionarios
select sum(salary)
from w3resources_exercises.employees_aggregate;

-- encontre o employee_id e o salario do funcionario com menor salario
select employee_id, salary
from w3resources_exercises.employees_aggregate
where salary = (select MIN(salary) from w3resources_exercises.employees_aggregate);

-- encontre o funcionario que é programmer com maior salario (IT_PROG)
select employee_id, salary
from w3resources_exercises.employees_aggregate
where job_id = 'IT_PROG'  
	AND salary = (select MAX(salary) from w3resources_exercises.employees_aggregate where job_id = 'IT_PROG');

-- conte quantos funcionários há no departamento 90 e qual a media salarial deles
select count(employee_id), avg(salary)
from w3resources_exercises.employees_aggregate
where department_id = 90;

-- conte quantos funcionarios há em cada job_id
select job_id, count(employee_id)
from w3resources_exercises.employees_aggregate
group by job_id;

-- encontre a diferença entre o maior e o menor salario
select max(salary)-min(salary)
from w3resources_exercises.employees_aggregate;

-- encontre o menor salario de cada time de acordo com o manager_d
select manager_id, min(salary)
from w3resources_exercises.employees_aggregate
where manager_id IS NOT NULL
group by manager_id
order by min(salary) desc;

-- mostre o total de salarios de cada departamento baseado no department_id
select department_id, sum(salary)
from w3resources_exercises.employees_aggregate
group by department_id;

-- mostre a media salarial de cada job_id
select job_id, avg(salary)
from w3resources_exercises.employees_aggregate
group by job_id;

-- encontre o total de salarios, min salario, max salario e media salarias de cada job_id dentro do departamento 90
select job_id, sum(salary), min(salary), max(salary), avg(salary)
from w3resources_exercises.employees_aggregate
where department_id = 90
group by job_id;

## exercicios subquery (subquery e join fazem coisas similares, é só entender a sua preferencia)
-- link dos exercicios: https://www.w3resource.com/mysql-exercises/subquery-exercises/index.php

-- criando database de novo
DROP TABLE IF EXISTS w3resources_exercises.countries_subquery;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.countries_subquery (
  `COUNTRY_ID` varchar(2) NOT NULL,
  `COUNTRY_NAME` varchar(40) DEFAULT NULL,
  `REGION_ID` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`COUNTRY_ID`),
  KEY `COUNTR_REG_FK` (`REGION_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.countries_subquery WRITE;
/*!40000 ALTER TABLE w3resources_exercises.countries_subquery DISABLE KEYS */;
INSERT INTO w3resources_exercises.countries_subquery VALUES ('AR','Argentina',2),('AU','Australia',3),('BE','Belgium',1),('BR','Brazil',2),('CA','Canada',2),('CH','Switzerland',1),('CN','China',3),('DE','Germany',1),('DK','Denmark',1),('EG','Egypt',4),('FR','France',1),('HK','HongKong',3),('IL','Israel',4),('IN','India',3),('IT','Italy',1),('JP','Japan',3),('KW','Kuwait',4),('MX','Mexico',2),('NG','Nigeria',4),('NL','Netherlands',1),('SG','Singapore',3),('UK','United Kingdom',1),('US','United States of America',2),('ZM','Zambia',4),('ZW','Zimbabwe',4);
/*!40000 ALTER TABLE w3resources_exercises.countries_subquery ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.departments_subquery;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.departments_subquery (
  `DEPARTMENT_ID` decimal(4,0) NOT NULL DEFAULT '0',
  `DEPARTMENT_NAME` varchar(30) NOT NULL,
  `MANAGER_ID` decimal(6,0) DEFAULT NULL,
  `LOCATION_ID` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`DEPARTMENT_ID`),
  KEY `DEPT_MGR_FK` (`MANAGER_ID`),
  KEY `DEPT_LOCATION_IX` (`LOCATION_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.departments_subquery WRITE;
/*!40000 ALTER TABLE w3resources_exercises.departments_subquery DISABLE KEYS */;
INSERT INTO w3resources_exercises.departments_subquery VALUES (10,'Administration',200,1700),(20,'Marketing',201,1800),(30,'Purchasing',114,1700),(40,'Human Resources',203,2400),(50,'Shipping',121,1500),(60,'IT',103,1400),(70,'Public Relations',204,2700),(80,'Sales',145,2500),(90,'Executive',100,1700),(100,'Finance',108,1700),(110,'Accounting',205,1700),(120,'Treasury',0,1700),(130,'Corporate Tax',0,1700),(140,'Control And Credit',0,1700),(150,'Shareholder Services',0,1700),(160,'Benefits',0,1700),(170,'Manufacturing',0,1700),(180,'Construction',0,1700),(190,'Contracting',0,1700),(200,'Operations',0,1700),(210,'IT Support',0,1700),(220,'NOC',0,1700),(230,'IT Helpdesk',0,1700),(240,'Government Sales',0,1700),(250,'Retail Sales',0,1700),(260,'Recruiting',0,1700),(270,'Payroll',0,1700);
/*!40000 ALTER TABLE w3resources_exercises.departments_subquery ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.employees_subquery;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.employees_subquery(
  `EMPLOYEE_ID` decimal(6,0) NOT NULL DEFAULT '0',
  `FIRST_NAME` varchar(20) DEFAULT NULL,
  `LAST_NAME` varchar(25) NOT NULL,
  `EMAIL` varchar(25) NOT NULL,
  `PHONE_NUMBER` varchar(20) DEFAULT NULL,
  `HIRE_DATE` date NOT NULL,
  `JOB_ID` varchar(10) NOT NULL,
  `SALARY` decimal(8,2) DEFAULT NULL,
  `COMMISSION_PCT` decimal(2,2) DEFAULT NULL,
  `MANAGER_ID` decimal(6,0) DEFAULT NULL,
  `DEPARTMENT_ID` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`),
  UNIQUE KEY `EMP_EMAIL_UK` (`EMAIL`),
  KEY `EMP_DEPARTMENT_IX` (`DEPARTMENT_ID`),
  KEY `EMP_JOB_IX` (`JOB_ID`),
  KEY `EMP_MANAGER_IX` (`MANAGER_ID`),
  KEY `EMP_NAME_IX` (`LAST_NAME`,`FIRST_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.employees_subquery WRITE;
/*!40000 ALTER TABLE w3resources_exercises.employees_subquery DISABLE KEYS */;
INSERT INTO w3resources_exercises.employees_subquery VALUES (100,'Steven','King','SKING','515.123.4567','1987-06-17','AD_PRES',24000.00,0.00,0,90),(101,'Neena','Kochhar','NKOCHHAR','515.123.4568','1987-06-18','AD_VP',17000.00,0.00,100,90),(102,'Lex','De Haan','LDEHAAN','515.123.4569','1987-06-19','AD_VP',17000.00,0.00,100,90),(103,'Alexander','Hunold','AHUNOLD','590.423.4567','1987-06-20','IT_PROG',9000.00,0.00,102,60),(104,'Bruce','Ernst','BERNST','590.423.4568','1987-06-21','IT_PROG',6000.00,0.00,103,60),(105,'David','Austin','DAUSTIN','590.423.4569','1987-06-22','IT_PROG',4800.00,0.00,103,60),(106,'Valli','Pataballa','VPATABAL','590.423.4560','1987-06-23','IT_PROG',4800.00,0.00,103,60),(107,'Diana','Lorentz','DLORENTZ','590.423.5567','1987-06-24','IT_PROG',4200.00,0.00,103,60),(108,'Nancy','Greenberg','NGREENBE','515.124.4569','1987-06-25','FI_MGR',12000.00,0.00,101,100),(109,'Daniel','Faviet','DFAVIET','515.124.4169','1987-06-26','FI_ACCOUNT',9000.00,0.00,108,100),(110,'John','Chen','JCHEN','515.124.4269','1987-06-27','FI_ACCOUNT',8200.00,0.00,108,100),(111,'Ismael','Sciarra','ISCIARRA','515.124.4369','1987-06-28','FI_ACCOUNT',7700.00,0.00,108,100),(112,'Jose Manuel','Urman','JMURMAN','515.124.4469','1987-06-29','FI_ACCOUNT',7800.00,0.00,108,100),(113,'Luis','Popp','LPOPP','515.124.4567','1987-06-30','FI_ACCOUNT',6900.00,0.00,108,100),(114,'Den','Raphaely','DRAPHEAL','515.127.4561','1987-07-01','PU_MAN',11000.00,0.00,100,30),(115,'Alexander','Khoo','AKHOO','515.127.4562','1987-07-02','PU_CLERK',3100.00,0.00,114,30),(116,'Shelli','Baida','SBAIDA','515.127.4563','1987-07-03','PU_CLERK',2900.00,0.00,114,30),(117,'Sigal','Tobias','STOBIAS','515.127.4564','1987-07-04','PU_CLERK',2800.00,0.00,114,30),(118,'Guy','Himuro','GHIMURO','515.127.4565','1987-07-05','PU_CLERK',2600.00,0.00,114,30),(119,'Karen','Colmenares','KCOLMENA','515.127.4566','1987-07-06','PU_CLERK',2500.00,0.00,114,30),(120,'Matthew','Weiss','MWEISS','650.123.1234','1987-07-07','ST_MAN',8000.00,0.00,100,50),(121,'Adam','Fripp','AFRIPP','650.123.2234','1987-07-08','ST_MAN',8200.00,0.00,100,50),(122,'Payam','Kaufling','PKAUFLIN','650.123.3234','1987-07-09','ST_MAN',7900.00,0.00,100,50),(123,'Shanta','Vollman','SVOLLMAN','650.123.4234','1987-07-10','ST_MAN',6500.00,0.00,100,50),(124,'Kevin','Mourgos','KMOURGOS','650.123.5234','1987-07-11','ST_MAN',5800.00,0.00,100,50),(125,'Julia','Nayer','JNAYER','650.124.1214','1987-07-12','ST_CLERK',3200.00,0.00,120,50),(126,'Irene','Mikkilineni','IMIKKILI','650.124.1224','1987-07-13','ST_CLERK',2700.00,0.00,120,50),(127,'James','Landry','JLANDRY','650.124.1334','1987-07-14','ST_CLERK',2400.00,0.00,120,50),(128,'Steven','Markle','SMARKLE','650.124.1434','1987-07-15','ST_CLERK',2200.00,0.00,120,50),(129,'Laura','Bissot','LBISSOT','650.124.5234','1987-07-16','ST_CLERK',3300.00,0.00,121,50),(130,'Mozhe','Atkinson','MATKINSO','650.124.6234','1987-07-17','ST_CLERK',2800.00,0.00,121,50),(131,'James','Marlow','JAMRLOW','650.124.7234','1987-07-18','ST_CLERK',2500.00,0.00,121,50),(132,'TJ','Olson','TJOLSON','650.124.8234','1987-07-19','ST_CLERK',2100.00,0.00,121,50),(133,'Jason','Mallin','JMALLIN','650.127.1934','1987-07-20','ST_CLERK',3300.00,0.00,122,50),(134,'Michael','Rogers','MROGERS','650.127.1834','1987-07-21','ST_CLERK',2900.00,0.00,122,50),(135,'Ki','Gee','KGEE','650.127.1734','1987-07-22','ST_CLERK',2400.00,0.00,122,50),(136,'Hazel','Philtanker','HPHILTAN','650.127.1634','1987-07-23','ST_CLERK',2200.00,0.00,122,50),(137,'Renske','Ladwig','RLADWIG','650.121.1234','1987-07-24','ST_CLERK',3600.00,0.00,123,50),(138,'Stephen','Stiles','SSTILES','650.121.2034','1987-07-25','ST_CLERK',3200.00,0.00,123,50),(139,'John','Seo','JSEO','650.121.2019','1987-07-26','ST_CLERK',2700.00,0.00,123,50),(140,'Joshua','Patel','JPATEL','650.121.1834','1987-07-27','ST_CLERK',2500.00,0.00,123,50),(141,'Trenna','Rajs','TRAJS','650.121.8009','1987-07-28','ST_CLERK',3500.00,0.00,124,50),(142,'Curtis','Davies','CDAVIES','650.121.2994','1987-07-29','ST_CLERK',3100.00,0.00,124,50),(143,'Randall','Matos','RMATOS','650.121.2874','1987-07-30','ST_CLERK',2600.00,0.00,124,50),(144,'Peter','Vargas','PVARGAS','650.121.2004','1987-07-31','ST_CLERK',2500.00,0.00,124,50),(145,'John','Russell','JRUSSEL','011.44.1344.429268','1987-08-01','SA_MAN',14000.00,0.40,100,80),(146,'Karen','Partners','KPARTNER','011.44.1344.467268','1987-08-02','SA_MAN',13500.00,0.30,100,80),(147,'Alberto','Errazuriz','AERRAZUR','011.44.1344.429278','1987-08-03','SA_MAN',12000.00,0.30,100,80),(148,'Gerald','Cambrault','GCAMBRAU','011.44.1344.619268','1987-08-04','SA_MAN',11000.00,0.30,100,80),(149,'Eleni','Zlotkey','EZLOTKEY','011.44.1344.429018','1987-08-05','SA_MAN',10500.00,0.20,100,80),(150,'Peter','Tucker','PTUCKER','011.44.1344.129268','1987-08-06','SA_REP',10000.00,0.30,145,80),(151,'David','Bernstein','DBERNSTE','011.44.1344.345268','1987-08-07','SA_REP',9500.00,0.25,145,80),(152,'Peter','Hall','PHALL','011.44.1344.478968','1987-08-08','SA_REP',9000.00,0.25,145,80),(153,'Christopher','Olsen','COLSEN','011.44.1344.498718','1987-08-09','SA_REP',8000.00,0.20,145,80),(154,'Nanette','Cambrault','NCAMBRAU','011.44.1344.987668','1987-08-10','SA_REP',7500.00,0.20,145,80),(155,'Oliver','Tuvault','OTUVAULT','011.44.1344.486508','1987-08-11','SA_REP',7000.00,0.15,145,80),(156,'Janette','King','JKING','011.44.1345.429268','1987-08-12','SA_REP',10000.00,0.35,146,80),(157,'Patrick','Sully','PSULLY','011.44.1345.929268','1987-08-13','SA_REP',9500.00,0.35,146,80),(158,'Allan','McEwen','AMCEWEN','011.44.1345.829268','1987-08-14','SA_REP',9000.00,0.35,146,80),(159,'Lindsey','Smith','LSMITH','011.44.1345.729268','1987-08-15','SA_REP',8000.00,0.30,146,80),(160,'Louise','Doran','LDORAN','011.44.1345.629268','1987-08-16','SA_REP',7500.00,0.30,146,80),(161,'Sarath','Sewall','SSEWALL','011.44.1345.529268','1987-08-17','SA_REP',7000.00,0.25,146,80),(162,'Clara','Vishney','CVISHNEY','011.44.1346.129268','1987-08-18','SA_REP',10500.00,0.25,147,80),(163,'Danielle','Greene','DGREENE','011.44.1346.229268','1987-08-19','SA_REP',9500.00,0.15,147,80),(164,'Mattea','Marvins','MMARVINS','011.44.1346.329268','1987-08-20','SA_REP',7200.00,0.10,147,80),(165,'David','Lee','DLEE','011.44.1346.529268','1987-08-21','SA_REP',6800.00,0.10,147,80),(166,'Sundar','Ande','SANDE','011.44.1346.629268','1987-08-22','SA_REP',6400.00,0.10,147,80),(167,'Amit','Banda','ABANDA','011.44.1346.729268','1987-08-23','SA_REP',6200.00,0.10,147,80),(168,'Lisa','Ozer','LOZER','011.44.1343.929268','1987-08-24','SA_REP',11500.00,0.25,148,80),(169,'Harrison','Bloom','HBLOOM','011.44.1343.829268','1987-08-25','SA_REP',10000.00,0.20,148,80),(170,'Tayler','Fox','TFOX','011.44.1343.729268','1987-08-26','SA_REP',9600.00,0.20,148,80),(171,'William','Smith','WSMITH','011.44.1343.629268','1987-08-27','SA_REP',7400.00,0.15,148,80),(172,'Elizabeth','Bates','EBATES','011.44.1343.529268','1987-08-28','SA_REP',7300.00,0.15,148,80),(173,'Sundita','Kumar','SKUMAR','011.44.1343.329268','1987-08-29','SA_REP',6100.00,0.10,148,80),(174,'Ellen','Abel','EABEL','011.44.1644.429267','1987-08-30','SA_REP',11000.00,0.30,149,80),(175,'Alyssa','Hutton','AHUTTON','011.44.1644.429266','1987-08-31','SA_REP',8800.00,0.25,149,80),(176,'Jonathon','Taylor','JTAYLOR','011.44.1644.429265','1987-09-01','SA_REP',8600.00,0.20,149,80),(177,'Jack','Livingston','JLIVINGS','011.44.1644.429264','1987-09-02','SA_REP',8400.00,0.20,149,80),(178,'Kimberely','Grant','KGRANT','011.44.1644.429263','1987-09-03','SA_REP',7000.00,0.15,149,0),(179,'Charles','Johnson','CJOHNSON','011.44.1644.429262','1987-09-04','SA_REP',6200.00,0.10,149,80),(180,'Winston','Taylor','WTAYLOR','650.507.9876','1987-09-05','SH_CLERK',3200.00,0.00,120,50),(181,'Jean','Fleaur','JFLEAUR','650.507.9877','1987-09-06','SH_CLERK',3100.00,0.00,120,50),(182,'Martha','Sullivan','MSULLIVA','650.507.9878','1987-09-07','SH_CLERK',2500.00,0.00,120,50),(183,'Girard','Geoni','GGEONI','650.507.9879','1987-09-08','SH_CLERK',2800.00,0.00,120,50),(184,'Nandita','Sarchand','NSARCHAN','650.509.1876','1987-09-09','SH_CLERK',4200.00,0.00,121,50),(185,'Alexis','Bull','ABULL','650.509.2876','1987-09-10','SH_CLERK',4100.00,0.00,121,50),(186,'Julia','Dellinger','JDELLING','650.509.3876','1987-09-11','SH_CLERK',3400.00,0.00,121,50),(187,'Anthony','Cabrio','ACABRIO','650.509.4876','1987-09-12','SH_CLERK',3000.00,0.00,121,50),(188,'Kelly','Chung','KCHUNG','650.505.1876','1987-09-13','SH_CLERK',3800.00,0.00,122,50),(189,'Jennifer','Dilly','JDILLY','650.505.2876','1987-09-14','SH_CLERK',3600.00,0.00,122,50),(190,'Timothy','Gates','TGATES','650.505.3876','1987-09-15','SH_CLERK',2900.00,0.00,122,50),(191,'Randall','Perkins','RPERKINS','650.505.4876','1987-09-16','SH_CLERK',2500.00,0.00,122,50),(192,'Sarah','Bell','SBELL','650.501.1876','1987-09-17','SH_CLERK',4000.00,0.00,123,50),(193,'Britney','Everett','BEVERETT','650.501.2876','1987-09-18','SH_CLERK',3900.00,0.00,123,50),(194,'Samuel','McCain','SMCCAIN','650.501.3876','1987-09-19','SH_CLERK',3200.00,0.00,123,50),(195,'Vance','Jones','VJONES','650.501.4876','1987-09-20','SH_CLERK',2800.00,0.00,123,50),(196,'Alana','Walsh','AWALSH','650.507.9811','1987-09-21','SH_CLERK',3100.00,0.00,124,50),(197,'Kevin','Feeney','KFEENEY','650.507.9822','1987-09-22','SH_CLERK',3000.00,0.00,124,50),(198,'Donald','OConnell','DOCONNEL','650.507.9833','1987-09-23','SH_CLERK',2600.00,0.00,124,50),(199,'Douglas','Grant','DGRANT','650.507.9844','1987-09-24','SH_CLERK',2600.00,0.00,124,50),(200,'Jennifer','Whalen','JWHALEN','515.123.4444','1987-09-25','AD_ASST',4400.00,0.00,101,10),(201,'Michael','Hartstein','MHARTSTE','515.123.5555','1987-09-26','MK_MAN',13000.00,0.00,100,20),(202,'Pat','Fay','PFAY','603.123.6666','1987-09-27','MK_REP',6000.00,0.00,201,20),(203,'Susan','Mavris','SMAVRIS','515.123.7777','1987-09-28','HR_REP',6500.00,0.00,101,40),(204,'Hermann','Baer','HBAER','515.123.8888','1987-09-29','PR_REP',10000.00,0.00,101,70),(205,'Shelley','Higgins','SHIGGINS','515.123.8080','1987-09-30','AC_MGR',12000.00,0.00,101,110),(206,'William','Gietz','WGIETZ','515.123.8181','1987-10-01','AC_ACCOUNT',8300.00,0.00,205,110);
/*!40000 ALTER TABLE w3resources_exercises.employees_subquery ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.job_history_subquery;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.job_history_subquery (
  `EMPLOYEE_ID` decimal(6,0) NOT NULL,
  `START_DATE` date NOT NULL,
  `END_DATE` date NOT NULL,
  `JOB_ID` varchar(10) NOT NULL,
  `DEPARTMENT_ID` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`,`START_DATE`),
  KEY `JHIST_DEPARTMENT_IX` (`DEPARTMENT_ID`),
  KEY `JHIST_EMPLOYEE_IX` (`EMPLOYEE_ID`),
  KEY `JHIST_JOB_IX` (`JOB_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.job_history_subquery WRITE;
/*!40000 ALTER TABLE w3resources_exercises.job_history_subquery DISABLE KEYS */;
INSERT INTO w3resources_exercises.job_history_subquery VALUES (102,'1993-01-13','1998-07-24','IT_PROG',60),(101,'1989-09-21','1993-10-27','AC_ACCOUNT',110),(101,'1993-10-28','1997-03-15','AC_MGR',110),(201,'1996-02-17','1999-12-19','MK_REP',20),(114,'1998-03-24','1999-12-31','ST_CLERK',50),(122,'1999-01-01','1999-12-31','ST_CLERK',50),(200,'1987-09-17','1993-06-17','AD_ASST',90),(176,'1998-03-24','1998-12-31','SA_REP',80),(176,'1999-01-01','1999-12-31','SA_MAN',80),(200,'1994-07-01','1998-12-31','AC_ACCOUNT',90),(0,'0000-00-00','0000-00-00','',0);
/*!40000 ALTER TABLE w3resources_exercises.job_history_subquery ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.jobs_subquery;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.jobs_subquery (
  `JOB_ID` varchar(10) NOT NULL DEFAULT '',
  `JOB_TITLE` varchar(35) NOT NULL,
  `MIN_SALARY` decimal(6,0) DEFAULT NULL,
  `MAX_SALARY` decimal(6,0) DEFAULT NULL,
  PRIMARY KEY (`JOB_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.jobs_subquery WRITE;
/*!40000 ALTER TABLE w3resources_exercises.jobs_subquery DISABLE KEYS */;
INSERT INTO w3resources_exercises.jobs_subquery VALUES ('AD_PRES','President',20000,40000),('AD_VP','Administration Vice President',15000,30000),('AD_ASST','Administration Assistant',3000,6000),('FI_MGR','Finance Manager',8200,16000),('FI_ACCOUNT','Accountant',4200,9000),('AC_MGR','Accounting Manager',8200,16000),('AC_ACCOUNT','Public Accountant',4200,9000),('SA_MAN','Sales Manager',10000,20000),('SA_REP','Sales Representative',6000,12000),('PU_MAN','Purchasing Manager',8000,15000),('PU_CLERK','Purchasing Clerk',2500,5500),('ST_MAN','Stock Manager',5500,8500),('ST_CLERK','Stock Clerk',2000,5000),('SH_CLERK','Shipping Clerk',2500,5500),('IT_PROG','Programmer',4000,10000),('MK_MAN','Marketing Manager',9000,15000),('MK_REP','Marketing Representative',4000,9000),('HR_REP','Human Resources Representative',4000,9000),('PR_REP','Public Relations Representative',4500,10500);
/*!40000 ALTER TABLE w3resources_exercises.jobs_subquery ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.locations_subquery;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.locations_subquery (
  `LOCATION_ID` decimal(4,0) NOT NULL DEFAULT '0',
  `STREET_ADDRESS` varchar(40) DEFAULT NULL,
  `POSTAL_CODE` varchar(12) DEFAULT NULL,
  `CITY` varchar(30) NOT NULL,
  `STATE_PROVINCE` varchar(25) DEFAULT NULL,
  `COUNTRY_ID` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`LOCATION_ID`),
  KEY `LOC_CITY_IX` (`CITY`),
  KEY `LOC_COUNTRY_IX` (`COUNTRY_ID`),
  KEY `LOC_STATE_PROVINCE_IX` (`STATE_PROVINCE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.locations_subquery WRITE;
/*!40000 ALTER TABLE w3resources_exercises.locations_subquery DISABLE KEYS */;
INSERT INTO w3resources_exercises.locations_subquery VALUES (1000,'1297 Via Cola di Rie','989','Roma','','IT'),(1100,'93091 Calle della Testa','10934','Venice','','IT'),(1200,'2017 Shinjuku-ku','1689','Tokyo','Tokyo Prefecture','JP'),(1300,'9450 Kamiya-cho','6823','Hiroshima','','JP'),(1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US'),(1500,'2011 Interiors Blvd','99236','South San Francisco','California','US'),(1600,'2007 Zagora St','50090','South Brunswick','New Jersey','US'),(1700,'2004 Charade Rd','98199','Seattle','Washington','US'),(1800,'147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA'),(1900,'6092 Boxwood St','YSW 9T2','Whitehorse','Yukon','CA'),(2000,'40-5-12 Laogianggen','190518','Beijing','','CN'),(2100,'1298 Vileparle (E)','490231','Bombay','Maharashtra','IN'),(2200,'12-98 Victoria Street','2901','Sydney','New South Wales','AU'),(2300,'198 Clementi North','540198','Singapore','','SG'),(2400,'8204 Arthur St','','London','','UK'),(2500,'\"Magdalen Centre',' The Oxford ','OX9 9ZB','Oxford','Ox'),(2600,'9702 Chester Road','9629850293','Stretford','Manchester','UK'),(2700,'Schwanthalerstr. 7031','80925','Munich','Bavaria','DE'),(2800,'Rua Frei Caneca 1360','01307-002','Sao Paulo','Sao Paulo','BR'),(2900,'20 Rue des Corps-Saints','1730','Geneva','Geneve','CH'),(3000,'Murtenstrasse 921','3095','Bern','BE','CH'),(3100,'Pieter Breughelstraat 837','3029SK','Utrecht','Utrecht','NL'),(3200,'Mariano Escobedo 9991','11932','Mexico City','\"Distrito Federal','\"');
/*!40000 ALTER TABLE w3resources_exercises.locations_subquery ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS w3resources_exercises.regions_subquery;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE w3resources_exercises.regions_subquery (
  `REGION_ID` decimal(5,0) NOT NULL,
  `REGION_NAME` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`REGION_ID`),
  UNIQUE KEY `sss` (`REGION_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES w3resources_exercises.regions_subquery WRITE;
/*!40000 ALTER TABLE w3resources_exercises.regions_subquery DISABLE KEYS */;
INSERT INTO w3resources_exercises.regions_subquery VALUES (1,'Europe\r'),(2,'Americas\r'),(3,'Asia\r'),(4,'Middle East and Africa\r');
/*!40000 ALTER TABLE w3resources_exercises.regions_subquery ENABLE KEYS */;
UNLOCK TABLES;

Select * 
from w3resources_exercises.countries_subquery;

select * 
from w3resources_exercises.departments_subquery;

select *
from w3resources_exercises.employees_subquery;

select *
from w3resources_exercises.job_history_subquery;

select *
from w3resources_exercises.regions_subquery;

select *
from w3resources_exercises.locations_subquery;

select *
from w3resources_exercises.jobs_aggregate;

-- encontre o employee_id, first_name, last_name de todos os funcionarios do IT deparment
select em.employee_id, em.first_name, em.last_name, dep.department_name
from w3resources_exercises.employees_subquery as EM
natural join w3resources_exercises.departments_subquery as DEP
where dep.department_name LIKE 'IT%';
#agora fazer com subquery
select employee_id, first_name, last_name
from w3resources_exercises.employees_subquery
where department_id = (select department_id from w3resources_exercises.departments_subquery where department_name LIKE 'IT'); #o resultado do subquery so pode ter uma linha, se nao da erro

-- encontre o employee_id, first_name, last_name de todos os funcionarios no qual está nos EUA
select employee_id, first_name, last_name
from w3resources_exercises.employees_subquery
where department_id in ( #se usar o IN ao inves do =, a query pode retornar mais de um valor sem dar erro
	select department_id from w3resources_exercises.departments_subquery where location_id in 
		(select location_id from w3resources_exercises.locations_subquery where country_id = 'US')
);
# vou tentar fazer o mesmo com join, so para teste
select em.employee_id, em.first_name, em.last_name, dep.department_id
from w3resources_exercises.employees_subquery as EM
join w3resources_exercises.departments_subquery as DEP
ON (em.department_id = dep.department_id)
join w3resources_exercises.locations_subquery as LOC
on (dep.location_id = loc.location_id)
where loc.country_id = 'US';

-- pegue o employee_id, first_name, last_name de funcionarios que NAO sao gerentes
select employee_id, first_name, last_name
from w3resources_exercises.employees_subquery
where employee_id not in (select manager_id from w3resources_exercises.employees_subquery);


##Estudo de dates
-- Link dos exercicios: https://www.w3resource.com/mysql-exercises/date-time-exercises/index.php

-- encontrei o primeiro dia do mes de tres meses atras
SELECT 
date(((PERIOD_ADD -- ajuda no calculo para tirar tres meses de hoje
    (EXTRACT(YEAR_MONTH -- puxa mes e ano de hoje
    FROM CURDATE()) -- curdate é a data de hoje
    ,-3)*100)+1));

-- encontre o ultimo dia do mes de tres meses atras
SELECT 
   DATE_ADD(LAST_DAY(NOW() - INTERVAL 4 MONTH), INTERVAL 1 DAY) AS primeiro_dia_3mesestras,
   (LAST_DAY(NOW() - INTERVAL 3 MONTH)) AS ultimo_dia_mes__3mesestras;


-- encontre o primeiro dia deste ano
SELECT 
MAKEDATE( -- cria data 
EXTRACT(YEAR FROM CURDATE()), -- puxa o atual ano
        1 -- coloque o dia como 1.
    );

-- encontre o ultimo dia deste ano
SELECT 
    STR_TO_DATE( -- converte string em data
CONCAT( 
            12, -- coloca meses em numeros
            31, -- coloca em dias 
EXTRACT(YEAR FROM CURDATE()) -- puxa o ano da data de hoje
        ), 
        '%m%d%Y'
    );

-- puxa a data de hoje no formato escrito(ex:Setembr 4, 2014)
SELECT 
    DATE_FORMAT(
CURDATE(),
        '%M %e, %Y'
    ) 
    AS 'Current_date'; 

-- converta um valor numerico em data
SELECT 
    FROM_DAYS(730677);
    
-- encontre os funcionarios contratados entre 19871-06-01 a 1987-07-30
select *
from w3resources_exercises.employees_subquery
where hire_date between '1987-06-01' AND '1987-07-30';

-- puxe o dia de hoje no formato descritivo, com dia da semana e hora
SELECT 
date_format( -- Formats a date and time value according to the specified format.
CURDATE(), -- Retrieves the current date using the CURDATE() function.
        '%W %D %M %Y %T' -- Specifies the desired format for the date and time.
    );
    
-- puxe o dia de hoje no formato brasileiro de data
SELECT 
date_format( -- Formats a date value according to the specified format.
CURDATE(), -- Retrieves the current date using the CURDATE() function.
        '%d/%m/%Y' -- Specifies the desired format for the date.
    );

-- encontre o ano que houve mais de 10 contrataçoes
select date_format(hire_date, '%Y'),count(employee_id) #obs: '%y' tras so os ultimos 2 digitos do anos
from w3resources_exercises.employees_subquery
group by date_format(hire_date,'%Y')
having count(employee_id)>10;

-- encontre os funcionarios contratados em 1987
select employee_id, first_name, last_name
from w3resources_exercises.employees_subquery
where date_format(hire_date, '%Y') = 1987;

-- encontre os manager com mais de 5 anos de experiencia
select *
from w3resources_exercises.departments_subquery as dep
natural join w3resources_exercises.employees_subquery as em
where (SYSDATE()-em.hire_date)/365 > 5;

-- encontre quantas pessoas foram contratados para cada departamento por ano
select department_id, date_format(hire_date,'%Y'), count(employee_id)
from w3resources_exercises.employees_subquery
group by department_id, date_format(hire_date,'%Y')
order by department_id;