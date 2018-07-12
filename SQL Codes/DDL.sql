CREATE TABLE IF NOT EXISTS Driver (
    driver_id int,
    driver_first_name varchar(20),
    driver_last_name varchar(20),
	driver_balance numeric(10,2),
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(driver_id)
);
 
CREATE TABLE IF NOT EXISTS Train (
    train_id int,
    train_name varchar(20),
    train_production_date date,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(train_id)
);

CREATE TABLE IF NOT EXISTS TrainStation (
    ts_id int,
    ts_city varchar(20),
    ts_province varchar(20),
    ts_manager varchar(40),
    train_construction_date date,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(ts_id)
);

CREATE TABLE IF NOT EXISTS Trip (
    trip_id int,
    train_id int,
    driver_id int,
    trip_cost numeric(10,2),
    trip_start_timestamp timestamp,
    trip_finish_timestamp timestamp,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(trip_id),
    FOREIGN KEY(train_id) REFERENCES Train(train_id),
    FOREIGN KEY(driver_id) REFERENCES Driver(driver_id)
);

CREATE TABLE IF NOT EXISTS TripTrainStation (
    trip_train_station_id int,
    trip_id int,
    ts_id int,
    ts_sequence int,
    ts_type varchar(20),
    trip_enter_timestamp timestamp,
    trip_exit_timestamp timestamp,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(trip_train_station_id),
    FOREIGN KEY(trip_id) REFERENCES Trip(trip_id),
    FOREIGN KEY(ts_id) REFERENCES TrainStation(ts_id)
);

CREATE TABLE IF NOT EXISTS Route (
    route_id int,
    train_station_id1 int,
    train_station_id2 int,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(route_id),
    FOREIGN KEY(train_station_id1) REFERENCES TrainStation(ts_id),
    FOREIGN KEY(train_station_id2) REFERENCES TrainStation(ts_id)
);

CREATE TABLE IF NOT EXISTS DriverAccounts (
    account_id int,
    account_number int,
    driver_id int,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(account_id),
    FOREIGN KEY(driver_id) REFERENCES Driver(driver_id)
);

CREATE TABLE IF NOT EXISTS GuestPassenger (
    gp_id int,
    gp_first_name varchar(20),
    gp_last_name varchar(20),
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(gp_id)
);

CREATE TABLE IF NOT EXISTS BankTransaction (
    transaction_id int,
    transaction_amount numeric(10,2),
    transaction_timestamp timestamp,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(transaction_id)
);

CREATE TABLE IF NOT EXISTS GuestBook (
    guest_book_id int,
    guest_id int,
    transaction_id int,
    trip_id int,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(guest_book_id),
    FOREIGN KEY(guest_id) REFERENCES GuestPassenger(gp_id),
    FOREIGN KEY(transaction_id) REFERENCES BankTransaction(transaction_id),
    FOREIGN KEY(trip_id) REFERENCES Trip(trip_id)
);


CREATE TABLE IF NOT EXISTS SubmittedPassenger (
    sp_id int,
    sp_first_name varchar(20),
    sp_last_name varchar(20),
	sp_national_number int,
    sp_father_first_name varchar(20),
    sp_born_city varchar(20),
    sp_born_date date,
    sp_balance int,
    sp_registeration_timestamp timestamp,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
    PRIMARY KEY(sp_id)
);

CREATE TABLE IF NOT EXISTS DeletedSubmittedPassengerLog (
    sp_id int,
    sp_first_name varchar(20),
    sp_last_name varchar(20),
	sp_national_number int,
    sp_father_first_name varchar(20),
    sp_born_city varchar(20),
    sp_born_date date,
    sp_balance int,
    sp_registeration_timestamp timestamp,
    created_at timestamp not null
);

CREATE TABLE IF NOT EXISTS SubmittedBankTransactionBook (
    submitted_bank_id int,
    sp_id int,
    transaction_id int,
    trip_id int,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(submitted_bank_id),
    FOREIGN KEY(sp_id) REFERENCES SubmittedPassenger(sp_id),
    FOREIGN KEY(transaction_id) REFERENCES BankTransaction(transaction_id),
    FOREIGN KEY(trip_id) REFERENCES Trip(trip_id)
);

CREATE TABLE IF NOT EXISTS SubmittedBalanceBook (
    sp_id int,
    trip_id int,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(sp_id, trip_id),
    FOREIGN KEY(sp_id) REFERENCES SubmittedPassenger(sp_id),
    FOREIGN KEY(trip_id) REFERENCES Trip(trip_id)
);

CREATE TABLE IF NOT EXISTS SubmittedPassengerTelephones (
    telephone_id int,
    telephone_number int,
    sp_id int,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(telephone_id),
    FOREIGN KEY(sp_id) REFERENCES SubmittedPassenger(sp_id)
);

CREATE TABLE IF NOT EXISTS SubmittedPassengerAddresses (
    address_id int,
    address_number varchar(40),
    sp_id int,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(address_id),
    FOREIGN KEY(sp_id) REFERENCES SubmittedPassenger(sp_id)
);

CREATE TABLE IF NOT EXISTS Company (
    company_id int,
    company_name varchar(20),
	company_registeration_number int,
	company_income numeric(10, 2),
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
    PRIMARY KEY(company_id)
);

CREATE TABLE IF NOT EXISTS CompanyTelephones (
    telephone_id int,
    telephone_number int,
    company_id int,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(telephone_id),
    FOREIGN KEY(company_id) REFERENCES Company(company_id)
);

CREATE TABLE IF NOT EXISTS CompanyAddresses (
    address_id int,
    address_number varchar(40),
    company_id int,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(address_id),
    FOREIGN KEY(company_id) REFERENCES Company(company_id)
);

CREATE TABLE IF NOT EXISTS Agent (
    agent_id int,
    agent_first_name varchar(20),
    agent_last_name varchar(20),
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(agent_id)
);

CREATE TABLE IF NOT EXISTS Employee (
    employee_id int,
    employee_first_name varchar(20),
    employee_last_name varchar(20),
    employee_personnel_id int,
    company_id int,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(employee_id),
    FOREIGN KEY(company_id) REFERENCES Company(company_id)
);

CREATE TABLE IF NOT EXISTS AgentTelephones (
    telephone_id int,
    telephone_number int,
    agent_id int,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(telephone_id),
    FOREIGN KEY(agent_id) REFERENCES Agent(agent_id)
);

CREATE TABLE IF NOT EXISTS CompanyAgent (
    companu_agent_id int,
    company_id int,
    agent_id int,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
	PRIMARY KEY(companu_agent_id),
    FOREIGN KEY(agent_id) REFERENCES Agent(agent_id),
    FOREIGN KEY(company_id) REFERENCES Company(company_id)
);

CREATE TABLE IF NOT EXISTS Supporter (
    supporter_id int,
    supporter_first_name varchar(20),
    supporter_last_name varchar(20),
    supporter_status boolean,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
    PRIMARY KEY(supporter_id)
);

CREATE TABLE IF NOT EXISTS DeletedSupporterLog (
    supporter_id int,
    supporter_first_name varchar(20),
    supporter_last_name varchar(20),
    supporter_status boolean,
    created_at timestamp not null
);

CREATE TABLE IF NOT EXISTS SupporterTrip (
    supporter_trip_id int, 
    supporter_id int,
    trip_id int,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
    PRIMARY KEY(supporter_trip_id),
    FOREIGN KEY(supporter_id) REFERENCES Supporter(supporter_id),
    FOREIGN KEY(trip_id) REFERENCES Trip(trip_id)
);

CREATE TABLE IF NOT EXISTS SupporterStatusLog (
    supporter_status_log_id int,
    supporter_id int,
    supporter_status boolean,
    supporter_status_timestamp timestamp,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
    PRIMARY KEY(supporter_status_log_id)
);

CREATE TABLE IF NOT EXISTS SupporterAgent (
    supporter_agent_id int,
    supporter_id int,
    agent_id int,
    employee_id int,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
    PRIMARY KEY(supporter_agent_id),
    FOREIGN KEY(agent_id) REFERENCES Agent(agent_id),
    FOREIGN KEY(supporter_id) REFERENCES Supporter(supporter_id),
    FOREIGN KEY(employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE IF NOT EXISTS SupporterSubmittedPassenger (
    supporter_submitted_passenger_id int,
    supporter_id int,
    sp_id int,
    ssp_timestamp timestamp,
    ssp_message varchar(100),
    ssp_type varchar(20),
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
    PRIMARY KEY(supporter_submitted_passenger_id),
    FOREIGN KEY(sp_id) REFERENCES SubmittedPassenger(sp_id),
    FOREIGN KEY(supporter_id) REFERENCES Supporter(supporter_id)
);

CREATE TABLE IF NOT EXISTS SupporterGuestPassenger (
    supporter_guset_passenger_id int,
    supporter_id int,
    gp_id int,
    ssp_timestamp timestamp,
    ssp_message varchar(100),
    ssp_type varchar(20),
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
    PRIMARY KEY(supporter_guset_passenger_id),
    FOREIGN KEY(gp_id) REFERENCES GuestPassenger(gp_id),
    FOREIGN KEY(supporter_id) REFERENCES Supporter(supporter_id)
);

CREATE TABLE IF NOT EXISTS DriverSupport (
    driver_support_id int,
    supporter_id int,
    driver_id int,
    account_id int,
    ds_timestamp timestamp,
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
    PRIMARY KEY(driver_support_id),
    FOREIGN KEY(driver_id) REFERENCES Driver(driver_id),
    FOREIGN KEY(account_id) REFERENCES DriverAccounts(account_id),
    FOREIGN KEY(supporter_id) REFERENCES Supporter(supporter_id)
);

CREATE TABLE IF NOT EXISTS SupportDriver (
    supporter_driver_id int,
    supporter_id int,
    driver_id int,
    sd_timestamp timestamp,
    sd_number timestamp,
    sd_amount numeric(10, 2),
    created_at timestamp not null,
    updated_at timestamp not null DEFAULT now() on update now(),
    PRIMARY KEY(supporter_driver_id),
    FOREIGN KEY(driver_id) REFERENCES Driver(driver_id),
    FOREIGN KEY(supporter_id) REFERENCES Supporter(supporter_id)
);

CREATE TABLE IF NOT EXISTS DriverResignLog (
    driver_id int,
    driver_first_name varchar(20),
    driver_last_name varchar(20),
    resign_timestamp timestamp not null
);

CREATE TABLE IF NOT EXISTS PassengerExecutionLog (
    passenger_id int,
    execution_type varchar(20),
    created_at timestamp not null
);

CREATE TABLE IF NOT EXISTS SupporterExecutionLog (
    supporter_id int,
    execution_type varchar(20),
    created_at timestamp not null
);
