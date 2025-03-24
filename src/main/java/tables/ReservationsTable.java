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
    
    public boolean getHistory(int guestID){
        try(Connection connection = DriverManager.getConnection(dburl, user, pass)){
            String sqlStatement = "SELECT v.reserveID, v.bookRefID, v.roomRefID, v.guestCount, v.checkInDate, v.checkOutDate, v.reservationStatus\n" +
                                  "FROM reservationRecords v\n" +
                                  "JOIN guestRecords g ON v.bookRefID = g.guestID\n" +
                                  "JOIN roomRecords r ON v.roomRefID = r.roomNumberID\n" +
                                  "WHERE g.guestID = ?";
            ArrayList<Reservations> records = new ArrayList<>();
            
            PreparedStatement query = connection.prepareStatement(sqlStatement);
            
            query.setInt(1, guestID);
            
            ResultSet result = query.executeQuery();
            
            while(result.next()){
                int reserveID = result.getInt("reserveID");
                int bookRefID = result.getInt("bookRefID");
                int roomRefID = result.getInt("roomRefID");
                int guestCount = result.getInt("guestCount");
                
                LocalDateTime checkInDate = result.getTimestamp("checkInDate").toLocalDateTime();
                LocalDateTime checkOutDate = result.getTimestamp("checkOutDate").toLocalDateTime();
                String reservationStatus = result.getString("reservationStatus");
                
                this.reservationRecords.add(new Reservations(reserveID, bookRefID, roomRefID, guestCount, 
                                                            checkInDate, checkOutDate, reservationStatus));
            } 
            
            return true;
        } catch(SQLException sqle){
            return false;
        }
    }
    
    public Map<Integer, Double> report(int year, int month){
        try(Connection connection = DriverManager.getConnection(dburl, user, pass)){
            String sqlStatement = "SELECT room.roomNumberID, AVG(ABS(DATEDIFF(resv.checkOutDate, resv.checkInDate))) AS averageNumberOFDays\n" +
                                  "FROM reservationrecords resv \n" +
                                  "JOIN roomrecords room ON resv.roomRefID = room.roomNumberID\n" +
                                  "WHERE YEAR(resv.checkInDate) = ? AND MONTH(resv.checkInDate) = ?\n" +
                                  "GROUP BY room.roomNumberID\n" +
                                  "ORDER BY roomNumberID;";
            Map<Integer, Double> roomAvgs = new HashMap<Integer, Double>();
            
            PreparedStatement query = connection.prepareStatement(sqlStatement);
            
            query.setInt(1, year);
            query.setInt(2, year);
            
            ResultSet result = query.executeQuery();
            
            while(result.next()){
                int roomNumberID = result.getInt("roomNumberID");
                double avgDays = result.getDouble("averageNumberOfDays");
                
                roomAvgs.put(roomNumberID, avgDays);
            }
            
            return roomAvgs;
        } catch(SQLException sqle){
            return null;
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
