<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="tables.GuestsTable, records.GuestRecords" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Guest List</title>
    </head>
    <body>
        <jsp:useBean id="guestsTable" class="tables.GuestsTable" scope="page" />

        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            guestsTable.setRecords();  // Load guest records
        %>

        <h2>Guest List</h2>

        <%
            if (guestsTable.getRecords().isEmpty()) {
        %>
            <h3>No guest records available.</h3>
        <%
            } else {
        %>
            <table border="1" style="border-collapse: collapse;" cellpadding="5">
                <tr>
                    <th>Guest ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Telephone Number</th>
                </tr>
                <%
                    for (GuestRecords guest : guestsTable.getRecords()) {
                %>
                    <tr>
                        <td align="center"><%= guest.getGuestID() %></td>
                        <td align="center"><%= guest.getFirstName() %></td>
                        <td align="center"><%= guest.getLastName() %></td>
                        <td align="center"><%= guest.getEmail() %></td>
                        <td align="center"><%= guest.getTelNo() %></td>
                    </tr>
                <%
                    }
                %>
            </table>
        <%
            }
        %>

        <br><form action="../../index.html">
            <input type="submit" value="Back To Main Menu">
        </form>
    </body>
</html>
