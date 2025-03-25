<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="tables.RefRoomTable, records.RefRoomTypes" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Update Room Type Information</title>
        <meta charset="UTF-8">
    </head>
    <body>
    <div align="center">
        <jsp:useBean id="refRoomTable" class="tables.RefRoomTable" scope="page" />

        <%
            Class.forName("com.mysql.cj.jdbc.Driver");  // Load MySQL driver
            refRoomTable.setRecords();  // Fetch records from refRoomTypes table

            if (refRoomTable.getRecords().isEmpty()) {
        %>
            <h3>No room type records available for update.</h3>
        <%
            } else {
        %>
            <h1>Update Room Type Information</h1>

            <form action="Update2.jsp" method="POST">
                <label for="roomType">Select Room Type to Update:</label>
                <select name="roomType">
                    <%
                        for (RefRoomTypes room : refRoomTable.getRecords()) {
                    %>
                        <option value="<%= room.getRoomType().name() %>">
                            <%= room.getRoomType().getRoomType() %>
                        </option>
                    <%
                        }
                    %>
                </select><br><br>

                <label for="roomPrice">New Room Price:</label>
                <input type="number" step="0.01" name="roomPrice" required><br><br>

                <label for="maxCapacity">New Max Capacity:</label>
                <input type="number" name="maxCapacity" min="1" required><br><br>

                <input type="submit" value="Update Room Type">
            </form>

            <%
                // Handle form submission and update records
                if (request.getMethod().equalsIgnoreCase("POST")) {
                    String roomType = request.getParameter("roomType");
                    float newPrice = Float.parseFloat(request.getParameter("roomPrice"));
                    int newCapacity = Integer.parseInt(request.getParameter("maxCapacity"));

                    // Update the database through the RefRoomTable class
                    RefRoomTypes.RoomType selectedType = RefRoomTypes.RoomType.valueOf(roomType);
                    boolean success = refRoomTable.updateRoomType(selectedType, newPrice, newCapacity);

                    if (success) {
                        out.println("<h3>Room type updated successfully!</h3>");
                    } else {
                        out.println("<h3>Error: Failed to update the room type.</h3>");
                    }
                }
            %>
        <%
            }
        %>

        <br>
        <form action="room_mgmt.html">
            <input type="submit" value="Back To Room Transactions">
        </form>
    </div>
    </body>
</html>
