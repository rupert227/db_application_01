package tables;

/**
 * 
 * Tables supertype
 */
public abstract class Tables {
    protected static String dburl;
    protected static String user;
    protected static String pass;

    // default constructor (non-parameterized)
    public Tables(){
        this.dburl = "jdbc:mysql://localhost:3306/hotel_db";
        this.user = "root";
        this.pass = "12345678";
    };
    
    public abstract boolean setRecords();
}
