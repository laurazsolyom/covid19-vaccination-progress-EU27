-- =========================================
-- Author: Laura Zsolyom
-- CreateDate: 22/09/2021
-- Description: Calculates vaccination rate progress per EU27 countries
-- Tableau dataset: 2 cummulative fully vaccination EU27
-- Tableau vizualization: https://public.tableau.com/app/profile/laura.zsolyom/viz/Explanationofcovid-19vaccinationprogress/Explanationofcovid-19vaccinationprogress
-- =========================================


WITH EU27_Countries AS (
  SELECT
    date,
    country_code,
    country_name,
    subregion1_code,
    subregion1_name,
    cumulative_persons_fully_vaccinated,
    population,
    gdp_per_capita_usd
  FROM
    `bigquery-public-data.covid19_open_data.covid19_open_data`
   WHERE  country_name IN ('Austria',  'Italy', 'Belgium',	'Latvia', 'Bulgaria', 'Lithuania', 'Croatia', 'Luxembourg', 'Cyprus', 'Malta', 'Czech Republic', 'Netherlands', 'Denmark',	'Poland', 'Estonia', 'Portugal', 'Finland',	'Romania', 'France', 'Slovakia', 'Germany',	'Slovenia', 'Greece',	'Spain', 'Hungary',	'Sweden', 'Ireland')
    AND aggregation_level = 0 
    AND cumulative_persons_fully_vaccinated > 0
  ORDER BY 3,1,5
 
 )


 SELECT
  date,
  country_code,
  country_name,
  SUM(cumulative_persons_fully_vaccinated) AS cumulative_persons_fully_vaccinated,
  MIN(population) AS population,
  MIN(gdp_per_capita_usd) AS gdp_per_capita_usd
 FROM EU_Countries 
 GROUP BY 1,2,3
 ORDER BY 2,1
 

