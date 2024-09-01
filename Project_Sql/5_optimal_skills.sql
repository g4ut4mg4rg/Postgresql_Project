/*
Question : What are the most optimal skills to learn (high demand and high paying)?
- Identify skills in high demand with high average salaries for Data Analyst roles
- Focus on remote positions with specified salaries
- Job security (high demand) and financial benefits (high salaries) will provide insight into Skills for career development in Data Analysis.
*/

with highest_paying_skills as(
    SELECT
        skills_dim.skill_id,
        skills_dim.skills as skills,
        round(avg(salary_year_avg)) as avg_sal
    FROM job_postings_fact
    inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
    inner join skills_dim on skills_Job_dim.skill_id=skills_dim.skill_id
    where job_title_short='Data Analyst' AND
        salary_year_avg is not NULL AND
        job_work_from_home=TRUE
    group by skills_dim.skill_id,skills
), 

in_demand_skills as(
    select
        skills_Job_dim.skill_id,
        skills_dim.skills as Skills,
        count(skills_job_dim.job_id) as demand_count
    from job_postings_fact
    inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
    inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
    where job_title_short='Data Analyst' AND
        salary_year_avg is not NULL AND
        job_work_from_home=TRUE
    group by skills_Job_dim.skill_id,skills
)

select
    in_demand_skills.skill_id,
    in_demand_skills.skills,
    in_demand_skills.demand_count,
    avg_sal
from highest_paying_skills
inner join in_demand_skills on highest_paying_skills.skill_id=in_demand_skills.skill_id
where demand_count>50
order by avg_sal desc, demand_count desc
limit 10;



--Python: High demand (236) and salary ($101,397). 
--Versatile for data science, automation, and web development. Top skill to learn.

--SQL: Highest demand (398), good salary ($97,237). 
--Essential for database management, complements other tech skills.

--Tableau: Strong demand (230), competitive salary ($99,288). 
--Key for data visualization in business intelligence.

--Excel: High demand (256), moderate salary ($87,288). 
--Widely used in finance and data analysis.

--Power BI: Decent demand (110), good salary ($97,431). 
--Valuable for business intelligence, integrates well with Microsoft products.

--R: Moderate demand (148), high salary ($100,499). 
--Best for statistical analysis and data science, especially in research.

--SAS: Lower demand (63), competitive salary ($98,902). 
--Important in industries requiring advanced analytics.

--PowerPoint: Low demand (58), moderate salary ($88,701). 
--Necessary for effective communication in corporate settings.

--Focus on Python and SQL, with Tableau or Power BI as complementary skills for strong career prospects.