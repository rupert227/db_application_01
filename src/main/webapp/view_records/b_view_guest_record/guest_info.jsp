<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="tables.GuestsTable, records.GuestRecords" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Guest Information</title>
    </head>
    <body>
        <jsp:useBean id="guestsTable" class="tables.GuestsTable" scope="page" />

        <%
            try {
                guestsTable.setRecords();
            } catch (Exception e) {
                System.out.println("Error loading guest records: " + e.getMessage());
            }
        %>

        <h2>View Guest Information</h2>

        <form action="guest_info.jsp" method="POST">
            <label for="guestID">Select a Guest:</label>
            <select name="guestID">
                <%
                    for (GuestRecords guest : guestsTable.getRecords()) {
                %>
                    <option value="<%= guest.getGuestID() %>">
                        Guest ID <%= guest.getGuestID() %> - <%= guest.getFirstName() %> <%= guest.getLastName() %>
                    </option>
                <%
                    }
                %>
            </select>
            <input type="submit" value="View Details">
        </form>

        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                int selectedGuestID = 0;
                GuestRecords selectedGuest = null;

                try {
                    selectedGuestID = Integer.parseInt(request.getParameter("guestID"));
                    for (GuestRecords guest : guestsTable.getRecords()) {
                        if (guest.getGuestID() == selectedGuestID) {
                            selectedGuest = guest;
                            break;
                        }
                    }
                } catch (NumberFormatException e) {
                    out.println("Invalid Guest ID provided.");
                }

                if (selectedGuest != null) {
        %>
                    <h3>Guest Information for ID <%= selectedGuestID %>:</h3>
                    <table border="1" style="border-collapse: collapse;" cellpadding="5">
                        <tr>
                            <th>Guest ID</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Email</th>
                            <th>Telephone Number</th>
                        </tr>
                        <tr>
                            <td align="center"><%= selectedGuest.getGuestID() %></td>
                            <td align="center"><%= selectedGuest.getFirstName() %></td>
                            <td align="center"><%= selectedGuest.getLastName() %></td>
                            <td align="center"><%= selectedGuest.getEmail() %></td>
                            <td align="center"><%= selectedGuest.getTelNo() %></td>
                        </tr>
                    </table>
        <%
                } else {
                    if (selectedGuestID != 0) {
                        out.println("No guest found with ID " + selectedGuestID + ".");
                    } else {
                        out.println("Please select a valid Guest ID.");
                    }
                }
            }
        %>

        <br><form action="../../index.html">
            <input type="submit" value="Back To Main Menu">
        </form>
    </body>
</html>