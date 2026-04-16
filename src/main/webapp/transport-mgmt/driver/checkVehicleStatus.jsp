check vehicle status ======================
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
response.setContentType("application/json");
String vehicleNumber = request.getParameter("vehicleNumber");
if (vehicleNumber != null) {
	try {
		String sql = "SELECT stats FROM vehicle WHERE vehicle_number = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, vehicleNumber.toUpperCase());

		ResultSet rs = ps.executeQuery();

		if (rs.next()) {
	String status = rs.getString("stats");
	if (status.equals("active")) {
		out.println("{\"status\":\"active\",\"message\":\"already assigned\"}");
	} else if (status.equals("service")) {
		out.println("{\"status\":\"not_active\",\"message\":\"Under maintenance!\"}");
	} else {
		/* out.println("{\"status\":\"available\",\"message\":\"available\"}"); */

		String assign = "UPDATE vehicle SET status = ? WHERE vehicle_number = ?";
		PreparedStatement pst = con.prepareStatement(assign);

		ps.setString(1, "available");
		ps.setString(2, vehicleNumber);
		ps.executeUpdate();

	}
		} else {
	out.println("{\"status\":\"error\",\"message\":\"Not registered vehicle\"}");
		}
	} catch (Exception e) {
		response.setStatus(500);
		out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
		return;
	}

}
%>