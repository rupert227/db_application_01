package tables;

import records.GuestRecords;
import java.sql.*;
import java.util.*;

public class GuestsTable extends Tables {
    // not yet done
    ArrayList<GuestRecords> guestRecords = new ArrayList<GuestRecords>();
    
    public GuestsTable () {
        super();
    }

    /**
     * Retrieves all guest records from the database
     * Puts the data to the Guest ArrayList
     */
    @Override
    public boolean setRecords(){
        try(Connection connection = DriverManager.getConnection(dburl, user, pass)){
            String sqlStatement = "SELECT * FROM guestRecords;";
            PreparedStatement query = connection.prepareStatement(sqlStatement);
            ResultSet records = query.executeQuery();
            
            while(records.next()){
                int guestID = records.getInt("guestID");
                String firstName = records.getString("firstName");
                String lastName = records.getString("lastName");
                String email = records.getString("email");
                String telNo = records.getString("telNo");
                
                guestRecords.add(new GuestRecords(guestID, firstName, lastName, email, telNo));
            }
            
            return true;
        } catch(SQLException sqle){
            return false;
        }
    }


    // Inserts a new record into the database 
    public boolean addNewGuest(GuestRecords newGuest) {
        String sqlStatement = "INSERT INTO guestRecords (firstName, lastName, email, telNo) VALUES (?, ?, ?, ?);";

        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            PreparedStatement insert = connection.prepareStatement(sqlStatement, Statement.RETURN_GENERATED_KEYS);

            // Bind parameters to the INSERT query
            insert.setString(1, newGuest.getFirstName());
            insert.setString(2, newGuest.getLastName());
            insert.setString(3, newGuest.getEmail());
            insert.setString(4, newGuest.getTelNo());

            int rowsAffected = insert.executeUpdate();
            if (rowsAffected > 0) {
                
                ResultSet generatedKeys = insert.getGeneratedKeys();
                if (generatedKeys.next()) {
                    newGuest.setGuestID(generatedKeys.getInt(1)); // Set generated key
                }

                return fetchAndAddLatestRecord(); // Fetch and update ArrayList
            }


            return false;

        } catch (SQLException sqle) {
            System.out.println("SQL Error in addNewGuest: " + sqle.getMessage());
            return false;
        }
    }

     // Inserts latest record from database to ArrayList
    public boolean fetchAndAddLatestRecord() {
        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            String sql = "SELECT * FROM guestRecords ORDER BY guestID DESC LIMIT 1;";
            PreparedStatement query = connection.prepareStatement(sql);
            ResultSet records = query.executeQuery();

            if (records.next()) {
                int guestID = records.getInt("guestID");
                String firstName = records.getString("firstName");
                String lastName = records.getString("lastName");
                String email = records.getString("email");
                String telNo = records.getString("telNo");

                // Add the latest record to the ArrayList
                guestRecords.add(new GuestRecords(guestID, firstName, lastName, email, telNo));
                System.out.println("Latest guest added to ArrayList.");
                return true;
            }
            return false;

        } catch (SQLException sqle) {
            System.out.println("SQL Error while fetching latest record: " + sqle.getMessage());
            return false;
        }
    }

    // Return the in-memory list of guest records
    public ArrayList<GuestRecords> getRecords() {
        return new ArrayList<>(guestRecords);
    }
}
