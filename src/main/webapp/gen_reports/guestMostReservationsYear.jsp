<%-- 
    Document   : guestMostReservations
    Created on : 25 Mar 2025, 05.37.40
    Author     : ODie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, java.time.LocalDateTime, records.*, tables.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Guests Most Reservations Year</title>
    </head>
    <body>
        <jsp:useBean id="rt" class="tables.ReservationsTable" scope="page"/>
        
        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            rt.setRecords();
            
            ArrayList<Integer> year = new ArrayList<>();
            boolean hasYear = false;
            
            year.add(rt.getRecords().get(0).getCheckInDate().getYear());
            
            for(int i = 1; i < rt.getRecords().size(); i++) {
                for(int j = 0; j < year.size(); j++) {
                    if(year.get(j) == rt.getRecords().get(i).getCheckInDate().getYear()) {
                        hasYear = true;
                    } 
                }
                if(!hasYear) {
                    year.add(rt.getRecords().get(i).getCheckInDate().getYear());
                }
                hasYear = false;
            }
            
            if(rt.getRecords().size() == 0) {
        %>
            <h1>There are no reservations.</h1>
        <%
            } else {
        %>
            <h1>Select Year:</h1>
            <form action="guestMostReservationsMonth.jsp">
                <select id="year" name="year">
                    <%
                        for(int i = 0; i < year.size(); i++) {
                    %>
                        <option value="<%=year.get(i)%>"><%=year.get(i)%></option>
                    <%
                        }
                    %>
                </select>
                <input type="submit" value="Submit">
                <br>
                <br>
            </form>
        <% } %>
        <form action="../index.html">
            <input type="submit" value="Go Back">
        </form>
    </body>
</html>
