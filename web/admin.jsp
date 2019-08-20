<%-- 
    Document   : index
    Created on : 19 Jun, 2019, 7:00:44 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/index_css.css"/>
        <link href='https://fonts.googleapis.com/css?family=Ubuntu:500' rel='stylesheet' type='text/css'>
        <script> 
                    
                    </script>
    </head>
    <body>
        <%@include file="adminHeader.jsp" %>
           <div class="login">
                <div class="login-header">
                    <h1>Admin Panel</h1>
                </div>       
               <br/>
               <% HttpSession httpS=request.getSession(false);
               String msg;
               if(httpS.getAttribute("wrong")==null)
               {
                   msg="";
               }
               else
               {
                   msg=(String)httpS.getAttribute("wrong");             
               %>
               <div style="color:red; background-color: rgb(255,0,0,.10); border: 2px solid red; padding: 15px;">
<%=msg%>                   
</div>
               <%}
%>
               <div class="login-header" >
              
               </div>
                <br/>
                <br/>
             <div class="login-form">
                <form action="AdminLogin" method="post">
                    <h3>Username*</h3>
                     <input type="text" placeholder="Username"  name="uname"/>
                     <h3>Password*</h3>
                     <input type="password" placeholder="Password" name="pass"/>
                     <br>
                     <input type="submit" value="Login"  class="login-button"/>
                     <br>
</form>
                 <br/>
    
  </div>
</div>
<%httpS.setAttribute("wrong",null);%>
    </body>
</html>

    
 
    
</html>
