package tables;

import records.RefRoomTypes;
import java.sql.*;
import java.util.ArrayList;

public class RefRoomTable extends Tables {

    ArrayList<RefRoomTypes> roomTypesList = new ArrayList<>();

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

    public ArrayList<RefRoomTypes> getRecords() {
        return roomTypesList;
    }
}
