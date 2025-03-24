<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="records.Reservations"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            body {
                text-align: center;
            }
        </style>
        <title>Reservation Record Management</title>
    </head>
    <body>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

                int bookRefID = Integer.parseInt(request.getParameter("bookRefID"));
                int roomNumberID = Integer.parseInt(request.getParameter("roomNumberID"));
                int guestCount = Integer.parseInt(request.getParameter("guestCount"));
                LocalDateTime checkInDate = LocalDateTime.parse(request.getParameter("checkInDate").replace('T', ' ') + ":00", formatter);
                LocalDateTime checkOutDate = LocalDateTime.parse(request.getParameter("checkOutDate").replace('T', ' ') + ":00", formatter);
                String reservationStatus = request.getParameter("reservationStatus");
                
                Reservations reservation = new Reservations(bookRefID, roomNumberID, guestCount, checkInDate, checkOutDate, reservationStatus);
                reservation.insertRecord(reservation);
        %>
            <h1>Reservation Successfully Created!</h1>
        <%
            } catch(Exception e){
        %>
            <h1>Error: <%out.println(e.getMessage());%></h1>
        <%
            }
        %>
    </body>
    <form action="/db_application_01/transactions/c_reservation_management/reservation_page.jsp" method="GET">
        <button type="submit">Back to Menu</button>
    </form>
</html>
