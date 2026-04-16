<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
response.setContentType("application/json");
String staffId = request.getParameter("staffId");
String routeNumber = request.getParameter("routeNumber");
String vehicleNumber = request.getParameter("vehicleNumber");
String firstName=null;
String lastName= null;
String contactNumber= null;
String department= null;
try {
	if (vehicleNumber != null && staffId != null && !staffId.trim().equalsIgnoreCase("Select Driver") && !vehicleNumber.trim().equalsIgnoreCase("Select Vehicle Number") && !vehicleNumber.trim().isEmpty() && !staffId.trim().isEmpty()) {
		System.out.println("-------");
		//Update Vehicle Status
		PreparedStatement query = con.prepareStatement("Select * from staff where staff_id=?;");
		query.setString(1,staffId);
		ResultSet rs = query.executeQuery();
		if(rs.next()){
			firstName = rs.getString("first_name");
			lastName = rs.getString("last_name");
			contactNumber = rs.getString("guardian_number");
			department = rs.getString("department");
		}
			PreparedStatement assignStudent= con.prepareStatement("INSERT INTO staff_to_vehicle(vehicle_number, staff_id, first_name, last_name, contact_number, department, route_number) VALUES(?,?,?,?,?,?,?);");
			assignStudent.setString(1,vehicleNumber);
			assignStudent.setString(2, staffId);
			assignStudent.setString(3, firstName);
			assignStudent.setString(4,lastName);
			assignStudent.setString(5,contactNumber);
			assignStudent.setString(6, department);
			assignStudent.setString(7,routeNumber);
			assignStudent.executeUpdate();
		
		out.print("{\"status\":\"success\"}");
		return;
	}
} catch (Exception e) {
	e.printStackTrace();
	String message = e.getMessage();
			if(e.getMessage().equalsIgnoreCase(message)){
				message = "This Staff ID already registered!";
			}
			else{
				message = "something went wrong";
			}
	out.print("{\"status\":\"error\",\"message\":\"" + message + "\"}");
}
%>
