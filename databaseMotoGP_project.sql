DROP DATABASE IF EXISTS practiceTestProject;
CREATE DATABASE IF NOT EXISTS practiceTestProject;
USE practiceTestProject;
DROP TABLE IF EXISTS riders, teams, assigned_rider,bikes,rankings,circuits;


CREATE TABLE riders ( 
riderID VARCHAR(5) NOT NULL,
rider_name VARCHAR(30) NOT NULL,
date_of_birth DATE,
place_of_birth VARCHAR(15),
country VARCHAR(20),
PRIMARY KEY (riderID));


CREATE TABLE teams ( 
teamID VARCHAR(5) NOT NULL,
team_name VARCHAR(30) NOT NULL,
team_founded_by VARCHAR(30),
total_wins INT,
PRIMARY KEY (teamID));

CREATE TABLE assigned_rider ( 
    riderID VARCHAR(5) NOT NULL, 
    teamID VARCHAR(5) NOT NULL, 
    rider_wins int, 
    PRIMARY KEY (riderID), 
    FOREIGN KEY (riderID) REFERENCES riders(riderID), 
    FOREIGN KEY (teamID) REFERENCES teams(teamID));

CREATE TABLE bikes ( 
    teamID VARCHAR(5) NOT NULL, 
    bike_name VARCHAR(20) NOT NULL, 
	engine_type VARCHAR(30),
	max_power INT,
    max_speed INT,
    tires VARCHAR(15),
    fuel_capacity DOUBLE(4,2),
    dry_weight DOUBLE (6,3),
	PRIMARY KEY (teamID), 
    FOREIGN KEY (teamID) REFERENCES teams(teamID));

CREATE TABLE circuits ( 
    circuitID VARCHAR(5) NOT NULL,
    circuit_name VARCHAR(35) NOT NULL,
	track_length DOUBLE(5,2),
	average_track_condition VARCHAR(10),
    average_temperature INT,
    PRIMARY KEY (circuitID));
    
    
CREATE TABLE rankings ( 
    ranking INT NOT NULL,
    riderID VARCHAR(5) NOT NULL,
	teamID VARCHAR(5) NOT NULL,
	circuitID VARCHAR(5) NOT NULL,
    race_date DATE,
    PRIMARY KEY (riderID,race_date),
    FOREIGN KEY (riderID) REFERENCES riders(riderID),
    FOREIGN KEY (teamID) REFERENCES teams(teamID),
    FOREIGN KEY (circuitID) REFERENCES circuits(circuitID));
    
    
ALTER TABLE bikes CHANGE tires bike_tires varchar(15);

INSERT INTO `riders` (`riderID`, `rider_name`, `date_of_birth`, `place_of_birth`, `country`) 
VALUES ('RD12', 'Maverick Vinales', '12/01/1995', 'Figueres', 'Spain');

UPDATE `riders` SET `date_of_birth` = '1995-01-12' WHERE `riders`.`riderID` = 'RD12';

INSERT 
INTO `riders` (`riderID`, `rider_name`, `date_of_birth`, `place_of_birth`, `country`) 
    VALUES 
    ('RD44', 'Pol Espargaro', '1991-06-10', 'Granollers', 'Spain'), 
    ('RD5', 'Johann Zarco', '1990-07-16', 'Cannes', 'France');

INSERT INTO `riders` (`riderID`, `rider_name`, `date_of_birth`, `place_of_birth`, `country`) 
VALUES ('RD33', 'Brad Binder', '1995-08-11', 'Potchefstroom', 'South Africa'),
       ('RD25', 'Miguel Oliveira', '1995-01-04', 'Pragal', 'Portugal '),
       ('RD23', 'Enea Bastianin', '1997-12-30', 'Rimini', 'Italy'),
       ('RD63', 'Francesco Bagnaia', '1997-01-14', 'Torino', 'Italy'),
       ('RD20', 'Fabio Quartararo', '1999-04-20', 'Nice', 'France'),
       ('RD16', 'Jorge Martin', '1998-01-29', 'Madrid', 'Spain');

INSERT INTO `riders` (`riderID`, `rider_name`, `date_of_birth`, `place_of_birth`, `country`) 
VALUES ('RD36', 'Joan Mir', '1997-09-01', 'Palma de Mallorca', 'Spain');

ALTER TABLE `riders` CHANGE `place_of_birth` `place_of_birth` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL;

UPDATE `riders` SET `place_of_birth` = 'Palma de Mallorca' WHERE `riders`.`riderID` = 'RD36';

SELECT place_of_birth FROM riders WHERE riders.riderID = 'RD36';


INSERT INTO `teams` (`teamID`, `team_name`, `team_founded_by`, `total_wins`) 
VALUES 
('T01', 'Red Bull KTM Factory Racing', 'Pit beirer', '1'),
('T02', 'Monster Energy Yamaha MotoGP™', 'Yamaha', '105'),
('T03', 'Ducati Lenovo Team', 'Claudio Domenicali', '50'),
('T04', 'Gresini Racing MotoGP', 'Fausto Gresini', '1'),
('T05', 'Repsol Honda Team', 'Honda', '5'),
('T06', 'Pramac Racing', "Luis d'Antin", '0'),
('T07', 'Aprilia Racing', 'Alberto Beggio', '294'),
('T08', 'Suzuki Ecstar', 'Livio Suppo', '1'),
('T09', 'Mooney VR46 Racing Team', 'Valentino Rossi', '0'),
('T10', 'Team HRC', 'Honda', '0');

INSERT INTO `assigned_rider` (`riderID`, `teamID`, `rider_wins`) 
VALUES 
('RD5', 'T06', '0'),
('RD12', 'T07', '9'),
('RD16', 'T06', '1'),
('RD20', 'T02', '8'),
('RD23', 'T04', '1'),
('RD25', 'T01', '4'),
('RD33', 'T01', '2'),
('RD36', 'T08', '3'),
('RD44', 'T05', '0'),
('RD63', 'T03', '4');

INSERT INTO `circuits` (`circuitID`, `circuit_name`, `track_length`, `average_track_condition`, `average_temperature`) 
VALUES 
('CR01', 'Lusail International Circuit', '5.380', 'Dry', '23'),
('CR02', 'Pertamina Mandalika Circuit', '4.313', 'Wet', '25'),
('CR03', 'Termas de Río Hondo', '4.805', 'Dry', '26'),
('CR04', 'Circuit Of The Americas', '5.514', 'Dry', '26'),
('CR05', 'Autódromo Internacional do Algarve', ' 4.653', 'Dry', '18'),
('CR06', 'Circuito de Jerez', '4.428', 'Dry', '27'),
('CR07', 'Circuito de Derek', '5.369', 'Wet', '23'),
('CR08', 'Le Mans', '4.185', 'Dry', '17'),
('CR09', 'Autodromo Internazionale del Mugello', '5.245', 'Dry', '23'),
('CR10', 'Circuit de Barcelona-Catalunya', '4.655', 'Dry', '25');


ALTER TABLE circuits CHANGE circuit_name circuit_name varchar(40);

UPDATE `circuits` SET `circuit_name` = 'Autodromo Internazionale del Mugello' WHERE `circuits`.`circuitID` = 'CR09';

INSERT INTO `bikes` (`teamID`, `bike_name`, `engine_type`, `max_power`, `max_speed`, `bike_tires`, `fuel_capacity`, `dry_weight`) 
VALUES 
('T01', 'KTM RC16', 'Four-stroke V4', '198', '339', 'Marchesini', '22', '157'),
('T02', 'Yamaha YZR-M1', 'DOHC 4-stroke with 16-valve ', '183', '340', 'Michelin', '21', '157');

ALTER TABLE `bikes` CHANGE `bike_name` `bike_name` VARCHAR(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL;

INSERT INTO `bikes` (`teamID`, `bike_name`, `engine_type`, `max_power`, `max_speed`, `bike_tires`, `fuel_capacity`, `dry_weight`)
VALUES 
('T03', 'Ducati Desmosedici GP22', ' V4 4-stroke with 16-valve', '186.42', '350', 'Bridgestone', '21', '157'),
('T04', 'Ducati Desmosedici GP21', ' V4 4-stroke with 16-valve', '149.14', '350', 'Bridgestone', '21', '150'),
('T05', 'Honda RC213V', '4-stroke DOHC 4-valve V4', '237', '355', 'Michelin', '16', '160'),
('T06', 'Ducati Desmosedici GP21', ' V4 4-stroke with 16-valve', '149.14', '350', 'Bridgestone', '21', '150'),
('T07', 'Aprilia RS-GP', 'Four-stroke V4 75°, liquid-cooled', '251', '350', '', '22', '160'),
('T08', 'Suzuki GSX-RR', 'DOHC 16-valve', '237', '340 ', 'Bridgestone', '22', '157'),
('T09', 'Ducati Desmosedici GP22', ' V4 4-stroke with 16-valve', '186.42', '350', 'Bridgestone', '21', '157'),
('T10', 'Honda RC213V', ' V4 4-stroke with 16-valve', '185', '355', 'Michelin', '20', '160');

UPDATE `bikes` SET `engine_type` = 'Four-stroke V4 liquid-cooled' WHERE `bikes`.`teamID` = 'T07';


INSERT INTO `rankings` (`ranking`, `riderID`, `teamID`, `circuitID`, `race_date`)
VALUES 
('1', 'RD23', 'T04', 'CR01', '2022-03-06'),
('2', 'RD33', 'T01', 'CR01', '2022-03-06'),
('3', 'RD44', 'T05', 'CR01', '2022-03-06'),
('4', 'RD20', 'T02', 'CR01', '2022-03-06'),
('5', 'RD5', 'T06', 'CR01', '2022-03-06'),
('1', 'RD25', 'T01', 'CR02', '2022-03-20'),
('2', 'RD23', 'T04', 'CR02', '2022-03-20'),
('3', 'RD36', 'T08', 'CR02', '2022-03-20'),
('4', 'RD63', 'T03', 'CR02', '2022-03-20'),
('5', 'RD12', 'T07', 'CR02', '2022-03-20');

SELECT * from rankings WHERE race_date="2022-03-06";

SELECT * from rankings WHERE race_date="2022-03-06" ORDER BY ranking ASC;

SELECT riders.rider_name , rankings.ranking FROM rankings 
    JOIN riders ON rankings.riderID = riders.riderID WHERE race_date = "2022-03-06" ORDER BY ranking ASC;

SELECT bikes.bike_name , rankings.race_date FROM bikes JOIN rankings ON rankings.teamID = bikes.teamID WHERE ranking = 1;
