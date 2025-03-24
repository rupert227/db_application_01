package records;

import java.sql.*;
import records.Records;

public class GuestRecords extends Records{
    private int guestID;
    private String firstName;
    private String lastName;
    private String email;
    private String telNo;
    
    public GuestRecords(){
        super();
    }
    
    public GuestRecords(int guestID, String firstName, String lastName, String email, String telNo){
        super();
        setGuestID(guestID);
        setFirstName(firstName);
        setLastName(lastName);
        setEmail(email);
        setTelNo(telNo);
    }
    
    public boolean existingGuest() throws SQLException{
        String sqlStatement = "SELECT firstName, lastName, email, telNo\n"
                            + "FROM guestRecords\n"
                            + "WHERE email = ? OR telNo = ?;";
        
        try(Connection connection = DriverManager.getConnection(dburl, user, pass)){
        
            PreparedStatement validate = connection.prepareStatement(sqlStatement);

            validate.setString(1, getEmail());
            validate.setString(2, getTelNo());

            ResultSet result = validate.executeQuery();

            if(result.next()){
                return true;
            } else{
                return false;
            }
        }
    }
        
    //getters
    public int getGuestID(){
        return guestID;
    }
    
    public String getFirstName(){
        return firstName;
    }
    
    public String getLastName(){
        return lastName;
    }
    
    public String getEmail(){
        return email;
    }
    
    public String getTelNo(){
        return telNo;
    }
    
    //setters
    public void setGuestID(int guestID){
        this.guestID = guestID;
    }
    
    public void setFirstName(String firstName){
        this.firstName = firstName;
    }
    
    public void setLastName(String lastName){
        this.lastName = lastName;
    }
    
    public void setEmail(String email){
        this.email = email;
    }
    
    public void setTelNo(String telNo){
        this.telNo = telNo;
    }
    
    public static void main(String[] args){
        GuestRecords g = new GuestRecords();
        
        try(Connection connection = DriverManager.getConnection(dburl, user, pass)){
            
            g.setEmail("alice.johnson@emai.com");
            g.setTelNo("12345678900");
            
            System.out.println(g.existingGuest());
            
        } catch(SQLException sqle){
            System.out.println(sqle.getMessage());
        }
    }
}