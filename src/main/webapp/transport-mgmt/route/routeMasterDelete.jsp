<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
	response.setContentType("application/json");
	String routeNumber = request.getParameter("routeNumber");
	System.out.println(routeNumber);
	if (routeNumber != null && !routeNumber.trim().isEmpty()) {
		try {
			PreparedStatement pst= con.prepareStatement("DELETE from route where route_number=?");
			pst.setString(1, routeNumber);

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