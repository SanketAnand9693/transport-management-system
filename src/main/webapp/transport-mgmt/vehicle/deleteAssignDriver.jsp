<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
response.setContentType("application/json");
try {
	String vehicleNumber = request.getParameter("vehicleNumber");
	String driverId = request.getParameter("driverId");

	if (vehicleNumber != null && driverId != null && !vehicleNumber.trim().isEmpty() && !driverId.trim().isEmpty()) {
		//Query for Update Status Driver
		PreparedStatement changeDriverStatus = con.prepareStatement("UPDATE driver SET stats=? WHERE driver_id=?");
		changeDriverStatus.setString(1, "inactive");
		changeDriverStatus.setString(2, driverId);
		changeDriverStatus.executeUpdate();
		
		//Query for Update Status Vehicle
		PreparedStatement changeVehicleStatus = con
		.prepareStatement("UPDATE vehicle SET stats=? WHERE vehicle_number=?");
		changeVehicleStatus.setString(1, "inactive");
		changeVehicleStatus.setString(2, vehicleNumber);
		changeVehicleStatus.executeUpdate();
		
		//Query for DELETE 
		PreparedStatement pst = con.prepareStatement("DELETE from driver_to_vehicle WHERE vehicle_number=?");
		pst.setString(1, vehicleNumber);
		pst.executeUpdate();	
		out.print("{\"status\":\"success\"}");
		return;

	}
} catch (Exception e) {
	e.printStackTrace();
	out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
	return;
}
%>