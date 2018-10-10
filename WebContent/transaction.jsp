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
	pr=con.prepareStatement("select * from trans where debited_id=?;");
	pr.setString(1,id);	
	ResultSet rs=pr.executeQuery();
	pw.println("<body bgcolor='yellow'>");
	pw.println("<h1><i>Transaction Details</i></h1><br><br>");
	pw.println("<table border=2>");
	pw.println("<tr><td><h3>Creditor_ID</h3></td><td><h3>Credited_amount</h3></td></tr>");
	while(rs.next()){
		pw.println("<tr><td>");
		pw.println(rs.getString(1)+"</td><td>");
		pw.println(rs.getString(2)+"</td></tr>");
	}
	pw.println("</table><br><br>");
	request.getSession().setAttribute("id", id);
	pw.println("<a href='details.jsp'>My Account</a>");
}
catch(Exception e)
{}
%>