package records;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Class for reservation records table
 */
public class Reservations extends Records {
    private int reserveID, bookRefID, roomRefID, guestCount;
    private LocalDateTime checkInDate, checkOutDate;
    private ReservationStatus reservationStatus;

    private static final DateTimeFormatter DATE_FORMAT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    public enum ReservationStatus{
        CONFIRMED("Confirmed"),
        CHECKED_IN("Checked-in"),
        CHECKED_OUT("Checked-out"),
        CANCELLED("Cancelled"),
        PENDING("Pending");

        private final String status;

        ReservationStatus(String status) {
            this.status = status;
        }

        public String getReservationStatus() {
            return status;
        }
    }

    // Default constructor
    public Reservations(){
        super();
    }
    
    // parameterized constructor
    public Reservations(int reserveID, int bookRefID, int roomRefID, int guestCount,
                        LocalDateTime checkInDate, LocalDateTime checkOutDate, String reservationStatus) {
        super();
        setReserveID(reserveID);
        setBookRefID(bookRefID);
        setRoomRefID(roomRefID);
        setGuestCount(guestCount);
        setCheckInDate(checkInDate);
        setCheckOutDate(checkOutDate);
        setReservationStatus(reservationStatus);
    }
    
    public Reservations(int bookRefID, int roomRefID, int guestCount,
                        LocalDateTime checkInDate, LocalDateTime checkOutDate, String reservationStatus) {
        super();
        setBookRefID(bookRefID);
        setRoomRefID(roomRefID);
        setGuestCount(guestCount);
        setCheckInDate(checkInDate);
        setCheckOutDate(checkOutDate);
        setReservationStatus(reservationStatus);
    }


    // --- Validation Methods ---

    // Validate that check-out is after check-in
    public boolean isValidDateRange() {
        if (checkOutDate.isAfter(checkInDate)) {
            return true;
        } else {
            System.out.println("Error: Check-out date must be after check-in date.");
            return false;
        }
    }
    
    public void recordGuestCount(){
        String sqlStatement = 
                "UPDATE reservation_record" +
                "SET guestCount = ?" +
                "WHERE bookRefID = ?;";
        
        try(Connection connection = DriverManager.getConnection(dburl, user, pass)){
            if(isValidGuestCount()){
                PreparedStatement update = connection.prepareStatement(sqlStatement);

                update.setInt(1, getGuestCount());
                update.setInt(2, getBookRefID());
            }
        } catch(SQLException sqle){
            System.out.println(sqle.getMessage());
        }
    }
    
    public void insertRecord(Reservations reservation){
        try(Connection connection = DriverManager.getConnection(dburl, user, pass)){
            String sqlStatement = "INSERT INTO reservationRecords(bookRefID, roomRefID, guestCount, checkInDate, checkoutDate, reservationStatus)"
                                + "VALUES(?, ?, ?, ?, ?, ?)";
            
            PreparedStatement update = connection.prepareStatement(sqlStatement);
            
            update.setInt(1, reservation.getBookRefID());
            update.setInt(2, reservation.getRoomRefID());
            update.setInt(3, reservation.getGuestCount());
            update.setString(4, reservation.getCheckInDate().format(DATE_FORMAT));
            update.setString(5, reservation.getCheckOutDate().format(DATE_FORMAT));
            update.setString(6, reservation.reservationStatus.getReservationStatus());
            
            update.executeUpdate();
        } catch(SQLException sqle){
            System.out.println(sqle.getMessage());
        }
    }
    
    // Validate that guest count does not exceed room capacity
    public boolean isValidGuestCount() {
        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            String sql = "SELECT resv.guestCount, refRoom.maxCapacity\n" +
                         "FROM reservationRecords resv\n" +
                         "JOIN roomRecords room ON resv.roomRefID = room.roomNumberID\n" +
                         "JOIN refRoomTypes refRoom ON room.roomType = refRoom.roomType\n" +
                         "WHERE resv.bookRefID = ?;";
            
            PreparedStatement query = connection.prepareStatement(sql);
            query.setInt(1, getBookRefID());
            ResultSet rst = query.executeQuery();

            if (rst.next()) {
                int maxCapacity = rst.getInt("maxCapacity");

                if (guestCount > 0 && guestCount <= maxCapacity){
                    return true;
                } else {
                    System.out.println("Error: Guest count exceeds room capacity (Max: " + maxCapacity + ")");
                    return false;
                }
            } else {
                System.out.println("Error: Room ID not found.");
                return false;
            }
        } catch (SQLException sqle) {
            System.out.println("SQL Error: " + sqle.getMessage());
            return false;
        }
    }

    // Check that the new reservation dates do not conflict with any existing reservations for the room
    public boolean isDateAvailable() {
        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            String sql = "SELECT * FROM reservationRecords\n" +
                         "WHERE roomRefID = 1\n" +
                         "AND (reservationStatus = 'Confirmed' OR reservationStatus = 'Checked-in)\n" +
                         "AND ((checkInDate BETWEEN ? AND ?)\n" +
                         "OR (checkOutDate BETWEEN ? AND ?)\n" +
                         "OR (checkInDate <= ? AND checkOutDate >= ?))";
            
            PreparedStatement query = connection.prepareStatement(sql);
            
            query.setObject(1, getCheckInDate());
            query.setObject(2, getCheckOutDate());
            query.setObject(3, getCheckInDate());
            query.setObject(4, getCheckOutDate());
            query.setObject(5, getCheckInDate());
            query.setObject(6, getCheckOutDate());
            
            ResultSet rst = query.executeQuery();

            if(rst.next()){
                return false; //there is a date collision
            }
            
            return true; // No conflicts found
        } catch (SQLException sqle) {
            System.out.println("SQL Error: " + sqle.getMessage());
            return false;
        }
    }

    
    // --- Transaction Methods (for Servlets) ---
    // Update reservation status to "Checked-in"
    public boolean checkIn() {
        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            String sql = "UPDATE reservationRecords SET reservationStatus = ? WHERE reserveID = ?";
            PreparedStatement pst = connection.prepareStatement(sql);
            pst.setString(1, ReservationStatus.CHECKED_IN.getReservationStatus());
            pst.setInt(2, reserveID);
            int rowsAffected = pst.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException sqle) {
            System.out.println("SQL Error: " + sqle.getMessage());
            return false;
        }
    }

    // Update reservation status to "Checked-out"
    public boolean checkOut() {
        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            String sql = "UPDATE reservationRecords SET reservationStatus = ? WHERE reserveID = ?";
            PreparedStatement pst = connection.prepareStatement(sql);
            pst.setString(1, ReservationStatus.CHECKED_OUT.getReservationStatus());
            pst.setInt(2, reserveID);
            int rowsAffected = pst.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException sqle) {
            System.out.println("SQL Error: " + sqle.getMessage());
            return false;
        }
    }
    
    public boolean cancel(){
        try(Connection connection = DriverManager.getConnection(dburl, user, pass)){
            PreparedStatement pst = connection.prepareStatement(
                    "UPDATE reservationRecords\n" +
                    "SET reservationStatus = ?\n" +
                    "WHERE reserveID = ?");
            pst.setString(1, ReservationStatus.CANCELLED.getReservationStatus());
            pst.setInt(2, getReserveID());
            int rowsAffected = pst.executeUpdate();
            return rowsAffected > 0;
        } catch(SQLException sqle){
            return false;
        }
    }
        
    public boolean confirm(){
        try(Connection connection = DriverManager.getConnection(dburl, user, pass)){
            PreparedStatement pst = connection.prepareStatement(
                    "UPDATE reservationRecords\n" +
                    "SET reservationStatus = ?\n" +
                    "WHERE reserveID = ?");
            pst.setString(1, ReservationStatus.CONFIRMED.getReservationStatus());
            pst.setInt(2, getReserveID());
            int rowsAffected = pst.executeUpdate();
            return rowsAffected > 0;
        } catch(SQLException sqle){
            return false;
        }
    }
    
    public boolean pending(){
        try(Connection connection = DriverManager.getConnection(dburl, user, pass)){
            PreparedStatement pst = connection.prepareStatement(
                    "UPDATE reservationRecords\n" +
                    "SET reservationStatus = ?\n" +
                    "WHERE reserveID = ?");
            pst.setString(1, ReservationStatus.PENDING.getReservationStatus());
            pst.setInt(2, getReserveID());            
            int rowsAffected = pst.executeUpdate();
            return rowsAffected > 0;
        } catch(SQLException sqle){
            return false;
        }
    }
    
    public int getDateDuration(){
        String sqlStatement = 
                "SELECT DATEDIFF(checkOutDate, checkInDate) AS dateDuration" +
                " FROM reservationRecords" +
                " WHERE reserveID = ?;";
        
        int dateRange = 0;
        
        try(Connection connection = DriverManager.getConnection(dburl, user, pass)){
            PreparedStatement select = connection.prepareStatement(sqlStatement);

            select.setInt(1, getReserveID());
            
            ResultSet rst = select.executeQuery();
            
            while(rst.next())
                dateRange = rst.getInt("dateDuration");
            
            return dateRange;
        } catch(SQLException sqle){
            System.out.println(sqle.getMessage());
            return 0;
        }
    }

    // --- Setters ---
    public void setReserveID(int reserveID){ 
        this.reserveID = reserveID; 
    }
    
    public void setBookRefID(int bookRefID){ 
        this.bookRefID = bookRefID; 
    }
    
    public void setRoomRefID(int roomRefID){ 
        this.roomRefID = roomRefID; 
    }
    
    public void setGuestCount(int guestCount){ 
        this.guestCount = guestCount; 
    }
    
    // modified this method
    public void setReservationStatus(String status){ 
        this.reservationStatus = ReservationStatus.valueOf(status.replace("-","_").toUpperCase()); 
    }
    
    public void setCheckInDate(LocalDateTime checkInDate){
        this.checkInDate = checkInDate;
    }
    
    public void setCheckOutDate(LocalDateTime checkOutDate){
        this.checkOutDate = checkOutDate;
    }

    // --- Getters ---
    public int getReserveID(){ 
        return reserveID; 
    }
    
    public int getBookRefID(){ 
        return bookRefID; 
    }
    
    public int getRoomRefID(){ 
        return roomRefID; 
    }
    
    public int getGuestCount(){ 
        return guestCount; 
    }
    
    public LocalDateTime getCheckOutDate(){
        return checkOutDate;
    }
    
    public LocalDateTime getCheckInDate(){
        return checkInDate;
    }
    
    public ReservationStatus getReservationStatus() {
        return reservationStatus;
    }
}