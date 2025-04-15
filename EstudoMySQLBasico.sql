

SELECT * 
FROM parks_and_recreation.employee_demographics; #Erro: Code: 1046. NO database selected - faltou selecionar o database, que coloca antes da tabela e depois um ponto

SELECT first_name, last_name
FROM parks_and_recreation.employee_demographics; 


SELECT first_name, gender
FROM parks_and_recreation.employee_demographics;

SELECT DISTINCT gender
FROM parks_and_recreation.employee_demographics;

SELECT DISTINCT first_name, gender, age, age+10 #Lembre-se MySQL roda com base em PEMDAS (entao se soma vem antes de multiplicaçao no seu calculo, coloque em ())
FROM parks_and_recreation.employee_demographics;

# estudo where

SELECT *
FROM parks_and_recreation.employee_salary
WHERE first_name = 'Leslie';

SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary <> 50000;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE NOT gender <> 'Female' AND age>30; #no SQL funciona AND e OR, && e ||, e tambem  <> e != (sinais de diferente)


SELECT *
FROM parks_and_recreation.employee_demographics
WHERE (gender = 'Female' AND first_name = 'Leslie') OR age<30;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name Like 'A__'; #WHERE _ define quantos caracteres pode ter depois de A e filtra, nesse caso 2

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name Like '%e%'; #WHERE % - pede para encontrar qualquer campo que tenha E neste caso, antes ou depois - % define o limite

#Estudo Group By + Order BY

SELECT gender
FROM parks_and_recreation.employee_demographics
GROUP BY gender; #group by junta linhas iguais, nao mostra todas as linhas

SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

SELECT occupation, salary
FROM parks_and_recreation.employee_salary
GROUP BY occupation, salary;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender; 

#order by ordena as linhas de acordo com padrao, mas mostra todas as linhas
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY first_name DESC; #DESC vai ordernar descendente, por padrao ORDER BY ordena ASC (ascendente)

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY gender, age; #ordena primeiro por genero e depois age

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY 5, 4; #não é recomendado filtrar desta forma, mas é uma opçao

#Having vs Where

SELECT gender, AVG(AGE) #OBS: todo AVG precisa de um group by para rodar, se nao, nao vai
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING AVG (age) > 40;
#WHERE nao filtra apos Groupd BY - para filtrar resultados do groupd by so com Having

SELECT occupation, AVG(salary)
FROM parks_and_recreation.employee_salary
WHERE occupation LIKE '%manager%' # aqui o where esta filtrando a coluna, nao o group by
GROUP BY occupation
HAVING AVG (salary) > 75000; #group by sendo filtrado pelo havint

#Limit vs Aliasing

#limit limita a quantidade de rows
SELECT *
FROM parks_and_recreation.employee_demographics
LIMIT 3;
#é simples, mas combinado com group by faz muita coisa

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 3;
#assim mostra os tres mais velhos da tabela

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 2,1;
# Limit aqui define aonde começar a pegar o dado, caso a partir da linha 2 - e depois aonde parar - no caso vai mostrar apenas 1 linha



#Aliasing muda o nome da coluna
Select gender, AVG (age) AS avg_age # AS esta mudando o nome da coluna para avg_age
FROM parks_and_recreation.employee_demographics
Group BY gender
HAVING avg_age >40; #com o nome alterado nao precisa fazer AVG(age)>40 como fizemos em outros exemplos






