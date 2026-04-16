<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
response.setContentType("application/json");

String routeNumber = request.getParameter("routeNumber");
String vehicleNumber = request.getParameter("vehicleNumber");
System.out.println(routeNumber + vehicleNumber);

try {

    if (routeNumber != null && vehicleNumber != null && !routeNumber.trim().isEmpty() && !routeNumber.trim().isEmpty()){
    		//Query for Update Status Driver
    		PreparedStatement changeDriverStatus = con.prepareStatement("UPDATE vehicle SET route_assigned=? WHERE vehicle_number=?");
    		changeDriverStatus.setString(1, "false");
    		changeDriverStatus.setString(2, vehicleNumber);
    		changeDriverStatus.executeUpdate();
    		
    		
    		//Query for DELETE 
    		PreparedStatement pst = con.prepareStatement("DELETE from vehicle_to_route WHERE vehicle_number=?");
    		pst.setString(1, vehicleNumber);
    		pst.executeUpdate();	

        out.print("{\"status\":\"success\"}");

    } else {
        out.print("{\"status\":\"error\",\"message\":\"Invalid input\"}");
    }

} catch (Exception e) {
    e.printStackTrace();
    out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
}
%>
