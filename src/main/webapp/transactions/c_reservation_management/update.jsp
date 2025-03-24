<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="records.Reservations"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            body{
                text-align: center;
            }
        </style>
        <title>Update Status</title>
    </head>
    <body>
        <%
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                Reservations reservation = new Reservations();

                int reserveID = Integer.parseInt(request.getParameter("reserveID"));
                String status = request.getParameter("reservationStatus");

                reservation.setReserveID(reserveID);
                
                if(status.equalsIgnoreCase("checkIn")){
                    reservation.checkIn();
        %>
                <h1>Successfully Checked-in!</h1>
        <%
                } else if(status.equalsIgnoreCase("checkOut")){
                    reservation.checkOut();
        %> 
                <h1>Successfully Checked-out!</h1>
        <%
                } else if(status.equalsIgnoreCase("confirm")){
                    reservation.confirm();
        %>
                <h1>Successfully Confirmed!</h1>
        <%
                } else if(status.equalsIgnoreCase("pending")){
                    reservation.pending();
        %>
                <h1>Reservation is now Pending!</h1>
        <%
                } else if(status.equalsIgnoreCase("cancel")){
                    reservation.cancel();
        %>
                <h1>Reservation Cancelled!</h1>
        <%
                } else if(status.equalsIgnoreCase("delete")){
                    reservation.deleteRecord(reservation);
        %>
                <h1>Reservation Deleted!</h1>
        <%
                }
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
