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
			PreparedStatement assignStudent= con.prepareStatement("INSERT INTO student_to_vehicle(vehicle_number, student_id, first_name, last_name, contact_number, class, route_number) VALUES(?,?,?,?,?,?,?);");
			assignStudent.setString(1,vehicleNumber);
			assignStudent.setString(2, studentId);
			assignStudent.setString(3, firstName);
			assignStudent.setString(4,lastName);
			assignStudent.setString(5,contactNumber);
			assignStudent.setString(6, studentClass);
			assignStudent.setString(7,routeNumber);
			assignStudent.executeUpdate();
		
		out.print("{\"status\":\"success\"}");
		return;
	}
} catch (Exception e) {
	e.printStackTrace();
	out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
}
%>
