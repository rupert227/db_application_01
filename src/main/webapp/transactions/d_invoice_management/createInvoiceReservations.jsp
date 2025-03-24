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
            int v_guestID = Integer.parseInt(request.parameter("guestID"));
            
            if(v_guestID == NULL) {
        %>
            <h1>No guest was chosen.</h1>
        <%
            } else {
        %>
            <form action="createInvoice.jsp">
                <%
                    for(int i = 0; i < rt.getRecords().size(); i++)
                        if((rt.getRecords().get(i).getGuestID() == v_guestID) && (rt.getRecords().get(j).getReservationStatus().getReservationStatus() == "Pending")) {
                %>
                    <input type="radio" id="<%=rt.getRecords().get(i).getReserveID%>">
                    <label for="<%=rt.getRecords().get(i).getReserveID%>"><%=rt.getRecords().get(i).getReserveID%>, <%=rt.getRecords().get(i).getRoomRefID%>, <%=rt.getRecords().get(i).getCheckInDate%>, <%=rt.getRecords().get(i).getCheckOutDate%></label><br>
                <% } %>
                
                <input type="submit" value="Submit">
            </form>
        <% } %>
        <form action="createInvoiceGuest.jsp">
            <input type="submit" value="Go Back">
        </form>
    </body>
</html>
