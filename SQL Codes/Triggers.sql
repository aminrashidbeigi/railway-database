DELIMITER $$
CREATE TRIGGER IF NOT EXISTS driver_resign_trigger
AFTER DELETE ON Driver
FOR EACH ROW
BEGIN
    INSERT INTO DriverResignLog (driver_id, driver_first_name, driver_last_name, resign_timestamp)
    VALUES(OLD.driver_id ,OLD.driver_first_name , OLD.driver_last_name , NOW());
END$$

DELIMITER $$
CREATE TRIGGER IF NOT EXISTS driver_trip_income
AFTER INSERT ON Trip
FOR EACH ROW
BEGIN
    UPDATE Driver
    SET driver_balance = driver_balance + NEW.trip_cost * 0.1;
END$$


DELIMITER $$
CREATE TRIGGER IF NOT EXISTS passenger_trigger_ins_log
AFTER INSERT ON SubmittedPassenger
FOR EACH ROW
BEGIN
    INSERT INTO PassengerExecutionLog VALUES(NEW.sp_id, 'INSERT', NOW());
END$$

DELIMITER $$
CREATE TRIGGER IF NOT EXISTS passenger_trigger_update_log
AFTER UPDATE ON SubmittedPassenger
FOR EACH ROW
BEGIN
    INSERT INTO PassengerExecutionLog VALUES(NEW.sp_id, 'UPDATE', NOW());
END$$


DELIMITER $$
CREATE TRIGGER IF NOT EXISTS supporter_trigger_ins_log
AFTER INSERT ON Supporter
FOR EACH ROW
BEGIN
    INSERT INTO SupporterExecutionLog VALUES(NEW.supporter_id, 'INSERT', NOW());
END$$

DELIMITER $$
CREATE TRIGGER IF NOT EXISTS supporter_trigger_update_log
AFTER UPDATE ON Supporter
FOR EACH ROW
BEGIN
    INSERT INTO SupporterExecutionLog VALUES(NEW.supporter_id, 'UPDATE', NOW());
END$$


DELIMITER $$
CREATE TRIGGER IF NOT EXISTS deleted_passenger_trigger
AFTER DELETE ON SubmittedPassenger
FOR EACH ROW
BEGIN
    INSERT INTO DeletedSubmittedPassengerLog (sp_id, sp_first_name, sp_last_name, sp_national_number, sp_father_first_name, sp_born_city, sp_born_date, sp_balance, sp_registeration_timestamp, created_at)
    VALUES(OLD.sp_id, OLD.sp_first_name, OLD.sp_last_name, OLD.sp_national_number, OLD.sp_father_first_name, OLD.sp_born_city, OLD.sp_born_date, OLD.sp_balance, OLD.sp_registeration_timestamp,NOW());
END$$

DELIMITER $$
CREATE TRIGGER IF NOT EXISTS deleted_supporter_trigger
AFTER DELETE ON Supporter
FOR EACH ROW
BEGIN
    INSERT INTO DeletedSupporterLog VALUES(OLD.supporter_id, OLD.supporter_first_name, OLD.supporter_last_name, OLD.supporter_status, NOW());
END$$

DELIMITER $$
CREATE TRIGGER IF NOT EXISTS balance_trip_reserve
AFTER INSERT ON SubmittedBalanceBook
FOR EACH ROW
BEGIN
    UPDATE SubmittedPassenger
    SET SubmittedPassenger.sp_balance = SubmittedPassenger.sp_balance -
    (
        SELECT Trip.trip_cost
        FROM Trip
        WHERE Trip.trip_id = NEW.trip_id
    )
    WHERE SubmittedPassenger.sp_id = NEW.sp_id;
END$$