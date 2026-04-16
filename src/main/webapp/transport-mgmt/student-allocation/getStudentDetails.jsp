<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
	response.setContentType("application/json");
	String studentId = request.getParameter("student_id");
	
	
	if (studentId != null && !studentId.trim().isEmpty()) {
		
		try {
			 PreparedStatement pst =
					  con.prepareStatement("SELECT * FROM student WHERE student_id=?");

			pst.setString(1, studentId);
			
			ResultSet rs= pst.executeQuery();
			JSONObject studentData = new JSONObject();
			
			
			if(rs.next()){
				
				studentData.put("student_class", rs.getString("student_class"));
				studentData.put("student_id", studentId);
				studentData.put("guardian_number", rs.getString("guardian_number"));
				studentData.put("first_name", rs.getString("first_name"));
				studentData.put("middle_name", rs.getString("middle_name"));
				studentData.put("last_name", rs.getString("last_name"));
				studentData.put("pickup_drop_point", rs.getString("pickup_drop_point"));
				studentData.put("address", rs.getString("address"));
			}
		
			
			JSONObject result = new JSONObject();
			result.put("status", "success");
			result.put("data", studentData);
			out.print(result.toJSONString());
			return;

		} catch (Exception e) {
			response.setStatus(500);
			out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
			return;
		}
	}
	
%>