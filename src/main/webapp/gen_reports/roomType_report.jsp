<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="tables.ReservationsTable" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Room Type Reservation Report</title>
        <meta charset="UTF-8">
    </head>
    <body>
        <div align="center">
            <jsp:useBean id="reservationsTable" class="tables.ReservationsTable" scope="page" />

            <%
                Class.forName("com.mysql.cj.jdbc.Driver");  // Load MySQL driver
                reservationsTable.setRecords();  // Fetch all reservation records

                int year = request.getParameter("year") != null ? Integer.parseInt(request.getParameter("year")) : 0;
                int month = request.getParameter("month") != null ? Integer.parseInt(request.getParameter("month")) : 0;

                Map<String, Integer> roomTypeReservations = (year > 0 && month > 0) 
                                                            ? reservationsTable.report2(year, month) 
                                                            : null;

                if (roomTypeReservations == null || roomTypeReservations.isEmpty()) {
            %>
                <h1>Room Type Reservation Report</h1>

                <!-- Form to input year and month (only shows if no report is generated yet) -->
                <form action="roomType_report.jsp" method="POST">
                    <label for="year">Enter Year:</label>
                    <input type="number" name="year" min="2000" required><br><br>

                    <label for="month">Enter Month (1-12):</label>
                    <input type="number" name="month" min="1" max="12" required><br><br>

                    <input type="submit" value="Generate Report">
                </form>

            <%
                } else {
            %>
                <h2>Reservation Report for <%= year %> - Month <%= month %></h2>
                <table border="1" style="border-collapse: collapse;" cellpadding="5">
                    <tr>
                        <th>Room Type</th>
                        <th>Reservation Count</th>
                    </tr>
                    <%
                        for (String roomType : roomTypeReservations.keySet()) {
                            int reservationCount = roomTypeReservations.get(roomType);
                    %>
                        <tr>
                            <td align="center"><%= roomType %></td>
                            <td align="center"><%= reservationCount %></td>
                        </tr>
                    <%
                        }
                    %>
                </table>
                <br>
                <form action="roomType_report.jsp">
                    <input type="submit" value="Return">
                </form>
            <%
                }
            %>

            <br>
            <form action="../index.html">
                <input type="submit" value="Back To Room Transactions">
            </form>
        </div>
    </body>
</html>
