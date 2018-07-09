CREATE TABLE Driver (
    driver_id int,
    driver_first_name varchar(20),
    driver_last_name varchar(20),
	driver_balance numeric(10,2),
	PRIMARY KEY(driver_id)
);

CREATE TABLE Train (
    train_id int,
    train_name varchar(20),
    train_production_date date,
	PRIMARY KEY(train_id)
);

CREATE TABLE TrainStation (
    ts_id int,
    ts_city varchar(20),
    ts_province varchar(20),
    ts_manager varchar(40),
    train_construction_date date,
	PRIMARY KEY(ts_id)
);

CREATE TABLE Trip (
    trip_id int,
    train_id int,
    driver_id int,
    trip_start_timestamp timestamp,
    trip_finish_timestamp timestamp,
	PRIMARY KEY(trip_id),
    FOREIGN KEY(train_id) REFERENCES Train(train_id),
    FOREIGN KEY(driver_id) REFERENCES Driver(driver_id)
);


CREATE TABLE TripTrainStation (
    trip_id int,
    ts_id int,
    ts_sequence int,
    trip_enter_timestamp timestamp,
    trip_exit_timestamp timestamp,
	PRIMARY KEY(trip_id, ts_id, ts_sequence),
    FOREIGN KEY(trip_id) REFERENCES Trip(trip_id),
    FOREIGN KEY(ts_id) REFERENCES TrainSation(ts_id)
);

CREATE TABLE Route (
    route_id int,
    train_station_id1 int,
    train_station_id2 int,
	PRIMARY KEY(ts_id),
    FOREIGN KEY(train_station_id1) REFERENCES TrainStation(ts_id),
    FOREIGN KEY(train_station_id2) REFERENCES TrainStation(ts_id)
);

CREATE TABLE DriverAccounts (
    account_id int,
    account_number int,
    driver_id int,
	PRIMARY KEY(account_id),
    FOREIGN KEY(driver_id) REFERENCES Driver(driver_id)
);

CREATE TABLE GuestPassenger (
    gp_id int,
    gp_first_name varchar(20),
    gp_last_name varchar(20),
	PRIMARY KEY(gp_id)
);

CREATE TABLE BankTransaction (
    transaction_id int,
    transaction_amount numeric(10,2),
    transaction_timestamp timestamp,
	PRIMARY KEY(transaction_id)
);

CREATE TABLE GuestBook (
    guest_id int,
    transaction_id int,
    trip_id int,
	PRIMARY KEY(guest_id, transaction_id, trip_id),
    FOREIGN KEY(guest_id) REFERENCES GuestPassenger(guest_id),
    FOREIGN KEY(transaction_id) REFERENCES BankTransaction(transaction_id),
    FOREIGN KEY(trip_id) REFERENCES Trip(trip_id)
);


CREATE TABLE SubmittedPassenger (
    sp_id int,
    sp_first_name varchar(20),
    sp_last_name varchar(20),
	sp_national_number int,
    sp_father_first_name varchar(20),
    sp_born_city varchar(20),
    sp_born_date date,
    sp_balance int,
    PRIMARY KEY(sp_id)
);

CREATE TABLE SubmittedBankTransactionBook (
    sp_id int,
    transaction_id int,
    trip_id int,
	PRIMARY KEY(sp_id, transaction_id, trip_id),
    FOREIGN KEY(sp_id) REFERENCES SubmittedPassenger(sp_id),
    FOREIGN KEY(transaction_id) REFERENCES BankTransaction(transaction_id),
    FOREIGN KEY(trip_id) REFERENCES Trip(trip_id)
);

CREATE TABLE SubmittedBalanceBook (
    sp_id int,
    trip_id int,
	PRIMARY KEY(sp_id, trip_id),
    FOREIGN KEY(sp_id) REFERENCES SubmittedPassenger(sp_id),
    FOREIGN KEY(trip_id) REFERENCES Trip(trip_id)
);

CREATE TABLE SubmittedPassengerTelephones (
    telephone_id int,
    telephone_number int,
    sp_id varchar(20),
	PRIMARY KEY(telephone_id),
    FOREIGN KEY(sp_id) REFERENCES SubmittedPassenger(sp_id)
);

CREATE TABLE SubmittedPassengerAddresses (
    address_id int,
    address_number varchar(40),
    sp_id varchar(20),
	PRIMARY KEY(address_id),
    FOREIGN KEY(sp_id) REFERENCES SubmittedPassenger(sp_id)
);

CREATE TABLE Compnay (
    company_id int,
    company_name varchar(20),
	company_registeration_number int,
    PRIMARY KEY(company_id)
);

CREATE TABLE CompnayTelephones (
    telephone_id int,
    telephone_number int,
    company_id varchar(20),
	PRIMARY KEY(telephone_id),
    FOREIGN KEY(company_id) REFERENCES Compnay(company_id)
);

CREATE TABLE CompnayAddresses (
    address_id int,
    address_number varchar(40),
    sp_id varchar(20),
	PRIMARY KEY(address_id),
    FOREIGN KEY(company_id) REFERENCES Compnay(company_id)
);

CREATE TABLE Agent (
    agent_id int,
    agent_first_name varchar(20),
    agent_last_name varchar(20),
	PRIMARY KEY(agent_id)
);

CREATE TABLE Employee (
    employee_id int,
    employee_first_name varchar(20),
    employee_last_name varchar(20),
    company_id varchar(20),
	PRIMARY KEY(employee_id),
    FOREIGN KEY(company_id) REFERENCES Compnay(company_id)
);

CREATE TABLE AgentTelephones (
    telephone_id int,
    telephone_number int,
    agent_id varchar(20),
	PRIMARY KEY(telephone_id),
    FOREIGN KEY(agent_id) REFERENCES Agent(agent_id)
);

CREATE TABLE CompanyAgent (
    company_id int,
    agent_id int,
	PRIMARY KEY(company_id, agent_id),
    FOREIGN KEY(agent_id) REFERENCES Agent(agent_id),
    FOREIGN KEY(company_id) REFERENCES Compnay(company_id)
);

CREATE TABLE Supporter (
    supporter_id int,
    supporter_first_name varchar(20),
    supporter_last_name varchar(20),
    supporter_status boolean,
    PRIMARY KEY(supporter_id)
);

CREATE TABLE SupporterStatusLog (
    supporter_status_log_id int,
    supporter_id int,
    supporter_status boolean,
    supporter_status_timestamp timestamp,
    PRIMARY KEY(supporter_status_log_id)
);

CREATE TABLE SupporterAgent (
    supporter_id int,
    agent_id int,
    employee_id int,
    PRIMARY KEY(supporter_id, agent_id, employee_id),
    FOREIGN KEY(agent_id) REFERENCES Agent(agent_id),
    FOREIGN KEY(supporter_id) REFERENCES Supporter(supporter_id),
    FOREIGN KEY(employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE SupporterSubmittedPassenger (
    supporter_id int,
    sp_id int,
    ssp_timestamp timestamp,
    ssp_message varchar(100),
    ssp_type varchar(20),
    PRIMARY KEY(supporter_id, sp_id),
    FOREIGN KEY(sp_id) REFERENCES SubmittedPassenger(sp_id),
    FOREIGN KEY(supporter_id) REFERENCES Supporter(supporter_id)
);

CREATE TABLE SupporterGuestPassenger (
    supporter_id int,
    gp_id int,
    ssp_timestamp timestamp,
    ssp_message varchar(100),
    ssp_type varchar(20),
    PRIMARY KEY(supporter_id, gp_id),
    FOREIGN KEY(gp_id) REFERENCES GuestPassenger(gp_id),
    FOREIGN KEY(supporter_id) REFERENCES Supporter(supporter_id)
);

CREATE TABLE SupporterDriver (
    supporter_id int,
    driver_id int,
    account_id int,
    sd_timestamp timestamp,
    PRIMARY KEY(supporter_id, driver_id, account_id),
    FOREIGN KEY(driver_id) REFERENCES Driver(driver_id),
    FOREIGN KEY(account_id) REFERENCES DriverAccounts(account_id),
    FOREIGN KEY(supporter_id) REFERENCES Supporter(supporter_id)
);
