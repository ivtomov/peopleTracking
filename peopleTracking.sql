DROP DATABASE people_tracking;
CREATE DATABASE people_tracking;
USE people_tracking;

CREATE TABLE person(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
egn VARCHAR(10) NOT NULL,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
race VARCHAR(50) NOT NULL,
religion VARCHAR(50) NOT NULL,
date_of_birth DATE NOT NULL,
gender ENUM ('male', 'female', 'other') NOT NULL,
address VARCHAR(255) NOT NULL,
height DOUBLE NOT NULL,
weight DOUBLE,
hair_colour ENUM('Blonde', 'Black', 'Brown', 'Grey', 'Other'),
eye_color ENUM ('Green','Blue', 'Brown', 'Other'),
person_egn INT,
email VARCHAR(255),
phone_number VARCHAR(20) NOT NULL,
passport_number VARCHAR(20) NOT NULL,
shoe_size DOUBLE,
clothes_size VARCHAR(5)
);

CREATE TABLE cars(
id INT AUTO_INCREMENT PRIMARY KEY,
car_plate VARCHAR(15),
car_color VARCHAR (20),
car_type ENUM ('SUV', 'Coupe', 'Sedan'),
car_VIN_number VARCHAR(30),
person_id INT,
CONSTRAINT FOREIGN KEY (person_id) REFERENCES person(id)
);

CREATE TABLE family_status(
id INT AUTO_INCREMENT PRIMARY KEY,
person_id INT,
mother_name VARCHAR (255),
father_name VARCHAR (255),
engaged ENUM ('Yes', 'No'),
fiance_name VARCHAR(255),
children ENUM ('Yes', 'No'),
children_name VARCHAR (255),
CONSTRAINT FOREIGN KEY (person_id) REFERENCES person(id)
);

CREATE TABLE profession(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
occupation VARCHAR(50) NOT NULL,
employer VARCHAR (100) NOT NULL,
work_address VARCHAR(255) NOT NULL,
work_phone_number VARCHAR(20) NOT NULL,
person_id INT,
CONSTRAINT FOREIGN KEY (person_id) REFERENCES person(id)
);

CREATE TABLE demographic(
id INT AUTO_INCREMENT PRIMARY KEY,
country VARCHAR(50) NOT NULL,
city VARCHAR(50) NOT NULL,
nationality VARCHAR(50) NOT NULL,
education VARCHAR(50) NOT NULL,
income FLOAT NOT NULL,
person_id INT,
CONSTRAINT FOREIGN KEY (person_id) REFERENCES person(id)
);

CREATE TABLE interests(
id INT AUTO_INCREMENT PRIMARY KEY,
category ENUM('Sports', 'Music', 'Reading', 'Travel', 'Art', 'Other'),
interest VARCHAR(50) NOT NULL,
UNIQUE KEY (category, interest)
);

CREATE TABLE person_interests(
person_id INT,
interest_id INT,
PRIMARY KEY(person_id, interest_id),
CONSTRAINT FOREIGN KEY (person_id) REFERENCES person(id),
CONSTRAINT FOREIGN KEY (interest_id) REFERENCES interests(id)
);


CREATE TABLE frequently_visited_places(
id INT AUTO_INCREMENT PRIMARY KEY,
place_type ENUM ('Work', 'Home', 'Restaurant', 'Park', 'Beach', 'Library', 'Pub', 'Nightclub', 'Other'),
place_name VARCHAR (100) NOT NULL,
place_address VARCHAR(255) NOT NULL,
visit_date TIMESTAMP NOT NULL,
visit_duration TIME NOT NULL,
visit_frequency ENUM ('Daily', 'Weekly', 'Monthly', 'Yearly'),
visit_with VARCHAR (100),
UNIQUE KEY(place_name, place_address, visit_date)
);

CREATE TABLE person_frequently_visited_places(
person_id INT,
frequently_visited_places_id INT,
PRIMARY KEY(person_id, frequently_visited_places_id),
CONSTRAINT FOREIGN KEY (person_id) REFERENCES person(id),
CONSTRAINT FOREIGN KEY (frequently_visited_places_id) REFERENCES frequently_visited_places(id)
);

CREATE TABLE criminal_record(
id INT AUTO_INCREMENT PRIMARY KEY,
person_id INT,
judicial_status ENUM ('Convicted', 'Not convicted'),
commited_crimes VARCHAR(255),
criminal_history TEXT,
links_with_criminal_groups VARCHAR (255),
CONSTRAINT FOREIGN KEY (person_id) REFERENCES person(id)
);

CREATE TABLE bank_accounts(
id INT AUTO_INCREMENT PRIMARY KEY,
person_id INT,
card_number VARCHAR(50) NOT NULL UNIQUE,
card_balance FLOAT NOT NULL,
currency VARCHAR(10) NOT NULL,
CONSTRAINT FOREIGN KEY (person_id) REFERENCES person(id)
);

CREATE TABLE real_estate(
id INT AUTO_INCREMENT PRIMARY KEY,
real_estate_type ENUM('Apartment', 'House', 'Building'),
real_estate_address VARCHAR(255),
real_estate_value FLOAT
);

CREATE TABLE person_real_estate(
real_estate_id INT,
person_id INT,
PRIMARY KEY(person_id, real_estate_id),
CONSTRAINT FOREIGN KEY (real_estate_id) REFERENCES real_estate(id),
CONSTRAINT FOREIGN KEY (person_id) REFERENCES person(id)
);

CREATE TABLE statistics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    person_count INT DEFAULT 0,
    car_count INT DEFAULT 0,
    family_count INT DEFAULT 0,
    profession_count INT DEFAULT 0,
    demographic_count INT DEFAULT 0,
    interest_count INT DEFAULT 0,
    hobby_count INT DEFAULT 0,
    place_count INT DEFAULT 0,
    criminal_record_count INT DEFAULT 0,
    bank_account_count INT DEFAULT 0,
    real_estate_count INT DEFAULT 0,
    person_id INT,
	CONSTRAINT FOREIGN KEY (person_id) REFERENCES person(id)
);

-- Insert data into person table
INSERT INTO person (egn, first_name, last_name, race, religion, date_of_birth, gender, address, height, weight, hair_colour, eye_color,  email, phone_number, passport_number, shoe_size, clothes_size)
VALUES 
('8001011234', 'John', 'Doe', 'Caucasian', 'Christian', '1980-01-01', 'male', '123 Main St, Anytown, USA', 1.8, 80, 'Brown', 'Blue', 'john.doe@example.com', '555-1234', 'ABC123', 10, 'M'),
('8502025678', 'Jane', 'Smith', 'Asian', 'Buddhist', '1985-02-02', 'female', '456 Maple Ave, Othertown, USA', 1.6, 60, 'Black', 'Brown', 'jane.smith@example.com', '555-5678', 'DEF456', 8, 'S'),
('9003039876', 'Mike', 'Johnson', 'African American', 'Muslim', '1990-03-03', 'male', '789 Oak St, Somewhere, USA', 1.85, 90, 'Black', 'Brown', 'mike.johnson@example.com', '555-9876', 'GHI789', 11, 'L'),
('9001011234', 'Jane', 'Doe', 'Caucasian', 'Christian', '1990-01-01', 'female', '456 Oak St, Anytown, USA', 170.0, 60.0, 'Blonde', 'Green', 'janedoe@example.com', '+1-555-555-1213', 'DEF123456', 8.5, 'S'),
('8606121234', 'Bob', 'Smith', 'African American', 'Christian', '1986-06-12', 'male', '789 Elm St, Anytown, USA', 175.0, 70.0, 'Black', 'Brown', 'bobsmith@example.com', '+1-555-555-1214', 'GHI123456', 9.5, 'L');
-- Insert data into cars table
INSERT INTO cars (car_plate, car_color, car_type, car_VIN_number, person_id)
VALUES 
('ABC123', 'Red', 'Sedan', '1G1BL52W1RR135540', 1),
('DEF456', 'Silver', 'SUV', '1GYS4BKJ8FR521782', 2),
('GHI789', 'Black', 'Coupe', 'JTDJTUD30DD568022', 3);

-- Insert data into family_status table
INSERT INTO family_status (person_id, mother_name, father_name, engaged, fiance_name, children, children_name)
VALUES 
(1, 'Mary Doe', 'Bob Doe', 'Yes', 'Jane Smith', 'Yes', 'Timothy Doe'),
(2, 'Kim Lee', 'Jack Smith', 'No', NULL, 'No', NULL),
(3, 'Lisa Johnson', 'David Johnson', 'No', NULL, 'Yes', 'Emily Johnson');

-- Insert data into profession table
INSERT INTO profession (occupation, employer, work_address, work_phone_number, person_id)
VALUES 
('Software Engineer', 'Acme Inc.', '1234 Elm St, Anytown, USA', '555-4321', 1),
('Teacher', 'ABC School', '5678 Maple Ave, Othertown, USA', '555-8765', 2),
('Doctor', 'XYZ Hospital', '9012 Oak St, Somewhere, USA', '555-2468', 3);

-- Insert data into demographic table
INSERT INTO demographic (country, city, nationality, education, income, person_id)
VALUES 
('USA', 'Anytown', 'American', 'Bachelor degree', 80000, 1),
('USA', 'Othertown', 'Korean', 'Master degree', 60000, 2),
('Brazil', 'Somewhere', 'African American', 'Doctorate degree', 120000, 3);

-- Insert values into interests table
INSERT INTO interests (category, interest) VALUES
    ('Sports', 'Soccer'),
    ('Sports', 'Basketball'),
    ('Sports', 'Swimming'),
    ('Music', 'Rock'),
    ('Music', 'Hip hop'),
    ('Reading', 'Mystery'),
    ('Reading', 'Romance'),
    ('Travel', 'Beach'),
    ('Travel', 'Safari'),
    ('Art', 'Painting'),
    ('Art', 'Sculpture'),
    ('Other', 'Cooking'),
    ('Other', 'Gardening');

-- Insert values into frequently_visited_places table
INSERT INTO frequently_visited_places (place_type, place_name, place_address, visit_date, visit_duration, visit_frequency, visit_with) VALUES
    ('Work', 'ABC Corporation', '123 Main St', '2022-01-01 09:00:00', '01:30:00', 'Weekly', 'Coworkers'),
    ('Home', 'My Apartment', '456 Elm St', '2022-01-01 18:00:00', '08:00:00', 'Daily', NULL),
    ('Restaurant', 'Joe\'s Pizza', '789 Broadway', '2022-01-02 12:00:00', '01:00:00', 'Weekly', 'Friends'),
    ('Park', 'Central Park', 'Central Park West and 79th St', '2022-01-02 15:00:00', '02:00:00', 'Monthly', 'Family'),
    ('Beach', 'Malibu Beach', 'Pacific Coast Highway', '2022-01-03 11:00:00', '03:00:00', 'Yearly', 'Partner'),
    ('Library', 'NY Public Library', 'Fifth Ave and 42nd St', '2022-01-04 10:00:00', '02:00:00', 'Monthly', 'Alone'),
    ('Pub', 'The Red Lion', '123 Main St', '2022-01-04 20:00:00', '04:00:00', 'Weekly', 'Friends'),
    ('Nightclub', 'Studio 54', '254 W 54th St', '2022-01-05 23:00:00', '05:00:00', 'Yearly', 'Group of friends'),
    ('Other', 'Art Gallery', '1020 Park Ave', '2022-01-06 13:00:00', '01:30:00', 'Monthly', 'Partner');

-- Insert values into criminal_record table
INSERT INTO criminal_record (person_id, judicial_status, commited_crimes, criminal_history, links_with_criminal_groups) VALUES
    (1, 'Convicted', 'Robbery', 'Served 2 years in prison', 'None'),
    (2, 'Not convicted', NULL, 'Arrested for public intoxication', 'None'),
    (3, 'Convicted', 'Embezzlement', 'Served 5 years in prison', 'Had ties to organized crime'),
    (4, 'Not convicted', NULL, 'Arrested for possession of marijuana', 'None'),
    (5, 'Convicted', 'Grand theft auto', 'Served 3 years in prison', 'Had ties to a car theft ring');

-- Insert into real_estate table
INSERT INTO real_estate (real_estate_type, real_estate_address, real_estate_value) VALUES
('Apartment', '123 Main St, Anytown USA', 50500.00),
('House', '456 Elm St, Anytown USA', 10000000),
('Building', '789 Maple St, Anytown USA', 75540000);

-- Insert into person_real_estate table
INSERT INTO person_real_estate (real_estate_id, person_id) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Insert into bank_accounts table
INSERT INTO bank_accounts (person_id, card_number, card_balance, currency) VALUES
(1, '1234-5678-9012-3456', 5000, 'BGN'),
(2, '2345-6789-0123-4567', 7500, 'BGN'),
(3, '3456-7890-1234-5678', 10000, 'BGN');

-- 2
SELECT first_name, last_name FROM person
WHERE religion LIKE '%Christian%';

-- 3
SELECT nationality, AVG (income) AS AverageIncomePerNationality
FROM demographic
GROUP BY nationality;

-- 4
SELECT person.first_name, person.last_name, cars.car_plate, cars.car_type
FROM person
INNER JOIN cars ON person.id = cars.person_id;

-- 5 извежда всичката инфо за хората с коли
SELECT *
FROM person
LEFT OUTER JOIN cars ON person.id = cars.person_id;

-- 6 Извежда име и номер на всички бразилци
SELECT first_name, phone_number
FROM person
WHERE id IN(
			SELECT person_id
			FROM demographic 
            WHERE country = 'Brazil'
            );

-- 7 намира общата ст-т на всички недвижими имоти, притежавани от всеки човек 
SELECT person.first_name, person.egn, SUM(real_estate_value) AS total_real_estate_value
FROM person_real_estate
JOIN person ON person.id = person_real_estate.person_id
JOIN real_estate ON real_estate.id = person_real_estate.real_estate_id
GROUP BY person.id
LIMIT 3;

-- 8 Тригер, който обновява информацията в таблица 'statistics' 
-- This trigger is set to execute after an INSERT operation on the person table. It updates each count in the statistics table by performing a SELECT COUNT(*) on the corresponding tables.

DELIMITER //
CREATE TRIGGER update_statistics_trigger AFTER INSERT ON person
FOR EACH ROW
BEGIN
    UPDATE statistics
    SET person_count = (SELECT COUNT(*) FROM person);

    UPDATE statistics
    SET car_count = (SELECT COUNT(*) FROM cars);

    UPDATE statistics
    SET family_count = (SELECT COUNT(*) FROM family_status);

    UPDATE statistics
    SET profession_count = (SELECT COUNT(*) FROM profession);

    UPDATE statistics
    SET demographic_count = (SELECT COUNT(*) FROM demographic);

    UPDATE statistics
    SET interest_count = (SELECT COUNT(*) FROM interests);

    UPDATE statistics
    SET hobby_count = (SELECT COUNT(*) FROM hobby);

    UPDATE statistics
    SET place_count = (SELECT COUNT(*) FROM frequently_visited_places);

    UPDATE statistics
    SET criminal_record_count = (SELECT COUNT(*) FROM criminal_record);

    UPDATE statistics
    SET bank_account_count = (SELECT COUNT(*) FROM bank_accounts);

    UPDATE statistics
    SET real_estate_count = (SELECT COUNT(*) FROM real_estate);

END //
DELIMITER ;

SELECT *
FROM statistics;

INSERT INTO person (egn, first_name, last_name, race, religion, date_of_birth, gender, address, height, weight, hair_colour, eye_color,  email, phone_number, passport_number, shoe_size, clothes_size)
VALUES 
('8001011254', 'John', 'Doe', 'Caucasian', 'Christian', '1980-01-01', 'male', '123 Main St, Anytown, USA', 1.8, 80, 'Brown', 'Blue', 'john.doe@example.com', '555-1234', 'ABC123', 10, 'M');

-- 9 процеура, която извежда осъжданите лица
drop procedure get_convicted_persons;
DROP TABLE IF EXISTS temp_convicted_persons;
DELIMITER //
CREATE PROCEDURE get_convicted_persons()
BEGIN
 -- Declare variables
    DECLARE done INT DEFAULT FALSE;
    DECLARE person_id INT;
    DECLARE egn VARCHAR(10);
    DECLARE first_name VARCHAR(100);
    DECLARE last_name VARCHAR(100);
    DECLARE race VARCHAR(50);
    DECLARE religion VARCHAR(50);
    DECLARE date_of_birth DATE;
    DECLARE gender ENUM ('male', 'female', 'other');
    DECLARE address VARCHAR(255);
    DECLARE height DOUBLE;
    DECLARE weight DOUBLE;
    DECLARE hair_colour ENUM('Blonde', 'Black', 'Brown', 'Grey', 'Other');
    DECLARE eye_color ENUM ('Green','Blue', 'Brown', 'Other');
    DECLARE person_egn INT;
    DECLARE email VARCHAR(255);
    DECLARE phone_number VARCHAR(20);
    DECLARE passport_number VARCHAR(20);
    DECLARE shoe_size DOUBLE;
    DECLARE clothes_size VARCHAR(5);
      
      -- Declare a variable to check if the person exists
    DECLARE person_exists INT DEFAULT 0;
    
    DECLARE cur_person CURSOR FOR
        SELECT p.id, p.egn, p.first_name, p.last_name, p.race, p.religion, p.date_of_birth, p.gender, p.address, p.height, p.weight, p.hair_colour, p.eye_color, p.person_egn, p.email, p.phone_number, p.passport_number, p.shoe_size, p.clothes_size
        FROM person p
        JOIN criminal_record c ON p.id = c.person_id
        WHERE c.judicial_status = 'Convicted';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    CREATE TEMPORARY TABLE temp_convicted_persons (
        person_id INT,
        egn VARCHAR(10),
        first_name VARCHAR(100),
        last_name VARCHAR(100),
        race VARCHAR(50),
        religion VARCHAR(50),
        date_of_birth DATE,
        gender ENUM ('male', 'female', 'other'),
        address VARCHAR(255),
        height DOUBLE,
        weight DOUBLE,
        hair_colour ENUM('Blonde', 'Black', 'Brown', 'Grey', 'Other'),
        eye_color ENUM ('Green','Blue', 'Brown', 'Other'),
        person_egn INT,
        email VARCHAR(255),
        phone_number VARCHAR(20),
        passport_number VARCHAR(20),
        shoe_size DOUBLE,
        clothes_size VARCHAR(5)
    );

    OPEN cur_person;

    -- Loop through the convicted persons and insert into the temporary table
    FETCH cur_person INTO person_id, egn, first_name, last_name, race, religion, date_of_birth, gender, address, height, weight, hair_colour, eye_color, person_egn, email, phone_number, passport_number, shoe_size, clothes_size;
        
        -- Check if the person exists
    SELECT COUNT(*) INTO person_exists FROM person WHERE id = person_id;
    
    REPEAT
		IF person_exists > 0 THEN
			INSERT INTO temp_convicted_persons (person_id, egn, first_name, last_name, race, religion, date_of_birth, gender, address, height, weight, hair_colour, eye_color, person_egn, email, phone_number, passport_number, shoe_size, clothes_size)
			VALUES (person_id, egn, first_name, last_name, race, religion, date_of_birth, gender, address, height, weight, hair_colour, eye_color, person_egn, email, phone_number, passport_number, shoe_size, clothes_size);
		END IF;
        -- Fetch the next convicted person
        FETCH cur_person INTO person_id, egn, first_name, last_name, race, religion, date_of_birth, gender, address, height, weight, hair_colour, eye_color, person_egn, email, phone_number, passport_number, shoe_size, clothes_size;
    UNTIL done END REPEAT;

    CLOSE cur_person;

    SELECT * FROM temp_convicted_persons;

    DROP TABLE IF EXISTS temp_convicted_persons;
   END;
//

DELIMITER ;

CALL get_convicted_persons();



