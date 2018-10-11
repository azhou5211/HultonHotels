<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login jsp</title>
</head>
<body>

<%
		
	//Get username from entered input
	String updatedCID = request.getParameter("CID");
	session.putValue("Username",updatedCID); 
	String updatedCName = request.getParameter("CName");
	String updatedEmail = request.getParameter("Email");
	String updatedPhone = request.getParameter("Phone");
	String updatedAddress = request.getParameter("Address");
	String updatedPassword = request.getParameter("Password");
	
	//Create a connection string
	String url = "jdbc:mysql://cs336.cdosnw6vnspt.us-east-2.rds.amazonaws.com:3306/HotelSchema";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");
				
	//Create a connection to your DB
	Connection con = DriverManager.getConnection(url, "admin", "password");
				
	//Create a SQL statement
	Statement stmt = con.createStatement();

	ResultSet rs;
	
	int i= stmt.executeUpdate("UPDATE Customer set Password='"+updatedPassword+"',  CName = '"+updatedCName+"', Phone = '"+updatedPhone+"', Address = '"+updatedAddress+"',Email='"+updatedEmail+"' where CID='"+updatedCID+"'"); 
	System.out.println("Updated Account Information Successful!");
	response.sendRedirect("account.html");
%>

</body>
</html>