<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
response.setContentType("application/json");
String routeNumber = request.getParameter("routeNumber");
System.out.println("Route: "+ routeNumber);

if (routeNumber != null && !routeNumber.trim().isEmpty()) {

	try {
		PreparedStatement pst = con.prepareStatement("SELECT * FROM route WHERE route_number=?");

		pst.setString(1, routeNumber);

		ResultSet rs = pst.executeQuery();
		JSONObject routeData = new JSONObject();

		if (rs.next()) {

	routeData.put("route_number", routeNumber);
	routeData.put("bus_stop_1", rs.getString("bus_stop_1"));
	routeData.put("bus_stop_2", rs.getString("bus_stop_2"));
	routeData.put("bus_stop_3", rs.getString("bus_stop_3"));
	routeData.put("bus_stop_4", rs.getString("bus_stop_4"));
	routeData.put("bus_stop_5", rs.getString("bus_stop_5"));
	routeData.put("bus_stop_6", rs.getString("bus_stop_6"));
		}

		JSONObject result = new JSONObject();
		result.put("status", "success");
		result.put("data", routeData);
		out.print(result.toJSONString());
		return;

	} catch (Exception e) {
		response.setStatus(500);
		out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
		return;
	}
}
%>