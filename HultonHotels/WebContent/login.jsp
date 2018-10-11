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
	String uname = request.getParameter("CID");
	//Get password from entered input
	String pass = request.getParameter("Password");
		
	//Create a connection string
	String url = "jdbc:mysql://cs336.cdosnw6vnspt.us-east-2.rds.amazonaws.com:3306/HotelSchema";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");
				
	//Create a connection to your DB
	Connection con = DriverManager.getConnection(url, "admin", "password");
				
	//Create a SQL statement
	Statement stmt1 = con.createStatement();

	//Make a SELECT query from the Customer table that matches CID
	String user= "SELECT COUNT(*) as cnt FROM Customer WHERE CID = '"+uname+"'";
	
	//Run the query against the database.
	ResultSet res1 = stmt1.executeQuery(user);
	res1.next();
	int num1 = res1.getInt("cnt");
	
	if(num1>0) {
		//System.out.println("username is registered in database!");
	}else {
		System.out.println("username is not registered in database!");
		response.sendRedirect("home.html");
		return;
	}
	
	Statement stmt2 = con.createStatement();
	String passw = "SELECT Password as pwd FROM Customer WHERE CID = '" +uname+ "'";
	ResultSet res2 = stmt2.executeQuery(passw);
	res2.next();
	String pwd = res2.getString("pwd");
	
	if(pass.equals(pwd)) {
		session.setAttribute("Username",uname);
		response.sendRedirect("options.html");
	}else {
		System.out.println("Wrong Password please try again!");
		response.sendRedirect("home.html");
	}
	
	con.close();

%>
</body>
</html>