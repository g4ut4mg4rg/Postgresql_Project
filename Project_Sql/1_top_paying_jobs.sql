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