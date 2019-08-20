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
        <%@include file="top_header.jsp" %>
           <div class="login">
                <div class="login-header">
                    <h1>Login</h1>
                </div>      
               <br/>
               <% HttpSession httpS=request.getSession(false);
               String msg;
               Integer i=(Integer)httpS.getAttribute("flag");
               
               if(httpS.getAttribute("error")==null)
               {
                   msg="";
               }
               else
               {
                   msg=(String)httpS.getAttribute("error");
                   if(i==0)
                   {
                       %>
                       <div style="color:red; padding: 15px; background-color: rgb(255,0,0,0.25); border:2px solid red;">
                           <%=msg%>
                       </div>
                       <%
                   }

                else if(i==1)
                   {
                       %>
                       <div style="color:green; border:2px solid greenyellow; padding: 15px; background-color: rgb(0,255,0,0.25); border:2px solid green ">
                           <%=msg%>
                       </div>
                       <%
                   }
                    else
                    {
                       %>
                       <div>
                           
                       </div>
                       <%
                    }
                   
               }
               %>
                <br/>
                <br/>
             <div class="login-form">
                <form action="Login" method="post">
                    <h3>Email*</h3>
                     <input type="text" placeholder="Email"  name="email"/>
                     <h3>Password*</h3>
                     <input type="password" placeholder="Password" name="pass"/>
                     <br>
                     <input type="submit" value="Login"  class="login-button"/>
                     <br>
</form>
                <% httpS.setAttribute("error", null);%>
                 <br/>
    
  </div>
</div>
    </body>
</html>

    
 
    
</html>
