<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
response.setContentType("application/json");
String staffId = request.getParameter("staff_Id");
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
			PreparedStatement assignStudent= con.prepareStatement("UPDATE staff_to_vehicle set route_number=? vehicle_number=? where staff_id=?;");
			assignStudent.setString(1,routeNumber);
			assignStudent.setString(2, vehicleNumber);
			assignStudent.setString(3, staffId);
			assignStudent.executeUpdate();
		
		out.print("{\"status\":\"success\"}");
		return;
	}
} catch (Exception e) {
	e.printStackTrace();
	out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
}
%>
