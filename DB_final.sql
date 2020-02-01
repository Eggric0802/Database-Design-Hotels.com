--Part 1. Create Table

CREATE TABLE customer (
  member_id integer primary key,
  Fname     varchar(25) not null,
  Lname     varchar(25) not null,
  email     varchar(25) not null,
  password  varchar(25) not null,
  facebook  char(1) default 'N',
  marketing char(1) default 'N',  
  member_level  integer default 0,
  collected_nights  integer default 0,
  free_nights   integer default 0,
  unique(email)
);

CREATE TABLE creditcard (
  card_num      varchar(16) not null,
  member_id     integer,
  card_type     varchar(10) not null,
  name_on_card  varchar(25) not null,
  expire_date_mm   char(2) not null,
  expire_date_yy    char(2) not null,
  cvv2          char(3) not null,
  preferred         char(1) default 'N',
  primary key(card_num)
);

CREATE TABLE TODAY_PRICE(
    ROOM_ID INT NOT NULL,
    Price_availability char(1) default 'Y',
    HOTEL_ID VARCHAR(20) NOT NULL,
    PRICE_Date date,
    ORIGINAL_PRICE INT NOT NULL,
    primary key (ROOM_ID,HOTEL_ID,PRICE_Date)
);

CREATE TABLE ROOM(
    ROOM_ID INT NOT NULL,
    HOTEL_ID VARCHAR(10) NOT NULL,
    ROOM_Availability char(1) default 'Y',
    ROOM_FEATURE varchar(250),
    ROOM_Type varchar(60),   
    primary key (ROOM_ID,HOTEL_ID)
);

CREATE TABLE BED(
    BED_Type varchar(20) NOT NULL,   
    primary key (BED_Type)
);

CREATE TABLE ROOM_BED(
    ROOM_ID INT NOT NULL,
    HOTEL_ID VARCHAR(10) NOT NULL,
    Number_of_BEDS INT NOT NULL,
    BED_Type varchar(20) NOT NULL,   
    primary key (ROOM_ID,HOTEL_ID, BED_Type)
);

CREATE TABLE REVIEW(
    REVIEW_ID INT NOT NULL PRIMARY KEY,
    HOTEL_ID VARCHAR(10) NOT NULL,
    MEMBER_ID INT NOT NULL,
    REVIEW_TITLE varchar(20),
    REVIEW_CONTENT varchar(300),
    RESPONSE varchar(200),
    TYPE_of_TRIP varchar(200) NOT NULL,
    REVIEW_DATE date
);

CREATE TABLE reserve (
  order_id      integer,
  order_date     timestamp not null,
  status    varchar(10) not null,
  checkin_date  date not null,
  checkout_date date not null,
  payment_method    varchar(10) not null,
  speciall_request  varchar(2000),
  comfirmation_num  integer,
  member_id integer not null,
  hotel_id varchar(10) not null,
  room_id integer not null,
  unique(comfirmation_num),
  primary key(order_id)
); 

CREATE TABLE amenities (
  amenity_id	integer,
  amenity	varchar(25) not null,
  primary key(amenity_id)
); 

CREATE TABLE hotel_amenities(
    hotel_id    varchar(10),
    amenity_id  integer
);

CREATE TABLE HOTEL(
    Hotel_ID                VARCHAR(10) NOT NULL, 
    Hotel_name              VARCHAR(50) NOT NULL,
    Hotel_instruction       VARCHAR(300) NULL,
    Photo                   BLOB NULL, 
    Address_street_number   VARCHAR(100) NOT NULL,
    Address_city            VARCHAR(15) NOT NULL,
    Address_state_province  VARCHAR(15) NULL,
    Address_country         VARCHAR(30) NOT NULL,
    Zipcode                 VARCHAR(15) NOT NULL, 
    Star_rating             FLOAT NULL,
    Contact_name            VARCHAR(20) NOT NULL,
    Contact_phone           VARCHAR(20) NOT NULL,
    Contact_email           VARCHAR(30) NOT NULL,
    PRIMARY KEY (Hotel_ID)
);

CREATE TABLE DEAL(
    Deal_ID                 VARCHAR(20) NOT NULL,
    Start_date               DATE,
    End_date                 DATE,
    Deal_type               VARCHAR(15) NOT NULL,
    Discount_amount         FLOAT(24),
    Discount_remains        INT,
    PRIMARY KEY (Deal_ID)
);

CREATE TABLE OFFER_DEAL(
    Hotel_ID	VARCHAR(10),
    Deal_ID       VARCHAR(20) NOT NULL,
    PRIMARY KEY (Hotel_ID, Deal_ID)
);

CREATE TABLE APPLY_Deal(
    ROOM_ID INT NOT NULL,
    Hotel_ID		VARCHAR(10),
    Deal_ID       	VARCHAR(20) NOT NULL,
    Deal_date    	DATE NOT NULL,
    Final_Price 	INT NOT NULL,
    PRIMARY KEY (ROOM_ID,Hotel_ID, Deal_ID, Deal_date)
);


--Part 2. Foriegn key reference
ALTER TABLE creditcard ADD CONSTRAINT cc_c_key FOREIGN KEY(member_id) REFERENCES customer(member_id);
ALTER TABLE TODAY_PRICE ADD CONSTRAINT tp_ro_ey FOREIGN KEY(HOTEL_ID,ROOM_ID) REFERENCES ROOM(HOTEL_ID,ROOM_ID);
ALTER TABLE ROOM ADD CONSTRAINT ro_h_key FOREIGN KEY(HOTEL_ID) REFERENCES HOTEL(HOTEL_ID);
ALTER TABLE REVIEW ADD CONSTRAINT re_h_key FOREIGN KEY(HOTEL_ID) REFERENCES HOTEL(HOTEL_ID);
ALTER TABLE REVIEW ADD CONSTRAINT re_c_key FOREIGN KEY(MEMBER_ID) REFERENCES CUSTOMER(MEMBER_ID);
ALTER TABLE reserve ADD CONSTRAINT r_c_key FOREIGN KEY(member_id) REFERENCES customer(member_id);
ALTER TABLE reserve ADD CONSTRAINT r_ro_key FOREIGN KEY(hotel_id, room_id) REFERENCES ROOM(hotel_id,room_id);
ALTER TABLE hotel_amenities ADD CONSTRAINT ha_h_key FOREIGN KEY(hotel_id) REFERENCES hotel(hotel_id);
ALTER TABLE hotel_amenities ADD CONSTRAINT ha_a_key FOREIGN KEY(amenity_id) REFERENCES amenities(amenity_id);
ALTER TABLE ROOM_BED ADD CONSTRAINT rb_r_key FOREIGN KEY(HOTEL_ID,ROOM_ID) REFERENCES ROOM(HOTEL_ID,ROOM_ID);
ALTER TABLE ROOM_BED ADD CONSTRAINT rb_b_key FOREIGN KEY(BED_Type) REFERENCES BED(BED_Type);
ALTER TABLE OFFER_DEAL ADD CONSTRAINT od_h_key FOREIGN KEY(HOTEL_ID) REFERENCES HOTEL(HOTEL_ID);
ALTER TABLE OFFER_DEAL ADD CONSTRAINT od_d_key FOREIGN KEY(DEAL_ID) REFERENCES DEAL(DEAL_ID);
ALTER TABLE APPLY_Deal ADD CONSTRAINT ad_d_key FOREIGN KEY(DEAL_ID) REFERENCES DEAL(DEAL_ID);
ALTER TABLE APPLY_Deal ADD CONSTRAINT ad_tp_key FOREIGN KEY(ROOM_ID,Hotel_ID, Deal_date) REFERENCES TODAY_PRICE(ROOM_ID,HOTEL_ID, PRICE_Date);


--Part 3. Data Insertion
--Hotel Table
INSERT INTO HOTEL 
VALUES ('ho163463','Hilton Garden Inn Hollywood','3-star hotel with outdoor pool, near Dolby Theater','','2005 N Highland Avenue','Los Angeles', 'CA', 'United States of America', '90068', '3', 'Jasmine Cole', '855-239-9477', 'manager@hilton.com');

INSERT INTO HOTEL
VALUES ('ho416237','TRYP by Wyndham Panamá Centro','Beaux Arts hotel with outdoor pool, near Via Espana','','Via Veneto, El Cangrejo Bellavista','Panama City', NULL, 'Panama', '0834-01294', '3.5', 'Ozbern Smith', '800-491-6126', 'management@hotel.com');

INSERT INTO HOTEL
VALUES ('ho525177','Lis Hostel','Convenient to Tunghai University','','No.13, Ln. 143, Youyuan S. Rd., Longjing Dist.','Taichung', NULL, 'Taiwan', '43448', '2', 'Ozbern Smith', '800-491-6126', 'management@hotel.com');

INSERT INTO HOTEL
VALUES ('ho63135235','Tocuyeros Boutique Hotel', '4-star hotel with restaurant, near San Blas Church', '','Tocuyeros 560, San Blas','Cusco','Cusco','Peru','8003','4', 'Ozbern Smith', '800-491-6126', 'management@hotel.com');

INSERT INTO HOTEL
VALUES ('ho17618688','Thon Hotel Rosenkrantz', '4-star hotel with 2 restaurants, near Oslo Spektrum', '','Rosenkrantz gate 1','Oslo','','Norway','0159', '4', 'Ozbern Smith', '800-491-6126', 'management@hotel.com');

INSERT INTO HOTEL 
VALUES ('ho456130','Cochs Pensjonat', 'City-center hotel within easy reach of Aker Brygge', '','Parkveien 25','Oslo','','Norway','0350', '4', 'Ozbern Smith', '800-491-6126', 'management@hotel.com');

--Room Table
INSERT INTO ROOM VALUES (022, 'ho163463', 'N', '', 'One King Bed');
INSERT INTO ROOM VALUES (042, 'ho163463', 'Y', '', 'Two Queen Beds');
INSERT INTO ROOM VALUES (215, 'ho416237', 'Y', '', 'Premium Room');
INSERT INTO ROOM VALUES (411, 'ho416237', 'N', '', 'Family Room');
INSERT INTO ROOM VALUES (250, 'ho525177', 'Y', '', 'Basic Double Room');
INSERT INTO ROOM VALUES (431, 'ho525177', 'Y', '', 'Economic Room');
INSERT INTO ROOM VALUES (5124, 'ho63135235', 'Y', '', 'Superior Room, Courtyard View, Garden Area');
INSERT INTO ROOM VALUES (4003, 'ho63135235', 'N', '', 'Signature Suite, 1 King Bed with Sofa bed, City View, Tower');
INSERT INTO ROOM VALUES (2001, 'ho63135235', 'Y', '', 'Presidential Suite, 1 King Bed, City View, Tower');
INSERT INTO ROOM VALUES (292, 'ho456130', 'Y', '', 'Twin Room');
INSERT INTO ROOM VALUES (415, 'ho456130', 'Y', '', 'Superior Double and Twin Room, 1 Bedroom');
INSERT INTO ROOM VALUES (313, 'ho456130', 'N', '', 'Triple Room');


--Bed Table
INSERT INTO BED VALUES ('Single Bed');
INSERT INTO BED VALUES ('Twin Bed');
INSERT INTO BED VALUES ('Double Bed');
INSERT INTO BED VALUES ('Queen Bed');
INSERT INTO BED VALUES ('King Bed');
INSERT INTO BED VALUES ('Sofa Bed');


--Room_Bed Table 
INSERT INTO ROOM_BED VALUES (022, 'ho163463', 1,'King Bed');
INSERT INTO ROOM_BED VALUES (042, 'ho163463', 2, 'Queen Bed');
INSERT INTO ROOM_BED VALUES (215, 'ho416237', 1, 'King Bed');
INSERT INTO ROOM_BED VALUES (411, 'ho416237', 2, 'King Bed');
INSERT INTO ROOM_BED VALUES (250, 'ho525177', 1, 'Double Bed');
INSERT INTO ROOM_BED VALUES (431, 'ho525177', 1, 'Queen Bed');
INSERT INTO ROOM_BED VALUES (431, 'ho525177', 1, 'Single Bed');
INSERT INTO ROOM_BED VALUES (431, 'ho525177', 1, 'Sofa Bed');
INSERT INTO ROOM_BED VALUES (5124, 'ho63135235', 2, 'Queen Bed');
INSERT INTO ROOM_BED VALUES (4003, 'ho63135235', 1, 'King Bed');
INSERT INTO ROOM_BED VALUES (4003, 'ho63135235', 1, 'Sofa Bed');
INSERT INTO ROOM_BED VALUES (2001, 'ho63135235', 1, 'King Bed');
INSERT INTO ROOM_BED VALUES (292, 'ho456130', 2, 'Twin Bed');
INSERT INTO ROOM_BED VALUES (415, 'ho456130', 1, 'Double Bed');
INSERT INTO ROOM_BED VALUES (415, 'ho456130', 1, 'Twin Bed');
INSERT INTO ROOM_BED VALUES (313, 'ho456130', 3, 'Twin Bed');

--Customer Table
insert into customer values('1', 'Andy','Vile','AndyVile@email.com',123,'Y','Y',0,10,0 );
insert into customer values('2', 'Brad','Knight','BradKnight@email.com',123,'N','N',1,0,0 );
insert into customer values('3', 'Evan','Wallis','EvanWallis@email.com',123,'N','N',3,20,2 );
insert into customer values('4', 'Josh','Zell','JoshZell@email.com',123,'N','N',2,25,0 );
insert into customer values('5', 'Jared','James','JaredJames@email.com',123,'Y','N',0,13,1);
insert into customer values('6', 'Justin','Mark','JustinMark@email.com',123,'Y','N',4,14,0);
insert into customer values('7', 'Jon','Jones','JonJones@email.com',123,'N','Y',1,5,0);
insert into customer values('8', 'John','James','JohnJames@email.com',123,'Y','Y',2,4,1);
insert into customer values('9', 'Alex','Freed','AlexFreed@email.com',123,'N','Y',0,2,1);
insert into customer values('10', 'Ahmad','Jabbar','AhmadJabbar@email.com',123,'Y','Y',3,4,2);


--Creditcard Table
insert into creditcard values(5433909571415577,1,'MasterCard','Andy Vile',08,21,'102','N');
insert into creditcard values(4916474828332884,6,'Visa','Justin Mark',07,20,'909','Y');
insert into creditcard values(5494846956864712,6,'MasterCard','Justin Mark',10,20,'218','N');
insert into creditcard values(4485334601172280,6,'Visa','Toby Mark',09,22,'150','N');
insert into creditcard values(4716110409650003,4,'Visa','Josh Zell',07,22,'102','Y');
insert into creditcard values(4539839892763841,4,'Visa','Josh Zell',12,20,'704','N');
insert into creditcard values(4556468652783449,3,'Visa','Evan Wallis',04,22,'628','Y');
insert into creditcard values(5426699102629619,8,'MasterCard','John James',08,21,'138','Y');
insert into creditcard values(4929023799928058,10,'Visa','Ahmad Jabbar',12,23,'339','Y');
insert into creditcard values(4916326873430957,5,'Visa','Jared James',10,22,'221','Y');


--Amenity Table
insert into amenities values (1, 'Free Wifi');
insert into amenities values (2, 'Free Parking');
insert into amenities values (3, 'Refrigerator');
insert into amenities values (4, 'Laundry Service');
insert into amenities values (5, 'Fitness Center');
insert into amenities values (6, 'Bar');
insert into amenities values (7, '24hr Frontdesk');
insert into amenities values (8, 'Air conditioning');
insert into amenities values (9, 'Daily housekeeping');
insert into amenities values (10, 'Breakfast available');


--Ｈotel_amenities  Table
insert into hotel_amenities values('ho163463', 1);
insert into hotel_amenities values('ho163463', 2);
insert into hotel_amenities values('ho163463', 5);
insert into hotel_amenities values('ho163463', 7);
insert into hotel_amenities values('ho416237', 3);
insert into hotel_amenities values('ho416237', 4);
insert into hotel_amenities values('ho63135235', 1);
insert into hotel_amenities values('ho63135235', 8);
insert into hotel_amenities values('ho17618688', 6);
insert into hotel_amenities values('ho17618688', 4);

--Deal Table
INSERT INTO Deal values ('A3B27883948','1-Feb-19','31-May-19','Credit Card',0.15,27);
INSERT INTO Deal values ('B3C49388244','18-Jan-19','18-Mar-19','COUPON',0.2,10);
INSERT INTO Deal values ('S8849375848','27-Mar-19','27-Mar-20','Credit Card',0.1,57);
INSERT INTO Deal values ('B8838929389','09-Sep-19','09-Sep-19','Festiva',0.15,60);
INSERT INTO Deal values ('CB278839483','25-Aug-19','31-Oct-19','COUPON',0.1,20);
INSERT INTO Deal values ('V5156637489','13-Feb-19','20-Feb-19','Festiva',0.3,8);
INSERT INTO Deal values ('K3662738499','01-Apr-19','30-Apr-19','Festiva',0.25,15);
INSERT INTO Deal values ('J2637499902','24-Jan-19','24-Jun-19','COUPON',0.05,33);
INSERT INTO Deal values ('M2637485773','25-Dec-18','31-Dec-19','Credit Card',0.1,40);
INSERT INTO Deal values ('R9892837498','05-Oct-19','05-Nov-19','COUPON',0.35,10);


--Today Price Table
INSERT INTO TODAY_PRICE values (022,'N','ho163463','28-May-19',350);
INSERT INTO TODAY_PRICE values (042,'Y','ho163463','17-Feb-19',500);
INSERT INTO TODAY_PRICE values (042,'N','ho163463','13-Sep-19',400);
INSERT INTO TODAY_PRICE values (431,'Y','ho525177','09-May-19',300);
INSERT INTO TODAY_PRICE values (250,'Y','ho525177','07-Oct-19',150);
INSERT INTO TODAY_PRICE values (250,'N','ho525177','04-Jan-19',250);
INSERT INTO TODAY_PRICE values (250,'N','ho525177','16-Apr-19',250);
INSERT INTO TODAY_PRICE values (5124,'N','ho63135235','15-Jul-19',700);
INSERT INTO TODAY_PRICE values (411,'Y','ho416237','22-Jun-19',590);
INSERT INTO TODAY_PRICE values (411,'Y','ho416237','25-Nov-19',380);
INSERT INTO TODAY_PRICE values (215,'N','ho416237','19-Jun-19',280);
INSERT INTO TODAY_PRICE values (2001,'N','ho63135235','22-Feb-19',750);



--Reserve Table
Insert into RESERVE values (1, '29-APR-19 04.51.04 PM','comfirmed','08-MAY-19','09-MAY-19','creditcard',null,9778115522,1,'ho525177',431);
Insert into RESERVE values (2, '29-MARCH-19 07.45.00 PM','comfirmed','07-JUNE-19','09-JUNE-19','creditcard',null,7412179564,1,'ho63135235',5124);
Insert into RESERVE values (3, '20-APR-19 10.12.10 PM','cancelled','25-APR-19','26-APR-19','deposit','lots of baggage',4315614325,2,'ho525177',250);
Insert into RESERVE values (4, '15-FEB-19 10.12.10 PM','no show','10-MARCH-19','15-MARCH-19','creditcard','late chech in',2390382566,3,'ho163463',022);
Insert into RESERVE values (5, '18-JAN-19 07.18.10 PM','complete','10-APR-19','13-APR-19','deposit','',5867211205,3,'ho416237',215);
Insert into RESERVE values (6, '02-APR-19 01.18.10 PM','comfirmed','15-MAY-19','18-MAY-19','creditcard','',9609033639,4,'ho416237',411);


--Offer_Deal Table
INSERT INTO OFFER_DEAL values ('ho163463','A3B27883948');
INSERT INTO OFFER_DEAL values ('ho163463','B3C49388244');
INSERT INTO OFFER_DEAL values ('ho63135235','S8849375848');
INSERT INTO OFFER_DEAL values ('ho456130','B8838929389');
INSERT INTO OFFER_DEAL values ('ho163463','CB278839483');
INSERT INTO OFFER_DEAL values ('ho63135235','V5156637489');
INSERT INTO OFFER_DEAL values ('ho416237','K3662738499');
INSERT INTO OFFER_DEAL values ('ho416237','J2637499902');
INSERT INTO OFFER_DEAL values ('ho525177','M2637485773');
INSERT INTO OFFER_DEAL values ('ho456130','R9892837498');


--Review Table
INSERT INTO REVIEW VALUES (110878,'ho63135235', 1, 'Exceptional', 'Everything was great. Best location for Cusco, best service, bestview', '','Romance trip','5-May-18');
INSERT INTO REVIEW VALUES (087904,'ho163463', 2, 'Exceptional', 'Very nice hotel and a very convenient location to the Hollywood Bowl and Hollywood Boulevard.', '','Friend trip','24-May-17');
INSERT INTO REVIEW VALUES (104080,'ho163463', 5, 'Very Good', 'Breakfast buffet was delicious!!', '','Romance trip','1-Jan-18');
INSERT INTO REVIEW VALUES (110885,'ho63135235', 8, 'Exceptional', 'Beautiful tranquil place in the midst of a bustling city. Great neighborhood with fabulous restaurants. This hotel is a gem and the staff is truly helpful.', '','Family trip','10-Jul-18');
INSERT INTO REVIEW VALUES (000612,'ho416237', 1, 'Good', 'Breakfast was not worth it. Room got dusty on day 2, firing up my allergies.', '','Romance trip','10-Dec-14');
INSERT INTO REVIEW VALUES (200051,'ho63135235', 8, 'Exceptional', 'My favorite hotel on the trip from the service to the location and condition of the hotel is flawless. Will def return back!', 'Thank you very much!','Romance trip','12-Mar-19');
INSERT INTO REVIEW VALUES (101066,'ho525177', 7, 'Very Good', 'Hotel was nice, room very good, fair price.','', 'Business trip','1-Feb-18');
INSERT INTO REVIEW VALUES (100280,'ho525177', 10, 'Very Good', 'Really nice and clean hotel. Liked the complimentary small dinner buffet at the lounge.','', 'Friend trip','10-Jan-18');
INSERT INTO REVIEW VALUES (200199,'ho456130', 2, 'Very Good', 'The room was nothing to write home about, it was pretty Basic. BUT, it was clean, comfortable the location was great.','', 'Family trip','19-Apr-19');

--Apply Deal Table
INSERT INTO APPLY_Deal values (022,'ho163463','A3B27883948','28-May-19', 298);
INSERT INTO APPLY_Deal values (042,'ho163463','B3C49388244','17-Feb-19',400);
INSERT INTO APPLY_Deal values (5124,'ho63135235','S8849375848','15-Jul-19',360);
INSERT INTO APPLY_Deal values (042,'ho163463','CB278839483','13-Sep-19',135);
INSERT INTO APPLY_Deal values (2001,'ho63135235','V5156637489','22-Feb-19',175);
INSERT INTO APPLY_Deal values (215,'ho416237','J2637499902','19-Jun-19',665);
INSERT INTO APPLY_Deal values (250,'ho525177','M2637485773','07-Oct-19',531);
INSERT INTO APPLY_Deal values (250,'ho525177','M2637485773','04-Jan-19',531);
INSERT INTO APPLY_Deal values (250,'ho525177','M2637485773','16-Apr-19',531);





    






--Part 4. Procedures
--Procedure a. Set Preferred Credit Card
create or replace PROCEDURE setPreferredCard (this_card_num IN creditcard.card_num%TYPE, member_id_in IN creditcard.member_id%TYPE) 
    IS
        card_num_out creditcard.member_id%TYPE;
        cursor c1 is
        select card_num from creditcard where member_id = member_id_in and  preferred = 'Y';
    BEGIN
        open c1;
        fetch c1 into card_num_out;
        update creditcard set preferred = 'N' where card_num = card_num_out;
        update creditcard set preferred = 'Y' where card_num = this_card_num;
    END;

BEGIN
    setPreferredCard(4916474828332884,6);
END;

--Procedure b. If availibility of room = 'N', today's price will be 'N'
create or replace PROCEDURE roomPriceAvailability(hotel_id_in in room.hotel_id%type, room_id_in in room.room_id%type) 
    IS
        thisPrice today_price%ROWTYPE;
        cursor c1 is
        select * from today_price where room_id = room_id_in and hotel_id = hotel_id_in and price_availability = 'Y'
        for update;
    BEGIN
        OPEN c1;
        LOOP
        FETCH c1 INTO thisPrice;
        EXIT WHEN c1%NOTFOUND;
            IF (thisPrice.price_availability = 'Y') THEN
                update today_price set price_availability = 'N' WHERE CURRENT OF c1;
            END IF;
        END LOOP;
        close c1;
    END;
    
BEGIN     
    roomPriceAvailability('ho525177',250);
END;









--Trigger a. Delete related tuples before deleting customer
create or replace TRIGGER customer_delete
BEFORE DELETE ON customer FOR EACH ROW
    BEGIN
    DELETE FROM creditcard WHERE member_id = :OLD.member_id;
    DELETE FROM review WHERE  member_id = :OLD.member_id;
    DELETE FROM reserve WHERE  member_id = :OLD.member_id;
END;

SELECT * FROM creditcard;
DELETE FROM Customer where member_ID=1;


--Trigger b. Delete a Tuple of Apply_Deal relation before deleting Deal
CREATE OR REPLACE TRIGGER deal_delete 
BEFORE DELETE ON DEAL FOR EACH ROW
  BEGIN
    DELETE FROM APPLY_DEAL WHERE Deal_ID = :OLD.Deal_ID;
    DELETE FROM OFFER_DEAL WHERE Deal_ID = :OLD.Deal_ID;
END;

SELECT * FROM APPLY_DEAL;
SELECT * FROM DEAL;

DELETE FROM DEAL where DEAL_ID = 'A3B27883948';


--Trigger c. Delete or Insert a tuple of Apply_Deal relation after changing Deal
CREATE OR REPLACE TRIGGER deal_change BEFORE UPDATE ON DEAL FOR EACH ROW 
  DECLARE 
    thisDayPrise   TODAY_PRICE%ROWTYPE;
    finalPrice  TODAY_PRICE.ORIGINAL_PRICE%TYPE;
    CURSOR      PriceForDiscount IS
        SELECT * FROM TODAY_PRICE WHERE Hotel_ID IN
            (SELECT Hotel_ID  FROM OFFER_DEAL WHERE Deal_ID = :new.Deal_ID)
        FOR UPDATE;       
  BEGIN
    OPEN PriceForDiscount;
    LOOP 
        FETCH PriceForDiscount INTO thisDayPrise;
        EXIT WHEN PriceForDiscount%NOTFOUND;           
                IF ((thisDayPrise.PRICE_Date > :new.Start_date) AND (thisDayPrise.PRICE_Date < :new.End_date)) THEN
                    finalPrice := thisDayPrise.ORIGINAL_PRICE * (1 - :new.Discount_amount);
                    INSERT INTO APPLY_DEAL VALUES(thisDayPrise.Room_ID, thisDayPrise.Hotel_ID, :new.Deal_ID, thisDayPrise.Price_Date, finalPrice);                    
                ELSIF ((thisDayPrise.PRICE_Date < :new.Start_date) OR (thisDayPrise.PRICE_Date > :new.End_date)) THEN
                    DELETE FROM APPLY_DEAL WHERE Deal_ID = :new.Deal_ID;                    
                END IF;
    END LOOP;
    CLOSE PriceForDiscount;
END;

UPDATE 	DEAL
    SET Start_date = '01-Apr-19', End_date = '30-Jun-19' 
    WHERE	Deal_ID = 'K3662738499';














--Delete Table
drop table reserve;
drop table room_bed;
drop table room;
drop table bed;
drop table hotel_amenities;
drop table amenities;
drop table review;
drop table offer_deal;
drop table deal;
drop table hotel;
drop table today_price;
drop table creditcard;
drop table customer;





    



