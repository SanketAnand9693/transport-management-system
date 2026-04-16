<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
	response.setContentType("application/json");
	String staffId = request.getParameter("staff_id");
	if (staffId != null && !staffId.trim().isEmpty()) {
		try {
			PreparedStatement pst= con.prepareStatement("DELETE from staff where staff_id=?");
			pst.setString(1, staffId);

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