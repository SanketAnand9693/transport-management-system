<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
response.setContentType("application/json");
String vehicleNumber = request.getParameter("vehicleNumber");
String driverId = request.getParameter("driverId");
System.out.println(vehicleNumber + driverId);


String vehicleType =null;
try {
	if(vehicleNumber.equalsIgnoreCase("Select Vehicle Number") && driverId.equalsIgnoreCase("Select Driver") ){
		vehicleNumber = null;
		driverId = null;
		System.out.println(vehicleNumber + driverId);
	}
	if (vehicleNumber != null && driverId != null && !driverId.trim().equalsIgnoreCase("Select Driver") && !vehicleNumber.trim().equalsIgnoreCase("Select Vehicle Number") && !vehicleNumber.trim().isEmpty() && !driverId.trim().isEmpty()) {
		System.out.println("-------");
		//Update Vehicle Status
		PreparedStatement vehicleQuery = con.prepareStatement("UPDATE vehicle SET stats =? where vehicle_number=?;");
		vehicleQuery.setString(1, "active");
		vehicleQuery.setString(2, vehicleNumber);
		vehicleQuery.executeUpdate();
		
		//Update Driver Status
		PreparedStatement driverQuery = con.prepareStatement("UPDATE driver SET stats =? where driver_id=?;");
		driverQuery.setString(1, "active");
		driverQuery.setString(2, driverId);
		driverQuery.executeUpdate();
		
		//Get Vehicle Data
		PreparedStatement getDriverQuery = con.prepareStatement("SELECT * FROM driver WHERE driver_id=?");
		getDriverQuery.setString(1, driverId);
		ResultSet rsDriver = getDriverQuery.executeQuery();
		String firstName = null;
		String lastName = null;
		String contactNumber = null;
		if(rsDriver.next()){
			firstName= rsDriver.getString("first_name");
			lastName = rsDriver.getString("last_name");
			contactNumber = rsDriver.getString("contact_number");
		}
		
		//Get Vehicle Data
		PreparedStatement getVehicleQuery = con.prepareStatement("SELECT * FROM vehicle WHERE vehicle_number=?;");
		getVehicleQuery.setString(1, vehicleNumber);
		ResultSet rsVehicle = getVehicleQuery.executeQuery();
		if(rsVehicle.next()){
			vehicleType = rsVehicle.getString("vehicle_type");
		}		
	 	PreparedStatement assignDriver = con.prepareStatement("INSERT INTO driver_to_vehicle(vehicle_number, driver_id, first_name, last_name, contact_number, vehicle_type) VALUES(?,?,?,?,?,?);");
	 	assignDriver.setString(1,vehicleNumber);
		assignDriver.setString(2, driverId);
		assignDriver.setString(3, firstName);
		assignDriver.setString(4, lastName);
		assignDriver.setString(5, contactNumber);
		assignDriver.setString(6, vehicleType);
		assignDriver.executeUpdate();
		out.print("{\"status\":\"success\"}");
		return;
	}
} catch (Exception e) {
	e.printStackTrace();
	out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
}
%>
