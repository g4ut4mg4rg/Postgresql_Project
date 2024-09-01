/*
Question : What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- This reveals how different skills impact salary levels for Data Analysts and helps identify the most financially rewarding skills to acquire
*/


SELECT
    skills,
    --count(skills_dim.skill_id) as demand_count,
    round(avg(salary_year_avg)) as avg_sal
FROM job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
inner join skills_dim on skills_Job_dim.skill_id=skills_dim.skill_id
where job_title_short='Data Analyst' and 
    salary_year_avg is not NULL AND
    job_work_from_home=TRUE
group by skills
order by avg_sal desc
limit 10


-- The top paying skills for Data Analyst jobs, based on the given query, are:

-- PySpark - Average Salary: $208,172
-- Bitbucket - Average Salary: $189,155
-- Watson - Average Salary: $160,515
-- Couchbase - Average Salary: $160,515
-- DataRobot - Average Salary: $155,486
-- These skills are highly valued in remote Data Analyst positions, with PySpark topping the list. ​