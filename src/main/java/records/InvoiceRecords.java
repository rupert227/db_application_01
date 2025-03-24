package records;

import java.util.*;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.format.FormatStyle;

/**
 * 
 * This class is used for managing the hotel_db database
 * invoiceRecords table
 */
public class InvoiceRecords extends Records{
    private int paymentID;
    private int bookRefID;
    private PaymentMethod paymentMethod;
    private PaymentStatus paymentStatus;
    private LocalDateTime paymentDate;
    private float totalCost;
    
    private static final DateTimeFormatter DATE_FORMAT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
    
    public enum PaymentMethod{
        CREDIT_CARD("Credit Card"),
        DEBIT_CARD("Debit Card"),
        CASH("Cash"),
        CHECK("Check");
        
        private final String method;

        PaymentMethod(String method) {
            this.method = method;
        }

        public String getPaymentMethod() {
            return method;
        }
    }
    
    public enum PaymentStatus{
        REFUNDED("Refunded"),
        PAID("Paid");
        
        private final String status;
        
        PaymentStatus(String status){
            this.status = status;
        }
        
        public String getPaymentStatus(){
            return status;
        }
    }
        
    public InvoiceRecords(){
        super();
    }

    public InvoiceRecords(int paymentID, int bookRefID, String paymentMethod,
        String paymentStatus, LocalDateTime paymentDate, float totalCost){
        super();

        this.paymentID = paymentID;
        this.bookRefID = bookRefID;
        this.paymentMethod = PaymentMethod.valueOf(paymentMethod);
        this.paymentStatus = PaymentStatus.valueOf(paymentStatus);
        this.paymentDate = paymentDate;
        this.totalCost = totalCost;
    }
        
    //transactions
    public boolean refund(){
        try {
            Connection conn;
            conn = DriverManager.getConnection(dburl, user, pass);
            System.out.println("Connection Successful");

            PreparedStatement insert = conn.prepareStatement(
                    "UPDATE invoiceRecords SET paymentStatus = ? WHERE paymentID = ?;");
            
            insert.setString(1, PaymentStatus.REFUNDED.getPaymentStatus());
            insert.setInt(2, getPaymentID());
            
            insert.executeUpdate();
            
            System.out.println("Invoice payment status updated to refunded.");
            
            insert.close();
            conn.close();
            
            return true;
        }
        catch (SQLException sqle){
            System.out.print(sqle.getMessage());
            return false;
        }
    }
    
    //testing/debugging
    public static void main(String[] args){
        InvoiceRecords ir = new InvoiceRecords();
        
        ir.setPaymentID(0);
        ir.setBookRefID(1);
        ir.setTotalCost(Float.parseFloat("200.20"));
        ir.setPaymentDate(LocalDateTime.parse("2025-03-21 08:24",DATE_FORMAT));
        ir.paymentMethod = PaymentMethod.CREDIT_CARD;

        //ir.insertRecord();
        
        /*
            sample of new way to insert once insertRecord method 
            InvoicesTable ex = new InvoicesTable();  
            ex contains the invoices arraylist
            adds new record to db and arraylist
            ex.addNewInvoice(ir);
        */      
    }
    
    //setters
    public void setPaymentID(int paymentID) {
        this.paymentID = paymentID;
    }
    
    public void setBookRefID(int bookRefID) {
        this.bookRefID = bookRefID;
    }
    
    public void setTotalCost(float totalCost) {
        this.totalCost = totalCost;
    }
    
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = PaymentMethod.valueOf(paymentMethod.replace(" ","_").toUpperCase());
    }
    
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = PaymentStatus.valueOf(paymentStatus.toUpperCase());
    }
    
    public void setPaymentDate(LocalDateTime paymentDate) {
        this.paymentDate = paymentDate;
    }

    //getters
    public int getPaymentID() {
        return this.paymentID;
    }
    
    public int getBookRefID() {
        return this.bookRefID;
    }
    
    public float getTotalCost() {
        return this.totalCost;
    }
    
    public LocalDateTime getPaymentDate() {
        return paymentDate;
    }

    // added this method
    public PaymentStatus getPaymentStatus() {
        return paymentStatus;
    }

    // added this method
    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }
}