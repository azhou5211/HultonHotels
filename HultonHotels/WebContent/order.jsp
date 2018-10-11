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
	String newSType = request.getParameter("SType");
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
	
	
	//Make an insert statement for the Sells table:
	String insert = "INSERT INTO Orders(CID,HotelID ,SType)"
			+ "VALUES (?,?,?)";

	//String reservation = "SELECT Reservation.InDate, Reservation.OutDate, FROM Room, Reservation "
	
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(insert);

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	ps.setString(1, newCID);
	ps.setInt(2, newHotelID);
	ps.setString(3, newSType);
	//Run the query against the DB
	//System.out.println(newCountry);
	//System.out.println(ps);
	ps.executeUpdate();
			
	out.print("Your service order has been submitted! Press button to reload to page.");
} catch (Exception ex) {
	out.print("Your service order has failed please make sure you entered in the correct information, refer to PDF!");
}
%>

<a href="http://localhost:8080/HultonHotels/hotels.jsp"><button>Reload Home Page</button></a>

</body>
</html>
