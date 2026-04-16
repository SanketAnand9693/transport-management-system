
<%@page import="org.json.simple.JSONArray"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<%
response.setContentType("application/json");

String routeNumber = request.getParameter("routeNumber");

JSONArray jsonArray = new JSONArray();

try {
    String query = "SELECT vehicle_number FROM vehicle_to_route WHERE route_number=?";
    PreparedStatement ps = con.prepareStatement(query);
    ps.setString(1, routeNumber);

    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
        jsonArray.add(rs.getString("vehicle_number"));
    }

} catch(Exception e) {
    e.printStackTrace();
}

out.print(jsonArray);
%>