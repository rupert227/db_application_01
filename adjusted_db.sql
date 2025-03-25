
CREATE DATABASE IF NOT EXISTS hotel_db;
USE hotel_db;

CREATE TABLE refRoomTypes (
    roomType ENUM('Standard', 'Double', 'Suite') PRIMARY KEY NOT NULL,

    roomPrice DECIMAL(8,2) NOT NULL,
    maxCapacity INT NOT NULL
);

CREATE TABLE roomRecords (
	roomNumberID INT PRIMARY KEY AUTO_INCREMENT,
    
    roomType ENUM('Standard', 'Double', 'Suite') NOT NULL,
    availability ENUM('Available', 'Occupied', 'Maintenance') 
		DEFAULT 'Available',
	CONSTRAINT FOREIGN KEY(roomType)
		REFERENCES refRoomTypes(roomType)
);

CREATE TABLE guestRecords (
	guestID INT PRIMARY KEY AUTO_INCREMENT,
    
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    telNo VARCHAR(15) NOT NULL
);

CREATE TABLE reservationRecords (
	reserveID INT PRIMARY KEY AUTO_INCREMENT,
	bookRefID INT NOT NULL, 
    roomRefID INT NOT NULL,
    
    guestCount INT NOT NULL,
    checkInDate DATETIME NOT NULL, 
    checkOutDate DATETIME NOT NULL,
    reservationStatus ENUM('Pending', 'Confirmed', 
		'Checked-in', 'Checked-out', 'Cancelled') NOT NULL,
    
	CONSTRAINT FOREIGN KEY(bookRefID) 
		REFERENCES guestRecords(GuestID),
	CONSTRAINT FOREIGN KEY(roomRefID) 
		REFERENCES roomRecords(roomNumberID)
);

CREATE TABLE invoiceRecords (
	paymentID INT PRIMARY KEY AUTO_INCREMENT,
    reserveID INT NOT NULL,
    bookRefID INT NOT NULL, 
    
	paymentStatus ENUM('Refunded', 'Paid') 
		NOT NULL DEFAULT 'Paid',
    totalCost DECIMAL(8,2) NOT NULL,
	paymentMethod ENUM('Credit Card', 'Debit Card', 'Cash', 'Check') NOT NULL,
    paymentDate DATETIME NOT NULL,
	CONSTRAINT FOREIGN KEY(reserveID) 
		REFERENCES reservationRecords(reserveID),
    CONSTRAINT FOREIGN KEY(bookRefID) 
		REFERENCES guestRecords(guestID)
);