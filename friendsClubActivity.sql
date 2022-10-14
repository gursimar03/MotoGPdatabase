SELECT club.name,activity.activity_name,schedule.start_time FROM club,schedule,activity;

SELECT schedule.event_date , COUNT(*) FROM schedule GROUP BY (schedule.event_date);

SELECT activity_id, DAYNAME(event_date) FROM schedule;

SELECT activity_id,start_time FROM schedule WHERE HOUR(schedule.start_time) = 16;

SELECT activity.activity_name,schedule.event_date,schedule.start_time 
    FROM schedule JOIN activity USING(activity_id) WHERE event_date = '2020-03-29';

SELECT club.name,activity.activity_name,schedule.start_time
    FROM schedule,club,activity WHERE DAYNAME(schedule.event_date) = "thursday";

SELECT club.name,activity.activity_name,schedule.start_time,DAYNAME(schedule.event_date),schedule.event_date
    FROM schedule,activity INNER JOIN club ON club_id = club.club_id WHERE schedule.start_time <= '17:00';

SELECT activity.activity_name , DAYNAME(schedule.event_date) FROM activity JOIN schedule USING(activity_id) 
    WHERE (DAYNAME(schedule.event_date) != "tuesday" && DAYNAME(schedule.event_date) != "monday");

SELECT activity.activity_name , duration FROM activity 
    JOIN schedule USING(activity_id) WHERE duration > 60 AND DAYNAME(schedule.event_date) = "thursday";

SELECT activity.activity_name , duration 
    FROM activity,club,schedule WHERE duration > 60 AND DAYNAME(schedule.event_date) = "thursday" AND club.membership_cost < 100 AND club.club_id = schedule.club_id;

SELECT activity.activity_name , club.name, activity.minimum_players , schedule.start_time 
    FROM activity,club,schedule WHERE schedule.start_time > "14:00" AND DAYNAME(schedule.event_date) = "friday" AND club.club_id = schedule.club_id AND schedule.activity_id = activity.activity_id;

SELECT activity_name, name, minimum_players, start_time, DAYNAME(s.event_date),s.event_date 
    FROM activity a, club c, schedule s WHERE s.start_time > '14:00:00' AND DAYNAME(s.event_date) = 'Friday';
