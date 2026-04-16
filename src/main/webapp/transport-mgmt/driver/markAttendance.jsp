<%@ page import="java.sql.*" %>
<%@ include file="/dbconnectconfig/db_Connect.jsp" %>

<%
response.setContentType("application/json");

String[] allDrivers = request.getParameterValues("driverId");
String[] presentDrivers = request.getParameterValues("presentDriver");

try {

    for(String driverId : allDrivers){

        String status = "absent";

        if(presentDrivers != null){
            for(String presentId : presentDrivers){
                if(driverId.equals(presentId)){
                    status = "present";
                    break;
                }
            }
        }

        PreparedStatement pst = con.prepareStatement(
            "INSERT INTO driver_attendance (driver_id, attendance_date, status) " +
            "VALUES (?, CURDATE(), ?) " +
            "ON DUPLICATE KEY UPDATE status = ?"
        );

        pst.setString(1, driverId);
        pst.setString(2, status);
        pst.setString(3, status);

        pst.executeUpdate();
        pst.close();
    }

    out.print("{\"status\":\"success\"}");

} catch(Exception e){
    out.print("{\"status\":\"error\"}");
    e.printStackTrace();
}
%>
