<%-- 
    Document   : deleteInvoiceProcessing
    Created on : 25 Mar 2025, 04.35.21
    Author     : ODie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, java.time.LocalDateTime, records.*, tables.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Invoice Processing</title>
    </head>
    <body>
        <jsp:useBean id="ir" class="records.InvoiceRecords" scope="page"/>
        <jsp:useBean id="it" class="tables.InvoicesTable" scope="page"/>
        <jsp:useBean id="res" class="records.Reservations" scope="page"/>
        
        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            it.setRecords();
            int v_paymentID = Integer.parseInt(request.getParameter("paymentID"));
            int v_reserveID = Integer.parseInt(request.getParameter("reserveID"));
            
            
            ir.setPaymentID(v_paymentID);
            
            boolean invoiceDeleted = ir.delete();
            
            if(invoiceDeleted) {
                res.setReserveID(v_reserveID);
                res.pending();
        %>
            <h1>Invoice Successfully Deleted!</h1>
            <form action="InvoiceManagement.jsp">
                <input type="submit" value="Back To Invoice Management">
            </form>
        <% } else { %>
            <h1>Invoice Deletion Failed.</h1>
            <form action="deleteInvoice.jsp">
                <input type="submit" value="Go Back">
            </form>
        <% } %>
    </body>
</html>
