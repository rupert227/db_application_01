<%-- 
    Document   : guestMostReservations
    Created on : 25 Mar 2025, 07.07.16
    Author     : ODie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, java.time.LocalDateTime, records.*, tables.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Guest With Most Reservations</title>
    </head>
    <body>
        <jsp:useBean id="rt" class="tables.ReservationsTable" scope="page"/>
        <jsp:useBean id="gt" class="tables.GuestsTable" scope="page"/>
        
        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            rt.setRecords();
            gt.setRecords();
            int v_year = Integer.parseInt(request.getParameter("year"));
            int v_month = Integer.parseInt(request.getParameter("month"));
        %>
            <h1>Guests With The Most Reservations on <%=v_year%>/<%=v_month%>:</h1>
            <table  border="1" style="border-collapse: collapse;" cellpadding="5">
                <tr>
                    <th>Guest ID</th>
                    <th>Guest Name</th>
                    <th>Total Reservations</th>
                </tr>
            <%
                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "12345678");
                System.out.println("Connection Successful");

                PreparedStatement insert = conn.prepareStatement(
                    "SELECT gr.guestID, gr.firstName, gr.lastName, COUNT(rr.bookRefID) AS totalReservations " +
                    "FROM guestRecords gr " +
                    "JOIN reservationRecords rr " +
                    "ON gr.guestID = rr.bookRefID " +
                    "WHERE YEAR(rr.checkInDate) = ? " +
                    "AND MONTH(rr.checkInDate) = ? " +
                    "AND rr.reservationStatus != ? " +
                    "GROUP BY rr.bookRefID " +
                    "ORDER BY COUNT(rr.bookRefID) DESC;");
            
                insert.setInt(1, v_year);
                insert.setInt(2, v_month);
                insert.setString(3, "Cancelled");
            
                ResultSet rst = insert.executeQuery();
            
                while(rst.next()) {
            %>
                <tr>
                    <td><%=rst.getInt("guestID")%></td>
                    <td><%=rst.getString("firstName")%> <%=rst.getString("lastName")%></td>
                    <td><%=rst.getInt("totalReservations")%></td>
                </tr>
            <%
                }
                insert.close();
                conn.close();
            %>
            </table>
            <br>
        <form action="../index.html">
            <input type="submit" value="Back To Main Menu">
        </form>
    </body>
</html>
