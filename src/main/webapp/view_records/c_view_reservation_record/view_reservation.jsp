<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="records.Reservations"%>
<%@page import="tables.ReservationsTable"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            body {
                text-align: center;
            }
        </style>
        <title>View Transaction History</title>
    </head>
    <body>
        <h1>View Transaction History</h1>
        <form action="view_history.jsp" method="post">
            <label for="guestID">Enter The Guest ID:</label>
            <input type="number" id="guestID" name="guestID" required>
            <button type="submit">Submit</button>
        </form>
        <br><br>
        <form action="/db_application_01/index.html" method="GET">
            <button type="submit">Menu</button>
        </form>
    </body>
</html>