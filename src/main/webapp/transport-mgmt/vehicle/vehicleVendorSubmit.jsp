<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
	response.setContentType("application/json");
	String organization = request.getParameter("organization");
	
	if(organization!=null && !organization.trim().isEmpty()){
		String firstName= null;
		String middleName= null;
		String lastName= null;
		String contactNumber= null;
		String address= null;
		try{
			firstName= request.getParameter("firstName");
			middleName= request.getParameter("middleName");
			lastName= request.getParameter("lastName");
			contactNumber= request.getParameter("contactNumber");
			address= request.getParameter("address");
			
			PreparedStatement query = con.prepareStatement("INSERT INTO vendors(organization, first_name, middle_name, last_name, contact_number, address) VALUES(?,?,?,?,?,?);");
			query.setString(1, organization);
			query.setString(2, firstName);
			query.setString(3,middleName);
			query.setString(4, lastName);
			query.setString(5,contactNumber);
			query.setString(6, address);
			
			query.executeUpdate();
			out.print("{\"status\":\"success\"}");
			return;
			
		} catch(Exception e){
			e.printStackTrace();
			out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
			return;
		}
	}
%>