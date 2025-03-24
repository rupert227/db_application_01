<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="records.Reservations"%>
<%@page import="tables.ReservationsTable"%>
<%@page import="records.GuestRecords"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transaction History</title>
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
        <% int guestID = Integer.parseInt(request.getParameter("guestID")); %>
        
        <h1>Transaction History For Guest <% out.println(guestID); %></h1>
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
                        table.getHistory(guestID);
                        
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:00");

                    for (Reservations record : table.getRecords()){
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
            <br><br>
    </head>
    <body>
    <form action="/db_application_01/view_records/c_view_reservation_record/view_reservation.jsp" method="GET">
        <button type="submit">Back</button>
    </form>
    </body>
</html>