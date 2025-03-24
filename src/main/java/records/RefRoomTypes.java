package records;

public class RefRoomTypes {

    public enum RoomType {
        STANDARD("Standard"),
        DOUBLE("Double"),
        SUITE("Suite");

        private final String type;

        RoomType(String type) {
            this.type = type;
        }

        public String getRoomType() {
            return type;
        }
    }

    private RoomType roomType;
    private float roomPrice;
    private int maxCapacity;

    // No-argument constructor for flexibility
    public RefRoomTypes() { }

    // Constructor with parameters
    public RefRoomTypes(RoomType roomType, float roomPrice, int maxCapacity) {
        this.roomType = roomType;
        this.roomPrice = roomPrice;
        this.maxCapacity = maxCapacity;
    }

    // Getters
    public RoomType getRoomType() {
        return roomType;
    }

    public float getRoomPrice() {
        return roomPrice;
    }

    public int getMaxCapacity() {
        return maxCapacity;
    }

    // Setters for updating values
    public void setRoomType(RoomType roomType) {
        this.roomType = roomType;
    }

    public void setRoomPrice(float roomPrice) {
        this.roomPrice = roomPrice;
    }

    public void setMaxCapacity(int maxCapacity) {
        this.maxCapacity = maxCapacity;
    }
}
