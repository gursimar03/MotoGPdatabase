DROP DATABASE IF EXISTS clubactivityschedule;
CREATE DATABASE IF NOT EXISTS clubactivityschedule;
USE clubactivityschedule;
DROP TABLE IF EXISTS schedule, activity, club;

CREATE TABLE club ( club_id VARCHAR(20) NOT NULL,
name VARCHAR(30),
address VARCHAR(30),
subscription VARCHAR(20),
membership_cost DECIMAL(10,2) DEFAULT 0, -- changed back to decimal
PRIMARY KEY (club_id));

CREATE table activity (activity_id VARCHAR(5) NOT NULL,
activity_name VARCHAR (20) NOT NULL,
minimum_players int,
maximum_players int, 
duration int,
PRIMARY KEY (activity_id ));

CREATE table schedule (club_id VARCHAR(20) NOT NULL,
activity_id VARCHAR(5) NOT NULL,
event_date DATE NOT NULL, 
start_time TIME NOT NULL,
PRIMARY KEY (club_id, activity_id, event_date, start_time),
FOREIGN KEY (club_id) REFERENCES club(club_id),
FOREIGN KEY (activity_id) REFERENCES activity(activity_id));  


INSERT INTO club VALUES ("CouSP", "Court Sport", "Railway Rd Drogheda", "Yearly", 50);
INSERT INTO club VALUES ("CueCL", "Cue Club", "Newline Drogheda", "Session", 5);
INSERT INTO club VALUES ("DroSC", "Drogheda Swimming Centre", "Park St Drogheda", "Session", 7);
INSERT INTO club VALUES ("DunAC", "Dundalk Athletics Club", "Coast Rd Blackrock", "Yearly", 75);
INSERT INTO club VALUES ("DunLC", "Dundalk Leisure Complex", "Hillside Dundalk", "Session", 5);
INSERT INTO club VALUES ("KicFO", "Kickabout Football", "Marsh Pitches Dundalk", "None", 0);
INSERT INTO club VALUES ("NewGC", "Newtown Golf Club", "Newtown Rd Dundalk", "Yearly", 200);
INSERT INTO club VALUES ("PocSC", "Pockets Snooker Club", "Keepers Close Dundalk", "Session", 4);
INSERT INTO club VALUES ("RacCL", "Racket Club", "Community Courts Drogheda", "None", 0);
INSERT INTO club VALUES ("SeaTC", "Seaview Tennis Club", "Seaview Blackrock", "Yearly", 70);
INSERT INTO club VALUES ("TeeGC", "Tee Time Golf Club", "Avenue Lane Blackrock", "Session", 10);

INSERT INTO activity VALUES ("BDMN", "Badminton",2,4,45);
INSERT INTO activity VALUES ("TNIS", "Tennis", 2, 4, 90);
INSERT INTO activity VALUES ("POOL", "Pool", 2, 2, 30);
INSERT INTO activity VALUES ("SNKR", "Snooker", 2, 4, 90);
INSERT INTO activity VALUES ("SWIM", "Swimming", 1, null, 30);
INSERT INTO activity VALUES ("RUNN", "Running", 1, null, 30);
INSERT INTO activity VALUES ("FTBL", "Football", 5, 20, 100);
INSERT INTO activity VALUES ("SQSH", "Squash", 2, 4, 45);
INSERT INTO activity VALUES ("GOLF", "Golf", 1, null, 120);

INSERT INTO schedule VALUES ("CouSP","BDMN", '2020-03-27','15:00');
INSERT INTO schedule VALUES ("CouSP","BDMN", '2020-03-27','16:00');
INSERT INTO schedule VALUES ("CouSP","BDMN", '2020-03-28','15:00');
INSERT INTO schedule VALUES ("CouSP","BDMN", '2020-03-28','16:00');
INSERT INTO schedule VALUES ("CouSP","TNIS", '2020-03-29','17:00');
INSERT INTO schedule VALUES ("CouSP","BDMN", '2020-03-29','18:00');
INSERT INTO schedule VALUES ("CouSP","BDMN", '2020-03-30','17:00');
INSERT INTO schedule VALUES ("CouSP","BDMN", '2020-03-30','18:00');
INSERT INTO schedule VALUES ("CueCL","POOL", '2020-03-28','16:00');
INSERT INTO schedule VALUES ("CueCL","POOL", '2020-03-28','17:00');
INSERT INTO schedule VALUES ("CueCL","POOL", '2020-03-29','17:00');
INSERT INTO schedule VALUES ("CueCL","POOL", '2020-03-30','18:00');
INSERT INTO schedule VALUES ("CueCL","SNKR", '2020-03-28','12:00');
INSERT INTO schedule VALUES ("CueCL","SNKR", '2020-03-28','13:45');
INSERT INTO schedule VALUES ("CueCL","SNKR", '2020-03-28','16:00');
INSERT INTO schedule VALUES ("CueCL","SNKR", '2020-03-28','18:00');
INSERT INTO schedule VALUES ("DroSC","SWIM", '2020-03-08','15:00');
INSERT INTO schedule VALUES ("DunAC","RUNN", '2020-03-08','16:00');
INSERT INTO schedule VALUES ("DunLC","FTBL", '2020-03-09','18:00');
INSERT INTO schedule VALUES ("DunLC","POOL", '2020-03-09','17:00');
INSERT INTO schedule VALUES ("DunLC","SQSH", '2020-03-10','16:00');
INSERT INTO schedule VALUES ("DunLC","SWIM", '2020-03-10','17:00');
INSERT INTO schedule VALUES ("DunLC","TNIS", '2020-03-10','18:00');
INSERT INTO schedule VALUES ("KicFO","FTBL", '2020-03-08','18:00');
INSERT INTO schedule VALUES ("NewGC","GOLF", '2020-03-08','18:00');
INSERT INTO schedule VALUES ("PocSC","POOL", '2020-03-10','18:00');
INSERT INTO schedule VALUES ("PocSC","SNKR", '2020-03-10','18:00');
INSERT INTO schedule VALUES ("RacCL","TNIS", '2020-03-12','15:00');
INSERT INTO schedule VALUES ("SeaTC","TNIS", '2020-03-12','16:00');
INSERT INTO schedule VALUES ("TeeGC","GOLF", '2020-03-12','18:00'); 


SELECT name, activity_id
FROM club JOIN schedule USING (club_id);
/*displaying activity_id for each club name*/

SELECT club.name, schedule.activity_id
FROM club JOIN schedule ON club.club_id = schedule.club_id;
/*in cases where the same aattribute name is used in multiple tables*/

SELECT c.name, s.activity_id 
FROM club c JOIN schedule s ON c.club_id = s.club_id;
/*using alias for tables*/

select c.name, s.activity_id
from club c, schedule s where c.club_id = s.club_id;

--Q2. In order to obtain the activity NAME we need to join with the third table: 3-table JOIN
SELECT c.name, a.activity_name 
FROM club c JOIN schedule s using(club_id)
JOIN activity a using(activity_id);

--Alternatively: JOIN/ON -- in cases whre the same attribute name is used 
--in multiple tables of the same database
SELECT c.name, a.activity_name
FROM club c JOIN schedule s ON c.club_id = s.club_id
JOIN activity a ON s.activity_id = a.activity_id;

SELECT c.name, a.activity_name 
FROM club c,schedule s,activity a
WHERE c.club_id = s.club_id AND s.activity_id = a.activity_id;

/*Q3. Show club name, activity name and start time for all activities in DB*/
select c.name, a.activity_name, s.start_time
from club c, schedule s, activity a
where c.club_id = s.club_id AND
s.activity_id = a. activity_id;

/*Q4. Show count of number of events scheduled for each date*/
select event_date, count(activity_id) as number_of_activities
from schedule group by event_date;

/*Q5. 	Illustrating the use of some date & time functions 
to make more interesting queries. 
See link for reference:  https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html 
*/
SELECT activity_id, dayname(event_date) FROM schedule
/*displaying the day of the week for each activity_id in the schedule table */

SELECT activity_id,start_time from schedule WHERE hour(schedule.start_time) = 16;
/*displaying activity_id and its start time for activities starting after 16:00 and before 17*/

/*Q6 	Show activity name and date and start time for all scheduled 
events on particular date (chose your own date)*/
select a.activity_name, s.event_date, s.start_time
from schedule s, activity a 
where s.activity_id = a. activity_id
and s.event_date = '2020-03-10';

select a.activity_name, s.event_date, s.start_time
from schedule s join activity a 
on s.activity_id = a.activity_id
where s.event_date = '2020-03-10';

/*Q7 	Show club name, activity name and start time for all activities on a Thursday*/
select c.name, a.activity_name, s.start_time, dayname(s.event_date)
from club c, activity a, schedule s
where c.club_id = s.club_id and
a.activity_id = s.activity_id and
dayname(event_date) = "Thursday";

/*Alternative syntax*/
select c.name, a.activity_name, s.start_time, dayname(s.event_date)
from club c join schedule s 
ON c.club_id = s.club_id
join activity a 
on a.activity_id = s.activity_id
where dayname(event_date) = "Thursday";

/*Q8 	Show details (club name, activity name, start time and day) 
for all activities starting on or before 17:00*/
select c.name, a.activity_name, s.start_time, dayname(s.event_date)
from club c, schedule s, activity a 
where c.club_id = s.club_id and 
s.activity_id = a.activity_id and 
hour(s.start_time) <= 17;

/*Alternative join*/
select c.name, a.activity_name, s.start_time, dayname(s.event_date)
from club c join schedule s 
on c.club_id = s.club_id
join activity a 
on s.activity_id = a.activity_id
where hour(s.start_time) <= 17;

/*Q9 	Show details of all activities scheduled on days other than Monday or Tuesday*/
select a.*, dayname(s.event_date)
from activity a, schedule s 
where a.activity_id = s.activity_id and 
dayname(s.event_date) not in ("Monday","Tuesday");

select a.*, dayname(s.event_date)
from activity a, schedule s 
where a.activity_id = s.activity_id and 
dayname(s.event_date) in ("Wednesday","Thursday", "Friday", "Saturday", "Sunday");

/*Q10. Show names of activities of longer than 60 mins duration that 
are played on a Thursday*/
/*even though I am required to select from one table only, I have to join with scheudle, 
because info from scheudle is in one of the conditions*/
select a.activity_name, dayname(s.event_date), a.duration
from activity a, schedule s
where a.activity_id = s.activity_id and
a.duration > 60 and
dayname(s.event_date) = "Thursday";

/*Alternative Join*/
select a.activity_name, dayname(s.event_date), a.duration
from activity a join schedule s 
on a.activity_id = s.activity_id
where a.duration > 60 and
dayname(s.event_date) = "Thursday";

/*Q11. Show activities requiring longer than 60 mins that are 
played on a Thursday in a club with yearly sub of less than €100 */
select a.activity_name, dayname(s.event_date), a.duration, c.subscription, c.membership_cost
from activity a, schedule s, club c
where a.activity_id = s.activity_id and
s.club_id = c.club_id and
a.duration > 60 and
dayname(s.event_date) = "Thursday" and
c.subscription = "Yearly" and
c.membership_cost < 100;

/*Alternative Join*/
select a.activity_name, dayname(s.event_date), a.duration, c.subscription, c.membership_cost
from activity a join schedule s 
on a.activity_id = s.activity_id
join club c 
on c.club_id = s.club_id
where a.duration > 60 and
dayname(s.event_date) = "Thursday"and
c.subscription = "Yearly" and
c.membership_cost < 100;

/*Q12.Show activity name, clubname, minimum number of players required 
and starting time for all activities scheduled after 14:00 on a Friday*/
select a.activity_name, c.name, a.minimum_players, s.start_time, dayname(s.event_date)
from activity a, schedule s, club c 
where a.activity_id = s.activity_id and
s.club_id = c.club_id and 
hour(s.start_time) > 14 and 
dayname(s.event_date) = "Friday";

select a.activity_name, c.name, a.minimum_players, s.start_time, dayname(s.event_date)
from activity a join schedule s 
on a.activity_id = s.activity_id
join club c 
on s.club_id = c.club_id
where hour(s.start_time) > 14 and 
dayname(s.event_date) = "Friday";

/*Q13	Show activity name, clubname, for all activities scheduled in a club in Drogheda  
ordered by date & time. */
select a.activity_name, c.name, c.address, s.event_date, s.start_time 
from activity a, schedule s, club c 
where a.activity_id = s.activity_id and
s.club_id = c.club_id and 
address like "%Drogheda%"
order by s.event_date, s.start_time;

/*Modify Q13 to show a subset of the returned values based 
on additional criteria – Be creative!*/
/*Updated query: Show activity name, clubname, for all activities scheduled in a club 
in Drogheda which has annual subscription of less than €100 on Friday, Saturday or Sunday
ordered by date & time.*/
select a.activity_name, c.name, c.address, c.subscription, c.membership_cost, 
s.event_date, s.start_time, dayname(s.event_date) 
from activity a, schedule s, club c 
where a.activity_id = s.activity_id and
s.club_id = c.club_id and 
address like "%Drogheda%" and 
subscription = "Yearly" and 
membership_cost < 100 and 
dayname(s.event_date) in ("Friday", "Saturday", "Sunday")
order by s.event_date, s.start_time;

/*Q14 Show name of those activities of shorter duration than 90mins scheduled in a club 
with “session” subscription type.*/
/*even though displaying and conditionning on attributes from 2 tables, 
we need to join all three as club can only be joined with activity through schedule*/
select a.activity_name, a.duration, c.subscription 
from activity a, schedule s, club c 
where a.activity_id = s.activity_id and 
s.club_id = c.club_id and 
c.subscription = "Session" and 
a.duration < 90;

/*Q15. Show the number of times each activity appears in the schedule*/
/*aggregate functions*/
select activity_id, count(activity_id) from schedule group by activity_id;
/*More user friendly by displaying the actual activity name, not id  and using an alias for the count*/
select a.activity_name, count(s.activity_id) as number_of_times
from schedule s join activity a
on s.activity_id = a.activity_id
group by a.activity_name;

/*Q16. Show those activities that appear more than twice in the schedule*/
select a.activity_name, count(s.activity_id) as number_of_times
from schedule s join activity a
on s.activity_id = a.activity_id
group by a.activity_name
having count(s.activity_id) > 2;

/*Alternative syntax*/
select a.activity_name, count(s.activity_id) as number_of_times
from schedule s, activity a 
where s.activity_id = a.activity_id 
group by a.activity_name
having number_of_times > 2;










