<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
	response.setContentType("application/json");
	String studentId = request.getParameter("student_id");
	System.out.println(studentId);
	if (studentId != null && !studentId.trim().isEmpty()) {
		try {
			PreparedStatement pst= con.prepareStatement("DELETE from student where student_id=?");
			pst.setString(1, studentId);

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