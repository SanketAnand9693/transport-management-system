<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
response.setContentType("application/json");
String staffId = request.getParameter("staff_id");

if (staffId != null && !staffId.trim().isEmpty()) {

	try {
		PreparedStatement pst = con.prepareStatement("SELECT * FROM staff WHERE staff_id=?");

		pst.setString(1, staffId);

		ResultSet rs = pst.executeQuery();
		JSONObject vehicleData = new JSONObject();

		if (rs.next()) {

	vehicleData.put("staff_id", staffId);
	vehicleData.put("department", rs.getString("department"));
	vehicleData.put("guardian_number", rs.getString("guardian_number"));
	vehicleData.put("first_name", rs.getString("first_name"));
	vehicleData.put("middle_name", rs.getString("middle_name"));
	vehicleData.put("last_name", rs.getString("last_name"));
	vehicleData.put("pickup_drop_point", rs.getString("pickup_drop_point"));
	vehicleData.put("address", rs.getString("address"));
		}

		JSONObject result = new JSONObject();
		result.put("status", "success");
		result.put("data", vehicleData);
		out.print(result.toJSONString());
		return;

	} catch (Exception e) {
		response.setStatus(500);
		out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
		return;
	}
}
%>