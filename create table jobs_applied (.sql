create table jobs_applied (
    job_id INT,
    application_sent_date DATE,
    custome_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);


insert into jobs_applied (
    job_id,
    application_sent_date,
    custome_resume,
    resume_file_name,
    cover_letter_sent,
    cover_letter_file_name,
    status
)
values 
(
    1,
    '2024-08-13',
    true,
    'GAUTAM GARG.pdf',
    true,
    'GAUTAM GARG.docx',
    'submitted'
),
(
    2,
    '2024-08-14',
    true,
    'YOGESH KAREER.pdf',
    true,
    'YOGESH KAREER.docx',
    'rejected'
),
(
    3,
    '2024-08-15',
    false,
    'TUSHAL RAJPUT.pdf',
    true,
    'TUSHAL RAJPUT.docx',
    'submitted'
),
(
    4,
    '2024-08-16',
    true,
    'ANIRUDH RAI.pdf',
    false,
    'ANIRUDH RAI.docx',
    'rejected'
),
(
    5,
    '2024-08-17',
    true,
    'CALVIN ALBERT.pdf',
    true,
    'CALVIN ALBERT.docx',
    'submitted'
);


alter table jobs_applied
add contact varchar(50);

update jobs_applied
set contact='Calvin Albert'
where job_id='5'

alter table jobs_applied
rename column contact to contact_name

select * from jobs_applied order by job_id;