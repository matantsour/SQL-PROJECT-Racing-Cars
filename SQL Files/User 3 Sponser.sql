-- ex 1: MOST OLD TEAM
Select Team_Id
FRom Team
Where Fund_Date <= ALL (select Fund_Date from TEAM);

-- ex 2: for each race, print the id, the winner , his car and the time taken at the finish line
select T1.Race_ID ,T1.Driver_ID as 'Winner',T1.Car_Id,T2.Finish_Time_Winner as 'Time'
from car_driver_forrace as T1, 
							(select race_id,min(Finish_Time) as Finish_Time_Winner
							from car_driver_forrace
							group by race_id)
                            as T2
where T1.Race_Id=T2.Race_ID and T1.Finish_Time=T2.Finish_Time_Winner;

-- number of winning for each driver
select T1.Driver_ID, count(*) as Victories
from car_driver_forrace as T1, 
							(select race_id,min(Finish_Time) as Finish_Time_Winner
							from car_driver_forrace
							group by race_id)
                            as T2
where T1.Race_Id=T2.Race_ID and T1.Finish_Time=T2.Finish_Time_Winner
group by T1.Driver_Id
order by victories desc;

-- ex 3 absolute winner (could be multiple absolute winneer)
select Driver_Id
from (
select T1.Driver_ID, count(*) as Victories
	from car_driver_forrace as T1, 
							(select race_id,min(Finish_Time) as Finish_Time_Winner
							from car_driver_forrace
							group by race_id)
                            as T2
							where T1.Race_Id=T2.Race_ID and T1.Finish_Time=T2.Finish_Time_Winner
							group by T1.Driver_Id
) 
as Victories_Table
where victories>= all (
						(select count(*) as Victories
						from car_driver_forrace as T1, 
														(select race_id,min(Finish_Time) as Finish_Time_Winner
														from car_driver_forrace
														group by race_id)
														as T2
						where T1.Race_Id=T2.Race_ID and T1.Finish_Time=T2.Finish_Time_Winner
						group by T1.Driver_Id))
-- finding the max value(s) from victories table
;

-- finding the team for the absolute winner (or absolute winners)
select Team_Id,Driver_ID, nickName
from Driver D
where D.driver_id = ANY (select Driver_Id
from (
select T1.Driver_ID, count(*) as Victories
	from car_driver_forrace as T1, 
							(select race_id,min(Finish_Time) as Finish_Time_Winner
							from car_driver_forrace
							group by race_id)
                            as T2
							where T1.Race_Id=T2.Race_ID and T1.Finish_Time=T2.Finish_Time_Winner
							group by T1.Driver_Id
) 
as Victories_Table
where victories>= all (
						(select count(*) as Victories
						from car_driver_forrace as T1, 
														(select race_id,min(Finish_Time) as Finish_Time_Winner
														from car_driver_forrace
														group by race_id)
														as T2
						where T1.Race_Id=T2.Race_ID and T1.Finish_Time=T2.Finish_Time_Winner
						group by T1.Driver_Id)));


-- ex 4 -- find out which team doesn't have a sponsership
select T.team_id
from team T 
where Team_id <> ALL (SELECT T.Team_Id
						FROM  Team T, Sponser_ForTeam S
						where S.Team_ID=T.Team_ID);
                        
                        
-- ex 5 - DELETE the SPONSERSHIP that was given to the team with the cheapest car

select C.car_ID
				from car C , model M
				where M.Model_ID=C.Model_ID
				and price<=ALL (select price from model);

	-- the team with the cheapest car
select C.team_id
    from car C, (select C.car_ID
				from car C , model M
				where M.Model_ID=C.Model_ID
				and price<=ALL (select price from model)) Cheapest_Car
    where c.car_ID=Cheapest_Car.car_ID;

-- safe mode cancelation and proceed to DELETE the listing    
SET SQL_SAFE_UPDATES = 0;
Delete from Sponser_ForTeam 
where Team_ID IN ( -- the team with the cheapest car
					select C.team_id
					from car C, ( -- prev query
                    select C.car_ID
								from car C , model M
								where M.Model_ID=C.Model_ID
								and price<=ALL (select price from model)) Cheapest_Car
					where c.car_ID=Cheapest_Car.car_ID);

select *
from sponser_forTeam