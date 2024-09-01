/*
Question : 
What skills are required for the top-paying Data Analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from the first query
- Add the specific skills required for these roles
- This will provide a detailed look at which high-paying jobs demand certain skills,
    helping job seekers which skills to develop that align with top salaries.
*/

--Using INNER JOIN as we only need Salary that does have skills


with top_paying_jobs as (
    select 
        job_id,
        job_title_short,
        company.name as comapny_name,
        salary_year_avg
    from 
        job_postings_fact as jobs
    left join company_dim as company on jobs.company_id=company.company_id
    where 
        job_title_short='Data Analyst' AND
        salary_year_avg is not NULL AND
        job_location='Anywhere'
    order by salary_year_avg desc
    limit 10
)

select 
    top_paying_jobs.*,
    skills_dim.skills
from top_paying_jobs
inner join skills_job_dim on top_paying_jobs.job_id=skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
order by salary_year_avg desc


/*
The top skills required for a Data Analyst job, based on the provided data, are:

SQL - 8 occurrences
Python - 7 occurrences
Tableau - 6 occurrences
R - 4 occurrences
Snowflake - 3 occurrences
Pandas - 3 occurrences
Excel - 3 occurrences
Azure - 2 occurrences
Bitbucket - 2 occurrences
Go - 2 occurrences
These insights show that SQL and Python are the most frequently required skills, followed by Tableau and R, indicating their high relevance in data analyst roles.
*/