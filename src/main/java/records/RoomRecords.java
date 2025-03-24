package records;

import java.sql.*;

public class RoomRecords extends Records {
    private int roomID;
    
    private RefRoomTypes.RoomType type;  
    // Refers to the RoomType enum in RefRoomTypes
    
    private Availability availability;
    private float price;
    private int maxCapacity;

    public enum Availability {
        AVAILABLE("Available"),
        OCCUPIED("Occupied"),
        MAINTENANCE("Maintenance");

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
        Availability availability, float price, int maxCapacity) {
        super();
        
        this.roomID = roomID;
        this.type = type;
        this.availability = availability;
        this.price = price;
        this.maxCapacity = maxCapacity;
    }


    // Getters and setters
    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }
    
    public RefRoomTypes.RoomType getType() {
        return type;
    }

    public Availability getAvailability() {
        return availability;
    }

    public void setAvailability(Availability availability) {
        this.availability = availability;
    }

    public float getPrice() {
        return price;
    }

    public int getMaxCapacity() {
        return maxCapacity;
    }
}
