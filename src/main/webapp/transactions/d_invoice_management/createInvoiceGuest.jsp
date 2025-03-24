<%-- 
    Document   : createInvoice
    Created on : 24 Mar 2025, 17.36.51
    Author     : ODie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, java.time.LocalDateTime, records.*, tables.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Choose Guest For Invoice</title>
    </head>
    <body>
        <jsp:useBean id="rt" class="tables.ReservationsTable" scope="page"/>
        <jsp:useBean id="gt" class="tables.GuestsTable" scope="page"/>
        
        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            rt.setRecords();
            gt.setRecords();
                
            boolean hasPending = false;
                    
            for(int i = 0; i < rt.getRecords().size(); i++)
                if (rt.getRecords().get(i).getReservationStatus().getReservationStatus() == "Pending")
                    hasPending = true;
                        
            if(!hasPending) {
        %>
            <h1>There are no reservations requiring any payments.</h1>
        <%
            } else {
        %>
            <h1>Select Guest For Payment:</h1>
            <form action="createInvoiceReservations.jsp">
                <select id="guestID" name="guestID">
                    <%
                        for(int i = 0; i < gt.getRecords().size(); i++)
                            for(int j = 0; j < rt.getRecords().size(); j++) {
                                if((gt.getRecords().get(i).getGuestID() == rt.getRecords().get(j).getBookRefID()) && (rt.getRecords().get(j).getReservationStatus().getReservationStatus() == "Pending")) {
                    %>
                        <option value="<%=gt.getRecords().get(i).getGuestID()%>"><%=gt.getRecords().get(i).getFirstName()%>, <%=gt.getRecords().get(i).getLastName()%></option>
                    <%
                                    for(int k = 0; k < rt.getRecords().size(); k++) {
                                        if(gt.getRecords().get(i).getGuestID() == rt.getRecords().get(k).getBookRefID())
                                            rt.getRecords().remove(k);
                                    }
                                }
                            }
                    %>
                </select>
                <br>
                <br>
                <input type="submit" value="Submit">
                <br>
                <br>
            </form>
        <%
            }
        %>
        <form action="InvoiceManagement.jsp">
            <input type="submit" value="Go Back">
        </form>
    </body>
</html>
