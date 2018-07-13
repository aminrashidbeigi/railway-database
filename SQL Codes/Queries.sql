--1
SELECT sp_first_name, sp_last_name, sp_registeration_timestamp
FROM SubmittedPassenger;

--2
SELECT employee_id, employee_first_name, employee_last_name, employee_personnel_id
From Employee INNER JOIN Company ON (employee.company_id = company.company_id)
Where Company.company_name = 'snappfood';

--3
SELECT *
FROM Trip
WHERE Trip.trip_id in (
    SELECT Trip.trip_id
    FROM Trip NATURAL JOIN TrainStation as TS NATURAL JOIN TripTrainStation as TTS
    WHERE TTS.ts_type = 'source' and TS.ts_city = 'Tehran' and Trip.trip_id in (
        SELECT Trip.trip_id
        FROM Trip NATURAL JOIN TrainStation as TS NATURAL JOIN TripTrainStation as TTS
        WHERE TTS.ts_type = 'destination' and TS.ts_city = 'Mashhad' and Trip.trip_id in (
            SELECT Trip.trip_id
            FROM Trip NATURAL JOIN TrainStation as TS NATURAL JOIN TripTrainStation as TTS
            WHERE TTS.ts_type = 'middle' and TS.ts_city = 'Neishaboor'
        )
    )
);

--4
SELECT ssp_message
FROM SupporterSubmittedPassenger INNER JOIN Supporter ON (SupporterSubmittedPassenger.supporter_id = Supporter.supporter_id) 
	INNER JOIN SubmittedPassenger ON (SupporterSubmittedPassenger.sp_id = SubmittedPassenger.sp_id)
Where SubmittedPassenger.sp_id = 1

--5
SELECT SUM(Trip.trip_cost)
FROM Company INNER JOIN CompanyAgent ON (company.company_id = companyagent.company_id) 
	INNER JOIN agent ON (agent.agent_id = companyagent.agent_id)
    INNER JOIN SupporterAgent ON (agent.agent_id = SupporterAgent.agent_id)
    INNER JOIN Supporter ON (Supporter.supporter_id = SupporterAgent.supporter_id)
    INNER JOIN SupporterTrip ON (Supporter.supporter_id = SupporterTrip.supporter_id)
    INNER JOIN Trip ON (Trip.trip_id = SupporterTrip.trip_id)
WHERE Company.company_id = 1 and Trip.trip_start_timestamp BETWEEN SUBDATE(CURDATE(), INTERVAL 1 MONTH) AND NOW();

--6
SELECT *
FROM DriverResignLog
WHERE DriverResignLog.resign_timestamp BETWEEN SUBDATE(CURDATE(), INTERVAL 1 MONTH) AND NOW();

--7
SELECT *
FROM GuestPassenger INNER JOIN GuestBook ON (guestpassenger.gp_id = guestbook.guest_id) 
	INNER JOIN BankTransaction ON (banktransaction.transaction_id = guestbook.transaction_id) 
    INNER JOIN Trip ON (trip.trip_id = guestbook.trip_id) 
WHERE GuestPassenger.gp_id = 1;

--8
SELECT *
FROM SubmittedPassenger INNER JOIN SubmittedBalanceBook ON (SubmittedPassenger.sp_id = SubmittedBalanceBook.sp_id) 
    INNER JOIN Trip ON (Trip.trip_id = SubmittedBalanceBook.trip_id)
    INNER JOIN Driver ON (Driver.driver_id = Trip.driver_id)
WHERE Driver.driver_first_name = 'Hashem' and SubmittedPassenger.sp_id = 1;

--9
SELECT *
FROM Company INNER JOIN CompanyAgent ON (company.company_id = companyagent.company_id) 
	INNER JOIN agent ON (agent.agent_id = companyagent.agent_id)
WHERE CompanyAgent.created_at BETWEEN SUBDATE(CURDATE(), INTERVAL 1 MONTH) AND NOW();

--10
SELECT FirstPassenger.sp_id, SecondPassenger.sp_id
FROM (
    SELECT sp_id
    FROM SubmittedBankTransactionBook
    UNION
    SELECT sp_id
    FROM SubmittedBalanceBook
) as FirstPassenger JOIN
(
    SELECT sp_id
    FROM SubmittedBankTransactionBook
    UNION
    SELECT sp_id
    FROM SubmittedBalanceBook
) as SecondPassenger
NATURAL JOIN Trip NATURAL JOIN TripTrainStation NATURAL JOIN TrainStation
WHERE TrainStation.ts_city = 'Tehran' and DAYOFWEEK(Trip.trip_start_timestamp) = 3 and FirstPassenger.sp_id <> SecondPassenger.sp_id;

--11
SELECT TIMESTAMPDIFF(MONTH, '2012-05-05', CURDATE()) * Company.company_income
From Company

--12
SELECT *
FROM Trip INNER JOIN Driver ON (Driver.driver_id = Trip.driver_id)
    INNER JOIN Train ON (Train.train_id = Trip.train_id)
WHERE Trip.trip_start_timestamp BETWEEN SUBDATE(CURDATE(), INTERVAL 1 MONTH) AND NOW();

--13
SELECT SupporterSubmittedPassenger.supporter_id, SupporterSubmittedPassenger.sp_id, SupporterSubmittedPassenger.ssp_message
FROM SupporterSubmittedPassenger INNER JOIN Supporter ON (SupporterSubmittedPassenger.supporter_id = Supporter.supporter_id) 
	INNER JOIN SubmittedPassenger ON (SupporterSubmittedPassenger.sp_id = SubmittedPassenger.sp_id)
UNION
SELECT SupporterGuestPassenger.supporter_id, SupporterGuestPassenger.gp_id, SupporterGuestPassenger.ssp_message
FROM SupporterGuestPassenger INNER JOIN Supporter ON (SupporterGuestPassenger.supporter_id = Supporter.supporter_id) 
	INNER JOIN GuestPassenger ON (SupporterGuestPassenger.gp_id = GuestPassenger.gp_id)


--14
SELECT *
FROM Driver 
ORDER BY driver_balance DESC
LIMIT 1 , 1

--15
SELECT SP.sp_id, SP.sp_first_name, SP.sp_last_name, trips.c 
From SubmittedPassenger as SP INNER JOIN (
    SELECT alltrips.sp_id, COUNT(*) as c 
    FROM (
        SELECT sp_id, trip_id 
        FROM SubmittedBankTransactionBook
        WHERE SubmittedBankTransactionBook.created_at BETWEEN SUBDATE(CURDATE(), INTERVAL 1 MONTH) AND NOW()
        UNION
        SELECT sp_id, trip_id 
        FROM SubmittedBalanceBook
        WHERE SubmittedBalanceBook.created_at BETWEEN SUBDATE(CURDATE(), INTERVAL 1 MONTH) AND NOW()
    ) as alltrips
    GROUP BY alltrips.sp_id ORDER BY c DESC LIMIT 1
) as trips ON (trips.sp_id = SP.sp_id)

--16
SELECT SUM(accounted.cost) - (
    SELECT SUM(Trip.trip_cost) as cost
    FROM Trip INNER JOIN GuestBook ON (GuestBook.trip_id = Trip.trip_id)
) as guest_cost
FROM (
    SELECT Trip.trip_cost as cost
    FROM Trip INNER JOIN SubmittedBankTransactionBook ON (SubmittedBankTransactionBook.trip_id = Trip.train_id)
    UNION
    SELECT Trip.trip_cost as cost
    FROM Trip INNER JOIN SubmittedBalanceBook ON (SubmittedBalanceBook.trip_id = Trip.train_id)
) as accounted

--17
SELECT *
FROM Trip INNER JOIN Driver ON (Driver.driver_id = Trip.driver_id)
    INNER JOIN Train ON (Train.train_id = Trip.train_id)
WHERE Trip.trip_start_timestamp BETWEEN ADDDATE(CURDATE(), INTERVAL 1 MONTH) AND NOW()
