/*

	Database Systems 1

	Lab Test - Week 12 (30% of CA)

	Streaming Services & Content
	
	****************** PLEASE FILL IN THE FOLLOWING INFORMATION *******************

		Class Group : SD1c
		Name		: Gursimar Singh Ply
		Student ID	: D00251867

*/

drop database if exists streaming_and_content;
create database streaming_and_content;
use streaming_and_content;
drop table if exists streaming_content, streaming_service, content;

create table content(contentID INT NOT NULL,
content_name VARCHAR(50),
release_year INT,
duration_min INT,
primary key(contentID));

create table streaming_service(serviceID INT NOT NULL,
service_name VARCHAR(20),
service_website VARCHAR(50),
primary key(serviceID));

create table streaming_content(serviceID INT NOT NULL,
contentID INT NOT NULL,
start_date DATE,
end_date DATE,
primary key(serviceID, contentID),
foreign key(serviceID) references streaming_service(serviceID),
foreign key(contentID) references content(contentID));

insert into content values
(101, "The Wolf of Wall Street", 2013, 180),
(102, "The Talented Mr. Ripley", 1999, 139),
(103, "Top Boy", 2011, 1320),
(104, "Breaking Bad", 2008, 3720),
(105, "The Sopranos", 1999, 5160),
(106, "CODA", 2021, 111),
(107, "Amelie",2001, 122),
(108, "Spy", 2015,120),
(109, "Fight Club", 1999, 139),
(110, "Once Upon a Time in America", 1984, 229),
(111, "Pulp Fiction", 1994, 154);

insert into streaming_service values
(1, "Netflix", "https://www.netflix.com"),
(2, "Amazon Prime", "https://www.primevideo.com"),
(3, "Disney+", "https://www.disneyplus.com"),
(4, "Now TV", "https://www.nowtv.com"),
(5, "Apple TV", "https://tv.apple.com/");

insert into streaming_content values
(1,101,'2020-01-01','2023-12-31'),
(2,101,'2017-01-01','2019-11-30'),
(4,101,'2015-01-01','2015-12-31'),
(1,102,'2013-03-15','2023-05-10'),
(2,102,'2014-08-29','2015-09-11'),
(1,103,'2014-02-01','2030-12-31'),
(1,104,'2015-04-10','2015-11-30'),
(4,105,'2010-01-01','2025-01-01'),
(5,106,'2021-08-31','2030-01-31'),
(3,107,'2022-02-02','2023-07-01'),
(1,107,'2019-04-15','2022-06-01'),
(1,108,'2019-05-05','2020-09-10'),
(2,108,'2020-01-15','2021-10-15'),
(3,108,'2021-01-01','2025-01-01'),
(4,108,'2016-01-01','2025-11-10'),
(3,109,'2022-01-01','2029-05-17'),
(4,109,'2011-02-14','2017-01-31'),
(1,109,'2016-08-03','2020-12-31'),
(2,109,'2021-01-01','2021-12-31'),
(2,110,'2014-06-16','2019-01-31'),
(1,110,'2020-02-01','2024-12-31'),
(1,111,'2015-05-19','2018-08-31'),
(2,111,'2011-11-11','2012-12-12'),
(3,111,'2021-01-01','2021-12-31'),
(4,111,'2011-05-15','2029-01-31');

/* 	Q1 Display names of shows and/or movies longer than 3 hours which appeared on any straming services on Mondays
	
	Q1 NOTES: The following sql selects name duration and day name from all the three tables and checks for the movies which have duration less than 3hrs and  start date as monday

*/
--- PUT YOUR SQL COMMAND(S) FOR Q1 ON THE LINE BELLOW HERE...
SELECT content.content_name,duration_min,DAYNAME(streaming_content.start_date) 
	FROM content JOIN streaming_content USING(contentID) WHERE content.duration_min > 180 AND DAYNAME(streaming_content.start_date) = "Monday";


/* 	Q2 Provide the number of shows/movies released on any streaming service for days of the week where more than 3 shows were released.
	
	Q2 NOTES: I tried to understand the data but couldnt find the coloum of getting the realease date  as none of the coloumns specify a realease date, they either represent start date or release year
	
*/
--- PUT YOUR SQL COMMAND(S) FOR Q2 ON THE LINE BELLOW HERE...
	SELECT DAYNAME(cs.start_date) , COUNT(c.content_name) as number_of_shows 
		FROM content c JOIN streaming_content cs ON c.contentID =cs.contentID GROUP BY cs.start_date HAVING number_of_shows > 3;

/*	Q3 Display the name of movies/tv showa released for streaming on Fridays and the name of their streaming service(s).
	
	Q3 NOTES:  this sql statement finds the movies which where released on friday and gets there streaming service name

*/
--- PUT YOUR SQL COMMAND(S) FOR Q3 ON THE LINE BELLOW HERE...
	SELECT ss.service_name , c.content_name , DAYNAME(cs.start_date) FROM streaming_content cs 
	JOIN content c ON c.contentID = cs.contentID 
	JOIN streaming_service ss ON ss.serviceID = cs.serviceID 
	WHERE DAYNAME(cs.start_date) = "Friday";


/*	Q4 Display movies/tv showes which were/are streamed by only 1 streaming service. 
 
	Q4 NOTES: the following sql  counts the serice ID as number of servies for all the content and then we group the content id which has the number of serices as 1

*/
--- PUT YOUR SQL COMMAND(S) FOR Q4 ON THE LINE BELLOW HERE...
	SELECT DISTINCT c.content_name , COUNT(cs.serviceID) as number_of_services FROM streaming_content cs 
	JOIN content c ON c.contentID =	cs.contentID 
	JOIN streaming_service ss ON ss.serviceID = cs.serviceID 
	GROUP BY cs.contentID HAVING number_of_services = 1;

/*	Q5 Display the number of movies released on streaming services each month.

	Q5 NOTES: the following sql statment gets the month and counts all the content and groups them by their month

*/
--- PUT YOUR SQL COMMAND(S) FOR Q5 ON THE LINE BELLOW HERE...
SELECT month(start_date) as month, COUNT(*) as number_of_shows FROM streaming_content GROUP BY month(start_date);

/*	Q6 Display the movie/TV show with the shortest duration and its streaming service(s). 
       

	Q6 NOTES: this sql first selects name duration and service name and then we check by getting the lowest duration and only select the duration with the min duration

*/
--- PUT YOUR SQL COMMAND(S) FOR Q6 ON THE LINE BELLOW HERE...
SELECT DISTINCT c.content_name , c.duration_min , ss.service_name 
	FROM streaming_content cs 
	JOIN content c ON c.contentID = cs.contentID 
	JOIN streaming_service ss ON ss.serviceID = cs.serviceID 
	WHERE c.duration_min = (SELECT MIN(content.duration_min) FROM content);


/*	Q7 Display each movie, its respective streaming service and the streaming duration in months from streaming start date to streaming end date.

	Q7 NOTES: 

*/
--- PUT YOUR SQL COMMAND(S) FOR Q7 ON THE LINE BELLOW HERE...
