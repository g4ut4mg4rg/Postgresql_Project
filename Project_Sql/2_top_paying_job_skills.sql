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

/*
"job_id","job_title_short","comapny_name","salary_year_avg","skills"
552322,"Data Analyst","AT&T","255829.5","sql"
552322,"Data Analyst","AT&T","255829.5","python"
552322,"Data Analyst","AT&T","255829.5","r"
552322,"Data Analyst","AT&T","255829.5","azure"
552322,"Data Analyst","AT&T","255829.5","databricks"
552322,"Data Analyst","AT&T","255829.5","aws"
552322,"Data Analyst","AT&T","255829.5","pandas"
552322,"Data Analyst","AT&T","255829.5","pyspark"
552322,"Data Analyst","AT&T","255829.5","jupyter"
552322,"Data Analyst","AT&T","255829.5","excel"
552322,"Data Analyst","AT&T","255829.5","tableau"
552322,"Data Analyst","AT&T","255829.5","power bi"
552322,"Data Analyst","AT&T","255829.5","powerpoint"
99305,"Data Analyst","Pinterest Job Advertisements","232423.0","sql"
99305,"Data Analyst","Pinterest Job Advertisements","232423.0","python"
99305,"Data Analyst","Pinterest Job Advertisements","232423.0","r"
99305,"Data Analyst","Pinterest Job Advertisements","232423.0","hadoop"
99305,"Data Analyst","Pinterest Job Advertisements","232423.0","tableau"
1021647,"Data Analyst","Uclahealthcareers","217000.0","sql"
1021647,"Data Analyst","Uclahealthcareers","217000.0","crystal"
1021647,"Data Analyst","Uclahealthcareers","217000.0","oracle"
1021647,"Data Analyst","Uclahealthcareers","217000.0","tableau"
1021647,"Data Analyst","Uclahealthcareers","217000.0","flow"
168310,"Data Analyst","SmartAsset","205000.0","sql"
168310,"Data Analyst","SmartAsset","205000.0","python"
168310,"Data Analyst","SmartAsset","205000.0","go"
168310,"Data Analyst","SmartAsset","205000.0","snowflake"
168310,"Data Analyst","SmartAsset","205000.0","pandas"
168310,"Data Analyst","SmartAsset","205000.0","numpy"
168310,"Data Analyst","SmartAsset","205000.0","excel"
168310,"Data Analyst","SmartAsset","205000.0","tableau"
168310,"Data Analyst","SmartAsset","205000.0","gitlab"
731368,"Data Analyst","Inclusively","189309.0","sql"
731368,"Data Analyst","Inclusively","189309.0","python"
731368,"Data Analyst","Inclusively","189309.0","azure"
731368,"Data Analyst","Inclusively","189309.0","aws"
731368,"Data Analyst","Inclusively","189309.0","oracle"
731368,"Data Analyst","Inclusively","189309.0","snowflake"
731368,"Data Analyst","Inclusively","189309.0","tableau"
731368,"Data Analyst","Inclusively","189309.0","power bi"
731368,"Data Analyst","Inclusively","189309.0","sap"
731368,"Data Analyst","Inclusively","189309.0","jenkins"
731368,"Data Analyst","Inclusively","189309.0","bitbucket"
731368,"Data Analyst","Inclusively","189309.0","atlassian"
731368,"Data Analyst","Inclusively","189309.0","jira"
731368,"Data Analyst","Inclusively","189309.0","confluence"
310660,"Data Analyst","Motional","189000.0","sql"
310660,"Data Analyst","Motional","189000.0","python"
310660,"Data Analyst","Motional","189000.0","r"
310660,"Data Analyst","Motional","189000.0","git"
310660,"Data Analyst","Motional","189000.0","bitbucket"
310660,"Data Analyst","Motional","189000.0","atlassian"
310660,"Data Analyst","Motional","189000.0","jira"
310660,"Data Analyst","Motional","189000.0","confluence"
1749593,"Data Analyst","SmartAsset","186000.0","sql"
1749593,"Data Analyst","SmartAsset","186000.0","python"
1749593,"Data Analyst","SmartAsset","186000.0","go"
1749593,"Data Analyst","SmartAsset","186000.0","snowflake"
1749593,"Data Analyst","SmartAsset","186000.0","pandas"
1749593,"Data Analyst","SmartAsset","186000.0","numpy"
1749593,"Data Analyst","SmartAsset","186000.0","excel"
1749593,"Data Analyst","SmartAsset","186000.0","tableau"
1749593,"Data Analyst","SmartAsset","186000.0","gitlab"
387860,"Data Analyst","Get It Recruit - Information Technology","184000.0","sql"
387860,"Data Analyst","Get It Recruit - Information Technology","184000.0","python"
387860,"Data Analyst","Get It Recruit - Information Technology","184000.0","r"
*/