--EU_EMISSION_PORTFOLIO_PROJECT

--#TERMINOLOGIES:

--    airpol: Type of air pollutant

--    cpa08: Industry classification

--    induse: Industry sector

--    origin: Data source

--    unit: Measurement unit

--    geo\time: Country or region


--#To return all the values in the table

SELECT *
FROM emissions_EU27

SELECT *
FROM emissions_EU28


--#Total Emissions Over All Years

SELECT SUM(_2019 + _2018 + _2017 + _2016 + _2015 + _2014) AS Total_Emissions
FROM emissions_EU27


--#Annual Emissions Trend for a Specific Pollutant (e.g., CO2)

SELECT geo_time, _2014, _2015,_2016, _2017, _2018, _2019
FROM emissions_EU27
WHERE airpol = 'CO2'


--#Total CO2 Emissions in 2019

SELECT geo_time, SUM(_2019) AS Total_2019_Emissions
FROM emissions_EU27
WHERE airpol = 'CO2'
GROUP BY geo_time


--#Change in Emissions from 2014 to 2019 

SELECT geo_time, (_2019 - _2014) AS Change_In_Emissions
FROM emissions_EU27


--#Highest Industries Emissions ranking in 2019

SELECT cpa08, SUM(_2019) AS Industry_Emissions
FROM emissions_EU27
GROUP BY cpa08
ORDER BY Industry_Emissions DESC


--#Average Annual Emissions 

SELECT geo_time, AVG(_2019 + _2018 + _2017 + _2016 + _2015 + _2014) AS Avg_Annual_Emissions
FROM emissions_EU27
GROUP BY geo_time


--#Total Emissions by Industry Across All Years

SELECT cpa08, SUM(_2019 + _2018 + _2017 + _2016 + _2015 + _2014) AS Total_Emissions
FROM emissions_EU27
GROUP BY cpa08
ORDER BY Total_Emissions DESC


--#Annual Emission Reduction per Industry (2018 to 2019)

SELECT cpa08, (_2018 - _2019) AS Emission_Reduction
FROM emissions_EU27
ORDER BY Emission_Reduction DESC


--#Largest Pollutants Contributor in 2019

SELECT airpol, SUM(_2019) AS Total_Emissions
FROM emissions_EU27
GROUP BY airpol
ORDER BY Total_Emissions DESC


--#Percentage Decrease in Emissions for EU27 from 2014 to 2019

SELECT (SUM(_2014) - SUM(_2019)) * 100.0 / SUM(_2014) AS Percentage_Decrease
FROM emissions_EU27

