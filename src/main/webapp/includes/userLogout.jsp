<% session.invalidate(); 
String cookieName = "userid";
Cookie cookies [] = request.getCookies( );
if (cookies != null)
 {
     for (int i = 0; i < cookies.length; i++) 
     {
        if (cookies [i].getName().equals (cookieName))
        {
               System.out.println(" Cookies deleting "+cookies[i]);
               cookies[i].setMaxAge(0);
               System.out.println(" Cookies Deleted cookies successfully "+cookies[i]);

               break;
         }
      }
   }
response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Cache-Control","no-cache"); //HTTP 1.0
response.setHeader("Expires", "0");
response.setDateHeader ("Expires", -1); //prevents caching at the proxy server
response.sendRedirect("/transport-mgmt/login.jsp");

%>
