<%-- 
    Document   : guestMostReservationsMonth
    Created on : 25 Mar 2025, 06.18.01
    Author     : ODie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, java.time.LocalDateTime, records.*, tables.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:useBean id="rt" class="tables.ReservationsTable" scope="page"/>
        
        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            rt.setRecords();
            
            int v_year = Integer.parseInt(request.getParameter("year"));
            boolean hasMonth = false;
            
            ArrayList<Integer> month = new ArrayList<>();
            
            for(int i = 0; i < rt.getRecords().size(); i++) {
                if(rt.getRecords().get(i).getCheckInDate().getYear() == v_year) {
                    month.add(rt.getRecords().get(i).getCheckInDate().getMonthValue());
                    break;
                }
            }
            
            for(int i = 0; i < rt.getRecords().size(); i++) {
                for(int j = 0; j < month.size(); j++) {
                    if(month.get(j) == rt.getRecords().get(i).getCheckInDate().getMonthValue() && rt.getRecords().get(i).getCheckInDate().getYear() == v_year) {
                        hasMonth = true;
                    } 
                }
                if(!hasMonth && rt.getRecords().get(i).getCheckInDate().getYear() == v_year) {
                    month.add(rt.getRecords().get(i).getCheckInDate().getMonthValue());
                }
                hasMonth = false;
            }
        %>
            <h1>Select Year:</h1>
            <form action="guestMostReservations.jsp">
                <select id="month" name="month">
                    <%
                        for(int i = 0; i < month.size(); i++) {
                    %>
                        <option value="<%=month.get(i)%>"><%=month.get(i)%></option>
                    <%
                        }
                    %>
                </select>
                <input type="hidden" value="<%=v_year%>" name="year">
                <input type="submit" value="Submit">
                <br>
                <br>
            </form>
        <form action="../index.html">
            <input type="submit" value="Go Back">
        </form>
    </body>
</html>
