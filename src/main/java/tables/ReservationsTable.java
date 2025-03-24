package tables;

import records.Reservations;
import java.sql.*;
import java.util.*;
import java.time.LocalDateTime;

/**
 * 
 *Class for handling aggregate Reservations objects 
 */
public class ReservationsTable extends Tables{
    ArrayList<Reservations> reservationRecords = new ArrayList<Reservations>();
    
    public ReservationsTable(){
        super();
    }
    
    /**
     * 
     *obtain all records from the reservationRecords table
     * instantiate and add all objects to the ArrayList
     */
    @Override
    public boolean setRecords(){
        try(Connection connection = DriverManager.getConnection(dburl, user, pass)){
            String sqlStatement = "SELECT * FROM reservationRecords;";
            PreparedStatement tableQuery = connection.prepareCall(sqlStatement);
            ResultSet records = tableQuery.executeQuery();
            
            while(records.next()){
                int reserveID = records.getInt("reserveID");
                int bookRefID = records.getInt("bookRefID");
                int roomRefID = records.getInt("roomRefID");
                int guestCount = records.getInt("guestCount");
                LocalDateTime checkInDate = records.getTimestamp("checkInDate").toLocalDateTime();
                LocalDateTime checkOutDate = records.getTimestamp("checkOutDate").toLocalDateTime();
                String reservationStatus = records.getString("reservationStatus");
                
                this.reservationRecords.add(new Reservations(reserveID, bookRefID, roomRefID, guestCount, 
                                                            checkInDate, checkOutDate, reservationStatus));
            }
            
            return true;
        } catch(SQLException sqle){
            return false;
        }  
    }
    
    // Inserts a new record into the database 
    public boolean insertNewReservation(Reservations newReservation) {
        String sqlStatement = "INSERT INTO reservationRecords (bookRefID, roomRefID, " + 
            "guestCount, checkInDate, checkOutDate, reservationStatus) VALUES (?, ?, ?, ?, ?, ?);";
        
            try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            PreparedStatement insert = connection.prepareStatement(sqlStatement);
            insert.setInt(1, newReservation.getBookRefID());
            insert.setInt(2, newReservation.getRoomRefID());
            insert.setInt(3, newReservation.getGuestCount());
            insert.setObject(4, newReservation.getCheckInDate());
            insert.setObject(5, newReservation.getCheckOutDate());
            insert.setString(6, newReservation.getReservationStatus().getReservationStatus());

            int rowsAffected = insert.executeUpdate();
            if (rowsAffected > 0) {

                ResultSet generatedKeys = insert.getGeneratedKeys();
                if (generatedKeys.next()) {
                    newReservation.setReserveID(generatedKeys.getInt(1));  // Set generated key
                }

                return fetchAndAddLatestRecord();  // Fetch and update ArrayList
            }


            return false;
            
        } catch (SQLException sqle) {
            System.out.println("SQL Error: " + sqle.getMessage());
            return false;
        }
    }

    // Inserts latest record from database to ArrayList
    private boolean fetchAndAddLatestRecord() {
        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            // Fetch the latest record (assuming auto-incremented reserveID)
            String sql = "SELECT * FROM reservationRecords ORDER BY reserveID DESC LIMIT 1;";
            PreparedStatement query = connection.prepareStatement(sql);
            ResultSet records = query.executeQuery();
    
            if (records.next()) {
                int reserveID = records.getInt("reserveID");
                int bookRefID = records.getInt("bookRefID");
                int roomRefID = records.getInt("roomRefID");
                int guestCount = records.getInt("guestCount");
                LocalDateTime checkInDate = records.getTimestamp("checkInDate").toLocalDateTime();
                LocalDateTime checkOutDate = records.getTimestamp("checkOutDate").toLocalDateTime();
                String reservationStatus = records.getString("reservationStatus");
    
                // Add the latest record to the ArrayList
                reservationRecords.add(new Reservations(reserveID, bookRefID, roomRefID, guestCount,
                                                        checkInDate, checkOutDate, reservationStatus));
                System.out.println("Latest reservation added to ArrayList.");
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
    public ArrayList<Reservations> getRecords(){
        return reservationRecords;
    }
}
