<%@ page language="java" contentType="text/html" import="java.sql.*" session="true"%>
<%@ include file="../dbconnectconfig/db_Connect.jsp"%>

<%
String uid = request.getParameter("userid");  
    String pwd = request.getParameter("password");

    if(uid != null && pwd != null) {  // Prevents NullPointerException
        try {
            // Secure query using PreparedStatement to prevent SQL Injection
            String sql = "SELECT role FROM login WHERE userid = ? AND password = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            System.out.println("Logged in Successfully");
            ps.setString(1, uid);
            ps.setString(2, pwd);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {  
                String role = rs.getString("role");
                session.setAttribute("userid", uid); // Set user session

                session.removeAttribute("invalidLogin");

                // Redirect logic based on role
                String redirectPage = "/transport-mgmt/login.jsp"; // Default if no role matches
                if (role.equalsIgnoreCase("admin")) {
                    redirectPage = "/transport-mgmt/transport-mgmt/index.jsp";
                } else if (role.equalsIgnoreCase("staff")) {
                    redirectPage = "/transport-mgmt/STAFF/index.jsp";
		} else if (role.equalsIgnoreCase("clerk")) {
			redirectPage = "/transport-mgmt/CLERK/index.jsp";
		} else if (role.equalsIgnoreCase("principal")) {
			redirectPage = "/transport-mgmt/PRINCIPAL/index.jsp";
		} else if (role.equalsIgnoreCase("management")) {
			redirectPage = "/transport-mgmt/MANAGEMENT/index.jsp";
		} else if (role.equalsIgnoreCase("student")) {
			redirectPage = "/transport-mgmt/STUDENT/index.jsp";
		} else if (role.equalsIgnoreCase("Guest Teacher")) {
			redirectPage = "/transport-mgmt/STAFF/index.jsp";
		}

		// If there was a previous reference, append it to the redirect URL
		if (session.getAttribute("ref") != null) {
			redirectPage += session.getAttribute("ref");
		}
		response.sendRedirect(redirectPage);
		session.removeAttribute("ref"); // Cleanup

	} else { // Invalid login
		session.setAttribute("invalidLogin", "invalid");

		String loginRedirect = "/transport-mgmt/login.jsp";
		if (session.getAttribute("ref") != null) {
			loginRedirect += session.getAttribute("ref");
		}
		response.sendRedirect(loginRedirect);
		session.removeAttribute("ref");
	}
		} catch (Exception e) {
	out.println("Something went wrong! Please try again.");
	e.printStackTrace();
		}
	} else {
		response.sendRedirect("/transport-mgmt/"); // Redirect if empty inputs
	}
%>
