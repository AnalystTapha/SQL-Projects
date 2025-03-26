--NASA_DATA_PORTFOLIO_PROJECT

--#To return all the values in the table

SELECT *
FROM inflation

SELECT *
FROM mission_budgets

SELECT *
FROM mission_details

--#Total budget spent on the mission

SELECT SUM(cost_MUSD) AS total_budget
FROM mission_budgets


--#Yearly total mission cost

SELECT fiscal_year, SUM(cost_MUSD) AS total_cost_peryear
FROM mission_budgets
GROUP BY fiscal_year
ORDER BY fiscal_year DESC


--#Most expensive mission

SELECT mission, SUM(cost_MUSD) AS total_cost
FROM mission_budgets
GROUP BY mission
ORDER By total_cost DESC


--#Cost break down by cost_type

SELECT cost_type, SUM(cost_MUSD) AS total_cost
FROM mission_budgets
GROUP BY cost_type
ORDER BY total_cost DESC;


--#Total cost by mission destination

SELECT d.destination, SUM(b.cost_MUSD) AS total_cost
FROM mission_budgets b
JOIN mission_details d ON b.mission = d.mission
GROUP BY d.destination
ORDER BY total_cost DESC


--#Average mission cost per fiscal year

SELECT fiscal_year,AVG(cost_MUSD) AS Average_cost
FROM mission_budgets
GROUP BY fiscal_year
ORDER BY Average_cost DESC


--#Mission belonging to specific program(e.g Discovery)

SELECT mission, mission_full_name
FROM mission_details
WHERE program = 'Discovery'


--#Missions with there adjusted inflation

SELECT b.mission, b.fiscal_year, b.cost_MUSD, 
       (b.cost_MUSD * i.inflation_adjustment) AS adjusted_cost
FROM mission_budgets b
JOIN inflation i ON b.fiscal_year = i.fiscal_year
ORDER BY adjusted_cost DESC


--#Number of missions by destination

SELECT destination, COUNT(*) AS mission_count
FROM mission_details
GROUP BY destination
ORDER BY mission_count DESC


--#Categorize Missions Based on Budget

SELECT mission, cost_MUSD,
       CASE 
           WHEN cost_MUSD > 600 THEN 'Expensive'
           WHEN cost_MUSD BETWEEN 200 AND 600 THEN 'Moderate'
           ELSE 'Low Cost'
       END AS Mission_Category
FROM mission_budgets


--#Percenatge contribution for each cost group

SELECT cost_group, 
       SUM(cost_MUSD) AS total_cost,
	          ((SUM(cost_MUSD) / (SELECT SUM(cost_MUSD) FROM mission_budgets)) * 100) AS percentage
FROM mission_budgets
GROUP BY cost_group
ORDER BY total_cost DESC;


--#Highest spending year on space mission

SELECT fiscal_year, SUM(cost_MUSD) AS total_spending
FROM mission_budgets
GROUP BY fiscal_year 
ORDER BY total_spending DESC


--#Average cost of mission to each destination

SELECT d.destination, AVG(b.cost_MUSD) AS avg_cost
FROM mission_budgets b
JOIN mission_details d ON b.mission = d.mission
GROUP BY d.destination
ORDER BY avg_cost DESC