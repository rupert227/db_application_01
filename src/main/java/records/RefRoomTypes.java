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

    public RefRoomTypes(RoomType roomType, float roomPrice, int maxCapacity) {
        this.roomType = roomType;
        this.roomPrice = roomPrice;
        this.maxCapacity = maxCapacity;
    }

    public RoomType getRoomType() {
        return roomType;
    }

    public float getRoomPrice() {
        return roomPrice;
    }

    public int getMaxCapacity() {
        return maxCapacity;
    }
}
