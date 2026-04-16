<%@page import="java.io.InputStream"%>
<%@ page import="java.sql.*"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<%
	response.setContentType("application/json");

	String LicenceNumber = request.getParameter("licenceNumber");
	System.out.println(LicenceNumber);
	if (LicenceNumber != null && !LicenceNumber.trim().isEmpty()) {
		String createdBy = (String) session.getAttribute("userid");
		Date createdOn = new Date(System.currentTimeMillis());
		System.out.println("in if condition execution");
		try {
			PreparedStatement pst = con.prepareStatement(
			"INSERT INTO driver (licence_number, first_name, middle_name, last_name, contact_number, address, vehicle_type, licence_type, licence_date, exp, training, created_by, created_on, updated_by, updated_on, driver_id) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			
		
			pst.setString(1, LicenceNumber);
			pst.setString(2, request.getParameter("firstName"));
			pst.setString(3, request.getParameter("middleName"));
			pst.setString(4, request.getParameter("lastName"));
			pst.setString(5, request.getParameter("phoneNumber"));
			pst.setString(6, request.getParameter("driverAddress"));
			pst.setString(7, request.getParameter("vehicleType"));
			pst.setString(8, request.getParameter("licenceType"));
			pst.setString(9, request.getParameter("licenceDate"));
			pst.setString(10, request.getParameter("experience"));
			pst.setString(11, request.getParameter("training"));
			pst.setString(12, createdBy);
			pst.setDate(13, createdOn);
			pst.setString(14,null);
			pst.setString(15,null);
			pst.setString(16,request.getParameter("driverId"));
			
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