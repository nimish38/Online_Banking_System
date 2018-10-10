<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% 
	String acc,id,name,pass;
	PreparedStatement pr;
	response.setContentType("text/html");
	PrintWriter pw=response.getWriter();
	
	try{
		
		acc=request.getParameter("acc");
		id=request.getParameter("id");
		name=request.getParameter("nm");
		pass=request.getParameter("pwd");
		if(acc.equals("admin"))
		{
			if(id.equals("911") && name.equals("admin") && pass.equals("root"))
				response.sendRedirect("reg.html");
			else
				pw.println("Incorrect Credentials");
		}
		else
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root","");
			pr=con.prepareStatement("select pass from users where Acc_Id=?;");
			pr.setString(1,id);	
			ResultSet rs=pr.executeQuery();
			int flag=0;
			while(rs.next())
			{
				String z=rs.getString(1);
				if(pass.equals(z))
				{
					request.getSession().setAttribute("id", id);
					response.sendRedirect("details.jsp");
					flag=1;
					break;
				}
			}
			if(flag==0)
				pw.println("Incorrect Credentials");
		}
		
	}
	catch(Exception e)
	{}
%>