<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
	response.setContentType("application/json");
	String vehicleNumber = request.getParameter("vehicle_number");
	
	
	if (vehicleNumber != null && !vehicleNumber.trim().isEmpty()) {
		
		try {
			 PreparedStatement pst =
					  con.prepareStatement("SELECT * FROM vehicle WHERE vehicle_number=?");

			pst.setString(1, vehicleNumber);
			
			ResultSet rs= pst.executeQuery();
			JSONObject vehicleData = new JSONObject();
			
			
			if(rs.next()){
				
				vehicleData.put("vehicle_number", vehicleNumber);
				vehicleData.put("vehicle_type",rs.getString("vehicle_type"));
				vehicleData.put("seating_capacity",rs.getString("seating_capacity"));
				vehicleData.put("fuel_type",rs.getString("fuel_type"));
				vehicleData.put("model_name",rs.getString("model_name"));
				vehicleData.put("model_year", rs.getString("model_year"));
				vehicleData.put("vehicle_owner", rs.getString("vehicle_owner"));
				vehicleData.put("insurance_company",rs.getString("insurance_company"));
				vehicleData.put("policy_number",rs.getString("policy_number"));
				vehicleData.put("insurance_expiry", rs.getString("insurance_expiry"));
				vehicleData.put("polution_expiry",rs.getString("polution_expiry"));
				vehicleData.put("gps",rs.getString("gps"));
				vehicleData.put("speed",rs.getString("speed"));
				vehicleData.put("updated_on",rs.getString("updated_on"));
				vehicleData.put("updated_by",rs.getString("updated_by")); 
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