


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
	String newCname = request.getParameter("CName");
	String newBillingAddr = request.getParameter("BillingAddr");
	String newCType = request.getParameter("CType");
	String newCNumber = request.getParameter("CNumber");
	String newexpDate = request.getParameter("expDate");
	String newSecCode = request.getParameter("SecCode");

	//Make an insert statement for the Credit table:
	String insert = "INSERT INTO Credit(CName, BillingAddr, CType, CNumber, expDate, SecCode)"
			+ "VALUES (?, ?, ?, ?, ?, ?)";
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(insert);

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	ps.setString(1, newCname);
	ps.setString(2, newBillingAddr);
	ps.setString(3, newCType);
	ps.setString(4, newCNumber);
	ps.setString(5, newexpDate);
	ps.setString(6, newSecCode);
	//Run the query against the DB
	//System.out.println(ps);
	ps.executeUpdate();

	String newCID = request.getParameter("CID");
	insert = "INSERT INTO Owns(CID,CNumber)"
			+ "VALUES (?, ?)";
	ps = con.prepareStatement(insert);
	ps.setString(1, newCID);
	ps.setString(2, newCNumber);
	ps.executeUpdate();
	out.print("Succesfully added credit card! Press button to reload to home page.");
} catch (Exception ex) {
	out.print("You have failed to add a credit card please enter in the right information refer to PDF! press button to reload page!");
}
%>

<a href="http://localhost:8080/HultonHotels/account.html"><button>Reload Home Page</button></a>

</body>
</html>