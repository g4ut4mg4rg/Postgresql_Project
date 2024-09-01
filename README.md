# Introduction
This project analyzes the current job market landscape for data-related positions, focusing on the relationship between companies, required skills, and job postings. By leveraging a dataset containing information about various companies, the skills they require, and the number of job postings, we aim to provide insights into the most in-demand skills and trends in the data job market. Queries : [project_sql folder](/Project_Sql/)

# Background
In recent years, the demand for data professionals has surged as organizations increasingly rely on data-driven decision-making. Understanding which skills are most sought after by employers and how job postings vary across companies is crucial for job seekers looking to align their skills with market demands. This analysis utilizes a dataset containing information on companies, required skills, and the number of job postings.
### The Questions I wanted to answer : 
1) What are the top paying Data Analyst jobs?
2) What skills are required for the top-paying Data Analyst jobs?
3) What are the most in-demand skills for data analytics?
4) What are the top skills based on salary?
5) What are the most optimal skills to learn (High in demand and High paying)?


# Tools used
### SQL :
Used for querying and managing data, extracting relevant information for critical analysis.
### PostgreSQL :
The ideal relational database management system used to manage the job-postings dataset effectively.
### Visual Studio Code :
The code editor used for writing SQL queries offering debugging and terminal features for enhanced productivity.
### Git & GitHub :
Git for version control and GitHub for hosting the project repository, facilitating collaboration and tracking changes.


# The Analysis
Each query reveals specific aspects of the Data Analyst job market.

Q1. Top paying Data Analyst jobs :

Focusing on remote jobs, this query highlights the high paying opportunities in the field.
```
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
```
![Alt text](/Assets/1.jpg)

Q2. Skills required for the top-paying Data Analyst jobs :
```
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
```
![Alt text](/Assets/2.png)

Q3. Most in-demand skills for data analytics :
```
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
```
| Skills  | Demand Count |
|-------------|------------------|
| SQL         | 7,291            |
| Excel       | 4,611            |
| Python      | 4,330            |
| Tableau     | 3,745            |
| Power BI    | 2,609            |


Q4. Top skills based on salary :
```
SELECT
    skills,
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
```
![Alt text](/Assets/4.png)

Q5. Most optimal skills to learn for Data Analyst roles :
```
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
```

# Insights

### Q1 Top-paying Data Analyst jobs:
1. Highest Paying Role: Mantys offers the highest average annual salary at $650,000, significantly higher than other roles listed.
2. Notable Companies: Meta offers a competitive salary of $336,500, positioning itself as a high-paying tech company for data analysts.
3. Salary Range: The salaries vary widely, ranging from $184,000 at Get It Recruit - Information Technology to $650,000 at Mantys.
4. Multiple Listings for SmartAsset: SmartAsset has two listings, offering $205,000 and $186,000, showing a slight variance in compensation.
5. Industry Leaders: Well-known companies like AT&T ($255,829.5) and UCLA Healthcare ($217,000) also offer substantial salaries for data analyst roles.
6. Job Locations: All roles are listed as "Anywhere," indicating remote work flexibility, which may influence the competitive salaries.

Overall, Mantys leads in pay, followed by roles in top tech and healthcare companies.

### Q2 Top skills required for a Data Analyst jobs:

1. SQL - 8 occurrences
2. Python - 7 occurrences
3. Tableau - 6 occurrences
4. R - 4 occurrences
5. Snowflake - 3 occurrences
6. Pandas - 3 occurrences
7. Excel - 3 occurrences

These insights show that SQL and Python are the most frequently required skills, followed by Tableau and R, indicating their high relevance in data analyst roles.

### Q3 Top 5 in-demand skills for data analytics, ranked by the number of job postings or demand counts:

1. SQL (7,291 demand count) : The most crucial skill, essential for data manipulation and querying in databases.
2. Excel (4,611) : A versatile tool for data analysis and reporting, still highly valued in many industries.
3. Python (4,330) : Growing in importance for advanced analytics, automation, and data manipulation.
4. Tableau (3,745) : Key for data visualization and creating interactive dashboards.
5. Power BI (2,609) : Increasingly popular for data visualization, especially within Microsoft ecosystems.

Key Insight : Mastering these skills—especially SQL, Excel, and Python—will significantly enhance your competitiveness in the data analytics field.

### Q4 Top paying skills for Data Analyst jobs, based on the given query, are:

PySpark - Average Salary : $208,172

Bitbucket - Average Salary : $189,155

Watson - Average Salary : $160,515

Couchbase - Average Salary : $160,515

DataRobot - Average Salary : $155,486

These skills are highly valued in remote Data Analyst positions, with PySpark topping the list. ​


### Q5 Most optimal skills to learn for Data Analyst roles

Python: High demand (236) and salary ($101,397). 
Versatile for data science, automation, and web development. Top skill to learn.

SQL: Highest demand (398), good salary ($97,237). 
Essential for database management, complements other tech skills.

Tableau: Strong demand (230), competitive salary ($99,288). 
Key for data visualization in business intelligence.

Excel: High demand (256), moderate salary ($87,288). 
Widely used in finance and data analysis.

Power BI: Decent demand (110), good salary ($97,431). 
Valuable for business intelligence, integrates well with Microsoft products.

R: Moderate demand (148), high salary ($100,499). 
Best for statistical analysis and data science, especially in research.

SAS: Lower demand (63), competitive salary ($98,902). 
Important in industries requiring advanced analytics.

PowerPoint: Low demand (58), moderate salary ($88,701). 
Necessary for effective communication in corporate settings.

Focus on Python and SQL, with Tableau or Power BI as complementary skills for strong career prospects.

# Conclusion
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continous learning and adaptation to emerging trends in the field of data analytics.