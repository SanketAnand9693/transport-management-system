<%@page import="java.io.InputStream"%>
<%@ page import="java.sql.*"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<%
	response.setContentType("application/json");

	String studentId = request.getParameter("studentId");
	
	System.out.println(studentId);
	if (studentId != null && !studentId.trim().isEmpty()) {
		String createdBy = (String) session.getAttribute("userid");
		Date createdOn = new Date(System.currentTimeMillis());
		System.out.println("in if condition execution");
		try {
			PreparedStatement pst = con.prepareStatement(
			"INSERT INTO student (student_id, student_class, guardian_number, first_name, middle_name, last_name , pickup_drop_point, address,  created_by, created_on, updated_by, updated_on) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)");
			
		
			pst.setString(1, studentId);
			pst.setString(2, request.getParameter("studentClass"));
			pst.setString(3, request.getParameter("guardianContactNumber"));
			pst.setString(4, request.getParameter("firstName"));
			pst.setString(5, request.getParameter("middleName"));
			pst.setString(6, request.getParameter("lastName"));
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