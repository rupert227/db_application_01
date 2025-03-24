
INSERT INTO refRoomTypes (roomType, roomPrice, maxCapacity)
VALUES 
  ('Standard', 100.00, 2),
  ('Double', 150.00, 4),
  ('Suite', 250.00, 6);

ALTER TABLE roomRecords AUTO_INCREMENT = 1;
-- Insert 5 sample room records
INSERT INTO roomRecords (roomType, availability)
VALUES
  ('Standard', 'Available'),  
  ('Double', 'Occupied'),        
  ('Suite', 'Maintenance'),       
  ('Standard', 'Occupied'),      
  ('Suite', 'Available');         


