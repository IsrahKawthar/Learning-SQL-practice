-- Exploratory data analysis 
-- Just exploring data tbh

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;


SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;


SELECT MIN( `date`), MAX(`date`)
FROM layoffs_staging2;



SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;
-- can have a look at which industries laid most off


SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;
-- can see which country laid most off


SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;


SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 1 DESC;


SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;


SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date` ,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;




WITH Rolling_Total AS
(
SELECT SUBSTRING (`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date` ,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;
-- this didnt work so i did the following (coding underneath) to change data as it cant read th one above cos there was a problem with substring so i need to pratice substring more :(




WITH Rolling_Total AS (
  SELECT 
    DATE_FORMAT(`date`, '%Y-%m') AS month_key,
    SUM(total_laid_off) AS total_off
  FROM layoffs_staging2
  WHERE `date` IS NOT NULL
  GROUP BY month_key
)
SELECT 
  month_key, total_off, 
  SUM(total_off) OVER (ORDER BY month_key) AS rolling_total
FROM Rolling_Total
ORDER BY month_key;
-- shows months where most where laid off, good to think about reasons for why this could be for a personal project



SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;


SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;


WITH Company_year (company, years, total_laid_off) AS 
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
)
SELECT *
FROM Company_year;


WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
)
SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
ORDER BY Ranking ASC;




WITH Company_year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS 
(SELECT *,
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5
;




