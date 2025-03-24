<%-- 
    Document   : createInvoice
    Created on : 24 Mar 2025, 22.45.15
    Author     : ODie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, java.time.LocalDateTime, records.*, tables.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Invoice</title>
    </head>
    <body>
        <jsp:useBean id="rt" class="tables.ReservationsTable" scope="page"/>
        <jsp:useBean id="gt" class="tables.GuestsTable" scope="page"/>
        <jsp:useBean id="room" class="tables.RoomTable" scope="page"/>
        
        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            rt.setRecords();
            gt.setRecords();
            room.setRecords();
            int v_guestID = Integer.parseInt(request.getParameter("guestID"));
            int v_reserveIndex = 0;
            int v_guestIndex = 0;
            double roomPrice = 0;
            double totalCost = 0;
            
            if(request.getParameter("reserveIndex") != null)
                v_reserveIndex = Integer.parseInt(request.getParameter("reserveIndex"));
            
            for(int i = 0; i < gt.getRecords().size(); i++)
                if(gt.getRecords().get(i).getGuestID() == rt.getRecords().get(v_reserveIndex).getBookRefID()) {
                    v_guestIndex = i;
                    break;
            }
            
            for(int i = 0; i < room.getRecords().size(); i++)
                if(room.getRecords().get(i).getRoomID() == rt.getRecords().get(v_reserveIndex).getBookRefID()) {
                    roomPrice = room.getRecords().get(i).getPrice();
                    break;
            }
            
            totalCost = rt.getRecords().get(v_reserveIndex).getDateDuration() * roomPrice;
            
            if(request.getParameter("reserveIndex") == null) {
        %>
        <h1>A reservation was not chosen.</h1>
        <% } else { %>
        <h1>Reservation Details:</h1>
        <form action="createInvoiceProcessing.jsp">
            Reserve ID: 
                <label value="<%=rt.getRecords().get(v_reserveIndex).getReserveID()%>">
                    <%=rt.getRecords().get(v_reserveIndex).getReserveID()%>
                </label>
                <input type="hidden" value="<%=rt.getRecords().get(v_reserveIndex).getReserveID()%>" name="reserveID">
                <br>
            Guest Name: 
                <label value="<%=rt.getRecords().get(v_reserveIndex).getBookRefID()%>">
                    <%=gt.getRecords().get(v_guestIndex).getFirstName()%> <%=gt.getRecords().get(v_guestIndex).getLastName()%>
                </label>
                <input type="hidden" value="<%=rt.getRecords().get(v_reserveIndex).getBookRefID()%>" name="bookRefID">
                <br>
            Room Number ID: <%=rt.getRecords().get(v_reserveIndex).getRoomRefID()%><br>
            Check In Date: <%=rt.getRecords().get(v_reserveIndex).getCheckInDate()%><br>
            Check Out Date: <%=rt.getRecords().get(v_reserveIndex).getCheckOutDate()%><br>
            Total Cost: 
                <label value="<%=totalCost%>">
                    <%=totalCost%>
                </label>
                <input type="hidden" value="<%=totalCost%>" name="totalCost">
                <br>
                
            <h3>Select Payment Method:</h3>
            <select id="paymentMethod" name="paymentMethod">
                <option value="Credit Card">Credit Card</option>
                <option value="Debit Card">Debit Card</option>
                <option value="Cash">Cash</option>
                <option value="Check">Check</option>
            </select>
            <br>
            <br>
            <input type="hidden" value="<%=v_reserveIndex%>" name="reserveIndex">
            <input type="hidden" value="<%=v_guestID%>" name="guestID">
            <input type="submit" value="Submit">
            <br>
            <br>
        </form>
        <% } %>
        <form action="createInvoiceReservations.jsp">
            <input type="hidden" value="<%=v_guestID%>" name="guestID">
            <input type="submit" value="Go Back">
        </form>
    </body>
</html>
