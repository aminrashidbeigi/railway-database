#1
SELECT sp_first_name, sp_last_name, sp_registeration_date
FROM SubmittedPassenger

#2
SELECT employee_id, employee_first_name, employee_last_name, employee_personnel_id
FROM Employee NATURAL JOIN Company
Where Company.company_name = 'snappfood'

#3
SELECT *
FROM Trip NATURAL JOIN TrainStaion NATURAL JOIN TripTrainStation as TTS
WHERE Trip.trip_id in (
    SELECT Trip.trip_id
    FROM Trip NATURAL JOIN TrainStaion as TS NATURAL JOIN TripTrainStation as TTS
    WHERE TTS.ts_type = 'source' and TS.ts_name = 'Tehran' and Trip.trip_id in (
        SELECT Trip.trip_id
        FROM Trip NATURAL JOIN TrainStaion as TS NATURAL JOIN TripTrainStation as TTS
        WHERE TTS.ts_type = 'destination' and TS.ts_name = 'Mashhad' and Trip.trip_id in (
            SELECT Trip.trip_id
            FROM Trip NATURAL JOIN TrainStaion as TS NATURAL JOIN TripTrainStation as TTS
            WHERE TTS.ts_type = 'middle' and TS.ts_name = 'Neishaboor'
        )
    )
)

#4
SELECT ssp_message
FROM SupporterSubmittedPassenger NATURAL JOIN Supporter NATURAL JOIN SubmittedPassenger
Where SubmittedPassenger.sp_id = 1 and SupporterSubmittedPassenger.ssp_type = 'sp'

#5
SELECT SUM(Trip.trip_cost)
FROM Company NATURAL JOIN Agent NATURAL JOIN Supporter NATURAL JOIN SupporterTrip NATURAL JOIN Trip
WHERE Company.id = 1 and Trip.trip_start_timestamp between (CURDATE() - INTERVAL 1 MONTH ) and CURDATE()

#6
SELECT *
FROM DriverResignLog
WHERE DriverResignLog.resign_timestamp between (CURDATE() - INTERVAL 1 MONTH ) and CURDATE()

#7
SELECT *
FROM GuestPassenger NATURAL JOIN BankTransaction NATURAL JOIN Trip NATURAL JOIN GuestBook
WHERE GuestPassenger.gp_id = 1

#8
SELECT *
FROM SubmittedPassenger NATURAL JOIN
    BankTransaction NATURAL JOIN
    Trip NATURAL JOIN 
    SubmittedBalanceBook NATURAL JOIN 
    SubmittedBankTransactionBook NATURAL JOIN
    Driver
WHERE Driver.driver_first_name = 'Hossein' and SubmittedPassenger.sp_id = 1

#9
SELECT *
FROM Company NATURAL JOIN Agent NATURAL JOIN CompanyAgent
WHERE CompanyAgent.created_at between (CURDATE() - INTERVAL 1 MONTH ) and CURDATE()

#10
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
WHERE TrainStation.ts_name = '33Pol' and DAY(Trip.trip_start_timestamp) = 'Monday'

#11
SELECT TIMESTAMPDIFF(MONTH, '2012-05-05', CURDATE()) * Company.company_income
From Company

#12
SELECT *
FROM SubmittedPassenger NATURAL JOIN
    BankTransaction NATURAL JOIN
    Trip NATURAL JOIN 
    SubmittedBalanceBook NATURAL JOIN 
    SubmittedBankTransactionBook NATURAL JOIN
    Driver NATURAL JOIN
    Train NATURAL JOIN
    TrainStation NATURAL JOIN
    TripTrainStation
WHERE Trip.trip_start_timestamp between (CURDATE() - INTERVAL 1 MONTH ) and CURDATE()

#13
SELECT *
FROM SupporterSubmittedPassenger NATURAL JOIN Supporter NATURAL JOIN SubmittedPassenger NATURAL JOIN GuestPassenger NATURAL JOIN SupporterGuestPassenger
Where SubmittedPassenger.sp_id = 1 and SupporterSubmittedPassenger.ssp_type = 'sp'

#14
SELECT *
FROM Driver 
ORDER BY driver_balance DESC
LIMIT 1 , 1

#15
SELECT SP.sp_id, SP.sp_first_name, SP.sp_last_name, trips.c 
From SubmittedPassenger as SP NATURAL JOIN (
    SELECT alltrips.sp_id, COUNT(*) as c 
    FROM (
        SELECT sp_id, trip_id 
        FROM SubmittedBankTransactionBook
        UNION
        SELECT sp_id, trip_id 
        FROM SubmittedBalanceBook
    ) as alltrips
    GROUP BY alltrips.sp_id ORDER BY c DESC LIMIT 1
) as trips
WHERE CompanyAgent.created_at between (CURDATE() - INTERVAL 3 MONTH ) and CURDATE()

#16
SELECT SUM(accounted.cost) - guest.cost
FROM (
    SELECT Trip.trip_cost as cost
    FROM Trip NATURAL JOIN SubmittedBankTransactionBook 
    UNION
    SELECT Trip.trip_cost as cost
    FROM Trip NATURAL JOIN SubmittedBalanceBook
) as accounted JOIN (
    SELECT SUM(Trip.trip_cost) as cost
    FROM Trip NATURAL JOIN GuestBook
) as guest

#17
SELECT *
FROM Trip NATURAL JOIN Driver NATURAL JOIN Train NATURAL JOIN
WHERE Trip.trip_start_timestamp between (CURDATE() + INTERVAL 1 MONTH ) and CURDATE()
