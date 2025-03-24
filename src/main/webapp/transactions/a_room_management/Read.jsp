
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, records.*, tables.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Rooms</title>
    </head>
    <body>
            <jsp:useBean id="rt" class="tables.RoomTable" scope="page"/>
            
            <%
                Class.forName("com.mysql.cj.jdbc.Driver"); 
                rt.setRecords();  // Fetching room records into the ArrayList

                if(rt.getRecords().isEmpty()) {
            %>
            <h1>There are currently no room records available.</h1>
            <%
                } else {
            %>
            <h1>Room Records:</h1>
            <table border="1" style="border-collapse: collapse;" cellpadding="5">
                <tr>
                    <th>Room ID No.</th>
                    <th>Room Type</th>
                    <th>Availability</th>
                    <th>Max Capacity</th>
                </tr>

                <%
                    for (int i = 0; i < rt.getRecords().size(); i++) {
                %>
                    <tr>
                        <td align="center"><%= rt.getRecords().get(i).getRoomID() %></td>
                        <td align="center"><%= rt.getRecords().get(i).getType() %></td>
                        <td align="center"><%= rt.getRecords().get(i).getAvailability() %></td>
                        <td align="center"><%= rt.getRecords().get(i).getMaxCapacity() %></td>
                    </tr>
                <%
                    }
                %>
            </table>
            <%
                }
            %>
            
            <br><form action="room_mgmt.html">
                <input type="submit" value="Back To Room Transactions">
            </form>
    </body>
</html>
