<%@page import="java.sql.Date"%>
<%@ page import="java.sql.*"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<%
response.setContentType("application/json");

String driverId = request.getParameter("driverId");

if (driverId != null && !driverId.trim().isEmpty()) {
	String modifiedBy = (String) session.getAttribute("userid");

	Date modifiedOn = new Date(System.currentTimeMillis());
	System.out.println(driverId);
	try {
		PreparedStatement pst = con.prepareStatement(
		"UPDATE driver SET first_name=?, middle_name=?, last_name=?, contact_number=?, address=?, vehicle_type=?, licence_number=?, licence_type=?, licence_date=?, exp=?, training=?, updated_by=?, updated_on=? WHERE driver_id=? ;");

		pst.setString(1, request.getParameter("firstName"));
		pst.setString(2, request.getParameter("middleName"));
		pst.setString(3, request.getParameter("lastName"));
		pst.setString(4, request.getParameter("contactNumber"));
		pst.setString(5, request.getParameter("driverAddress"));
		pst.setString(6, request.getParameter("vehicleType"));
		pst.setString(7, request.getParameter("licenceNumber"));
		pst.setString(8, request.getParameter("licenceType"));
		pst.setString(9, request.getParameter("licenceDate"));
		pst.setString(10, request.getParameter("experience"));
		pst.setString(11, request.getParameter("training"));
		pst.setString(12, modifiedBy);
		pst.setDate(13, modifiedOn);
		pst.setString(14, driverId);
	
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