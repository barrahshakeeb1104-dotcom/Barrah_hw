1Q Find the names of students who improved their scores every single day (Day 3 > Day 2 AND Day 2 > Day 1). 
  Also, display the name of the Month they were born in using a date function.
select
full_name,
to_char(dob, 'month') as month,
t2.total_score as day_1,
t3.total_score as day_2,
t4.total_score as day_3
from "RSVP_New" as t1
join day_1_exam as t2
on t1.hall_ticket_no=t2.hall_ticket_no
join day_2_exam as t3
on t1.hall_ticket_no=t3.hall_ticket_no
join day_3_exam as t4
on t1.hall_ticket_no=t4.hall_ticket_no
where t4.total_score>t3.total_score and t3.total_score>t2.total_score

2Q List the names and contact numbers of students who attended the Day 1 AND Day 2 exams, but EXCEPT those who showed up for Day 3.
select
full_name,
contact_no
from "RSVP_New"
where hall_ticket_no in(
  select
  hall_ticket_no from day_1_exam
  intersect
  select hall_ticket_no from day_2_exam
  except
  select hall_ticket_no from day_3_exam 
)

3Q Find the students who registered in the Morning (before 12:00 PM) and scored higher than the average class score of Day 3.
select
t1.full_name,
t1.created_at,
t2.total_score
from "RSVP_New" as t1
join day_3_exam as t2
on t1.hall_ticket_no=t2.hall_ticket_no
where 
EXTRACT(HOUR FROM t1.created_at ) < 12
and
total_score>(
  select avg(total_score) from day_3_exam
)
order by 3 desc
AT TIME ZONE 'UTC'
--or
select
t1.full_name,
t1.created_at,
t2.total_score
from "RSVP_New" as t1
join day_3_exam as t2
on t1.hall_ticket_no=t2.hall_ticket_no
where 
t1.created_at ::time < '12:00:00'
and
total_score>(
  select avg(total_score) from day_3_exam
)
order by 3 desc
--or
select
t1.full_name,
t1.created_at,
t2.total_score
from "RSVP_New" as t1
join day_3_exam as t2
on t1.hall_ticket_no=t2.hall_ticket_no
where 
to_char(t1.created_at, 'HH24:MI:SS') < '12:00:00'
and
total_score>(
  select avg(total_score) from day_3_exam
)
order by 3 desc

4Q Create a master leaderboard. Combine the Hall Ticket Numbers and scores from all 3 days. 
  Use a CASE statement to label them: if the combined score across all 3 days is >120, they are a 'GOAT', otherwise 'Rising Legend'
 select
 hall_ticket_no, 
 SUM(total_score) as total_points,
 case 
when sum(total_score)>120 then 'GOAT'
else 'RISING LEGEND'
end as FINAL_status
 from
 (select hall_ticket_no, total_score from day_1_exam
union all
select hall_ticket_no, total_score from day_2_exam
union all
select hall_ticket_no, total_score FROM day_3_exam)
GROUP BY hall_ticket_no
order BY sum(total_score) desc
--or
SELECT
T1.hall_ticket_no,
(SUM(T2.total_score) + SUM(T3.total_score) + SUM(T4.total_score)) AS TOTAL_POINTS,
CASE
WHEN (SUM(T2.total_score) + SUM(T3.total_score) + SUM(T4.total_score)) > 120 THEN 'GOAT'
ELSE 'RISING LEGEND'
END AS FINAL_STATUS
FROM "RSVP_New" AS T1
JOIN day_1_exam AS T2
ON T1.hall_ticket_no = T2.hall_ticket_no
JOIN day_2_exam AS T3
ON T1.hall_ticket_no = T3.hall_ticket_no
JOIN day_3_exam AS T4
ON T1.hall_ticket_no = T4.hall_ticket_no
GROUP BY T1.hall_ticket_no
ORDER BY 2 DESC
--or
select
t1.hall_ticket_no,
t1.total_score + t2.total_score + t3.total_score as total_points,
case
when t1.total_score + t2.total_score + t3.total_score>120 then 'GOAT'
else 'RISING LEGENG'
end as FINAL_STATUS
from day_1_exam as t1
join day_2_exam as t2
on t1.hall_ticket_no=t2.hall_ticket_no
join day_3_exam as t3
on t1.hall_ticket_no=t3.hall_ticket_no
ORDER BY t1.total_score + t2.total_score + t3.total_score desc
