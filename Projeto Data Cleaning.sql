#Project Data Cleaning


#db for the exercise: https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv

#para adicionar o db: crie um database no MySQL Workbench
#depois abra o database e clique com o botao direito em Tables
#clique em: Table Data Import Wizard

Select *
FROM world_layoffs.layoffs;

-- 1. Remover duplicados
-- 2. padronizar os dados/data
-- 3. Verificar dados NULL e/ou blank
-- 4. remover colunas e linhas desnecessarias

CREATE TABLE world_layoffs.layoffs_staging #para poder fazer o cleaning sem correr o risco de perder tudo, faz um staging - nao é best practice fazer tudo na planilha original
like world_layoffs.layoffs;

Select *
FROM world_layoffs.layoffs_staging; #vai nascer com os dados em branco, so com as colunas

INSERT world_layoffs.layoffs_staging
SELECT *
from world_layoffs.layoffs;

Select *
FROM world_layoffs.layoffs_staging;

-- 1. remover duplicados

Select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM world_layoffs.layoffs_staging; #se trouxe rum numero diferente de 1, é porque é duplicado de acordo com as colunas que colocamos

WITH duplicate_cte AS
(Select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM world_layoffs.layoffs_staging
)
Select *
FROM duplicate_cte 
WHERE row_num > 1; #vai mostrar os dados duplicados


WITH duplicate_cte AS
(Select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM world_layoffs.layoffs_staging
)
DELETE
FROM duplicate_cte 
WHERE row_num > 1; #aqui nao vai funcionar, pq delete é só um update e row_number nao faz parte da tabela real - duplicate_cte nao é real

#entao vamos criar uma nova table e depois remover

#em cima de layoff_staging eu cliquei com o botao direito > copy to clickboard > create statement e colei aqui
CREATE TABLE world_layoffs.`layoffs_staging2` ( #coloquei o 2
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num`INT #adicionei este para colocarmos os dados
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Select *
FROM world_layoffs.layoffs_staging2; #vai nascer vazia

insert into world_layoffs.layoffs_staging2
Select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, `date`,stage, country, funds_raised_millions) AS row_num
FROM world_layoffs.layoffs_staging; #adicionando os dados de novo, mas agora com o row_number que antes nao tinha (se fizer o insert igual o da outra vez da erro, pq nao tem row_number)

Select *
FROM world_layoffs.layoffs_staging2;

DELETE
FROM world_layoffs.layoffs_staging2
WHERE row_num > 1; #aqui funciona porque nao é um CTE e faz parte da tabela

# para o delete funcionar, precisa desabilitar o Safe Update Mode
#No mac: MySQL Workbench > Settings SQL Editor > Uncheck the "Safe Updates" checkbox
#No Windows: Edit > Preferences > SQL Editor > Uncheck the "Safe Updates" checkbox

Select *
FROM world_layoffs.layoffs_staging2;


-- 2. padronizar os dados/data
#precisa limpar coluna por coluna

Select company,TRIM(company)
FROM world_layoffs.layoffs_staging2;

update world_layoffs.layoffs_staging2
SET company = trim(company); # trim vai tirar os espaços em branco no começo e final

Select DISTINCT Industry
FROM world_layoffs.layoffs_staging2
Order By 1; #tem null, tem branco, tem Crypto/Cript Currency/CriptCurrency ( que é tudo igual)

Select *
FROM world_layoffs.layoffs_staging2
Where industry like 'Crypto%';

update world_layoffs.layoffs_staging2
set industry = 'Crypto'
Where industry like 'Crypto%'; #aqui mudou tudo para Crypto o que antes era Cript Currency/CriptCurrency

Select distinct location
from world_layoffs.layoffs_staging2
ORDER By 1; #parece ok, sem repeticao

Select distinct country
from world_layoffs.layoffs_staging2
ORDER By 1; #tem 2 USA, um com ponto e um sem ponto - precisa limpar

Select distinct country, trim(TRAILING '.' FROM country)
from world_layoffs.layoffs_staging2
ORDER By 1; #aqui esta so testando o trim para ver se solucionaria o problema

UPDATE world_layoffs.layoffs_staging2
SET country = trim(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

Select distinct country
from world_layoffs.layoffs_staging2
ORDER By 1; #confirmando que o valor foi corrigido, YAY

Select `date` #date no momento está como text, precisa mudar para date collumn
from world_layoffs.layoffs_staging2
ORDER By 1;

Select `date`, str_to_date(`date`, '%m/%d/%Y') #str_to_date transforma string em data - só os valores
from world_layoffs.layoffs_staging2;

update world_layoffs.layoffs_staging2
set date = str_to_date(`date`, '%m/%d/%Y'); #aqui atualizou os valores, mas a coluna ainda é lida como string

ALTER table world_layoffs.layoffs_staging2 #aqui altera a coluna para DATE, mas so deve ser feito depois de atualizar os dados
modify COLUMN `date` DATE;

Select *
from world_layoffs.layoffs_staging2
ORDER By 1;



-- 3. Verificar dados NULL e/ou blank


Select *
FROM world_layoffs.layoffs_staging2
Where total_laid_off IS NULL; # = NULL nao funciona, precisa ser IS NULL

Select *
FROM world_layoffs.layoffs_staging2
Where total_laid_off IS NULL
AND percentage_load_odd IS NULL; #se ambos os dados sao NULL, podemos deletar (voltamos no paço 4)

Select *
FROM world_layoffs.layoffs_staging2
Where industry IS NULL
OR industry = ''; #encontramos dados que precisamos preencher

Select *
FROM world_layoffs.layoffs_staging2
Where company = 'Airbnb'
OR company = 'Bally\'s Interactive'; #essa pesquisa vai ajudar no que devemos preencher industry na pesquisa anterior

Select *
FROM world_layoffs.layoffs_staging2 t1
JOIN world_layoffs.layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
Where (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL; #aqui vai puxar os dados que nao sao null para ajudar a popular os que sao null


Update world_layoffs.layoffs_staging2
Set industry = NULL
Where industry = ''; #antes de colocar os dados, precisa transformar blank em NULL


Update world_layoffs.layoffs_staging2 t1
JOIN world_layoffs.layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
Where (t1.industry IS NULL)
AND t2.industry IS NOT NULL; #aqui vai preencher os dados com os semelhantes

Select *
FROM world_layoffs.layoffs_staging2
Where company = 'Airbnb'
OR company = 'Bally\'s Interactive'; #nao funcionou para Bally's porque esse so tem uma linha de industry para popular como copia


-- 4. remover colunas e linhas desnecessarias
delete #deletar linhas
FROM world_layoffs.layoffs_staging2
where total_laid_off is NULL
AND percentage_laid_off IS NULL;

alter table world_layoffs.layoffs_staging2 #deletar coluna
drop column row_num;

select *
FROM world_layoffs.layoffs_staging2;

