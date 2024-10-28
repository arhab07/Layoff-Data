select * 
from  layoffs_stagingdata;

UPDATE layoffs_stagingdata
set percentage_laid_off = null
where percentage_laid_off = 'NULL';

UPDATE layoffs_stagingdata
set percentage_laid_off = null
where percentage_laid_off = 'NULL';

UPDATE layoffs_stagingdata
set total_laid_off = null , funds_raised_millions = null 
where  total_laid_off = 'NULL' or funds_raised_millions = 'NULL' ;


select *
from layoffs_stagingdata
where percentage_laid_off is  null ;

select company , count(*)
from layoffs_stagingdata
group by company
having count(*)>1;

create table   layoff_New
like layoffs_stagingdata;

select *
from layoff_New;

insert into layoff_New
select * 
from layoffs_stagingdata;

-- removing dupicate
select *,
row_number() over(
partition by company,industry,total_laid_off,percentage_laid_off,`date`) as row_num
from layoff_New;


with duplicate_cte as
(
select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoff_New
)
select * 
from duplicate_cte
where row_num > 1;

select * 
from layoff_New
where company = 'Oda';

CREATE TABLE `layoff_New2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` text,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoff_New2
where row_num >1;

insert into layoff_New2
select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoff_New;

delete
from layoff_New2
where row_num >1;


select *
from layoff_New2;


-- ALTER TABLE table_name
-- DROP COLUMN column_name;

select company , trim(company)
from layoff_New2;

update layoff_New2
set company = trim(company);

select distinct(industry)
from layoff_New2
order by 1;


UPDATE layoff_New2
set industry = null
where industry = 'NULL';


select *
from layoff_New2
where industry like 'Crypto%';


update layoff_New2
set industry = 'Crypto'
where industry like 'Crypto%';




select distinct(country)
from layoff_New2
order by 1;

select distinct(country)
from layoff_New2
order by 1;




select `date`
from layoff_New2
where `date` is null;

update layoff_New2
set `date` = null
where `date` = 'NULL';



update layoff_New2
set country = 'United States'
where country like 'United States%';


select `date`
from layoff_New2;

select `date`,
str_to_date(`date`,'%m/%d/%Y') as date_format
from layoff_New2;

update layoff_New2
set `date` = str_to_date(`date`,'%m/%d/%Y');

select `date`
from layoff_New2;
 
 alter table layoff_New2
 modify column `date` Date;
 
 select * from
 layoff_New2
 where total_laid_off is null
 and percentage_laid_off is null;
 
 select *
 from layoff_New2
where industry is null
or industry = '';



select *
from layoff_New2
where company like 'Bally%';


select *
from layoff_New2 t1
join layoff_New2 t2
	on t1.company = t2.company
    where (t1.industry is null or t1.industry = '')
    and t2.industry is not null;
    
update layoff_New2 t1
join layoff_New2 t2
	on t1.company = t2.company
set  t1.industry = t2.industry
where (t1.industry is null or t1.industry = '')
    and t2.industry is not null;

update layoff_New2
set industry = null
where industry = '';

delete from
 layoff_New2
 where total_laid_off is null
 and percentage_laid_off is null;
 
alter table layoff_New2
drop column row_num;
