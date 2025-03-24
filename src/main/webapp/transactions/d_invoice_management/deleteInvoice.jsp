<%-- 
    Document   : deleteInvoice
    Created on : 25 Mar 2025, 04.28.08
    Author     : ODie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, java.time.LocalDateTime, records.*, tables.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Invoice</title>
    </head>
    <body>
        <jsp:useBean id="it" class="tables.InvoicesTable" scope="page"/>
        <jsp:useBean id="gt" class="tables.GuestsTable" scope="page"/>
        
        <%
                Class.forName("com.mysql.cj.jdbc.Driver");
                it.setRecords();
                gt.setRecords();
                
                int guestIndex = 0;
                
                if(it.getRecords().size() == 0) {
            %>
            <h1>There are currently no invoices.</h1>
            <%
                }else {
            %>
            <h1>Delete an invoice:</h1>
            <h3>Note: Only Delete For Unnecessary Mistakes.</h3>
            <table  border="1" style="border-collapse: collapse;" cellpadding="5">
                <tr>
                    <th>Payment ID</th>
                    <th>Reservation ID</th>
                    <th>Guest Name</th>
                    <th>Payment Status</th>
                    <th>Total Cost</th>
                    <th>Payment Method</th>
                    <th>Payment Date</th>
                </tr>
            <%
                for(int i = 0; i < it.getRecords().size(); i++) {
            %>
                <tr>
                    <form action="deleteInvoiceProcessing.jsp">
                    <td><input type="hidden" name="paymentID" value="<%=it.getRecords().get(i).getPaymentID()%>"><%=it.getRecords().get(i).getPaymentID()%></td>
                    <td><input type="hidden" name="reserveID" value="<%=it.getRecords().get(i).getReserveID()%>"><%=it.getRecords().get(i).getReserveID()%></td>
                    <td><%=gt.getRecords().get(guestIndex).getFirstName()%> <%=gt.getRecords().get(guestIndex).getLastName()%></td>
                    <td><%=it.getRecords().get(i).getPaymentStatus().getPaymentStatus()%></td>
                    <td><%=it.getRecords().get(i).getTotalCost()%></td>
                    <td><%=it.getRecords().get(i).getPaymentMethod().getPaymentMethod()%></td>
                    <td><%=it.getRecords().get(i).getPaymentDate()%></td>
                    <td><input type="submit" value="Delete"></td>
                    </form>
                </tr>
            <% 
                    }
                }
            %>
            </table>
            <br>
        <form action="InvoiceManagement.jsp">
            <input type="submit" value="Go Back">
        </form>
    </body>
</html>
