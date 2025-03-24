<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="tables.RefRoomTable, records.RefRoomTypes" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Room Type Information</title>
        <meta charset="UTF-8">
    </head>
    <body>

        <jsp:useBean id="refRoomTable" class="tables.RefRoomTable" scope="page" />

        <%
            Class.forName("com.mysql.cj.jdbc.Driver");  // Load MySQL driver
            refRoomTable.setRecords();  // Fetch records from refRoomTypes table

            if (refRoomTable.getRecords().isEmpty()) {
        %>
            <h3>No room type records available.</h3>
        <%
            } else {
        %>
            <h1>Room Type Presets:</h1>

            <table border="1" style="border-collapse: collapse;" cellpadding="10">
                <tr>
                    <th align="center">Room Type</th>
                    <th align="center">Room Price (Daily)</th>
                    <th align="center">Max Capacity</th>
                </tr>

                <%
                    for (RefRoomTypes room : refRoomTable.getRecords()) {
                %>
                    <tr>
                        <td align="center"><%= room.getRoomType().getRoomType() %></td>
                        <td align="center">$<%= room.getRoomPrice() %></td>
                        <td align="center"><%= room.getMaxCapacity() %></td>
                    </tr>
                <%
                    }
                %>
            </table>
        <%
            }
        %>

        <br>
        <form action="../../index.html">
            <input type="submit" value="Back To Main Menu">
        </form>
    </body>
</html>
