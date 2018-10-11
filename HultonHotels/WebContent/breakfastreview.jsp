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
	String newType = request.getParameter("Type");
	String newRating = request.getParameter("Rating");
	String newTextComment = request.getParameter("TextComment");
	String newRDate = request.getParameter("RDate");
	int newHotelID = ' ';
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
	String insert = "INSERT INTO Review(HotelID,RType ,Typess, Rating, TextComment, RDate)"
			+ "VALUES (?,'Breakfast' ,?, ?, ?, ?)";
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(insert);

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	ps.setInt(1, newHotelID);
	ps.setString(2, newType);
	ps.setString(3, newRating);
	ps.setString(4, newTextComment);
	ps.setString(5, newRDate);
	//Run the query against the DB
	//System.out.println(newCountry);
	//System.out.println(ps);
	ps.executeUpdate();
	
	//Pulls out the ReviewID
	Statement stmt2 = con.createStatement();
	String passw = "SELECT ReviewID as RID FROM Review WHERE RType = 'Breakfast' and Typess = '" + newType + "' and Rating = " + newRating + " and TextComment = '" + newTextComment + "'";
	//System.out.println(passw);
	ResultSet res2 = stmt2.executeQuery(passw);
	res2.next();
	int pwd = res2.getInt("RID");
	//System.out.println(pwd);

	insert = "INSERT INTO Evaluates(ReviewID,CID)"
			+ "VALUES (" + pwd + ",?)";
	ps = con.prepareStatement(insert);
	ps.setString(1, newCID);
	//System.out.println(ps);
	ps.executeUpdate();
			
	out.print("Review is submitted! Press button to reload to login/registration page.");
} catch (Exception ex) {
	out.print("Your breakfast review has failed please make sure you entered in the correct information, refer to PDF!");
}
%>

<a href="http://localhost:8080/HultonHotels/review.html"><button>Reload Home Page</button></a>

</body>
</html>
