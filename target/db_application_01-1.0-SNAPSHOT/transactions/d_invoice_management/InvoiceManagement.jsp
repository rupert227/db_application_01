<%-- 
    Document   : InvoiceManagement
    Created on : 24 Mar 2025, 17.55.32
    Author     : ODie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, java.time.LocalDateTime, records.*, tables.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Invoice Management</title>
    </head>
    <body>
        <jsp:useBean id="rt" class="tables.ReservationsTable" scope="page"/>
        
        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            rt.setRecords();
                   
            if(rt.getRecords().size() == 0) {
        %>
            <h1>There are no reservations.</h1>
        <%
            }else {
        %>
            <a href="createInvoiceGuest.jsp">Create Invoice</a><br>
            <a href="">View Invoices</a><br>
            <a href="">Delete Invoice</a><br><br>
        <%
            }
        %>
        <form action="../index.html">
            <input type="submit" value="Back To Main Menu">
        </form>
    </body>
</html>
