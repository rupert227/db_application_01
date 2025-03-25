<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="tables.RoomTable, records.RoomRecords, records.RefRoomTypes" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Create Room</title>
    </head>
    <body>
    <div align="center">
        <jsp:useBean id="rt" class="tables.RoomTable" scope="page" />

        <%
            Class.forName("com.mysql.cj.jdbc.Driver");  // Load MySQL driver
            rt.setRecords();  // Load existing room records
        %>

        <h2>Create a New Room</h2>

        <form action="Create.jsp" method="POST">
            <label for="roomType">Room Type:</label>
            <select name="roomType">
                <option value="Standard">Standard</option>
                <option value="Double">Double</option>
                <option value="Suite">Suite</option>
            </select><br><br>

            <input type="submit" value="Add Room">
        </form>

        <%
            // Check if the form was submitted
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String roomType = request.getParameter("roomType");

                // Map string to enum using getRoomType()
                RefRoomTypes.RoomType selectedRoomType = null;
                for (RefRoomTypes.RoomType rtEnum : RefRoomTypes.RoomType.values()) {
                    if (rtEnum.getRoomType().equals(roomType)) {
                        selectedRoomType = rtEnum;
                        break;
                    }
                }

                if (selectedRoomType == null) {
                    throw new IllegalArgumentException("Invalid room type: " + roomType);
                }

                // Create RoomRecords object without unused fields (maxCapacity, price)
                RoomRecords newRoom = new RoomRecords(0, selectedRoomType, RoomRecords.Availability.AVAILABLE, 0, 0); // Keep only relevant fields

                if (rt.insertNewRoom(newRoom)) {
                    out.println("<h3>Room added successfully!</h3>");
                } else {
                    out.println("<h3>Error: Failed to add the room.</h3>");
                }
            }
        %>

        <br><form action="room_mgmt.html">
            <input type="submit" value="Back To Room Transactions">
        </form>
    </div>
    </body>
</html>
