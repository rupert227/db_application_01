<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="tables.GuestsTable, records.GuestRecords" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Update Guest Information</title>
    </head>
    <body>
        <jsp:useBean id="gt" class="tables.GuestsTable" scope="page" />

        <%
            Class.forName("com.mysql.cj.jdbc.Driver");  // Load MySQL driver
            gt.setRecords();  // Load existing guest records
        %>

        <h2>Update Guest Information</h2>

        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                try {
                    int guestID = Integer.parseInt(request.getParameter("guestID"));
                    String newEmail = request.getParameter("newEmail");
                    String newTelNo = request.getParameter("newTelNo");

                    // Validation
                    if (newEmail == null || newTelNo == null) {
                        out.println("<h3>Error: Please fill in all fields.</h3>");
                    } else {
                        if (gt.updateGuest(guestID, newEmail, newTelNo)) {
                            out.println("<h3>Guest updated successfully!</h3>");
                        } else {
                            out.println("<h3>Error: Failed to update guest.</h3>");
                        }
                    }
                } catch (Exception e) {
                    out.println("<h3>Error: " + e.getMessage() + "</h3>");
                }
            }
        %>

        <form action="UpdateGuest.jsp" method="POST">
            <label for="guestID">Guest ID:</label>
            <select name="guestID">
                <%
                    for (GuestRecords guest : gt.getRecords()) {
                        out.println("<option value='" + guest.getGuestID() + "'>" + guest.getGuestID() + "</option>");
                    }
                %>
            </select><br><br>

            <label for="newEmail">New Email:</label>
            <input type="email" name="newEmail"><br><br>

            <label for="newTelNo">New Phone Number:</label>
            <input type="tel" name="newTelNo"><br><br>

            <input type="submit" value="Update Guest">
        </form>

        <br><form action="guest_mgmt.html">
            <input type="submit" value="Back To Guest Menu">
        </form>
    </body>
</html>
