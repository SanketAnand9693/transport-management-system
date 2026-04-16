<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<%
response.setContentType("application/json");

String staffId = request.getParameter("staffId");
System.out.println(staffId);
if (staffId != null && !staffId.trim().isEmpty()) {
	String createdBy = (String) session.getAttribute("userid");
	Date createdOn = new Date(System.currentTimeMillis());
	System.out.println("in if condition execution");
	try {
		PreparedStatement pst = con.prepareStatement(
		"INSERT INTO staff (staff_id, department, guardian_number, first_name, middle_name, last_name , pickup_drop_point, address, created_by, created_on, updated_by, updated_on) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)");

		pst.setString(1, staffId);
		pst.setString(2, request.getParameter("department"));
		pst.setString(3, request.getParameter("guardianContactNumber"));
		pst.setString(4, request.getParameter("staffFirstName"));
		pst.setString(5, request.getParameter("staffMiddleName"));
		pst.setString(6, request.getParameter("staffLastName"));
		pst.setString(7, request.getParameter("pickupDropPoint"));
		pst.setString(8, request.getParameter("address"));
		
		pst.setString(9, createdBy);
		pst.setDate(10, createdOn);
		pst.setString(11,null);
		pst.setString(12,null);

		pst.executeUpdate();

		out.print("{\"status\":\"success\"}");
		return;

	} catch (Exception e) {
		response.setStatus(500);
		out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
		return;
	}
}
%>