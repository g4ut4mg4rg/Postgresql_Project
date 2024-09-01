/*
Question : What are the most in-demand skills for data analytics?
- Join job postings to inner join table similar to Q2
- Identify the top 5 in-demand skills for a Data analyst.
- Focus on all job postings.
- This provides insight into retrieves the top 5 skills with the highest demand in the job market,
     into th emost valuable skills for job seekers.
*/

select
    skills,
    count(skills_job_dim.job_id) as demand_count
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
where job_title_short='Data Analyst' AND
job_work_from_home=TRUE
group by skills
order by demand_count desc
limit 5

--The SQL query result provides a list of the most in-demand skills for data analytics, ranked by the number of job postings or demand counts.:

--Top 5 In-Demand Skills for Data Analytics:
--1. SQL (7,291 demand count): The most crucial skill, essential for data manipulation and querying in databases.
--2. Excel (4,611): A versatile tool for data analysis and reporting, still highly valued in many industries.
--3. Python (4,330): Growing in importance for advanced analytics, automation, and data manipulation.
--4. Tableau (3,745): Key for data visualization and creating interactive dashboards.
--5. Power BI (2,609): Increasingly popular for data visualization, especially within Microsoft ecosystems.

--Key Insight: Mastering these skills—especially SQL, Excel, and Python—will significantly enhance your competitiveness in the data analytics field.



