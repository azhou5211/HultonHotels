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
	String newCName = request.getParameter("CName");
	String newEmail = request.getParameter("Email");
	String newPhone = request.getParameter("Phone");
	String newAddress = request.getParameter("Address");
	String newPassword = request.getParameter("Password");

	//Make an insert statement for the Sells table:
	String insert = "INSERT INTO Customer(CID, CName, Email, Phone, Address, Password)"
			+ "VALUES (?, ?, ?, ?, ?, ?)";
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(insert);

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	ps.setString(1, newCID);
	ps.setString(2, newCName);
	ps.setString(3, newEmail);
	ps.setString(4, newPhone);
	ps.setString(5, newAddress);
	ps.setString(6, newPassword);
	//Run the query against the DB
	ps.executeUpdate();

	out.print("Registration is complete! Press button to reload to login/registration page.");
} catch (Exception ex) {
	out.print("insert failed please reload page!");
}
%>

<a href="http://localhost:8080/HultonHotels/home.html"><button>Reload Home Page</button></a>

</body>
</html>