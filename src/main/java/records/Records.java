package records;

public abstract class Records{
    protected static String dburl; // path to the sv
    protected static String user;// username (root as always)
    protected static String pass; // infom requires 12345678 passwd default)

    // default constructor (non-parameterized)
    public Records(){
        this.dburl = "jdbc:mysql://localhost:3306/hotel_db";
        this.user = "root";
        this.pass = "12345678";
    };
}
