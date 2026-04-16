<%@page import="java.sql.Date"%>
<%@ page import="java.sql.*"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<% 
	response.setContentType("application/json");

	String vehicleNumber = request.getParameter("vehicleNumber");

	if (vehicleNumber != null && !vehicleNumber.trim().isEmpty()) {
		String createdBy = (String) session.getAttribute("userid");
		Date createdOn = new Date(System.currentTimeMillis());
		try {
			PreparedStatement pst = con.prepareStatement(
			"INSERT INTO vehicle (vehicle_number, vehicle_type, seating_capacity, fuel_type, model_name, model_year, vendor, insurance_company, policy_number, insurance_expiry, polution_expiry, gps, speed, created_by, created_on, updated_by, updated_on) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

			pst.setString(1, vehicleNumber);
			pst.setString(2, request.getParameter("vehicleType"));
			pst.setString(3, request.getParameter("seatCapacity"));
			pst.setString(4, request.getParameter("fuelType"));
			pst.setString(5, request.getParameter("modelName"));
			pst.setString(6, request.getParameter("modelYear"));
			pst.setString(7, request.getParameter("vendor"));
			pst.setString(8, request.getParameter("insuranceCompany"));
			pst.setString(9, request.getParameter("policyNumber"));
			pst.setString(10, request.getParameter("insuranceExpiryDate"));
			pst.setString(11, request.getParameter("polutionExpiryDate"));
			pst.setString(12, request.getParameter("gps"));
			pst.setString(13, request.getParameter("speed"));
			pst.setString(14, createdBy);
			pst.setDate(15, createdOn);
			pst.setString(16, null);
			pst.setString(17, null);

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