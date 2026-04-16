<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
	response.setContentType("application/json");
	String driverId= request.getParameter("driver_id");
	System.out.println(driverId);
	
	if (driverId != null && !driverId.trim().isEmpty()) {
		
		try {
			 PreparedStatement pst =
					  con.prepareStatement("SELECT * FROM driver WHERE driver_id=?");

			pst.setString(1, driverId);
			
			ResultSet rs= pst.executeQuery();
			JSONObject driverData = new JSONObject();
			
			
			if(rs.next()){
				
				driverData.put("driver_id", rs.getString("driver_id"));
				driverData.put("first_name",rs.getString("first_name"));
				driverData.put("middle_name",rs.getString("middle_name"));
				driverData.put("last_name",rs.getString("last_name"));
				driverData.put("contact_number",rs.getString("contact_number"));
				driverData.put("driver_address", rs.getString("address"));
				driverData.put("vehicle_type", rs.getString("vehicle_type"));
				driverData.put("licence_number",rs.getString("licence_number"));
				driverData.put("licence_type",rs.getString("licence_type"));
				driverData.put("licence_date", rs.getString("licence_date"));
				driverData.put("experience",rs.getString("exp"));
				driverData.put("training",rs.getString("training"));
			}
		
			
			JSONObject result = new JSONObject();
			result.put("status", "success");
			result.put("data", driverData);
			out.print(result.toJSONString());
			return;

		} catch (Exception e) {
			response.setStatus(500);
			out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
			return;
		}
	}
	
%>