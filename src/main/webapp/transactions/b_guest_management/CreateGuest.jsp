<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="tables.GuestsTable, records.GuestRecords" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Create New Guest Record</title>
    </head>
    <body>
        <jsp:useBean id="gt" class="tables.GuestsTable" scope="page" />

        <%
            Class.forName("com.mysql.cj.jdbc.Driver");  // Load MySQL driver
            gt.setRecords();  // Load existing guest records
        %>

        <h2>Create New Guest Record</h2>

        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                try {
                    String firstName = request.getParameter("firstName");
                    String lastName = request.getParameter("lastName");
                    String email = request.getParameter("email");
                    String telNo = request.getParameter("telNo");

                    // Validation
                    if (firstName == null || lastName == null || email == null || telNo == null) {
                        out.println("<h3>Error: Please fill in all fields.</h3>");
                    } else {
                        GuestRecords newGuest = new GuestRecords(0, firstName, lastName, email, telNo);

                        if (gt.addNewGuest(newGuest)) {
                            out.println("<h3>Guest added successfully!</h3>");
                        } else {
                            out.println("<h3>Error: Failed to add guest.</h3>");
                        }
                    }
                } catch (Exception e) {
                    out.println("<h3>Error: " + e.getMessage() + "</h3>");
                }
            }
        %>

        <form action="Create.jsp" method="POST">
            <label for="firstName">First Name:</label>
            <input type="text" name="firstName"><br><br>

            <label for="lastName">Last Name:</label>
            <input type="text" name="lastName"><br><br>

            <label for="email">Email:</label>
            <input type="email" name="email"><br><br>

            <label for="telNo">Phone Number:</label>
            <input type="tel" name="telNo"><br><br>

            <input type="submit" value="Create Guest">
        </form>

        <br><form action="guest_mgmt.html">
            <input type="submit" value="Back To Guest Menu">
        </form>
    </body>
</html>
