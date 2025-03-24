package tables;

import records.InvoiceRecords;
import java.sql.*;
import java.util.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class InvoicesTable extends Tables {

    ArrayList<InvoiceRecords> invoiceRecords = new ArrayList<>();
    
    private static final DateTimeFormatter DATE_FORMAT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");


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
                int bookRefId = records.getInt("bookRefID");
                String paymentMethodStr = records.getString("paymentMethod");
                String paymentStatusStr = records.getString("paymentStatus");
                String paymentDateStr = records.getString("paymentDate");
                float totalCost = records.getFloat("totalCost");

                invoiceRecords.add(new InvoiceRecords(paymentId, bookRefId, paymentMethodStr, paymentStatusStr,
                    LocalDateTime.parse(paymentDateStr, DATE_FORMAT), totalCost));
            }

            return true;

        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
    }

    // Inserts a new record into the database 
    public boolean addNewInvoice(InvoiceRecords newInvoice) {
        String sqlStatement = "INSERT INTO invoiceRecords (bookRefID, paymentStatus, totalCost, paymentMethod, paymentDate) " +
                              "VALUES (?, ?, ?, ?, ?);";

        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            PreparedStatement insert = connection.prepareStatement(sqlStatement, Statement.RETURN_GENERATED_KEYS);

            insert.setInt(1, newInvoice.getBookRefID());
            insert.setString(2, newInvoice.getPaymentStatus().getPaymentStatus());
            insert.setFloat(3, newInvoice.getTotalCost());
            insert.setString(4, newInvoice.getPaymentMethod().getPaymentMethod());
            insert.setString(5, newInvoice.getPaymentDate().format(DATE_FORMAT));

            int rowsAffected = insert.executeUpdate();
            if (rowsAffected > 0) {

                ResultSet generatedKeys = insert.getGeneratedKeys();
                if (generatedKeys.next()) {
                    newInvoice.setPaymentID(generatedKeys.getInt(1));  // Set generated key
                }
                
                return fetchAndAddLatestRecord(); // Fetch and update ArrayList
            }


            return false;

        } catch (SQLException sqle) {
            System.out.println("SQL Error in addNewInvoice: " + sqle.getMessage());
            return false;
        }
    }

    // Inserts latest record from database to ArrayList
    public boolean fetchAndAddLatestRecord() {
        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            String sql = "SELECT * FROM invoiceRecords ORDER BY paymentID DESC LIMIT 1;";
            PreparedStatement query = connection.prepareStatement(sql);
            ResultSet records = query.executeQuery();

            if (records.next()) {
                int paymentId = records.getInt("paymentID");
                int bookRefId = records.getInt("bookRefID");
                String paymentMethodStr = records.getString("paymentMethod");
                String paymentStatusStr = records.getString("paymentStatus");
                LocalDateTime paymentDate = LocalDateTime.parse(records.getString("paymentDate"), DATE_FORMAT);
                float totalCost = records.getFloat("totalCost");

                // Add the latest invoice record to the ArrayList
                invoiceRecords.add(new InvoiceRecords(paymentId, bookRefId, 
                    paymentMethodStr, paymentStatusStr, paymentDate, totalCost));
                
                    System.out.println("Latest invoice added to ArrayList.");
                return true;
            }
            return false;
        } catch (SQLException e) {
            System.out.println("SQL Error while fetching latest record: " + e.getMessage());
            return false;
        }
    }

    /**
     * 
     * return aggregates
     */
    public ArrayList<InvoiceRecords> getRecords() {
        return new ArrayList<>(invoiceRecords);
    }
}
