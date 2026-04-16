<%@page import="java.sql.Date"%>
<%@ page import="java.sql.*"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<%
response.setContentType("application/json");

String studentId = request.getParameter("studentId");
System.out.println(studentId);
if (studentId != null && !studentId.trim().isEmpty()) {
	String modifiedBy = (String) session.getAttribute("userid");

	Date modifiedOn = new Date(System.currentTimeMillis());
	System.out.println(studentId);
	try {
		PreparedStatement pst = con.prepareStatement(
		"UPDATE student SET student_class=?, guardian_number=?, first_name=?, middle_name=?, last_name=?, pickup_drop_point=?, address=?, updated_by=?, updated_on=? WHERE student_id=? ;");

		pst.setString(1, request.getParameter("studentClass"));
		pst.setString(2, request.getParameter("guardianContactNumber"));
		pst.setString(3, request.getParameter("firstName"));
		pst.setString(4, request.getParameter("middleName"));
		pst.setString(5, request.getParameter("lastName"));
		pst.setString(6, request.getParameter("pickupDropPoint"));
		pst.setString(7, request.getParameter("address"));
		pst.setString(8, modifiedBy);
		pst.setDate(9, modifiedOn);
		pst.setString(10, studentId);
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