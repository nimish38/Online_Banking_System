<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
String acc,name,pass;
PreparedStatement pr;
response.setContentType("text/html");
PrintWriter pw=response.getWriter();
String id = (String) request.getSession().getAttribute("id");

try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root","");
	pr=con.prepareStatement("select * from users where Acc_id=?;");
	pr.setString(1,id);	
	ResultSet rs=pr.executeQuery();
	pw.println("<body bgcolor='gray'>");
	pw.println("<h1><i>Account Details</i></h1><br><br>");
	while(rs.next())
	{
		pw.println("Account_ID: "+rs.getString(1)+"<br>");
		pw.println("Name: "+rs.getString(2)+" "+rs.getString(3)+"<br>");
		pw.println("Email: "+rs.getString(5)+"<br>");
		pw.println("Phone: "+rs.getString(4)+"<br>");
		pw.println("Balance: "+rs.getString(7)+"<br>");
	}
	
	pw.println("<br>");
	request.getSession().setAttribute("id", id);
	pw.println("<a href='transfer.html'>Transfer Money</a>"+"<br>");
	pw.println("<a href='transaction.jsp'>Transaction details</a>"+"<br>");
	pw.println("<a href='Home.html'>Logout</a>"+"<br>");
	pw.println("</body>");
}
catch(Exception e)
{}
%>