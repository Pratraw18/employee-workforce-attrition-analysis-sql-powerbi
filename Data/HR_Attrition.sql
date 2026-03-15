CREATE DATABASE HR_Analytics;
use HR_Analytics;
select * from hr_attrition;

-- Attrition count and active employee
select count(*) as total_rows,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
	SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) as active_count
from hr_attrition;



-- Analysis view

CREATE VIEW dbo.vw_hr_attrition_analysis AS
SELECT
    Employee_ID,
    Age,
    Attrition,
    Business_Travel,
    Department,
    Distance_From_Home,
    Education,
    Environment_Satisfaction,
    Gender,
    Salary,
    Job_Involvement,
    Job_Level,
    Job_Role,
    Job_Satisfaction,
    Marital_Status,
    Number_of_Companies_Worked_previously,
    Overtime,
    Salary_Hike_in_percent,
    Total_working_years_experience,
    Work_life_balance,
    No_of_years_worked_at_current_company,
    No_of_years_in_current_role,
    Years_since_last_promotion,

    CASE
        WHEN Job_Level IN (1, 2) THEN 'Entry Level'
        WHEN Job_Level = 3 THEN 'Mid Level'
        WHEN Job_Level IN (4, 5) THEN 'Senior Level'
        ELSE 'Executive'
    END AS Job_Level_Group,

    CASE
        WHEN No_of_years_worked_at_current_company <= 2 THEN '0-2 Years'
        WHEN No_of_years_worked_at_current_company BETWEEN 3 AND 5 THEN '3-5 Years'
        WHEN No_of_years_worked_at_current_company BETWEEN 6 AND 10 THEN '6-10 Years'
        ELSE '10+ Years'
    END AS Tenure_Group,

    CASE
        WHEN Years_since_last_promotion >= 4 THEN 'High Risk'
        WHEN Years_since_last_promotion BETWEEN 2 AND 3 THEN 'Moderate Risk'
        ELSE 'Low Risk'
    END AS Promotion_Risk,

    CASE
        WHEN Overtime = 'Yes' AND Work_life_balance <= 2 THEN 'High Burnout Risk'
        WHEN Overtime = 'Yes' AND Work_life_balance = 3 THEN 'Moderate Burnout Risk'
        ELSE 'Low Burnout Risk'
    END AS Burnout_Risk,

    CASE
        WHEN Distance_From_Home > 20 THEN 'Far'
        WHEN Distance_From_Home BETWEEN 10 AND 20 THEN 'Medium'
        ELSE 'Near'
    END AS Commute_Group,

    CASE
        WHEN Salary < 50000 THEN '30k-50k'
        WHEN Salary BETWEEN 50000 AND 80000 THEN '50k-80k'
        WHEN Salary BETWEEN 80001 AND 120000 THEN '80k-120k'
        WHEN Salary BETWEEN 120001 AND 160000 THEN '120k-160k'
        ELSE '160k-200k'
    END AS Salary_Band

FROM dbo.hr_attrition;

SELECT TOP 10
    Distance_From_Home,
    Commute_Group,
    Overtime,
    Work_life_balance,
    Burnout_Risk,
    Salary,
    Salary_Band
FROM dbo.vw_hr_attrition_analysis;