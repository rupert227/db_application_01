<%-- 
    Document   : viewGuestPayments
    Created on : 25 Mar 2025, 05.07.41
    Author     : ODie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, java.time.LocalDateTime, records.*, tables.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Guest Payments</title>
    </head>
    <body>
        <jsp:useBean id="it" class="tables.InvoicesTable" scope="page"/>
        <jsp:useBean id="gt" class="tables.GuestsTable" scope="page"/>
        
        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            it.setRecords();
            gt.setRecords();
            
            if(it.getRecords().size() == 0) {
        %>
            <h1>There are no invoices to view.</h1>
        <%
            } else {
        %>
            <h1>Select Guest To View Invoices:</h1>
            <form action="viewGuestPayments.jsp">
                <select id="guestIndex" name="guestIndex">
                    <%
                        for(int i = 0; i < gt.getRecords().size(); i++)
                            for(int j = 0; j < it.getRecords().size(); j++) {
                                if(gt.getRecords().get(i).getGuestID() == it.getRecords().get(j).getBookRefID()) {
                    %>
                        <option value="<%=i%>"><%=gt.getRecords().get(i).getFirstName()%> <%=gt.getRecords().get(i).getLastName()%></option>
                    <%
                                    for(int k = 0; k < it.getRecords().size(); k++) {
                                        if(gt.getRecords().get(i).getGuestID() == it.getRecords().get(k).getBookRefID()) {
                                            it.getRecords().remove(k);
                                            k = 0;
                                        }
                                    }
                                }
                            }
                    %>
                </select>
                <input type="submit" value="Submit">
                <br>
                <br>
            </form>
        <%
            }
            if(request.getParameter("guestIndex") != null) {
                it.setRecords();
                int v_guestIndex = Integer.parseInt(request.getParameter("guestIndex"));
        %>
            <h3>Invoice History of <%=gt.getRecords().get(v_guestIndex).getFirstName()%> <%=gt.getRecords().get(v_guestIndex).getLastName()%></h3>
            <table  border="1" style="border-collapse: collapse;" cellpadding="5">
                <tr>
                    <th>Payment ID</th>
                    <th>Reservation ID</th>
                    <th>Payment Status</th>
                    <th>Total Cost</th>
                    <th>Payment Method</th>
                    <th>Payment Date</th>
                </tr>
                <%
                    for(int i = 0; i < it.getRecords().size(); i++) {
                        if(gt.getRecords().get(v_guestIndex).getGuestID() == it.getRecords().get(i).getBookRefID()) {
                %>
                <tr>
                    <td><%=it.getRecords().get(i).getPaymentID()%></td>
                    <td><%=it.getRecords().get(i).getReserveID()%></td>
                    <td><%=it.getRecords().get(i).getPaymentStatus().getPaymentStatus()%></td>
                    <td><%=it.getRecords().get(i).getTotalCost()%></td>
                    <td><%=it.getRecords().get(i).getPaymentMethod().getPaymentMethod()%></td>
                    <td><%=it.getRecords().get(i).getPaymentDate()%></td>
                </tr>
            <% 
                        }
                    }
                }
            %>
            </table>
            <br>
        <form action="../../index.html">
            <input type="submit" value="Go Back">
        </form>
    </body>
</html>
