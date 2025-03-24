<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report</title>
    </head>
    <body>
        <h1>Provide the Year and Month of Range</h1>
        <form action="reservation_report.jsp" method="post">
            <label for="month">Month:</label>
             <select id="month" name="month" required>
                <option value="1">January</option>
                <option value="2">February</option>
                <option value="3">March</option>
                <option value="4">April</option>
                <option value="5">May</option>
                <option value="6">June</option>
                <option value="7">July</option>
                <option value="8">August</option>
                <option value="9">September</option>
                <option value="10">October</option>
                <option value="11">November</option>
                <option value="12">December</option>
            </select>
            <label for="year">Year:</label>
            <input type="number" id="year" name="year" required>

            <button type="submit">Submit</button>
        </form>
        <form action="/db_application_01/transactions/c_reservation_management/reservation_page.jsp" method="GET">
            <button type="submit">Menu</button>
        </form>
    </body>
</html>
