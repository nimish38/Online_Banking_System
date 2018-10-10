<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.util.UUID" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	String em,ph,nm,snm,usr,pwd,bal;
	PreparedStatement pr;
	response.setContentType("text/html");
	PrintWriter pw=response.getWriter();
	
	nm=request.getParameter("nm");
	snm=request.getParameter("snm");
	ph=request.getParameter("ph");
	em=request.getParameter("em");
	bal=request.getParameter("bal");

	
	int m = (int)(Math.random()*((10000-100)+1))+100;
    usr=Integer.toString(m);
	pwd=snm+"_"+nm;
	pw.println("<body bgcolor='cyan'>");
	pw.println("<h1><i>Account Info</i></h1><br><br>");
	pw.println("Account ID: "+usr+"<br>");
	pw.println("Name: "+nm+" "+snm+"<br>");
	pw.println("Email Id: "+em+"<br>");
	pw.println("Phone: "+ph+"<br>");
	pw.println("Password: "+pwd+"<br>");
	pw.println("Account Balance: "+bal+"<br>");
	pw.println("<br>");
	
	try{
		Class.forName("com.mysql.jdbc.Driver");	
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root","");
		Statement st=con.createStatement();
		int x=Integer.parseInt(bal);
		st.executeUpdate("insert into users values('"+usr+"','"+nm+"','"+snm+"','"+ph+"','"+em+"','"+pwd+"','"+x+"');");
	}
	catch(Exception e)
	{}
	pw.println("      * remember account_id and password for login"+"<br>");
	pw.println("<br>");
	pw.println("<br>"+"<a href='Home.html'>Home</a>");


%>