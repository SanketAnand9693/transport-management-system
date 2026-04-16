<%@page import="java.sql.Date"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
response.setContentType("application/json");
try {
	String routeName = request.getParameter("routeName");
	if (routeName != null && !routeName.trim().isEmpty()) {
		String createdBy = (String) session.getAttribute("userid");
		Date createdOn = new Date(System.currentTimeMillis());
		PreparedStatement pst = con.prepareStatement(
		"INSERT INTO route(route_number, bus_stop_1, bus_stop_2, bus_stop_3, bus_stop_4, bus_stop_5, bus_stop_6) 			values (?,?,?,?,?,?,?);");
		pst.setString(1, routeName);
		pst.setString(2,request.getParameter("busStop1"));
		pst.setString(3,request.getParameter("busStop2"));
		pst.setString(4,request.getParameter("busStop3"));
		pst.setString(5,request.getParameter("busStop4"));
		pst.setString(6,request.getParameter("busStop5"));
		pst.setString(7,request.getParameter("busStop6"));
		
		pst.executeUpdate();
		
		out.print("{\"status\":\"success\"}");
		return;
	}

} catch (Exception e) {
	e.printStackTrace();
	out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() +"\"}");
}
%>