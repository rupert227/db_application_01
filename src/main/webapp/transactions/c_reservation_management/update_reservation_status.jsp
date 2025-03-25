<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="records.Reservations"%>
<%@page import="tables.ReservationsTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            body{
                text-align: center;
            }
            table{
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td{
                border: 1px solid black;
            }
            th, td{
                padding: 10px;
                text-align: left;
            }
        </style>
    </head>
    <body>
        <h1>Select a Record To Update</h1>
        <form action="update.jsp" method="post">
            <table>
                <thead>
                    <tr>
                        <th>Reservation ID</th>
                        <th>Guest ID</th>
                        <th>Room ID</th>
                        <th>Guest Count</th>
                        <th>Check-in Date</th>
                        <th>Check-out Date</th>
                        <th>Reservation Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        ReservationsTable table = new ReservationsTable();
                        table.setRecords();
                        
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:00");

                        for(Reservations record : table.getRecords()){
                    %>
                    <tr>
                        <td><%= record.getReserveID()%></td>
                        <td><%= record.getBookRefID()%></td>
                        <td><%= record.getRoomRefID()%></td>
                        <td><%= record.getGuestCount()%></td>
                        <td><%= record.getCheckInDate().format(formatter)%></td>
                        <td><%= record.getCheckOutDate().format(formatter)%></td>
                        <td><%= record.getReservationStatus().getReservationStatus()%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <title>Update Reservation Status</title>
        
    </head>
    <body>
        <form action="update.jsp" method="post">
            <h1>Update a Reservation Status</h1>
            <label for="guestID">Enter The Reservation ID:</label><br>
            <input type="number" id="reserveID" name="reserveID" required><br><br>
            <label for="reservationStatus">Reservation Status</label><br>
                <select id="reservationStatus" name="reservationStatus" required>
                <option value="pending">Pending</option>
                <option value="confirm">Confirm</option>
                <option value="checkIn">Check-in</option>
                <option value="checkOut">Check-out</option>
                <option value="cancel">Cancel</option>
            </select>
            <br><br>
            <button type="submit">Submit</button>
        </form>
        <br><br>
        <form action="/db_application_01/transactions/c_reservation_management/reservation_page.jsp" method="GET">
            <button type="submit">Back to Menu</button>
        </form>
    </body>
</html>
