<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
response.setContentType("application/json");
String studentId = request.getParameter("studentId");
String routeNumber = request.getParameter("routeNumber");
String vehicleNumber = request.getParameter("vehicleNumber");
String firstName=null;
String lastName= null;
String contactNumber= null;
String studentClass= null;
try {
	if (vehicleNumber != null && studentId != null && !studentId.trim().equalsIgnoreCase("Select Driver") && !vehicleNumber.trim().equalsIgnoreCase("Select Vehicle Number") && !vehicleNumber.trim().isEmpty() && !studentId.trim().isEmpty()) {
		System.out.println("-------");
		//Update Vehicle Status
		PreparedStatement query = con.prepareStatement("Select * from student where student_id=?;");
		query.setString(1,studentId);
		ResultSet rs = query.executeQuery();
		if(rs.next()){
			firstName = rs.getString("first_name");
			lastName = rs.getString("last_name");
			contactNumber = rs.getString("guardian_number");
			studentClass = rs.getString("student_class");
		}
			PreparedStatement assignStudent= con.prepareStatement("UPDATE student_to_vehicle set route_number=? vehicle_number=? where student_id=?;");
			assignStudent.setString(1,routeNumber);
			assignStudent.setString(2, vehicleNumber);
			assignStudent.setString(3, studentId);
			assignStudent.executeUpdate();
		
		out.print("{\"status\":\"success\"}");
		return;
	}
} catch (Exception e) {
	e.printStackTrace();
	out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
}
%>
