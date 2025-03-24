
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Reservation Status</title>
        
    </head>
    <body>
        <form action="update.jsp" method="post">
            <h1>Update a Reservation Status</h1>
            <label for="guestID">Enter The Reservation ID:</label><br>
            <input type="number" id="reserveID" name="reserveID" required><br><br>
            <label for="reservationStatus">Reservation Status</label><br>
                <select id="reservationStatus" name="reservationStatus" required>
                <option value="pending">Pending</option>
                <option value="confirm">Confirm</option>
                <option value="checkIn">Check-in</option>
                <option value="checkOut">Check-out</option>
                <option value="cancel">Cancel</option>
            </select>
            <br><br>
            <button type="submit">Submit</button>
        </form>
        <br><br>
        <form action="/db_application_01/transactions/c_reservation_management/reservation_page.jsp" method="GET">
            <button type="submit">Menu</button>
        </form>
    </body>
</html>
