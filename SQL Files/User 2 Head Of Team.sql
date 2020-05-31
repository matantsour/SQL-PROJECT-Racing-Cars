use racing_project;
-- querys for user number 2,for the team manager

-- 1st query for user num2, get the crew id that can do a maintenanace at the cheapest rate for each model
select crew_id,t.min_fee,model_id
from crew_specialty cs,(select min(cs.fee) as min_fee from crew_specialty cs group by model_id) as t
where cs.fee=t.min_fee
order by model_id;
 
-- 2nd query for user num2, get the model ID and the price of the car which won most races
Select M1.Model_Id,M1.Price
from Model M1, ( SELECT T3.Model_Id,count(*) as Num_Of_Victories
					from car_driver_forrace as T1,car T3,
												(select race_id,min(Finish_Time) as Finish_Time_Winner
												from car_driver_forrace
												group by race_id)
												as T2
					where T1.Race_Id=T2.Race_ID and T1.Finish_Time=T2.Finish_Time_Winner
					and T1.Car_ID=T3.Car_Id
					 group by T3.Model_Id) as M2
where M1.Model_Id=M2.Model_Id
and M2.Num_Of_Victories>=ALL( SELECT count(*) as Num_Of_Victories
from car_driver_forrace as T1,car T3,
							(select race_id,min(Finish_Time) as Finish_Time_Winner
							from car_driver_forrace
							group by race_id)
                            as T2
where T1.Race_Id=T2.Race_ID and T1.Finish_Time=T2.Finish_Time_Winner
and T1.Car_ID=T3.Car_Id
 group by T3.Model_Id);


 -- query num5, insert another car to team 103. the car should be from the model with best performance. 
 
 insert into Car values (11,103,(-- the model of the car with the best performance
								Select M1.Model_Id
								from Model M1, ( 
				SELECT T3.Model_Id,count(*) as Num_Of_Victories
					from car_driver_forrace as T1,car T3,
												(select race_id,min(Finish_Time) as Finish_Time_Winner
												from car_driver_forrace
												group by race_id)
												as T2
					where T1.Race_Id=T2.Race_ID and T1.Finish_Time=T2.Finish_Time_Winner
					and T1.Car_ID=T3.Car_Id
					 group by T3.Model_Id) as M2
								where M1.Model_Id=M2.Model_Id
								and M2.Num_Of_Victories>=ALL( SELECT count(*) as Num_Of_Victories
																from car_driver_forrace as T1,car T3,
																	(select race_id,min(Finish_Time) as
                                                                    Finish_Time_Winner
																	from car_driver_forrace
																	group by race_id)
																	as T2
								where T1.Race_Id=T2.Race_ID and T1.Finish_Time=T2.Finish_Time_Winner
								and T1.Car_ID=T3.Car_Id
									group by T3.Model_Id) )
						,'no');
 
-- query num3 get the youngest driver in a team for each team
select t.team_id,d.driver_id,t.max_dob
from driver d, (select driver_id,team_id,max(dob) as max_dob from driver group by team_id) as T
where d.team_id = t.team_id and d.driver_id=t.driver_id;
    
-- query num4 get the driver with most years of expirience for each team 
select t.team_id,d.driver_id,d.firstname,d.lastname,t.max_expy
from driver d, (select driver_id,team_id,max(exp_years) as max_expy from driver group by team_id) as T
where d.team_id = t.team_id and d.driver_id=t.driver_id;
