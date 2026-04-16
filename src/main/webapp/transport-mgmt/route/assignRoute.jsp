<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
response.setContentType("application/json");

String routeNumber = request.getParameter("routeNumber");
String vehicleNumber = request.getParameter("vehicleNumber");

try {

    if (vehicleNumber != null && routeNumber != null &&
        !vehicleNumber.trim().isEmpty() &&
        !routeNumber.trim().isEmpty() &&
        !vehicleNumber.equalsIgnoreCase("Select Vehicle Number") &&
        !routeNumber.equalsIgnoreCase("Select Route")) {

        // Insert mapping
        PreparedStatement assignVehicle = con.prepareStatement(
            "INSERT INTO vehicle_to_route (vehicle_number, route_number) VALUES (?, ?)"
        );
        assignVehicle.setString(1, vehicleNumber);
        assignVehicle.setString(2, routeNumber);
        assignVehicle.executeUpdate();

        // Update vehicle status
        PreparedStatement changeVehicleStatus = con.prepareStatement(
            "UPDATE vehicle SET route_assigned = ? WHERE vehicle_number = ?"
        );
        changeVehicleStatus.setString(1, "true");
        changeVehicleStatus.setString(2, vehicleNumber);
        changeVehicleStatus.executeUpdate();

        out.print("{\"status\":\"success\"}");

    } else {
        out.print("{\"status\":\"error\",\"message\":\"Invalid input\"}");
    }

} catch (Exception e) {
    e.printStackTrace();
    out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
}
%>
