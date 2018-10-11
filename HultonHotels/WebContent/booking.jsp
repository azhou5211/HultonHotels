<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
try {

	//Create a connection string
	String url = "jdbc:mysql://cs336.cdosnw6vnspt.us-east-2.rds.amazonaws.com:3306/HotelSchema";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");

	//Create a connection to your DB
	Connection con = DriverManager.getConnection(url, "admin", "password");

	//Create a SQL statement
	Statement stmt = con.createStatement();

	//Get parameters from the HTML form 
	String newCID = request.getParameter("CID");
	String newCountry = request.getParameter("Country");
	String newRType = request.getParameter("RType");
	String newInDate = request.getParameter("InDate");
	String newOutDate = request.getParameter("OutDate");
	int newHotelID = 0;
	if(newCountry.equals("Brazil")) {
		newHotelID = 1;
	}
	if(newCountry.equals("Britain")) {
		newHotelID = 2;
	}
	if(newCountry.equals("Canada")) {
		newHotelID = 3;
	}
	if(newCountry.equals("Egypt")) {
		newHotelID = 4;
	}
	if(newCountry.equals("France")) {
		newHotelID = 5;
	}
	if(newCountry.equals("Goa")) {
		newHotelID = 6;
	}
	if(newCountry.equals("Italy")) {
		newHotelID = 7;
	}
	if(newCountry.equals("Japan")) {
		newHotelID = 8;
	}
	if(newCountry.equals("Maldives")) {
		newHotelID = 9;
	}
	if(newCountry.equals("New Zealand")) {
		newHotelID = 10;
	}
	if(newCountry.equals("Spain")) {
		newHotelID = 11;
	}
	if(newCountry.equals("Turkey")) {
		newHotelID = 12;
	}
	
	
	
			
	//Checks that room number doesn't conflict with same room number dates
	/*
	boolean roommatch = true;
	int userRoomNum = 
	while(roommatch)
	{
		if()	
	}
	*/
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	//String newInDate = request.getParameter("InDate");
	//String newOutDate = request.getParameter("OutDate");
	Statement stmt2 = con.createStatement();
	String query = "SELECT r.HotelID,q.Room_no as Room_no,r.InDate as din,r.OutDate as dout FROM HotelSchema.Reservation r, HotelSchema.Room q WHERE q.RType = '" +newRType+ "' and r.HotelID=q.HotelID and r.Room_no=q.Room_no";
	//System.out.println(query);
	ResultSet res2 = stmt2.executeQuery(query);
	boolean conflict = false;
	boolean first = true;
	while(res2.next()) {
		first = false;
		//System.out.println("test");
		/*
		String din = res2.getString("din");
		String dout = res2.getString("dout");
		DateFormat format = new SimpleDateFormat("yyyy-mm-dd",Locale.ENGLISH);
		*/
		String din = res2.getString("din");
		String dout = res2.getString("dout");
		//System.out.println(din + " " + dout);
		String sdyear = din.substring(0,4);
		int dinyear = Integer.parseInt(sdyear); //database in year
		//System.out.println(dyear);
		String sdmonth = din.substring(5,7);
		int dinmonth = Integer.parseInt(sdmonth); //databse in month
		String sdday  = din.substring(8,10);
		int dinday = Integer.parseInt(sdday); //database in day
		//System.out.println(dinyear);
		//System.out.println(dinmonth);
		//System.out.println(dinday);
		int databaseIn = dinyear*365 + dinmonth*30 + dinday; //databaseIn is total for database checkin
		String sinyear = newInDate.substring(0,4);
		int inyear = Integer.parseInt(sinyear); // user in year
		String sinmonth = newInDate.substring(5,7);
		int inmonth = Integer.parseInt(sinmonth); //databse in month
		String sinday = newInDate.substring(8,10);
		int inday = Integer.parseInt(sinday); //databse in month
		//System.out.println(newInDate);
		//System.out.println(inyear);
		//System.out.println(inmonth);
		//System.out.println(inday);
		int userIn = inyear*365 + inmonth*30 + inday;
		sdyear = dout.substring(0,4);
		dinyear = Integer.parseInt(sdyear);
		sdmonth = dout.substring(5,7);
		dinmonth = Integer.parseInt(sdmonth);
		sdday  = dout.substring(8,10);
		dinday = Integer.parseInt(sdday);
		//System.out.println(dinyear);
		//System.out.println(dinmonth);
		//System.out.println(dinday);
		int databaseOut = dinyear*365 + dinmonth*30 + dinday;
		String soutyear = newOutDate.substring(0,4);
		int outyear = Integer.parseInt(soutyear); // user in year
		String soutmonth = newOutDate.substring(5,7);
		int outmonth = Integer.parseInt(soutmonth); //databse in month
		String soutday = newOutDate.substring(8,10);
		int outday = Integer.parseInt(soutday); //databse in month
		int userOut = outyear*365 + outmonth*30 + outday;
		//System.out.println(outyear);
		//System.out.println(outmonth);
		//System.out.println(outday);
		
		if((userIn >= databaseIn && userIn <= databaseOut) || (userOut <= databaseOut && userOut >= databaseIn)) {
			System.out.println("Cannot make your reservation. Time conflict");
			conflict = true;
			break;
		}
	}
	int Room_no = 0;
	if (conflict == false && first == true) {
		Room_no = 1;
	} else if (conflict == false) {
		Room_no = res2.getInt("Room_no");
	}
	//System.out.println(Room_no);
	//Make an insert statement for the Sells table:
		if(conflict==false) {
		String insert = "INSERT INTO Reservation(CID,HotelID ,InDate,OutDate,Room_no)"
				+ "VALUES (?,?,?,?,?)";

		//String reservation = "SELECT Reservation.InDate, Reservation.OutDate, FROM Room, Reservation "
				
				

		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, newCID);
		ps.setInt(2, newHotelID);
		ps.setString(3, newInDate);
		ps.setString(4, newOutDate);
		ps.setInt(5, Room_no);
		//Run the query against the DB
		//System.out.println(newCountry);
		//System.out.println(ps);
		ps.executeUpdate();
		}
	out.print("Your room has been booked! Press button to reload to page.");
} catch (Exception ex) {
	out.print("Your booking has failed please make sure you entered in the correct information, refer to PDF!");
}
%>

<a href="http://localhost:8080/HultonHotels/hotels.jsp"><button>Reload Home Page</button></a>

</body>
</html>
