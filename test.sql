select 
    job_title_short as title,
    job_location as location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'AEST' as date_time,
    EXTRACT (MONTH from job_posted_date) as date_month,
    EXTRACT (YEAR from job_posted_date) as date_year
from
    job_postings_fact
limit 5;


select  
    company.name
from 
    job_postings_fact as jobs
left join company_dim company 
on jobs.company_id = company.company_id 
where jobs.job_health_insurance='1' 
and extract (month from jobs.job_posted_date)>'4'
limit 5;


create table mar_jobs as 
(
    select * 
    from job_postings_fact 
    where (extract (month from job_posted_date))='3')

select * from feb_jobs;



--CASE EXPRESSIONS

select 
    count(job_id) as number_of_jobs,
    case
        when job_work_from_home=False then 'NOPE'
        when job_work_from_home=True then 'YUP'
        else '¯\_(ツ)_/¯'
    end as working_from_home
from job_postings_fact 
where job_title_short='Data Analyst'
GROUP BY working_from_home 
order by number_of_jobs desc
limit 10;


select 
    count(job_id) as job_count,
    --job_title_short,
    case
        when salary_year_avg>80000 then 'High'
        when salary_year_avg>50000 then 'Good'
        when salary_year_avg<=50000 then 'Low'
        else '¯\_(ツ)_/¯'
    end as salary,
    round(avg(salary_year_avg)) as avg_sal
from job_postings_fact 
where salary_year_avg is not NULL and job_title_short='Data Analyst'
GROUP BY salary
order by round(avg(salary_year_avg)) desc;


--companies offering jobs that don't require a degree
-- select * from (
--     select 
--         company.name,
--         jobs.job_no_degree_mention
--     from 
--     job_postings_fact as jobs 
--     left join 
--     company_dim  as company
--     on jobs.company_id=company.company_id
--     where jobs.job_no_degree_mention=True
-- );

-- select name as comapny_name
-- from company_dim where company_id in (
--     select company_id from job_postings_fact where job_no_degree_mention=True
-- )


-- with most_job_openings as (
--     select 
--         count(jobs.job_id) as no_of_jobs, 
--         company.name as company_name
--     from 
--     job_postings_fact as jobs 
--     right join 
--     company_dim  as company
--     on jobs.company_id=company.company_id 
--     group BY company_name
--     order by no_of_jobs desc
-- )

-- select * from most_job_openings;



-- with remote_jobs as (
--     select skill.skill_id,
--     skill.skills as skill_name,
--     count(jobs.job_id) as number_of_jobs
-- from job_postings_fact as jobs
-- left join skills_job_dim as skill_per_job 
--     on jobs.job_id = skill_per_job.job_id
-- left join skills_dim as skill
--     on skill_per_job.skill_id=skill.skill_id
-- where jobs.job_work_from_home=True and jobs.job_title_short='Data Analyst'
-- group by skill.skill_id,skill_name
-- order by number_of_jobs desc
--     limit 5

-- )
-- select * from remote_jobs


-- select 
--     job_title_short,
--     salary_year_avg,
--     job_posted_date
-- from jan_jobs
-- where salary_year_avg is not NULL
-- UNION
-- select 
--     job_title_short,
--     salary_year_avg,
--     job_posted_date
-- from feb_jobs
-- where salary_year_avg is not NULL
-- order by job_posted_date



-- select 
--     skills.skills,
--     skills.type 
-- from skills_dim as skills
-- union all
-- select 
--     skills.skills,
--     skills.type 
-- from skills_dim as skills
-- left join skills_job_dim as skill_per_job on skills.skill_id = skill_per_job.skill_id
-- left join job_postings_fact as jobs on skill_per_job.job_id = jobs.job_id
-- where (extract(month from jobs.job_posted_date))>4 and salary_year_avg>700000

-- select
--     job_title_short,
--     job_posted_date::Date,
--     salary_year_avg
-- from(
--     select * from jan_jobs
--     UNION all
--     select * from feb_jobs
--     UNION all
--     select * from mar_jobs
-- )
-- -- left join skills_job_dim as skill_per_job on skills.skill_id = skill_per_job.skill_id
-- -- left join job_postings_fact as jobs on skill_per_job.job_id = jobs.job_id
-- where (extract(month from job_posted_date))<5 and salary_year_avg>70000
-- order by job_posted_date desc
-- limit 5;



select distinct job_location from job_postings_fact ORDER BY job_location