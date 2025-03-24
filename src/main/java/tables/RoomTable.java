package tables;

import records.RoomRecords;
import records.RefRoomTypes;
import java.sql.*;
import java.util.*;

public class RoomTable extends Tables {

    ArrayList<RoomRecords> roomRecords = new ArrayList<RoomRecords>();

    public RoomTable () {

    }

    /**
     * 
     *obtain all records from the room records table
     * instantiate and add all objects to the ArrayList
     */
    @Override
    public boolean setRecords() {
        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            PreparedStatement query = connection.prepareStatement(
                "SELECT r.roomNumberID, r.roomType, r.availability, t.roomPrice, t.maxCapacity " +
                "FROM roomRecords r INNER JOIN refRoomTypes t ON r.roomType = t.roomType " +
                "ORDER BY r.roomNumberID ASC"
            );

            ResultSet records = query.executeQuery();
    
            while (records.next()) {
                int roomID = records.getInt("roomNumberID");
                String roomTypeStr = records.getString("roomType");
                String availabilityStr = records.getString("availability");
                float price = records.getFloat("roomPrice");
                int maxCapacity = records.getInt("maxCapacity");
    
                // Adjusting enum case to avoid mismatches
                RefRoomTypes.RoomType roomType = RefRoomTypes.RoomType.valueOf(roomTypeStr.toUpperCase());
                RoomRecords.Availability availability = RoomRecords.Availability.fromString(availabilityStr);
    
                roomRecords.add(new RoomRecords(roomID, roomType, availability, price, maxCapacity));
            }
    
            return true;
    
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        } catch (IllegalArgumentException e) {
            System.out.println("Enum Error: Mismatch between database value and enum definition. " + e.getMessage());
            return false;
        }
    }
    

    public boolean insertNewRoom(RoomRecords newRoom) {
        String sqlStatement = "INSERT INTO roomRecords (roomType, availability) VALUES (?, ?)";
    
        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            PreparedStatement insert = connection.prepareStatement(sqlStatement, Statement.RETURN_GENERATED_KEYS);
    
            insert.setString(1, newRoom.getType().getRoomType());  // Insert exact string ("Standard", "Double", "Suite")
            insert.setString(2, newRoom.getAvailability().getAvail());  // Insert availability ("Available", etc.)
    
            int rowsAffected = insert.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet generatedKeys = insert.getGeneratedKeys();
                if (generatedKeys.next()) {
                    newRoom.setRoomID(generatedKeys.getInt(1));  // Retrieve and set generated roomNumberID
                }
                return fetchAndAddLatestRecord();  // Fetch latest record and update ArrayList
            }
            return false;
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
    }
    
    
    private boolean fetchAndAddLatestRecord() {
        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            String sql = "SELECT r.roomNumberID, r.roomType, r.availability, t.roomPrice, t.maxCapacity " +
                         "FROM roomRecords r INNER JOIN refRoomTypes t ON r.roomType = t.roomType " +
                         "ORDER BY r.roomNumberID DESC LIMIT 1;";
            PreparedStatement query = connection.prepareStatement(sql);
            ResultSet records = query.executeQuery();
    
            if (records.next()) {
                int roomID = records.getInt("roomNumberID");
                String roomTypeStr = records.getString("roomType");
                String availabilityStr = records.getString("availability");
                float price = records.getFloat("roomPrice");
                int maxCapacity = records.getInt("maxCapacity");
    
                RefRoomTypes.RoomType roomType = RefRoomTypes.RoomType.valueOf(roomTypeStr.toUpperCase());
                RoomRecords.Availability availability = RoomRecords.Availability.fromString(availabilityStr);
    
                // Add the fetched room record to the ArrayList
                roomRecords.add(new RoomRecords(roomID, roomType, availability, price, maxCapacity));
                System.out.println("Latest room added to ArrayList.");
                return true;
            }
            return false;
        } catch (SQLException e) {
            System.out.println("SQL Error while fetching latest record: " + e.getMessage());
            return false;
        }
    }
    






    public boolean updateRoomAvailability(int roomID, RoomRecords.Availability availability) {
        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            // Update in database
            String sql = "UPDATE roomRecords SET availability = ? WHERE roomNumberID = ?";
            PreparedStatement update = connection.prepareStatement(sql);
            update.setString(1, availability.getAvail());
            update.setInt(2, roomID);
            int rowsAffected = update.executeUpdate();

            // Update in in-memory ArrayList if DB update succeeds
            if (rowsAffected > 0) {
                for (RoomRecords room : roomRecords) {
                    if (room.getRoomID() == roomID) {
                        room.setAvailability(availability);
                        break;
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteRoom(int roomID) {
        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            // Delete from database
            String sql = "DELETE FROM roomRecords WHERE roomNumberID = ?";
            PreparedStatement delete = connection.prepareStatement(sql);
            delete.setInt(1, roomID);
            int rowsAffected = delete.executeUpdate();

            // Remove from ArrayList if DB deletion succeeds
            if (rowsAffected > 0) {
                roomRecords.removeIf(room -> room.getRoomID() == roomID);
                return true;
            }
            return false;
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
    }


    public ArrayList<RoomRecords> getRecords() {
        return roomRecords;
    }



}