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
                "SELECT r.room_numberID, r.room_type, r.availability, t.room_price, r.max_capacity " +
                "FROM room_record r INNER JOIN refRoomTypes t ON r.room_type = t.room_type"
            );

            ResultSet records = query.executeQuery();

            while (records.next()) {
                int roomID = records.getInt("room_numberID");
                String roomTypeStr = records.getString("room_type");
                String availabilityStr = records.getString("availability");
                double price = records.getDouble("room_price");
                int maxCapacity = records.getInt("max_capacity");

                RefRoomTypes.RoomType roomType = RefRoomTypes.RoomType.valueOf(roomTypeStr.toUpperCase());
                RoomRecords.Availability availability = RoomRecords.Availability.fromString(availabilityStr);

                roomRecords.add(new RoomRecords(roomID, roomType, availability, price, maxCapacity));
            }

            return true;

        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
    }



}