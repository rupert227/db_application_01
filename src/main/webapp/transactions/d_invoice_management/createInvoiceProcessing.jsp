<%-- 
    Document   : createInvoiceProcessing
    Created on : 25 Mar 2025, 02.31.14
    Author     : ODie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, java.time.LocalDateTime, records.*, tables.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Invoice Processing</title>
    </head>
    <body>
        <jsp:useBean id="ir" class="records.InvoiceRecords" scope="page"/>
        <jsp:useBean id="it" class="tables.InvoicesTable" scope="page"/>
        <jsp:useBean id="res" class="records.Reservations" scope="page"/>
        
        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
        
            int v_reserveID = Integer.parseInt(request.getParameter("reserveID"));
            int v_bookRefID = Integer.parseInt(request.getParameter("bookRefID"));
            double v_totalCost = Double.parseDouble(request.getParameter("totalCost"));
            String v_paymentMethod = request.getParameter("paymentMethod");
            
            ir.setReserveID(v_reserveID);
            ir.setBookRefID(v_bookRefID);
            ir.setPaymentStatus("Paid");
            ir.setTotalCost(v_totalCost);
            ir.setPaymentMethod(v_paymentMethod);
            ir.setPaymentDate(LocalDateTime.now());
            
            boolean invoiceCreated = it.addNewInvoice(ir);
            
            if(invoiceCreated) {
                res.setReserveID(v_reserveID);
                res.confirm();
        %>
            <h1>Invoice Successfully Created!</h1>
            <form action="InvoiceManagement.jsp">
                <input type="submit" value="Back To Invoice Management">
            </form>
        <% } else { %>
            <h1>Invoice Creation Failed.</h1>
            <form action="createInvoice.jsp">
                <%
                    int v_reserveIndex = Integer.parseInt(request.getParameter("reserveIndex"));
                    int v_guestID = Integer.parseInt(request.getParameter("guestID"));
                %>
                <input type="hidden" value="<%=v_reserveIndex%>" name="reserveIndex">
                <input type="hidden" value="<%=v_guestID%>" name="guestID">
                <input type="submit" value="Go Back">
            </form>
        <% } %>
    </body>
</html>
