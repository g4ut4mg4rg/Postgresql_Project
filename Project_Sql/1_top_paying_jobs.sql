/*
Question : 
What are the top paying Data Analyst jobs?
- Identify the top 10 highest paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlights the opportunities, offering insights into optimal skills required and roles offered for top paying Data Analysts roles.
*/


select 
    job_id,
    job_title_short,
    company.name as Comapny,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
from 
    job_postings_fact as jobs
left join company_dim as company on jobs.company_id=company.company_id
where 
    job_title_short='Data Analyst' AND
    salary_year_avg is not NULL AND
    job_location='Anywhere'
order by salary_year_avg desc
limit 10;


-- Insights from the list of top-paying Data Analyst jobs:

-- 1. Highest Paying Role: Mantys offers the highest average annual salary at $650,000, significantly higher than other roles listed.
-- 2. Notable Companies: Meta offers a competitive salary of $336,500, positioning itself as a high-paying tech company for data analysts.
-- 3. Salary Range: The salaries vary widely, ranging from $184,000 at Get It Recruit - Information Technology to $650,000 at Mantys.
-- 4. Multiple Listings for SmartAsset: SmartAsset has two listings, offering $205,000 and $186,000, showing a slight variance in compensation.
-- 5. Industry Leaders: Well-known companies like AT&T ($255,829.5) and UCLA Healthcare ($217,000) also offer substantial salaries for data analyst roles.
-- 6. Job Locations: All roles are listed as "Anywhere," indicating remote work flexibility, which may influence the competitive salaries.

-- Overall, Mantys leads in pay, followed by roles in top tech and healthcare companies.