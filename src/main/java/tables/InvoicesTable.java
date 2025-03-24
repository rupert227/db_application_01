package tables;

import records.InvoiceRecords;
import java.sql.*;
import java.util.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class InvoicesTable extends Tables {

    ArrayList<InvoiceRecords> invoiceRecords = new ArrayList<>();
    
    private static final DateTimeFormatter DATE_FORMAT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");


    public InvoicesTable () {
        super();
    }

    /**
     * Retrieves all invoice records from the database
     * Puts the data to the invoiceRecords ArrayList
     */
    @Override
    public boolean setRecords() {
        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            PreparedStatement query = connection.prepareStatement(
                    "SELECT * FROM invoiceRecords");

            ResultSet records = query.executeQuery();

            while (records.next()) {
                int paymentId = records.getInt("paymentID");
                int reserveId = records.getInt("reserveID");
                int bookRefId = records.getInt("bookRefID");
                String paymentMethodStr = records.getString("paymentMethod");
                String paymentStatusStr = records.getString("paymentStatus");
                String paymentDateStr = records.getString("paymentDate");
                double totalCost = records.getDouble("totalCost");

                invoiceRecords.add(new InvoiceRecords(paymentId, reserveId, bookRefId, paymentMethodStr, paymentStatusStr,
                    LocalDateTime.parse(paymentDateStr, DATE_FORMAT), totalCost));
            }
            
            query.close();

            return true;

        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
    }

    // Inserts a new record into the database 
    public boolean addNewInvoice(InvoiceRecords newInvoice) {
        String sqlStatement = "INSERT INTO invoiceRecords (reserveID, bookRefID, paymentStatus, totalCost, paymentMethod, paymentDate) " +
                              "VALUES (?, ?, ?, ?, ?, ?);";

        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            PreparedStatement insert = connection.prepareStatement(sqlStatement);

            insert.setInt(1, newInvoice.getReserveID());
            insert.setInt(2, newInvoice.getBookRefID());
            insert.setString(3, newInvoice.getPaymentStatus().getPaymentStatus());
            insert.setDouble(4, newInvoice.getTotalCost());
            insert.setString(5, newInvoice.getPaymentMethod().getPaymentMethod());
            insert.setObject(6, newInvoice.getPaymentDate());
            
            insert.executeUpdate();

            insert.close();
            
            return true;

        } catch (SQLException sqle) {
            System.out.println("SQL Error in addNewInvoice: " + sqle.getMessage());
            return false;
        }
    }

    /**
     * 
     * return aggregates
     */
    public ArrayList<InvoiceRecords> getRecords() {
        return invoiceRecords;
    }
}
