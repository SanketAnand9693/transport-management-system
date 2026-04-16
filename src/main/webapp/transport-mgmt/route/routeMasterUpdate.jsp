<%@page import="java.sql.Date"%>
<%@ page import="java.sql.*"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<%
response.setContentType("application/json");

String routeNumber = request.getParameter("routeNumber");

if (routeNumber != null && !routeNumber.trim().isEmpty()) {
	String modifiedBy = (String) session.getAttribute("userid");

	Date modifiedOn = new Date(System.currentTimeMillis());
	try {
		PreparedStatement pst = con.prepareStatement(
		"Update route set bus_stop_1=?, bus_stop_2=?, bus_stop_3=?, bus_stop_4=?, bus_stop_5=?, bus_stop_6=? WHERE route_number=? ;");
		pst.setString(1, request.getParameter("busStop1"));
		pst.setString(2, request.getParameter("busStop2"));
		pst.setString(3, request.getParameter("busStop3"));
		pst.setString(4, request.getParameter("busStop4"));
		pst.setString(5, request.getParameter("busStop5"));
		pst.setString(6, request.getParameter("busStop6"));
		pst.setString(7, routeNumber);
	
		pst.executeUpdate();
		out.print("{\"status\":\"success\"}");
		return;

	} catch (Exception e) {
		e.printStackTrace();

		response.setStatus(500);
		out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
		return;
	}
}
%>