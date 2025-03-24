package tables;

import records.RefRoomTypes;
import java.sql.*;
import java.util.ArrayList;

public class RefRoomTable extends Tables {

    ArrayList<RefRoomTypes> roomTypesList = new ArrayList<>();

    public RefRoomTable() {
        super();
    }

    // Retrieve all records from the database and store them in the ArrayList
    public boolean setRecords() {
        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            String sql = "SELECT * FROM refRoomTypes";
            PreparedStatement query = connection.prepareStatement(sql);
            ResultSet records = query.executeQuery();

            while (records.next()) {
                String roomType = records.getString("roomType");
                float roomPrice = records.getFloat("roomPrice");
                int maxCapacity = records.getInt("maxCapacity");

                RefRoomTypes room = new RefRoomTypes(
                    RefRoomTypes.RoomType.valueOf(roomType.toUpperCase()),
                    roomPrice, maxCapacity
                );
                roomTypesList.add(room);
            }
            return true;
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
    }

    // **Method to update room type in the database and the ArrayList**
    public boolean updateRoomType(RefRoomTypes.RoomType roomType, float newPrice, int newCapacity) {
        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            String sql = "UPDATE refRoomTypes SET roomPrice = ?, maxCapacity = ? WHERE roomType = ?";
            PreparedStatement update = connection.prepareStatement(sql);
            update.setFloat(1, newPrice);
            update.setInt(2, newCapacity);
            update.setString(3, roomType.getRoomType());
            int rowsAffected = update.executeUpdate();

            // If update is successful, update in-memory list
            if (rowsAffected > 0) {
                for (RefRoomTypes room : roomTypesList) {
                    if (room.getRoomType().equals(roomType)) {
                        room.setRoomPrice(newPrice);
                        room.setMaxCapacity(newCapacity);
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

    public ArrayList<RefRoomTypes> getRecords() {
        return roomTypesList;
    }
}
