Q1: Count how many students passed the exam.
select
count(result_status)
from day_1_exam
where result_status='Pass'

Q2: Find the average score of all students who failed.
select
avg(total_score)
from day_1_exam
where result_status='Fail'

Q3: Get the highest score among all students.
select
max(total_score)
from day_1_exam

Q4: Get the lowest score among passed students.
select
min(total_score)
from day_1_exam
where result_status='Pass'

Q5: Sum the total marks of all students who scored above 40.
select
sum(total_score)
from day_1_exam
where total_score>40

Q6: Count students by result status for those who scored 35 or more.
select
distinct result_status,
count (total_score)
from day_1_exam
where total_score>34
group by 1

Q7: Find average score grouped by result status for students with scores between 30 and 40.
select
distinct (result_status),
avg(total_score)
from day_1_exam
where total_score between 30 and 40
group by 1

Q8: Get maximum and minimum scores grouped by result status for students who scored less than 35.
select
distinct(result_status),
max(total_score),
min(total_score)
from day_1_exam
where total_score<35
group by 1

Q9: Count students grouped by result status for those whose names start with 'A'.
select
distinct(result_status),
count(result_status)
from day_1_exam
where student_name like 'A%'
group by 1 

Q10: Sum total scores grouped by result status for students who scored exactly 35, 40, or 45.
select
distinct(result_status),
SUM(total_score)
from day_1_exam
where total_score<35
group by 1

Q11: Count students by each score value, ordered by score descending.
select
distinct total_score,
count(total_score)
from day_1_exam
group by 1
order by total_score desc

Q12: Show average score for each result status, ordered by average score.
select
distinct result_status,
avg (total_score)
from day_1_exam
group by 1
order by avg (total_score) desc

Q13: Count how many students got each score, only for scores above 30, ordered by frequency.
select
distinct total_score,
count(total_score)
from day_1_exam
where total_score>30
group by 1
order by count(total_score)

Q14: Get total marks sum for each result status, ordered by sum.
select
distinct(result_status),
sum (total_score)
from day_1_exam
group by 1 
order by sum(total_score)

Q15: Find minimum score for each result status, ordered by min score.
 select
 distinct result_status,
 min (total_score)
 from day_1_exam
 group by 1 
 order by min(total_score)

Q16: For passed students only, show count, average, max and min scores grouped by whether score is above 40.
 select
 distinct(result_status),
 count(total_score),
 avg(total_score),
 max(total_score),
 min(total_score)
 from day_1_exam
 where result_status='Pass' and total_score>40
 group by 1

Q17: Count and average score for each result status, only for scores not equal to 35.
select
 distinct result_status,
 count(total_score),
 avg(total_score)
 from day_1_exam
 where total_score>35 or total_score<35
 group by 1

Q18: Group students by score ranges (0-20, 21-30, 31-40, 41-50) and show count for each range.
select
case
when total_score between 0 and 20 then '0-20'
when total_score between 21 and 30 then '21-30'
when total_score between 31 and 40 then '31-40'
else '41-50'
end as score_range,
count (total_score) as count_of_range 
from day_1_exam
group by 1
 
Q19: For each result status, show count of students with scores greater than 30 and less than 40.
select
distinct result_status,
count(total_score)
from day_1_exam
where total_score>30 and total_score<40
group by 1

Q20: Group by first letter of student name and show count and average score for each letter.
select
case
when student_name like 'A%' then 'A'
when student_name like 'B%' then 'B'
when student_name like 'C%' then 'C'
when student_name like 'D%' then 'D'
when student_name like 'E%' then 'E'
when student_name like 'F%' then 'F'
when student_name like 'G%' then 'G'
when student_name like 'H%' then 'H'
when student_name like 'I%' then 'I'
when student_name like 'J%' then 'J'
when student_name like 'K%' then 'K'
when student_name like 'L%' then 'L'
when student_name like 'M%' then 'M'
when student_name like 'N%' then 'N'
when student_name like 'O%' then 'O'
when student_name like 'P%' then 'P'
when student_name like 'Q%' then 'Q'
when student_name like 'R%' then 'R'
when student_name like 'S%' then 'S'
when student_name like 'T%' then 'T'
when student_name like 'U%' then 'U'
when student_name like 'V%' then 'V'
when student_name like 'W%' then 'W'
when student_name like 'X%' then 'X'
when student_name like 'Y%' then 'Y'
else 'Z'
end as first_letter,
count(student_name),
avg(total_score)
from day_1_exam
group by 1
order by 1
