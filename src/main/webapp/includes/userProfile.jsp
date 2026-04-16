<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*"%>
<%@ include file="../dbconnectconfig/db_Connect.jsp"%>
<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>ghps</title>
 <!-- Favicons -->
  <link href="${pageContext.request.contextPath}/assets/img/favicon.png" rel="icon">
  <link href="${pageContext.request.contextPath}/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
</head>
<body>
<%@ include file="/includes/commonFile.jsp" %>
<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/sideBar.jsp" %>


<%
try {
String query = "select staff_name,institution_name,role,city,branch from login where userid='" + (String) session.getAttribute("userid") + "' ";
Statement pst=con.createStatement();
ResultSet rs = pst.executeQuery(query);
if(rs.next()){
%>
  <main id="main" class="main">

    <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
           <div class="card-header text-black bg-light mb-3">    
            <h5 class="card-title1 text-center">Profile</h5>
           </div>
            <div class="card-body">
            
              <h5 class="card-title"></h5>
              <form class="row g-3" method="post" action="#">
                
                <!-- Profile Edit Form -->
                 
                   

                    <div class="row mb-3">
                      <label for="fullName" class="col-md-4 col-lg-3 col-form-label">Full Name</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="fullName" type="text" class="form-control" id="fullName" value="<%=rs.getString("staff_name")%>" readonly>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="company" class="col-md-4 col-lg-3 col-form-label">Institution Name</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="company" type="text" class="form-control" id="company" value="<%=rs.getString("institution_name")%>" readonly>
                      </div>
                    </div>

                     <div class="row mb-3">
                      <label for="Address" class="col-md-4 col-lg-3 col-form-label">Role</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="address" type="text" class="form-control" id="Address" value="Head of Department " readonly>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="Country" class="col-md-4 col-lg-3 col-form-label">City</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="country" type="text" class="form-control" id="Country" value="<%=rs.getString("city")%>" readonly>
                      </div>
                    </div>
                    
                     <div class="row mb-3">
                      <label for="Country" class="col-md-4 col-lg-3 col-form-label">Branch</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="country" type="text" class="form-control" id="Country" value="<%=rs.getString("branch")%>" readonly>
                      </div>
                    </div>
                      
                  </form><!-- End Profile Edit Form -->
  
            </div>
            
          </div>
							

   
        </div>


      </div>
    </section>

  </main><!-- End #main -->
  
  <%
}
}
catch(Exception e){}
%>
</body>
</html>