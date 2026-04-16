
<%
String user = (String) session.getAttribute("userid");

if (user == null) {
	response.sendRedirect("/transport-mgmt/");
}
%>