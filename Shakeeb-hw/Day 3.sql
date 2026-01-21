1Q Find the Average, Maximum, and Minimum marks obtained in the Day 1 Exam to see how the class performed as a whole.
select
avg(total_score) as average_score,
max(total_score) as highest_score,
min(total_score) as lowest_score
from day_1_exam

2Q List the names of MBA students who scored above 35 on Day 2.
select
t1.student_name,
t2.total_score
from day_1_exam as t1
join day_2_exam as t2
on t1. hall_ticket_no=t2.hall_ticket_no
where t2.total_score>35

3Q Identify students whose Day 2 score was strictly higher than their Day 1 score.
select
t1.student_name,
t1.total_score as day1,
t2.total_score as day2
from day_1_exam as t1
join day_2_exam as t2
on t1. hall_ticket_no=t2.hall_ticket_no
where t2.total_score>t1.total_score

4Q Do passing students work faster? Join day_2_exam with qaday2 to find the average 'Total Time' for students who 'Pass' vs those who 'Fail'.
select
t1.result_status,
avg(t2."Total Time")
from day_2_exam as t1
join qaday2 as t2
on t1.hall_ticket_no=t2.hall_ticket_no
group by 1

5Q Which students have NULLs in Q1 or Q2 but still passed the Day 2 exam? (This helps identify students who skip but are still accurate).
select
t1."Q1",
t1."Q2",
t2.result_status
from qaday2 as t1
join day_2_exam as t2
on t1.hall_ticket_no=t2.hall_ticket_no
where ("Q1" is null or "Q2" is null) and t2.result_status='Pass'

6Q For each department, show the total number of registrations, total students who took Day 1, and total students who took Day 2.
select
t1. department_name,
count (t1.department_name) as registrations,
count (t2.hall_ticket_no) as attendance_day1,
count (t3. hall_ticket_no) as attendance_day2
from "RSVP_New" as t1
left join day_1_exam as t2
on t1.hall_ticket_no=t2.hall_ticket_no
left join day_2_exam as t3
on t1.hall_ticket_no=t3.hall_ticket_no
group by 1

7Q Using the dob (Date of Birth) in RSVP_New, identify students born before the year 2000 as 'Senior Students' and those born in 2000 or later as 'Junior Students'.
select
full_name,
dob ,
case
when dob<'01-01-2000' then 'senior_students'
else 'junior_students'
end as age_group
from "RSVP_New"

8Q Join day_2_exam with qaday2. Create a logic: If 'Total Time' is less than 1000 and 'Result' is 'Pass', label them as 'High Efficiency'. If they passed but took longer, label them as 'Hard Worker'.
select
t1.hall_ticket_no,
t1. result_status,
t2. "Total Time",
case 
when t2."Total Time"<1000 and t1.result_status='Pass' then 'high_efficiency'
when t2."Total Time">1000 and t1.result_status='Pass' then 'hard_worker'
else 'needs_support'
end as efficiency_rank
from day_2_exam as t1
join qaday2 as t2
on t1.hall_ticket_no=t2.hall_ticket_no

9Q If a student finished Question 1 (Q1) in under 15 seconds, they are 'Quick to Fall in Love.' If they took over 60 seconds, they are 'Hard to Get.' If they skipped (NULL), they are 'Focusing on their Career'.
select
hall_ticket_no,
"Q1",
case
when "Q1"<15 then 'Quick to Fall in Love'
when "Q1"<60 then 'Waiting for the Right One'
when "Q1">60 then 'Hard to Get'
else 'Focusing on their Career'
end as love_logic
from 
qaday2

10Q Get the full details from RSVP_New for the student who got the absolute maximum score on Day 2.(use subquery)
select
t1.*
from 
"RSVP_New" as t1
join day_2_exam as t2
on t1.hall_ticket_no=t2.hall_ticket_no
where total_score=(select max(total_score) from day_2_exam)

11Q Who registered for the class before 'AMENAH AHSAN'?(use subquery)
select
full_name,
created_at
from "RSVP_New"
where created_at<(select created_at from "RSVP_New" where full_name='AMENAH AHSAN')

12Q Show the details of students who are among the 5 fastest finishers of the Day 2 exam.
select
t1.*
from "RSVP_New" as t1
join qaday2 as t2
on t1.hall_ticket_no=t2.hall_ticket_no
order by t2."Total Time" asc
limit 5
