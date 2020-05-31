-- ex1 finding the best Times of the  driver in any race
select race_id AS RaceNumber, Driver_Id as Driver,min(Finish_Time) as BestTime
from car_driver_forrace
group by race_id;

-- ex2 - finding the nickname of the slowest car
select t1.FinishLoser as 'Time', t2.nickName as 'LastPlaceNickname'
from car_driver_forrace as t, 
(select race_id,max(Finish_Time) as FinishLoser
from car_driver_forrace
group by race_id) as t1, 
driver as t2
where t.Race_Id=t1.Race_ID and t.Finish_Time=t1.FinishLoser and t2.Driver_ID = t.Driver_Id;

-- ex3 - Finding the team that won with the name of the tracks they won in
select t1.Team_name as 'Winner',t.Track_Name
from car_driver_forrace as c, 
race as r, track as t, team as t1,
		(select race_id,min(Finish_Time) as TimeWinner
		from car_driver_forrace
		group by race_id) as t2,
driver as d
where c.Race_Id=t2.Race_ID and 
	c.Finish_Time=t2.TimeWinner and 
	c.Race_Id = r.Race_ID and 
	r.Track_Id = t.Track_Id and
	d.Driver_ID = c.Driver_Id and
	t1.Team_ID = d.Team_ID;
    

-- ex 4 - FIND THE TIME AND RACE DETAILS OF THE ABSOLUTE LOSER

select R1.Race_ID,R1.Driver_ID,max(Duration)
from car_driver_forrace R1,(select R1.Driver_ID,R1.Race_ID,TIMEDIFF(R1.Finish_Time,R2.Starting_hour) as Duration
				from car_driver_forrace R1, race R2
				where R1.Race_Id= R2.Race_Id) as T
where T.Driver_ID=R1.Driver_ID and T.Race_ID=R1.Race_ID and T.Duration>=ALL (select TIMEDIFF(R1.Finish_Time,R2.Starting_hour) as Duration
																			from car_driver_forrace R1, race R2
																		where R1.Race_Id= R2.Race_Id);
                                                                        
                                                                        
-- NUM 5 -Finding the drivers without a nickname
--  and give them the nickname "Lame"
-- safe mode cancelation and proceed to updating the listing
SET SQL_SAFE_UPDATES =1;

-- NUM6- updated nicknames by condition
update Driver set nickName='LAME' where nickName is null;

select driver_id,firstname,nickname
from driver;