# Link para base das tabelas: https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/Beginner%20-%20Parks_and_Rec_Create_db.sql
#Advance classes for MySQL
#Be prepared - LOL


#CTE - common table expression: é quase um subquerie, mas de forma mais organizada, podendo nomear a seduna querie
SELECT gender, AVG (salary), salary
FROM parks_and_recreation.employee_demographics AS dem
JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender; #resultado para comparaçao

WITH CTE_Example AS #CTE so pode ser usado logo apos a criaçao, nao pode ser referenciado depois
(
SELECT gender, AVG (salary) avg_sal
FROM parks_and_recreation.employee_demographics AS dem
JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT *
from CTE_Example #vai dar o resultado como se  tivesse rodado o original - ajuda quando precisa fazer varias referencias
;


WITH CTE_Example As
(
SELECT gender, AVG (salary) avg_sal
FROM parks_and_recreation.employee_demographics AS dem
JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT AVG(avg_sal)
from CTE_Example #aqui ta tirando a meia das medias
;

WITH CTE_Example As
(
SELECT gender, AVG (salary) avg_sal
FROM parks_and_recreation.employee_demographics AS dem
JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT AVG(avg_sal)
from CTE_Example; #so funciona dentro o WIth ate o ";" - é so uma tabela criada em comentario, é uma tabela temporaria

#é possivel criar multiplos CTE dentro de um CTE

WITH CTE_Example As
(
SELECT employee_id, gender, birth_date
FROM parks_and_recreation.employee_demographics AS dem
WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS
(Select employee_id, salary
From parks_and_recreation.employee_salary AS sal
WHERE salary > 50000
)
SELECT *
from CTE_Example
Join CTE_Example2
	ON CTE_Example.employee_id = CTE_Example2.employee_id; #exemple de dois CTE, aqui trabalhando como se fosse um JOIN - aqui é basico o resultado, mas ajuda a combinar dados complexos
    
WITH CTE_Example As
(
SELECT gender, AVG (salary) avg_sal, max(salary) #para max funcionar precisa selecionar o correto, precisa ser de outra cor que o AVG e SELECT, se nao, nao funciona
FROM parks_and_recreation.employee_demographics AS dem
JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT *
from CTE_Example;



WITH CTE_Example (Gender2, AVGSAL, MAXSAL) As #O nome colocado das colunas aqui subsquecre aqueles que estao dentro do select
(
SELECT gender, AVG (salary) avg_sal, max(salary) max_sal
FROM parks_and_recreation.employee_demographics AS dem
JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT *
from CTE_Example;


#Temp Tables - tabelas vistas so dentro daquela sessao, ela apaga depois que fecha o programa uma vez 
#temp podem ser criadas de duas formas

CREATE TEMPORARY TABLE parks_and_recreation.temp_table #precisa adicionar o temporary, se nao, salva no database - e precisa ter parks_and_recreation se nao nao sabe em qual database colocar
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

#daqui pode adicionar dados dentro da table, para usar depois

INSERT INTO parks_and_recreation.temp_table
VALUE ('Rebeka', 'Dutra', 'Como perder um homem em 10 dias');

SELECT *
FROM parks_and_recreation.temp_table;

#O segundo jeito de criar é pegando dados de outro lugar

select *
from parks_and_recreation.employee_salary; 

CREATE TEMPORARY TABLE parks_and_recreation.salary_over_50k
select *
from parks_and_recreation.employee_salary
WHERE salary >= 50000;

SELECT *
FROM parks_and_recreation.salary_over_50k;


#Stored procedures - salva o mysql codigo, para ser usado em multiplas vezes, sem precisar reescrever
select *
from parks_and_recreation.employee_salary
where salary >= 50000;

create procedure parks_and_recreation.large_salaries () #precisa colocar o database e o ponto, para saber aonde salva o procedure, em qual database
select *
from parks_and_recreation.employee_salary
where salary >= 50000;
#OU faz:
use parks_and_recreation;
CREATE PROCEDURE large_salaries2 ()
select *
from parks_and_recreation.employee_salary
where salary >= 50000;

CALL large_salaries (); #chamando o procedure, é como uma funçao no javascript ou no vba
CALL Large_salaries2 ();

#Observe que os procedures estao salvos abaixo das tables em: stored procedures dentro do MySql - se clicar em cima com o botato direito, pode adicionar uma procedure ali tbm

#como puxar duas queries dentro de um mesmo procedure? precisa mudar o limitador
DELIMITER $$
USE parks_and_recreation$$
CREATE PROCEDURE large_salaries4 ()
BEGIN 
	select *
	from parks_and_recreation.employee_salary
	where salary >= 50000;
    select *
    from parks_and_recreation.employee_salary
    where salary >=10000;
END $$
DELIMITER ; 

CALL large_salaries4 ();

#como parar uma procedure? como parar a funçao como no javascript - usa DROP procedure IF

#como usar parametros dentro do stored procedure, para falar qual dado vc quer a partir da planilha original
DELIMITER $$
USE parks_and_recreation$$
CREATE PROCEDURE large_salaries6 (employee_id_parameter INT)
BEGIN 
	select salary
	from parks_and_recreation.employee_salary
	where employee_id = employee_id_parameter;
    
END $$
DELIMITER ; #a ideia aqui é puxar o salario com base no employee_id

Call large_salaries6 (2);



#TRIGGERS and EVENTS - TRIGGERS sao pedaços de codigos que rodam quando algo acontece, ex: quando um novo employee é contratado

SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT *
FROM parks_and_recreation.employee_salary;

DELIMITER $$ #permite multiplas queries dentro de uma só
create trigger parks_and_recreation.employee_insert
	AFTER INSERT ON parks_and_recreation.employee_salary #vai ser trigeado depois do insert, pode ser BEFORE tbm - é que nao faz snentido aqui
    FOR EACH ROW #para cada linha adicionada
BEGIN
	INSERT INTO parks_and_recreation.employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_db, NEW.first_name, NEW,last_name); #NEW mysql entende que é o valor adicionado
END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUE (13,'Rebeka', 'Calganiti', 'Exntertainment 720 CEO',100000, NULL);

SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT *
FROM parks_and_recreation.employee_salary;


#EVENTS - acontecem quando programados a partir de algo

SELECT *
FROM parks_and_recreation.employee_demographics;

DELIMITER $$ #event para tirar pessoas acima de 60 anos da planilha
create event delete_retirees
on schedule every 60 second
do
begin
	select *
    from parks_and_recreation.employee_demographics
    where age >= 60
END
Delimiter ;
