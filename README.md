# estudandomysql


todos os exercicios tiveram como fonte o <a href="http://w3resource.com/mysql-exercises/"> w3resource </a> 
ou um treinamento de bootcamp em ingles do <a href="https://www.youtube.com/watch?v=rGx1QNdYzvs&list=PLUaB-1hjhk8FE_XZ87vPPSfHqb6OcM0cF"> youtube </a>. 

## project data cleaning - youtube 
Neste file estao os exercicios do video do  <a href="https://www.youtube.com/watch?v=rGx1QNdYzvs&list=PLUaB-1hjhk8FE_XZ87vPPSfHqb6OcM0cF">youtube</a>, que tinham como objetivo: 
1. Remover duplicados
2. padronizar os dados/data 
3. Verificar dados NULL e/ou blank 
4. remover colunas e linhas desnecessarias
<a href="https://github.com/rcalcagniti/estudandomysql/blob/main/Projeto%20Data%20Cleaning.sql">Aqui</a> está a resoluçao de todas as partes

## Estes são os exercícios do w3resources
todos os exercícios podem ser encontrados <a href="http://w3resource.com/mysql-exercises/">aqui</a> e a resoluçao <a href="https://github.com/rcalcagniti/estudandomysql/blob/main/Estudos%20MySQL%20W2Resource.sql">aqui</a>- escolhi fazer aqueles que me eram mais interessantes.


Lista de exercícios que encontrará neste arquivo:
1. Criar tabela chamada "countries"
2. criar a tabela caso ja nao existe
3. criar uma tabela copia com todos os dados da orignal
4. criar uma tabela com restriçao para nao ter NULL
5. crie uma tabela chamada JOBS, com as colunas: job_id, job_title, min_salary, max_salary e verifique se max_salary nao é maior que 25000
6. cria uma tabela chama countries, com as colunas: country_id, country_name and region_id e verifique se os paises adicionados sejam apenas: Italy, India e China
7. cria uma tabela chamada job_histry, com as colunas: employee_id, start_date, end_date, job_id and department_id e tenha certeza que end_date tenha formato de data ('--/--/----')
8. criar uma tablea com nome countries_, com as colunas: country_id,country_name e region_id e que bloqueie a entrada de dados duplicados em countri_id
9. cria uma tabela jobs_default_values, com as colunas:   columns job_id, job_title, min_salary e max_salary - no uqal job_title tenha como default BLANK, o min_salary seja 8000 e o max_salary seja NULL
10. crie uma tabela countried_auto_increment, com as colunas: country_id, country_name e region_id - no qual countri_id seja unico e com tenha o proprio increment key
11. crie uma tabela country_unique, com as colunas: country_id, country_name e region_id - no qual a combinaçao de country_id e region_id seja unica (nao repete)
12. mude o nome da tabela de countries para countries_new
13. adicione a coluna region_id a tabela tabela de location (precisa primeiro criar a tabela)
14. agora adicione IDs como uma nova coluna, mas no inicio da tabela (nao no final)
15. adicione uma nova coluna depois de state_province
16. mude o tipo de coluna de country_id para um integer
17. remover/excluir a coluna region_id2 de location
18. mude o nome da coluna de state_province para state
19. adicione primary key para location_id
20. escreva uma query para adicionar uma linha com valores especificamente para country_id e country_name
21. duplique a tabela countries_new com todos os dados
22. coloque NULL nos valores de region_id
23. adicione 3 valores a tabela em um unico query
24. adicione os novos valores de countries_new para countries_new2
25. crie uma tabela de jobs com job_id, job_title e min_salary tendo job_id como valor unico - e coloque valores na tabela
26. cria uma nova tabela de jobs com job-id como unique primary key que é gerada sozinha
27. faça com todos os dados da coluna "email" da planilha employees_final sejam 'not available'
28. mude os dados de email e commission_pct da tabela employees_final para que sejam 'not available' e 0.1 para todos
29. mude os dados de email e commission_pct da tabela employees_final para que sejam 'not available' e 0.05 para quem está no sdepartamento 60
30. mude os dados de email da tabela employees_final para que sejam 'N/A' para quem está no department 90 e comission_pct é menor que 0.2
31. mude os dados de email da tabela employees_final para que sejam 'N/A' para quem está no department Accounting
32. aumente o salario do funcionario com id 104 para 9000, se o salario atual for menor ou igual a 6000
33. aumento o salario para quem esta no department_id 60 e 90, aumento 25% e 15% respectivamente
34. rankeie os funcionario de acordo com o salario de forma descendente
35. separe os funcionario de acordo com departamento e os rankeie de acordo com salario
36. calcule a diferença de salario entre departamentos (a partir da media do salario de cada departamento)
37. calcule o total de vendas de cada mes
38. calcule a media de vendas de cada mes
39. encontre a primeira e ultima data de compra de cada regiao
40. Calcule o percentual de vendas para cada Order_priority
41. encontrei o primeiro dia do mes de tres meses atras
42. encontre o ultimo dia do mes de tres meses atras
43. encontre o primeiro dia deste ano
44. encontre o ultimo dia deste ano
45. puxa a data de hoje no formato escrito(ex:Setembr 4, 2014)
46. converta um valor numerico em data
OBS: resoluçao dos exercicios estão <a href="https://github.com/rcalcagniti/estudandomysql/blob/main/Estudos%20MySQL%20W2Resource.sql">aqui</a>

Exercícios de RH: 
1. Encontre todos os endereços para os departamentos
2. encontre o primeiro nome, depart id e nome do departamento de todos os funcionarios
3. encontre o primeiro nome, depart id e nome do departamento dos funcionarios de londres
4. encontre o nome do funcionario junto com seu gerente_id e nome do gerente
5. Encontre o nome do funcionario que foram contratados após o "Jones"
6. encontre a quantidade de funcionarios por departamento
7. query que tenha employee_id, job title, e dias entre a contrataçao e a saida - dentro do departamento 90
8. query para trazer o job_title vs average salary
9. query com nome do funcionario, cargo, salario do funcionario e diferença do seu salario vcs o minimo do cargo
10. puxe o historico de trabalho de funcionario que hoje ganham mais de 10000 como salario
11. puxe nome do departamento, nome do manager, data de contrataçao, salario para managers com mais de 15 anos na empresa
12. query para puxar quais funcionários há por job_id
13. substitua 124 por 999 nos telefones dos employees
14. puxe os funcionarios que o nome tem mais de 7 letras
15. preencha os numeros de salary com 00 na frente para terem o mesmo tamanho
16. adicione '@example.com' aos emials
17. puxe o email_id e o email - mas discarte os ultimos 3 caracteres no email
18. encontre os employees que estao com o nome está em letra maiuscula
19. pegue os ultimos 4 numeros dos telefones
20. puxe os street_address com pelo menos 10 caracteres
21. encontre o endereço mais curto
22. encontre a primeira palavra de jobs_title que contenham mias de 1 palavra
23. puxe o nome e sobrenome dos funcionarios no qual o nome tenha "c" a partir do 2 caractere
24. puxe o nome dos funcionário que começam com a Letra A,J ou M
25. puxe os funcionarios que ganham salarios de pelo menos 8 caracteres, e coloque $ na frente
26. faça com que haja 10 caracteres no campo de salario para todos os funcionarios, preenchendo os espaços vazios com $
27. mostre os primeiros 8 caracteres do nome dos funcionarios e os seus salarios, coloque $ nos seus salarios (cada $ representa 10k) e organize de forma decrescente com base no salario
28. mostre o salario de cada funcionario com a representaçao de $ para cada 1k
29. mostre os funcionarios que foram contratados no dia 7 de cada mes ou no mes 7 do ano
30. mostre quantos jobs estao registrados na planilha employees
31. some todos os salarios dos funcionarios
32. encontre o employee_id e o salario do funcionario com menor salario
33. encontre o funcionario que é programmer com maior salario (IT_PROG)
34. conte quantos funcionários há no departamento 90 e qual a media salarial deles
35. conte quantos funcionarios há em cada job_id
36. encontre a diferença entre o maior e o menor salario
37. encontre o menor salario de cada time de acordo com o manager_d
38. mostre o total de salarios de cada departamento baseado no department_id
39. mostre a media salarial de cada job_id
40. encontre o total de salarios, min salario, max salario e media salarias de cada job_id dentro do departamento 90
41. encontre o employee_id, first_name, last_name de todos os funcionarios do IT deparment
42. encontre o employee_id, first_name, last_name de todos os funcionarios no qual está nos EUA
43. pegue o employee_id, first_name, last_name de funcionarios que NAO sao gerentes
44. encontre os funcionarios contratados entre 19871-06-01 a 1987-07-30
45. puxe o dia de hoje no formato descritivo, com dia da semana e hora
46. puxe o dia de hoje no formato brasileiro de data
47. encontre o ano que houve mais de 10 contrataçoes
48. encontre os funcionarios contratados em 1987
49. encontre os manager com mais de 5 anos de experiencia
50. encontre quantas pessoas foram contratados para cada departamento por ano
51. OBS: resoluçao dos exercicios estão <a href="https://github.com/rcalcagniti/estudandomysql/blob/main/Estudos%20MySQL%20W2Resource.sql">aqui</a>
    
