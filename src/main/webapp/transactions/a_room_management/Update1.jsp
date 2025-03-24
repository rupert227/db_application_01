<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="tables.RoomTable, records.RoomRecords" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Update Room Availability</title>
    </head>
    <body>
        <jsp:useBean id="rt" class="tables.RoomTable" scope="page" />

        <%
            Class.forName("com.mysql.cj.jdbc.Driver");  // Load MySQL driver
            rt.setRecords();  // Load existing room records
        %>

        <h2>Update Room Availability</h2>

        <%
            // Check if the form was submitted
            if (request.getMethod().equalsIgnoreCase("POST")) {
                int roomID = Integer.parseInt(request.getParameter("roomID"));
                String availability = request.getParameter("availability");

                RoomRecords.Availability selectedAvailability = RoomRecords.Availability.fromString(availability);

                // Update the room availability using the method in RoomTable
                if (rt.updateRoomAvailability(roomID, selectedAvailability)) {
                    out.println("<h3>Room availability updated successfully!</h3>");
                } else {
                    out.println("<h3>Error: Failed to update room availability.</h3>");
                }
            }
        %>

        <form action="Update1.jsp" method="POST">
            <label for="roomID">Select Room ID:</label>
            <select name="roomID">
                <%
                    for (RoomRecords room : rt.getRecords()) {
                        out.println("<option value='" + room.getRoomID() + "'>" + room.getRoomID() + " - " + room.getType() + "</option>");
                    }
                %>
            </select><br><br>

            <label for="availability">Select Availability:</label>
            <select name="availability">
                <option value="Available">Available</option>
                <option value="Occupied">Occupied</option>
                <option value="Maintenance">Maintenance</option>
            </select><br><br>

            <input type="submit" value="Update Availability">
        </form>

        <br><form action="room_mgmt.html">
            <input type="submit" value="Back To Room Transactions">
        </form>
    </body>
</html>
