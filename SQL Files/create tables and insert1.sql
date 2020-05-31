CREATE SCHEMA `racing_project` ;
use racing_project;

CREATE TABLE Team
(Team_ID      int NOT NULL,
Team_Name    varchar(50) NOT NULL,
Fund_Date   date NOT NULL,
nickName    varchar(50),
PRIMARY KEY (Team_ID ))
ENGINE=INNODB;

CREATE TABLE Driver
(Driver_ID    int NOT NULL,
Team_ID      int NOT NULL,
firstName    varchar(50) NOT NULL,
lastName   varchar(50) NOT NULL,
nickName    varchar(50),
doB			date NOT NULL,
exp_years   INT DEFAULT 0 ,
check (exp_years>=0),
PRIMARY KEY (Driver_ID),
FOREIGN KEY Driver(Team_ID) REFERENCES Team(Team_ID))
ENGINE=INNODB;

CREATE TABLE Model
( Model_ID INT NOT NULL,
  Firm varchar(50) NOT NULL,
  onRoadDate Date Not Null,
  Price Float Not Null,
  check (price>=0),
  PRIMARY KEY (Model_ID)
)
ENGINE=INNODB;

CREATE TABLE Car
(
  Car_Id INT NOT NULL,
  Team_Id INT NOT NULL,
  Model_Id INT NOT NULL,
  Req_Maintenance ENUM('Yes', 'No') NOT NULL,
  PRIMARY KEY (Car_Id),
FOREIGN KEY (Team_Id) REFERENCES team (Team_ID),
FOREIGN KEY (Model_Id) REFERENCES model (Model_ID)
)
ENGINE=INNODB;

CREATE TABLE Crew
(
  Crew_Id INT NOT NULL,
  Car_Id INT,
  PRIMARY KEY (Crew_Id),
FOREIGN KEY (Car_Id) REFERENCES car (car_id)
)
ENGINE=INNODB;

Create Table Crew_Specialty
(
Crew_Id INT,
Model_ID INT,
Fee Float Not Null,
Primary Key (Crew_Id,Model_Id),
check (fee>=0),
FOREIGN KEY (Crew_Id) REFERENCES Crew (Crew_Id),
FOREIGN KEY (Model_ID) REFERENCES model (Model_ID)
)
ENGINE=INNODB;

CREATE TABLE Track
(
Track_Id int not null primary key,
Track_Name varchar(50) not null,
length int not null,
check (length>=0)
)
ENGINE=INNODB;

CREATE TABLE Race
(
  Race_Id INT NOT NULL,
  Track_Id INT NOT NULL,
  Starting_hour datetime not null,
  PRIMARY KEY (Race_id),
FOREIGN KEY (Track_Id) REFERENCES  Track(Track_Id)
)
ENGINE=INNODB;

Create Table Car_Driver_ForRace
(
  Driver_Id INT NOT NULL,
  Race_Id INT NOT NULL,
  Car_Id INT NOT NULL,
  Finish_Time datetime NOT NULL,
  primary key (Race_Id,Car_Id,Driver_Id),
  UNIQUE (Race_Id,Driver_Id),
  UNIQUE (Race_Id,Car_Id),
  foreign key (Driver_ID) references DRIVER(Driver_ID),
  FOREIGN KEY (Race_Id) REFERENCES  Race(Race_Id),
  FOREIGN KEY (Car_Id) REFERENCES  Car(Car_Id)
  -- check that in any race, every car appears only one time
)
ENGINE=INNODB;


Create Table Sponser
(
	Spons_Id INT NOT NULL,
	Spons_Name varchar (50) not null,
	Primary Key (Spons_Id))
ENGINE=INNODB;

Create Table Sponser_ForTeam
(
  ID_Check INT NOT NULL,
  Spons_Id INT NOT NULL,
  Team_Id INT NOT NULL,
  Start_Sponsership Date NOT NULL,
  Amount Float NOT NULL,
  Primary Key (ID_Check,Spons_Id,Team_Id),
  check (Amount>=0),
  FOREIGN KEY (Team_Id) REFERENCES  Team(Team_Id),
  FOREIGN KEY (Spons_Id) REFERENCES  Sponser(Spons_Id)
)
ENGINE=INNODB;

-- 

-- FORMATS 
-- Team ID 10X
-- Driver ID 100X
-- Model ID 1X
-- Car ID X
-- Crew ID 1880X
-- Track ID 90X
-- Race ID 8000X
-- Sponser ID  690X


/* teams */
insert into Team values (101,'Action Stars','2015-01-01','Barron');
insert into Team values (102,'The Barry Sandwich','2012-02-02','Big Joe');
insert into Team values (103,'Go-go Girls','2001-03-03','Black Swallow of Death');
insert into Team values (104,'Road Hogs','1975-10-03','The Black Devil');
insert into Team values (106,'Crazy Minions','1999-05-05','Flotte Lotte');
insert into Team values (107,'Stayin Alive','1999-05-11','Walkers');
insert into Team values (108,'Threes Company','1998-01-07','Beasters');
insert into Team values (109,'Im Not Afraid Of The Dark','1542-02-03','Spooky');


/* drivers */
insert into Driver values (1001,102,'bob','brice','bear','1975-08-09',9);
insert into Driver values (1002,103,'jhon','dick','snake','1975-08-09',5);
insert into Driver values (1003,104,'ori','fridman',null,'1986-07-08',2);
insert into Driver values (1004,103,'alon','foiman','wolf','1991-02-20',2);
insert into Driver values (1005,106,'vlad','flilman','cub','1980-05-05',3);
insert into Driver values (1006,107,'ariel','bodek','owl','2000-01-18',1);
insert into Driver values (1007,108,'matan','wayne','rabbit','1980-09-17',10);
insert into Driver values (1008,101,'shalom','kent','lion','1985-10-07',8);
insert into Driver values (1009,102,'Nir','sharoni','turtle','1987-04-21',6);
insert into Driver values (1010,103,'shalom','koki',null,'1973-10-16',10);
insert into Driver values (1011,104,'thunder','mobi','bamba','1974-11-26',14);
insert into Driver values (1012,103,'pasific','robi','bisli','1980-05-05',12);
insert into Driver values (1013,106,'michael','toni','dubonim','1981-11-04',6);
insert into Driver values (1014,107,'juda','erik','avocado','1984-08-01',8);
insert into Driver values (1015,108,'ben','obama','banana','1978-02-07',10);
insert into Driver values (1016,109,'eliezer','amir','mango','1981-05-03',15);
insert into Driver values (1017,102,'eli','yossi','ipad','1989-12-11',11);
insert into Driver values (1018,104,'avshalom','vldadad','mavrik','1973-10-07',11);
/*model*/
insert into model values
(10,'Ferrari','1980-02-03',500000),
(20,'Ferrari','1981-04-03',300000),
(30,'Buggati','1985-09-23',400000),
(40,'Buggati','1983-08-21',750000),
(50,'Mazarati','1987-07-28',660000),
(60,'Mazarati','1984-02-05',220000),
(70,'Porshe','1991-03-03',245000),
(80,'Porshe','1981-01-01',315000);


/* cars */
insert into Car values (8,101,50,'yes');
insert into Car values (2,102,60,'no');
insert into Car values (4,103,70,'yes');
insert into Car values (9,103,10,'no');
insert into Car values (6,104,80,'no');
insert into Car values (1,103,10,'yes');
insert into Car values (3,106,20,'no');
insert into Car values (5,107,30,'yes');
insert into Car values (7,108,40,'no');


/*crews*/
insert into crew values
(18801,1),
(18802,2),
(18803,3),
(18804,4),
(18805,5),
(18806,null),
(18807,7),
(18808,8),
(18809,null);



/*Crew_Specialty*/
insert into Crew_Specialty values (18801,20,7800);
insert into Crew_Specialty values (18801,40,7800);
insert into Crew_Specialty values (18801,60,7800);
insert into Crew_Specialty values (18801,80,7800);

insert into Crew_Specialty values (18802,10,4108);
insert into Crew_Specialty values (18802,30,4208);
insert into Crew_Specialty values (18802,50,4308);
insert into Crew_Specialty values (18802,70,4408);

insert into Crew_Specialty values (18803,20,5826);
insert into Crew_Specialty values (18803,10,6826);
insert into Crew_Specialty values (18803,30,7826);
insert into Crew_Specialty values (18803,50,5626);

insert into Crew_Specialty values (18804,80,1500);
insert into Crew_Specialty values (18804,70,8999);
insert into Crew_Specialty values (18804,60,7421);

insert into Crew_Specialty values (18805,10,5842);
insert into Crew_Specialty values (18805,20,6326);

insert into Crew_Specialty values (18806,30,7535);
insert into Crew_Specialty values (18806,40,5912);
insert into Crew_Specialty values (18806,50,6547);
insert into Crew_Specialty values (18806,60,85242);
insert into Crew_Specialty values (18806,70,6353);

insert into Crew_Specialty values (18807,80,1498);
insert into Crew_Specialty values (18807,10,3069);
insert into Crew_Specialty values (18807,50,1036);

insert into Crew_Specialty values (18808,10,6514);

insert into Crew_Specialty values (18809,10,8521);
insert into Crew_Specialty values (18809,20,9632);
insert into Crew_Specialty values (18809,30,3698);
insert into Crew_Specialty values (18809,40,85242);
insert into Crew_Specialty values (18809,50,2587);
insert into Crew_Specialty values (18809,60,1478);
insert into Crew_Specialty values (18809,70,4565);
insert into Crew_Specialty values (18809,80,3214);





/*track*/
insert into track values
(901,'Bigibi',212),
(902,'Smuel',310),
(903,'La-Man',500),
(904,'Motomomo',249),
(905,'Minimi',330),
(906,'Cornery',370),
(907,'Hitech',300),
(908,'Simple',201);


/*race*/
insert into Race values (80001,904,'1991-08-09 13:13:13');
insert into Race values (80002,905,'1993-08-09 14:07:22');
insert into Race values (80003,906,'1994-08-09 21:22:22');
insert into Race values (80004,907,'2000-08-09 11:01:00');
insert into Race values (80005,908,'1999-08-09 09:09:59');
insert into Race values (80006,901,'2001-08-09 01:02:03');
insert into Race values (80007,903,'2012-08-09 12:59:59');
insert into Race values (80008,902,'2020-08-09 03:03:03');
 
 
 /*Car_Driver_ForRace*/
insert into Car_Driver_ForRace values (1003,80001,6,'1991-08-09 14:12:16');
insert into Car_Driver_ForRace values (1004,80001,7,'1991-08-09 14:45:55');
insert into Car_Driver_ForRace values (1005,80001,8,'1991-08-09 14:56:59');
insert into Car_Driver_ForRace values (1006,80001,1,'1991-08-09 14:34:59');
insert into Car_Driver_ForRace values (1007,80001,3,'1991-08-09 14:43:45');
insert into Car_Driver_ForRace values (1008,80001,2,'1991-08-09 15:03:01');

insert into Car_Driver_ForRace values (1001,80002,4,'1993-08-09 15:37:13');
insert into Car_Driver_ForRace values (1002,80002,5,'1993-08-09 14:07:24');
insert into Car_Driver_ForRace values (1004,80002,7,'1993-08-09 15:51:04');
insert into Car_Driver_ForRace values (1005,80002,8,'1993-08-09 15:52:59');
insert into Car_Driver_ForRace values (1006,80002,1,'1993-08-09 15:54:06');
insert into Car_Driver_ForRace values (1008,80002,2,'1993-08-09 15:13:06');

insert into Car_Driver_ForRace values (1001,80003,4,'1994-08-09 22:34:13');
insert into Car_Driver_ForRace values (1002,80003,5,'1994-08-09 22:43:22');
insert into Car_Driver_ForRace values (1004,80003,7,'1994-08-09 22:27:00');
insert into Car_Driver_ForRace values (1005,80003,8,'1994-08-09 22:56:59');
insert into Car_Driver_ForRace values (1006,80003,1,'1994-08-09 22:49:03');
insert into Car_Driver_ForRace values (1008,80003,2,'1994-08-09 22:57:03');

insert into Car_Driver_ForRace values (1001,80004,7,'2000-08-09 12:13:38');
insert into Car_Driver_ForRace values (1003,80004,6,'2000-08-09 13:22:27');
insert into Car_Driver_ForRace values (1004,80004,4,'2000-08-09 12:01:07');
insert into Car_Driver_ForRace values (1005,80004,8,'2000-08-09 12:09:54');
insert into Car_Driver_ForRace values (1006,80004,1,'2000-08-09 12:02:03');
insert into Car_Driver_ForRace values (1007,80004,3,'2000-08-09 12:59:52');
insert into Car_Driver_ForRace values (1008,80004,2,'2000-08-09 12:03:01');

insert into Car_Driver_ForRace values (1001,80005,4,'1999-08-09 10:16:13');
insert into Car_Driver_ForRace values (1002,80005,5,'1999-08-09 10:17:22');
insert into Car_Driver_ForRace values (1004,80005,7,'1999-08-09 10:19:00');
insert into Car_Driver_ForRace values (1006,80005,1,'1999-08-09 11:34:03');
insert into Car_Driver_ForRace values (1007,80005,3,'1999-08-09 10:56:59');
insert into Car_Driver_ForRace values (1008,80005,2,'1999-08-09 10:21:03');

insert into Car_Driver_ForRace values (1001,80006,4,'2001-08-09 02:53:15');
insert into Car_Driver_ForRace values (1002,80006,5,'2001-08-09 02:47:25');
insert into Car_Driver_ForRace values (1003,80006,6,'2001-08-09 03:32:25');
insert into Car_Driver_ForRace values (1004,80006,7,'2001-08-09 02:31:05');
insert into Car_Driver_ForRace values (1005,80006,8,'2001-08-09 02:29:54');
insert into Car_Driver_ForRace values (1007,80006,3,'2001-08-09 02:19:54');
insert into Car_Driver_ForRace values (1008,80006,2,'2001-08-09 02:13:04');

insert into Car_Driver_ForRace values (1001,80007,4,'2012-08-09 13:13:13');
insert into Car_Driver_ForRace values (1002,80007,5,'2012-08-09 14:17:23');
insert into Car_Driver_ForRace values (1003,80007,6,'2012-08-09 13:22:23');
insert into Car_Driver_ForRace values (1004,80007,7,'2012-08-09 13:21:02');
insert into Car_Driver_ForRace values (1005,80007,8,'2012-08-09 13:39:52');
insert into Car_Driver_ForRace values (1006,80007,1,'2012-08-09 13:32:02');
insert into Car_Driver_ForRace values (1008,80007,2,'2012-08-09 13:43:02');

insert into Car_Driver_ForRace values (1001,80008,4,'2020-08-09 04:17:11');
insert into Car_Driver_ForRace values (1002,80008,5,'2020-08-09 04:06:22');
insert into Car_Driver_ForRace values (1003,80008,6,'2020-08-09 04:26:23');
insert into Car_Driver_ForRace values (1004,80008,7,'2020-08-09 05:05:04');
insert into Car_Driver_ForRace values (1005,80008,8,'2020-08-09 04:04:55');
insert into Car_Driver_ForRace values (1006,80008,1,'2020-08-09 04:03:06');
insert into Car_Driver_ForRace values (1007,80008,3,'2020-08-09 04:52:57');




/*sponser*/
insert into sponser values
(6901,'Shalom'),
(6902,'Vlad'),
(6903,'Ariella'),
(6904,'Matania'),
(6905,'Dudi'),
(6906,'Hertdog'),
(6907,'Miriam'),
(6908,'Yehodit');

/*sponser*/
insert into sponser_forteam values
(1,6902,101,'2016-02-03',1000000),
(2,6902,102,'2016-02-03',2600000),
(3,6904,103,'2016-02-03',3000000),
(4,6904,104,'2016-02-03',1350000),
(5,6906,103,'2016-02-03',1980000),
(6,6907,106,'2016-02-03',2500000),
(7,6908,107,'2016-02-03',2490000),
(8,6908,108,'2016-02-03',3100000);


SELECT * FROM racing_project.Team;
SELECT * FROM racing_project.driver;
SELECT * FROM racing_project.model;
SELECT * FROM racing_project.car;
SELECT * FROM racing_project.crew;
SELECT * FROM racing_project.Crew_Specialty;
SELECT * FROM racing_project.track;
SELECT * FROM racing_project.race;
SELECT * FROM racing_project.Car_Driver_ForRace;
SELECT * FROM racing_project.sponser;
SELECT * FROM racing_project.sponser_forteam;

-- FORMATS 
-- Team ID 10X
-- Driver ID 100X
-- Model ID 1X
-- Car ID X
-- Crew ID 1880X
-- Track ID 90X
-- Race ID 8000X
-- Sponser ID  690X

-- 