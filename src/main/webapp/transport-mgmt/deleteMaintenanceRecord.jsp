<%@page import="java.sql.Date"%>
<%@ page import="java.sql.*"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<%
response.setContentType("application/json");

String vehicleNumber = request.getParameter("vehicleNumber");

if (vehicleNumber != null && !vehicleNumber.trim().isEmpty()) {
	String createdBy = (String) session.getAttribute("userid");

	Date createdOn = new Date(System.currentTimeMillis());
	System.out.println(vehicleNumber);
	try {
		//Getting the vehicle data for driver ID
		PreparedStatement getDriverToVehicle = con
		.prepareStatement("SELECT * FROM driver_to_vehicle WHERE vehicle_number=?");
		getDriverToVehicle.setString(1, vehicleNumber);
		ResultSet rs = getDriverToVehicle.executeQuery();
		String driverId = null;
		if (rs.next()) {
			driverId = rs.getString("driver_id");
		}
		
		PreparedStatement changeDriverToVehicleStatus = con.prepareStatement("UPDATE maintenance SET stats=? WHERE vehicle_number=?");
		changeDriverToVehicleStatus.setString(1, "active");
		changeDriverToVehicleStatus.setString(2, vehicleNumber);
		changeDriverToVehicleStatus.executeUpdate();

		/* Query for Update Status Driver */
		PreparedStatement changeDriverStatus = con.prepareStatement("UPDATE driver SET stats=? WHERE driver_id=?");
		changeDriverStatus.setString(1, "active");
		changeDriverStatus.setString(2, driverId);
		changeDriverStatus.executeUpdate();

		//Query for Update Status Vehicle
		PreparedStatement changeVehicleStatus = con
		.prepareStatement("UPDATE vehicle SET stats=? WHERE vehicle_number=?");
		changeVehicleStatus.setString(1, "active");
		changeVehicleStatus.setString(2, vehicleNumber);
		changeVehicleStatus.executeUpdate();

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