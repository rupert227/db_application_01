<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Status</title>
    </head>
    <body>
        <h1>Check-in Reservation</h1>
        <form action="status_update.jsp" method="post">
            <label for="reserveID">Enter Reservation ID:</label>
            <input type="number" id="reserveID" name="reserveID" required>
            <input type="hidden" name="status" value="checkIn">
            <button type="submit">Submit</button>
        </form>
    </body>
</html>
