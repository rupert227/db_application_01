-- Insert into refRoomTypes
INSERT INTO refRoomTypes (roomType, roomPrice, maxCapacity) VALUES
('Standard', 80.00, 1),
('Double', 120.00, 2),
('Suite', 200.00, 4);

-- Insert into roomRecords
INSERT INTO roomRecords (roomType, availability) VALUES
('Single', 'Available'),
('Single', 'Occupied'),
('Single', 'Available'),
('Double', 'Available'),
('Double', 'Occupied'),
('Double', 'Available'),
('Suite', 'Occupied'),
('Suite', 'Available'),
('Suite', 'Available'),
('Suite', 'Occupied');

-- Insert into guestRecords
INSERT INTO guestRecords (firstName, lastName, email, telNo) VALUES
('Alice', 'Johnson', 'alice.johnson@email.com', '1234567890'),
('Bob', 'Smith', 'bob.smith@email.com', '1234567891'),
('Charlie', 'Brown', 'charlie.brown@email.com', '1234567892'),
('David', 'Lee', 'david.lee@email.com', '1234567893'),
('Emma', 'Wilson', 'emma.wilson@email.com', '1234567894'),
('Frank', 'Harris', 'frank.harris@email.com', '1234567895'),
('Grace', 'Davis', 'grace.davis@email.com', '1234567896'),
('Henry', 'White', 'henry.white@email.com', '1234567897'),
('Isabella', 'Martinez', 'isabella.martinez@email.com', '1234567898'),
('Jack', 'Taylor', 'jack.taylor@email.com', '1234567899');

-- Insert into reservationRecords
INSERT INTO reservationRecords (bookRefID, roomRefID, guestCount, checkInDate, checkOutDate, reservationStatus) VALUES
(1, 2, 1, '2025-03-10 14:00:00', '2025-03-12 10:00:00', 'Checked-out'),
(2, 4, 2, '2025-03-15 14:00:00', '2025-03-18 10:00:00', 'Checked-in'),
(3, 6, 2, '2025-03-17 14:00:00', '2025-03-19 10:00:00', 'Coroomrecordsnfirmed'),
(4, 7, 4, '2025-03-12 14:00:00', '2025-03-16 10:00:00', 'Checked-out'),
(5, 8, 3, '2025-03-20 14:00:00', '2025-03-23 10:00:00', 'Confirmed'),
(6, 9, 1, '2025-03-11 14:00:00', '2025-03-14 10:00:00', 'Cancelled'),
(7, 3, 1, '2025-03-18 14:00:00', '2025-03-21 10:00:00', 'Confirmed'),
(8, 5, 2, '2025-03-14 14:00:00', '2025-03-16 10:00:00', 'Checked-out'),
(9, 10, 4, '2025-03-22 14:00:00', '2025-03-25 10:00:00', 'Confirmed'),
(10, 1, 1, '2025-03-09 14:00:00', '2025-03-11 10:00:00', 'Checked-out');

-- Insert into invoiceRecords
INSERT INTO invoiceRecords (reserveID, bookRefID, paymentStatus, totalCost, paymentMethod, paymentDate) VALUES
(1, 1,'Paid', 160.00, 'Credit Card', '2025-03-10 16:00:00'),
(2, 2, 'Paid', 360.00, 'Debit Card', '2025-03-15 16:00:00'),
(3, 3, 'Paid', 240.00, 'Cash', '2025-03-17 16:00:00'),
(4, 4, 'Paid', 800.00, 'Credit Card', '2025-03-12 16:00:00'),
(5, 5, 'Paid', 600.00, 'Debit Card', '2025-03-20 16:00:00'),
(6, 6, 'Refunded', 0.00, 'Cash', '2025-03-11 16:00:00'),
(7, 7, 'Paid', 80.00, 'Credit Card', '2025-03-18 16:00:00'),
(8, 8, 'Paid', 240.00, 'Check', '2025-03-14 16:00:00'),
(9, 9, 'Paid', 800.00, 'Credit Card', '2025-03-22 16:00:00'),
(10, 10, 'Paid', 160.00, 'Debit Card', '2025-03-09 16:00:00');
