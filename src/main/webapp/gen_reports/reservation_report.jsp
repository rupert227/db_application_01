<%@page import="tables.ReservationsTable"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report</title>
        <style>
            body{
                text-align: center;
            }
            table{
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td{
                border: 1px solid black;
            }
            th, td{
                padding: 10px;
                text-align: left;
            }
        </style>
    </head>
    <body>
        <h1>Average Number of Days Reserved For Each Room</h1>
            <table>
                <thead>
                    <tr>
                        <th>Room Number ID</th>
                        <th>Average Number of Days Reserved</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        ReservationsTable reservations = new ReservationsTable();
                        int year = Integer.parseInt(request.getParameter("year"));
                        int month = Integer.parseInt(request.getParameter("month"));
            
                        Map<Integer, Double> table = reservations.report(year, month);
                        

                        for(Map.Entry<Integer, Double> tuple : table.entrySet()){
                    %>
                    <tr>
                        <td><%= tuple.getKey() %></td>
                        <td><%= String.format("%.2f", tuple.getValue()) %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <br><form action="/db_application_01/gen_reports/input_report.jsp" method="GET">
            <button type="submit">Back</button>
        </form>
    </head>
</html>
