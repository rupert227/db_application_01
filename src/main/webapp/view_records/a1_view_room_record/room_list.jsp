
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="tables.RoomTable, tables.ReservationsTable, records.RoomRecords, records.Reservations" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Room Reservation History</title>
    </head>
    <body>
        <jsp:useBean id="rt" class="tables.RoomTable" scope="page" />
        <jsp:useBean id="reservationsTable" class="tables.ReservationsTable" scope="page" />

        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            rt.setRecords();  // Load room records
            reservationsTable.setRecords();  // Load reservation records
        %>

        <h2>View Reservation History for a Room</h2>

        <!-- Drop-down form for selecting a room -->
        <form action="room_list.jsp" method="POST">
            <label for="roomID">Select a Room:</label>
            <select name="roomID">
                <%
                    // Populate drop-down with room IDs and types
                    for (RoomRecords room : rt.getRecords()) {
                %>
                    <option value="<%= room.getRoomID() %>">
                        Room <%= room.getRoomID() %> - <%= room.getType() %>
                    </option>
                <%
                    }
                %>
            </select>
            <input type="submit" value="View Reservations">
        </form>

        <%
            // Display reservations for the selected room after form submission
            if (request.getMethod().equalsIgnoreCase("POST")) {
                int selectedRoomID = Integer.parseInt(request.getParameter("roomID"));
        %>

        <h3>Reservation History for Room ID <%= selectedRoomID %>:</h3>
        <table border="1" style="border-collapse: collapse;" cellpadding="5">
            <tr>
                <th>Reservation ID</th>
                <th>Guest ID</th>
                <th>Guest Count</th>
                <th>Check-In Date</th>
                <th>Check-Out Date</th>
                <th>Status</th>
            </tr>
            <%
                boolean hasReservations = false;
                for (Reservations reservation : reservationsTable.getRecords()) {
                    if (reservation.getRoomRefID() == selectedRoomID) {
                        hasReservations = true;
            %>
            <tr>
                <td align="center"><%= reservation.getReserveID() %></td>
                <td align="center"><%= reservation.getBookRefID() %></td>
                <td align="center"><%= reservation.getGuestCount() %></td>
                <td align="center"><%= reservation.getCheckInDate() %></td>
                <td align="center"><%= reservation.getCheckOutDate() %></td>
                <td align="center"><%= reservation.getReservationStatus().getReservationStatus() %></td>
            </tr>
            <%
                    }
                }
                if (!hasReservations) {
            %>
                <tr>
                    <td colspan="6" align="center"><em>No reservations found for this room.</em></td>
                </tr>
            <%
                }
            }
            %>
        </table>

        <br><form action="../../index.html">
            <input type="submit" value="Back To Main Menu">
        </form>
    </body>
</html>
