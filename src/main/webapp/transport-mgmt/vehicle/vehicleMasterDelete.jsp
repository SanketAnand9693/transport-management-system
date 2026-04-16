<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
	response.setContentType("application/json");
	String vehicleNumber = request.getParameter("vehicleNumber");
	System.out.println(vehicleNumber);
	if (vehicleNumber != null && !vehicleNumber.trim().isEmpty()) {
		try {
			PreparedStatement pst= con.prepareStatement("DELETE from vehicle where vehicle_number=?");
			pst.setString(1, vehicleNumber);

			pst.executeUpdate();

			out.print("{\"status\":\"success\"}");
			return;

		} catch (Exception e) {
			response.setStatus(500);
			out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
			return;
		}
	}
	
%>