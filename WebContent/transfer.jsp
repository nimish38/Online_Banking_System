<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% 
	String cid,yid,name,pass,at;
	PreparedStatement pr;
	response.setContentType("text/html");
	PrintWriter pw=response.getWriter();
	
	try{
		
		cid=request.getParameter("cid");
		yid=request.getParameter("yid");
		name=request.getParameter("nm");
		pass=request.getParameter("pd");
		at=request.getParameter("amt");
		
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root","");
			pr=con.prepareStatement("select pass,bal from users where Acc_Id=?;");
			pr.setString(1,yid);	
			ResultSet rs=pr.executeQuery();
			pw.println("<body bgcolor='orange'>");
			int flag=0;
			while(rs.next())
			{
				String z=rs.getString(1);
				if(pass.equals(z))
				{
					int bamt=Integer.parseInt(rs.getString(2));
					int ramt=Integer.parseInt(at);
					if(ramt<bamt)
					{
						pr=con.prepareStatement("update users set bal=bal-'"+ramt+"' where Acc_id='"+yid+"';");
						pr.executeUpdate();
						pr=con.prepareStatement("update users set bal=bal+'"+ramt+"' where Acc_id='"+cid+"';");
						pr.executeUpdate();
						Statement st=con.createStatement();
						st.executeUpdate("insert into trans values('"+cid+"','"+at+"','"+yid+"');");

						pw.println("Payment Successful"+"<br>");
						request.getSession().setAttribute("id", yid);
						pw.println("<a href='details.jsp'>My Account</a>");

					}
					else
						pw.println("Insufficient Balance");
					flag=1;
					break;
				}
			}
			if(flag==0)
				pw.println("Incorrect Credentials");
		
		
	}
	catch(Exception e)
	{}
%>