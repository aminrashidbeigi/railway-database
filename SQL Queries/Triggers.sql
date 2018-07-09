DELIMITER $$
CREATE TRIGGER driver_resign_trigger
AFTER DELETE ON Driver
FOR EACH ROW
BEGIN
    INSERT INTO DriverResignLog (driver_id, driver_first_name, driver_last_name, resign_timestamp)
    VALUES(OLD.driver_id ,OLD.driver_first_name , OLD.driver_last_name , NOW());
END$$

DELIMITER $$
CREATE TRIGGER driver_trip_income
AFTER INSERT ON Trip
FOR EACH ROW
BEGIN
    UPDATE Driver
    SET driver_balance = driver_balance + NEW.trip_cost * 0.1
END$$

