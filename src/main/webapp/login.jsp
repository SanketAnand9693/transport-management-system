<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
session.setAttribute("ref", request.getParameter("ref"));
response.addHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Vidysoft | School ERP Software Cambridge Montensarri School</title>
 <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

 <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">
 
  <link href="assets/css/style.css" rel="stylesheet">
  
  <!-- browser back button disable -->
  <!-- 
  <script type="text/javascript">
        window.history.forward();
        function noBack() {
            window.history.forward();
        }
    </script> -->
  <!-- end -->
<style>
html, body {
  height: 100%;
  margin: 0;
  background-color:#fff;
  overflow: hidden;   /* ?? CRITICAL */
}

/* MAIN WRAPPER */
.login-wrapper {
  display: flex;
  min-height: 100vh;   /* ? allow grow if needed */
  width: 100%;
  align-items: stretch;
}
/* LEFT IMAGE PANEL */
.left-panel12 {
  flex: 1;
  height: auto;        /* ?? allow stretch */
  min-height: 100vh;
background: url('assets/img/login-bg.png') center center no-repeat;
 background-size: cover;
  position: relative;
  /*background:
    linear-gradient(rgba(0,0,0,0.10), rgba(0,0,0,0.10)),
    url('assets/img/login-bg.png') center center no-repeat;
 
  animation: zoomEffect 20s ease-in-out infinite;*/
}

/* LEFT IMAGE PANEL */
.left-panel {
  flex: 1;
  height: 100vh;          /* ?? LOCK to viewport */
  min-height: 100vh;
  max-height: 100vh;      /* ?? EXTRA SAFETY */
  overflow: hidden;       /* ?? PREVENT REPAINT JUMP */

  background: url('assets/img/login-bg.jpg') center center no-repeat;
  background-size: cover;
  position: relative;
}

/* TEXT ON IMAGE */
.left-content {
  position: absolute;
  bottom: 15%;
  left: 8%;
  color: #fff;
}

.left-content h1 {
  font-size: 42px;
  font-weight: 700;
}

.left-content p {
  font-size: 18px;
}

/* RIGHT LOGIN PANEL */
.right-panel {
  width: 460px;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f8f9fa;
}


</style>
</head>

<body>

<main class="login-wrapper">

  <!-- LEFT SIDE -->
  <div class="left-panel">
    <div class="left-content">
  <!-- <h2 style="
    display:inline-block;
   background: rgba(0, 76, 153, 0.75);
box-shadow: 0 4px 10px rgba(0,0,0,0.15);
    color:#fff;
    padding:8px 14px;
    margin:0 0 6px 0;
    font-weight:700;
    font-size:34px;
  ">
    <strong>VIDYASOFT</strong> – Empowering Schools Digitally
  </h2> -->

  <br>

 <!--  <p style="
    display:inline-block;
    background: rgba(0, 76, 153, 0.75);
box-shadow: 0 4px 10px rgba(0,0,0,0.15);
    color:#fff;
    padding:6px 12px;
    margin:0;
    font-size:16px;
    letter-spacing:0.5px;
  ">
    Reliable · Secure · Efficient
  </p> -->
</div>
  </div>

  <!-- RIGHT SIDE -->
  <div class="right-panel">

    <!-- LOGIN CARD (UNCHANGED LOGIC) -->

    <div class="card">
      <div class="card-body">

        <div class="pt-4 pb-2 text-center">
          <img src="assets/img/logo1.png" alt="Cambridge Montessori School Logo">
        </div>

        <%
        if (session.getAttribute("invalidLogin") != null) {
        %>
        <div class="text-center">
          <span style="color:red;">Username or Password is Incorrect</span>
        </div>
        <%
        }
        session.removeAttribute("invalidLogin");
        %>

        <form class="row g-3 needs-validation" novalidate method="post" action="loginvalidate.jsp">
          <div class="col-12">
            <label class="form-label">Username</label>
            <div class="input-group has-validation">
              <span class="input-group-text"><i class="bi bi-person"></i></span>
              <input type="text" name="userid" class="form-control" autocomplete="off"
                     maxlength="35" required>
              <div class="invalid-feedback">Please enter your username.</div>
            </div>
          </div>

          <div class="col-12">
            <label class="form-label">Password</label>
            <div class="input-group has-validation">
              <span class="input-group-text"><i class="bi bi-lock"></i></span>
              <input type="password" name="password" class="form-control"
                     maxlength="20" required>
              <div class="invalid-feedback">Please enter your password!</div>
            </div>
          </div>

          <!--<div class="col-12">
            <button class="btn btn-primary w-100" type="submit">
              Login
            </button>
          </div>-->

<div class="col-12">
  <button class="btn btn-primary w-100" type="submit" id="loginBtn">
    <span id="loginText">Login</span>
    <span id="loginSpinner"
          class="spinner-border spinner-border-sm ms-2 d-none"
          role="status" aria-hidden="true"></span>
  </button>
</div>

        </form>

       
 <div class="container text-center mt-3">
                        <p style="font-size:15px;">
                            Powered by <br><strong style="color:#2d457f;">VIDYASOFT</strong> | Educational Operating System
                        </p>
                    </div>   

      </div>
    </div>

  </div>

</main>

<script>
(function () {
  'use strict';

  const form = document.querySelector('.needs-validation');
  const btn = document.getElementById('loginBtn');
  const spinner = document.getElementById('loginSpinner');
  const text = document.getElementById('loginText');

  form.addEventListener('submit', function (event) {

    // ? If form is INVALID ? stop submit + stop spinner
    if (!form.checkValidity()) {
      event.preventDefault();
      event.stopPropagation();

      spinner.classList.add('d-none');
      text.innerText = 'Login';
      btn.disabled = false;
    }
    // ? If form is VALID ? show spinner
    else {
      spinner.classList.remove('d-none');
      text.innerText = 'Logging in...';
      btn.disabled = true;
    }

    form.classList.add('was-validated');
  }, false);
})();
</script>


<!-- Vendor JS Files -->
  <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/chart.js/chart.umd.js"></script>
  <script src="assets/vendor/echarts/echarts.min.js"></script>
  <script src="assets/vendor/quill/quill.min.js"></script>
  <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
