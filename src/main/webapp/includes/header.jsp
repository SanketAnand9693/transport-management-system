<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="/includes/sessionCheckCommonFile.jsp" %>
    <%
  response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
  response.setHeader("Pragma", "no-cache");
  response.setDateHeader("Expires", 0);
%>
    
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
 
   <!-- ======= Header ======= -->
  <header id="header" class="header fixed-top d-flex align-items-center">
       <i class="bi bi-list toggle-sidebar-btn pe-2"></i>

    <div class="d-flex align-items-center justify-content-between">
        <a href="${pageContext.request.contextPath }/transport-mgmt/index.jsp" class="logo d-flex align-items-center">

  <img src="${pageContext.request.contextPath }/assets/img/logo1.png" alt="">

  <span class="d-none d-lg-block" style="margin-left:8px;">
    <div style="font-weight:700; font-size:18px; line-height:1.2; color:#0d3b8e;">
      Cambridge Montenssari
    </div>
    <div class="text-center" style="font-size:14px; line-height:1;">
      School
    </div>
  </span>

</a>
  
      
    </div>
    <!-- End Logo -->
   
    <nav class="header-nav ms-auto">
           <ul class="d-flex align-items-center">
      
        <li class="nav-item dropdown pe-3">
        
         <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
            <img src="${pageContext.request.contextPath }/assets/img/profile-img1.jpg" alt="Profile" class="rounded-circle">
            <span class="d-none d-md-block dropdown-toggle ps-2">Welcome! <%=session.getAttribute("userid") %> </span>
          </a><!-- End Profile Iamge Icon -->

         
          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
           <!--  <li class="dropdown-header">
              <h6></h6>
          </li> -->
           <!--  <li>
              <hr class="dropdown-divider">
            </li> -->

            <li>
              <a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath }/includes/userProfile.jsp">
                <i class="bi bi-person"></i>
                <span>My Profile</span>
              </a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="../CLERK/changePasswordForm.jsp">
                <i class="bi bi-lock"></i>
                <span>Change Password</span>
              </a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

	     <li>
              <a class="dropdown-item d-flex align-items-center" href="../Vidyasoft-GHPS-User-Guide/vidyasoft-GHPS-user-manual.pdf" target="_blank">
                <i class="bi bi-file-pdf"></i>
                <span>User Manual</span>
              </a>
		 <hr class="dropdown-divider">

            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="../CLERK/support.jsp">
                <i class="bi bi-question-circle"></i>
                <span>Support</span>
              </a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath }/includes/userLogout.jsp">
                <i class="bi bi-box-arrow-right"></i>
                <span>Sign Out</span>
              </a>
            </li>

          </ul><!-- End Profile Dropdown Items -->
        </li><!-- End Profile Nav -->

      </ul>
    </nav><!-- End Icons Navigation -->

  </header><!-- End Header -->
  
</body>
</html>