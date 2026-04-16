<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" %>


<% 
Connection con = null;
try{
Class.forName("com.mysql.cj.jdbc.Driver");
//Connection
con=DriverManager.getConnection("jdbc:mysql://localhost:3306/transport_mgmt?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true","root","Sanket@9693");
PreparedStatement pst= null;
ResultSet rs=null;
	
} catch(Exception e){
	e.printStackTrace();
}

%>
