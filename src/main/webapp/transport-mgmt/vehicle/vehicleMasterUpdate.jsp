<%@page import="java.sql.Date"%>
<%@ page import="java.sql.*"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<%
response.setContentType("application/json");

String vehicleNumber = request.getParameter("vehicleNumber");

if (vehicleNumber != null && !vehicleNumber.trim().isEmpty()) {
	String modifiedBy = (String) session.getAttribute("userid");

	Date modifiedOn = new Date(System.currentTimeMillis());
	try {
		PreparedStatement pst = con.prepareStatement(
		"Update vehicle set vehicle_type=?, seating_capacity=?, fuel_type=?, model_name=?, model_year=?, vendor=?, insurance_company=?, policy_number=?, insurance_expiry=?, polution_expiry=?, gps=?, speed=?, updated_by=?, updated_on=? WHERE vehicle_number=? ;");

		pst.setString(1, request.getParameter("vehicleType"));
		pst.setString(2, request.getParameter("seatCapacity"));
		pst.setString(3, request.getParameter("fuelType"));
		pst.setString(4, request.getParameter("modelName"));
		pst.setString(5, request.getParameter("modelYear"));
		pst.setString(6, request.getParameter("vendor"));
		pst.setString(7, request.getParameter("insuranceCompany"));
		pst.setString(8, request.getParameter("policyNumber"));
		pst.setString(9, request.getParameter("insuranceExpiry"));
		pst.setString(10, request.getParameter("polutionExpiry"));
		pst.setString(11, request.getParameter("gps"));
		pst.setString(12, request.getParameter("speed"));
		pst.setString(13, modifiedBy);
		pst.setDate(14, modifiedOn);
		pst.setString(15, vehicleNumber);
	
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