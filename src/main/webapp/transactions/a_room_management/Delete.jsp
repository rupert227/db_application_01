<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="tables.RoomTable, records.RoomRecords" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Delete Room</title>
    </head>
    <body>
        <jsp:useBean id="rt" class="tables.RoomTable" scope="page" />

        <%
            Class.forName("com.mysql.cj.jdbc.Driver");  // Load MySQL driver
            rt.setRecords();  // Load existing room records
        %>

        <h2>Delete a Room Record</h2>

        <%
            // Check if the form was submitted
            if (request.getMethod().equalsIgnoreCase("POST")) {
                int roomID = Integer.parseInt(request.getParameter("roomID"));

                // Delete the room record using RoomTable's deleteRoom method
                if (rt.deleteRoom(roomID)) {
                    out.println("<h3>Room deleted successfully!</h3>");
                } else {
                    out.println("<h3>Error: Failed to delete the room.</h3>");
                }
            }
        %>

        <form action="Delete.jsp" method="POST">
            <label for="roomID">Select Room ID to Delete:</label>
            <select name="roomID">
                <%
                    for (RoomRecords room : rt.getRecords()) {
                        out.println("<option value='" + room.getRoomID() + "'>" + room.getRoomID() + " - " + room.getType() + "</option>");
                    }
                %>
            </select><br><br>

            <input type="submit" value="Delete Room">
        </form>

        <br><form action="room_mgmt.html">
            <input type="submit" value="Back To Room Transactions">
        </form>
    </body>
</html>
