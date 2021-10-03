-- =========================================
-- Author: Laura Zsolyom
-- CreateDate: 22/09/2021
-- Description: Calculates Average vaccination rate in August 2021, HDI and GDP per capita per EU27 countries
-- Tableau dataset: 3 hdi gdp fully vaccination EU27
-- Tableau vizualization: https://public.tableau.com/app/profile/laura.zsolyom/viz/Explanationofcovid-19vaccinationprogress/Explanationofcovid-19vaccinationprogress
-- =========================================


WITH tVaccination AS (
  SELECT
    date,
    iso_3166_1_alpha_3,
    country_code,
    country_name,
    cumulative_persons_fully_vaccinated, 
    gdp_per_capita_usd,
    human_development_index
  FROM
    `bigquery-public-data.covid19_open_data.covid19_open_data`
   WHERE date BETWEEN '2021-08-01' AND '2021-08-31'
     AND country_name IN ('Austria',  'Italy', 'Belgium', 'Latvia', 'Bulgaria', 'Lithuania', 'Croatia', 'Luxembourg', 'Cyprus', 'Malta', 'Czech Republic', 'Netherlands', 'Denmark',  'Poland', 'Estonia', 'Portugal', 'Finland', 'Romania', 'France', 'Slovakia', 'Germany', 'Slovenia', 'Greece', 'Spain', 'Hungary', 'Sweden', 'Ireland')
     AND aggregation_level = 0 
   ORDER BY 3,1

 )
,

tPopulation AS (
  SELECT
    country_code AS iso_3166_1_alpha_3,
    year_2018 AS population_2018
  FROM `bigquery-public-data.world_bank_global_population.population_by_country`

)


SELECT 
  tV.country_name,
  ROUND(AVG(cumulative_persons_fully_vaccinated)) AS avg_cumulative_persons_fully_vaccinated,
  AVG(tP.population_2018) AS population_2018 ,
  AVG( tV.gdp_per_capita_usd) as gdp_per_capita_usd,
  AVG(tV.human_development_index) AS human_development_index
FROM tVaccination  AS tV

LEFT JOIN tPopulation AS tP USING(iso_3166_1_alpha_3)

GROUP BY 1
ORDER BY 1








