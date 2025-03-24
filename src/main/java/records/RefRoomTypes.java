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

    private double roomPrice;

    public double getRoomPrice() { 
        return roomPrice; }
    
    public void setRoomPrice(double roomPrice) { 
        this.roomPrice = roomPrice; }
}
