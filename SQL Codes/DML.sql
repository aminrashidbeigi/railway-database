--1
INSERT INTO SubmittedPassenger(sp_id, sp_first_name, sp_last_name, sp_national_number, sp_father_first_name, sp_born_city, sp_born_date, sp_balance, sp_registeration_timestamp, created_at)
VALUES (1, 'amin', 'rashidbeigi', 123456, 'test', 'teh', NOW(), 123456, NOW(), NOW());
INSERT INTO SubmittedPassenger(sp_id, sp_first_name, sp_last_name, sp_national_number, sp_father_first_name, sp_born_city, sp_born_date, sp_balance, sp_registeration_timestamp, created_at)
VALUES (2, 'amin2', 'rashidbeigi2', 123456, 'test', 'teh', NOW(), 123457, NOW(), NOW());


--2
INSERT INTO Company(company_id, company_name, company_registeration_number, company_income, created_at)
VALUES (1, 'snappfood', 123, 123456, NOW());
INSERT INTO Company(company_id, company_name, company_registeration_number, company_income, created_at)
VALUES (2, 'snapp', 123, 123456, NOW());
INSERT INTO Employee(employee_id, employee_first_name, employee_last_name, employee_personnel_id, company_id, created_at)
VALUES (1, 'Amin', 'Rashidbeigi', 123, 1, NOW());


--3
INSERT INTO Driver(driver_id, driver_first_name, driver_last_name, driver_balance, created_at)
VALUES (1, 'Hashem', 'Hasheminia', 123, NOW());
INSERT INTO Train(train_id, train_name, train_production_date)
VALUES (1, 'Eram Sabz', NOW());
INSERT INTO TrainStation(ts_id, ts_city, ts_province, ts_manager, train_construction_date, created_at)
VALUES (1, 'Tehran', 'Tehran', 'Mr Amini', NOW(), NOW());
INSERT INTO TrainStation(ts_id, ts_city, ts_province, ts_manager, train_construction_date, created_at)
VALUES (2, 'Mashhad', 'Khorasan Razavi', 'Mr Imani', NOW(), NOW());
INSERT INTO TrainStation(ts_id, ts_city, ts_province, ts_manager, train_construction_date, created_at)
VALUES (3, 'Neishaboor', 'Khorasan Razavi', 'Mr Emami', NOW(), NOW());
INSERT INTO Trip(trip_id, train_id, driver_id, trip_cost, trip_start_timestamp, trip_finish_timestamp, created_at)
VALUES (1, 1, 1, 123, NOW(), NOW(), NOW());
INSERT INTO TripTrainStation(trip_train_station_id, trip_id, ts_id, ts_sequence, ts_type, trip_enter_timestamp, trip_exit_timestamp, created_at)
VALUES (1, 1, 1, 1, 'source', NOW(), NOW(), NOW());
INSERT INTO TripTrainStation(trip_train_station_id, trip_id, ts_id, ts_sequence, ts_type, trip_enter_timestamp, trip_exit_timestamp, created_at)
VALUES (2, 1, 2, 3, 'destination', NOW(), NOW(), NOW());
INSERT INTO TripTrainStation(trip_train_station_id, trip_id, ts_id, ts_sequence, ts_type, trip_enter_timestamp, trip_exit_timestamp, created_at)
VALUES (3, 1, 3, 2, 'middle', NOW(), NOW(), NOW());


--4
INSERT INTO Supporter(supporter_id, supporter_first_name, supporter_last_name, supporter_status, created_at)
VALUES (1, 'Mohammad', 'Lee', true, NOW());
INSERT INTO SupporterSubmittedPassenger(supporter_submitted_passenger_id, supporter_id, sp_id, ssp_timestamp, ssp_message, ssp_type, created_at)
VALUES (1, 1, 1, NOW(), 'Hello this is fake message from supporter!', 'supporter', NOW());
INSERT INTO SupporterSubmittedPassenger(supporter_submitted_passenger_id, supporter_id, sp_id, ssp_timestamp, ssp_message, ssp_type, created_at)
VALUES (2, 1, 1, NOW(), 'Hello this is fake message from user!', 'passenger', NOW());

--5
INSERT INTO Agent(agent_id, agent_first_name, agent_last_name, created_at)
VALUES (1, 'Ahmad', 'Khalilikhoo', NOW());
INSERT INTO SupporterAgent(supporter_agent_id, supporter_id, agent_id, employee_id, created_at)
VALUES (1, 1, 1, 1, NOW());
INSERT INTO SupporterTrip(supporter_trip_id, supporter_id, trip_id, created_at)
VALUES (1, 1, 1, NOW());
INSERT INTO CompanyAgent(companu_agent_id, company_id, agent_id, created_at)
VALUES (1, 1, 1, NOW());

--6
INSERT INTO Driver(driver_id, driver_first_name, driver_last_name, driver_balance, created_at)
VALUES (2, 'Seyed', 'Ali', 123, NOW());

DELETE FROM Driver
WHERE Driver.id = 2;

--7
INSERT INTO GuestPassenger(gp_id, gp_first_name, gp_last_name, created_at)
VALUES (1, 'Seyed', 'Ali', NOW());
INSERT INTO BankTransaction(transaction_id, transaction_amount, transaction_timestamp, created_at)
VALUES (1, 123, NOW(), NOW());
INSERT INTO GuestBook(guest_book_id, guest_id, transaction_id, trip_id, created_at)
VALUES (1, 1, 1, 1, NOW());

--8
INSERT INTO SubmittedBalanceBook(sp_id, trip_id, created_at)
VALUES (1, 1, NOW());

--9
INSERT INTO TripDriver(trip_id, driver_id, created_at)
VALUES (1, 1, NOW());

--14
INSERT INTO Trip(trip_id, train_id, driver_id, trip_cost, trip_start_timestamp, trip_finish_timestamp, created_at)
VALUES (2, 1, 2, 1234, NOW(), NOW(), NOW());