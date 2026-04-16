<%@page import="java.sql.Date"%>
<%@ page import="java.sql.*"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<%
response.setContentType("application/json");

String staffId = request.getParameter("staffId");

if (staffId != null && !staffId.trim().isEmpty()) {
	String modifiedBy = (String) session.getAttribute("userid");

	Date modifiedOn = new Date(System.currentTimeMillis());
	System.out.println(staffId);
	try {
		PreparedStatement pst = con.prepareStatement(
		"UPDATE staff SET department=?, guardian_number=?, first_name=?, middle_name=?, last_name=?, pickup_drop_point=?, address=?, updated_by=?, updated_on=? WHERE staff_id=? ;");

		pst.setString(1, request.getParameter("department"));
		pst.setString(2, request.getParameter("guardianContactNumber"));
		pst.setString(3, request.getParameter("staffFirstName"));
		pst.setString(4, request.getParameter("staffMiddleName"));
		pst.setString(5, request.getParameter("staffLastName"));
		pst.setString(6, request.getParameter("pickupDropPoint"));
		pst.setString(7, request.getParameter("address"));
		pst.setString(8, modifiedBy);
		pst.setDate(9, modifiedOn);
		pst.setString(10, staffId);
		pst.executeUpdate();
		out.print("{\"status\":\"success\"}");
		return;

	} catch (Exception e) {
		e.printStackTrace();

		response.setStatus(500);
		out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
		return;
	}
}
%>