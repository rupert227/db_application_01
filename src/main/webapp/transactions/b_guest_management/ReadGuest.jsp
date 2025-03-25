<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="tables.GuestsTable, records.GuestRecords" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>List of All Guests</title>
    </head>
    <body>
        <jsp:useBean id="gt" class="tables.GuestsTable" scope="page" />

        <%
            Class.forName("com.mysql.cj.jdbc.Driver");  // Load MySQL driver
            gt.setRecords();  // Load existing guest records
        %>

        <h2>List of All Guests</h2>

        <table border="1" style="border-collapse: collapse;" cellpadding="5">
    		<tr>
        		<th>Guest ID</th>
        		<th>First Name</th>
        		<th>Last Name</th>
        		<th>Email</th>
        		<th>Telephone Number</th>
    		</tr>

        
            <%
                try {
                    for (GuestRecords guest : gt.getRecords()) {
                        out.println("<tr>");
                        out.println("<td>" + guest.getGuestID() + "</td>");
                        out.println("<td>" + guest.getFirstName() + "</td>");
                        out.println("<td>" + guest.getLastName() + "</td>");
                        out.println("<td>" + guest.getEmail() + "</td>");
                        out.println("<td>" + guest.getTelNo() + "</td>");
                        out.println("</tr>");
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>

        <br><form action="guest_mgmt.html">
            <input type="submit" value="Back To Guest Menu">
        </form>
    </body>
</html>
