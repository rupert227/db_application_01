package records;

import java.sql.*;

public class RoomRecords extends Records {
    private int roomID;
    
    private RefRoomTypes.RoomType type;  
    // Refers to the RoomType enum in RefRoomTypes
    
    private Availability availability;
    private double price;
    private int maxCapacity;

    public enum Availability {
        AVAILABLE("Available"),
        OCCUPIED("Occupied");

        private final String avail;

        Availability(String avail) {
            this.avail = avail;
        }

        public String getAvail() {
            return this.avail;
        }

        public static Availability fromString(String avail) {
            for (Availability a : Availability.values()) {
                if (a.avail.equalsIgnoreCase(avail)) {
                    return a;
                }
            }
            throw new IllegalArgumentException("Invalid availability: " + avail);
        }
    }

    public RoomRecords() {

        super();   
    }

    public RoomRecords(int roomID, RefRoomTypes.RoomType type, 
        Availability availability, double price, int maxCapacity) {
        super();
        
        this.roomID = roomID;
        this.type = type;
        this.availability = availability;
        this.price = price;
        this.maxCapacity = maxCapacity;
    }

    public boolean updateAvailability(int roomID, Availability newAvailability) {
        try (Connection connection = DriverManager.getConnection(dburl, user, pass)) {
            PreparedStatement stmt = connection.prepareStatement(
                "UPDATE room_record SET availability = ? WHERE room_numberID = ?");
            
            stmt.setString(1, newAvailability.getAvail());
            stmt.setInt(2, roomID);
            stmt.executeUpdate();
        
            this.availability = newAvailability;
        
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getRoomID() { 
        return roomID; 
    }
    
    public RefRoomTypes.RoomType getType() { 
        return type; 
    }
    
    public Availability getAvailability() { 
        return availability; 
    }
    
    public double getPrice() { 
        return price; 
    }
    
    public int getMaxCapacity() { 
        return maxCapacity; 
    }
}
