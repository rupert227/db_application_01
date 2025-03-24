<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reservation Record Management</title>
    </head>
    <body>
        <h1>Enter a Reservation Record</h1>
            <form action="success.jsp" method="post">   
                
            <label for="bookRefID">Guest ID</label><br>
            <input type="number" id="bookRefID" name="bookRefID" required><br><br>
            
            <label for="roomNumberID">Room Number</label><br>
            <input type="number" id="roomNumberID" name="roomNumberID" required><br><br>
            
            <label for="guestCount">Number of Guests</label><br>
            <input type="number" id="guestCount" name="guestCount" required><br><br>
            
            <label for="checkInDate">Check-in Date</label><br>
            <input type="datetime-local" id="checkInDate" name="checkInDate" required><br><br>
            
            <label for="checkOutDate">Check-out Date</label><br>
            <input type="datetime-local" id="checkOutDate" name="checkOutDate" required><br><br>
            
            <label for="reservationStatus">Reservation Status</label><br>
                <select id="reservationStatus" name="reservationStatus" required>
                <option value="Pending">Pending</option>
                <option value="Confirmed">Confirmed</option>
                <option value="Checked-in">Checked-in</option>
                <option value="Checked-out">Checked-out</option>
                <option value="Cancelled">Cancelled</option>
            </select>
            <br><br>
            <input type="submit" value="Submit">
        </form>
    </body>
</html>
