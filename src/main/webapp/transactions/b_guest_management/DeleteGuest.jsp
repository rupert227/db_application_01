<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="tables.GuestsTable, records.GuestRecords" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Delete Guest Record</title>
    </head>
    <body>
        <jsp:useBean id="gt" class="tables.GuestsTable" scope="page" />

        <%
            Class.forName("com.mysql.cj.jdbc.Driver");  // Load MySQL driver
            gt.setRecords();  // Load records into the ArrayList
        %>

        <h2>Delete Guest Record</h2>

        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                try {
                    int guestID = Integer.parseInt(request.getParameter("guestID"));

                    if (gt.deleteGuest(guestID)) {
                        out.println("<h3>Guest deleted successfully!</h3>");
                    } else {
                        out.println("<h3>Error: Failed to delete guest.</h3>");
                    }
                } catch (NumberFormatException e) {
                    out.println("<h3>Error: Invalid guest ID.</h3>");
                } catch (Exception e) {
                    out.println("<h3>Error: " + e.getMessage() + "</h3>");
                }
            }
        %>

        <form action="DeleteGuest.jsp" method="POST">
            <label for="guestID">Guest ID:</label>
            <select name="guestID">
                <%
                    if (gt.getRecords() != null && !gt.getRecords().isEmpty()) {
                        for (GuestRecords guest : gt.getRecords()) {
                            out.println("<option value='" + guest.getGuestID() + "'>" + guest.getGuestID() + "</option>");
                        }
                    } else {
                        out.println("<option disabled>No guests available</option>");
                    }
                %>
            </select><br><br>

            <input type="submit" value="Delete Guest">
        </form>

        <br><form action="guest_mgmt.html">
            <input type="submit" value="Back To Guest Menu">
        </form>
    </body>
</html>