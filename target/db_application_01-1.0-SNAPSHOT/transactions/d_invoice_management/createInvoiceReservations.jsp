<%-- 
    Document   : createInvoiceReservations
    Created on : 24 Mar 2025, 18.22.33
    Author     : ODie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, java.time.LocalDateTime, records.*, tables.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Choose Reservation For Invoice</title>
    </head>
    <body>
        <jsp:useBean id="rt" class="tables.ReservationsTable" scope="page"/>

        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            rt.setRecords();
            int v_guestID = Integer.parseInt(request.getParameter("guestID"));
        %>
        
        <h1>Select Reservation For Payment:</h1>
        <form action="createInvoice.jsp">
        <%
            for(int i = 0; i < rt.getRecords().size(); i++)
                if((rt.getRecords().get(i).getBookRefID() == v_guestID) && (rt.getRecords().get(i).getReservationStatus().getReservationStatus() == "Pending")) {
        %>
            <input type="radio" name="reserveIndex" id="<%=i%>" value="<%=i%>">
            <label for="<%=i%>"><%=rt.getRecords().get(i).getReserveID()%>, <%=rt.getRecords().get(i).getRoomRefID()%>, <%=rt.getRecords().get(i).getCheckInDate()%>, <%=rt.getRecords().get(i).getCheckOutDate()%></label><br>
        <% } %>
        <br>
        <br>
        <input type="hidden" value="<%=v_guestID%>" name="guestID">
        <input type="submit" value="Submit">
        <br>
        <br>
        </form>
        <form action="createInvoiceGuest.jsp">
            <input type="submit" value="Go Back">
        </form>
    </body>
</html>
