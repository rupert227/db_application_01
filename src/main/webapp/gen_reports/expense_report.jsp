<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="records.GuestRecords"%>
<%@page import="records.InvoiceRecords"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            body {
                text-align: center;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td {
                border: 1px solid black;
            }
            th, td {
                padding: 10px;
                text-align: left;
            }
        </style>
        <title>Guest Amount Paid</title>
    </head>
    <body>
        <h1>Guests by Total Amount Paid (Specific Year):</h1>

        <form method="GET">
            <label for="year">Enter Year:</label>
            <input type="number" id="year" name="year" required value="<%= request.getParameter("year") != null ? request.getParameter("year") : "" %>">
            <button type="submit">Submit</button>
        </form>

        <%
            String yearParam = request.getParameter("year");
            if (yearParam != null && !yearParam.isEmpty()) {
                try {
                    int v_year = Integer.parseInt(yearParam);
        %>

        <table>
            <thead>
                <tr>
                    <th>Guest ID</th>
                    <th>Guest Name</th>
                    <th>Total Amount Paid</th>
                </tr>
            </thead>
            <tbody>
        <%
                    // Define database credentials
                    String dburl = "jdbc:mysql://localhost:3306/your_database";
                    String user = "your_username";
                    String pass = "your_password";

                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rst = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(dburl, user, pass);
                        System.out.println("Connection Successful");

                        String sql = "SELECT " +
                                     "gr.guestID," +
                                     "gr.firstName," +
                                     "gr.lastName," +
                                     "SUM(ir.totalCost) AS totalAmount" +
                                     " FROM " +
                                     "guestRecords gr" +
                                     " JOIN " +
                                     "invoiceRecords ir ON gr.guestID = ir.bookRefID" +
                                     " WHERE YEAR(ir.paymentDate) = ?" +
                                     " GROUP BY " +
                                     "gr.guestID" +
                                     " ORDER BY " +
                                     "totalAmount DESC";

                        stmt = conn.prepareStatement(sql);
                        stmt.setInt(1, v_year);
                        rst = stmt.executeQuery();

                        while (rst.next()) {
        %>
            <tr>
                <td><%=rst.getInt("guestID")%></td>
                <td><%=rst.getString("firstName")%> <%=rst.getString("lastName")%></td>
                <td><%=rst.getDouble("totalAmount")%></td>
            </tr>
        <%
                        }

                    } catch (SQLException sqle) {
                        out.println("<p>Error executing SQL: " + sqle.getMessage() + "</p>");
                        sqle.printStackTrace(System.err);

                    } catch (ClassNotFoundException cnfe) {
                        out.println("<p>Error loading JDBC driver: " + cnfe.getMessage() + "</p>");
                        cnfe.printStackTrace(System.err);
                    } finally {
                        try {
                            if (rst != null) {
                                rst.close();
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        try {
                            if (stmt != null) {
                                stmt.close();
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        try {
                            if (conn != null) {
                                conn.close();
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
        %>
            </tbody>
        </table>

        <%
                } catch (NumberFormatException nfe) {
                    out.println("<p>Invalid year format. Please enter a valid year.</p>");
                }
            }
        %>

        <br><br>
        <form action="../index.html">
            <button type="submit">Back To Main Menu</button>
        </form>
    </body>
</html>
