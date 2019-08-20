<%-- 
    Document   : userReg
    Created on : 29 Jun, 2019, 12:02:11 AM
    Author     : DELL
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
                
        <%! String driverName = "com.mysql.cj.jdbc.Driver";%>
<%!String url = "jdbc:mysql://localhost:3306/bloodcamp";%>
<%!String user = "root";%>
<%!String psw = "";%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="css/index_css.css"/>
        <link href='https://fonts.googleapis.com/css?family=Ubuntu:500' rel='stylesheet' type='text/css'>
    </head>
    <body style="background-color: white;">
        <%  HttpSession httpS=request.getSession(false);
            String chck_Em = (String) httpS.getAttribute("email");
            String chk_pass=(String)httpS.getAttribute("password");
            if(chck_Em!=null && chk_pass!=null)
            { %>
            
        <%@ include file="userHeader.jsp" %>
        <br/>
                 <div class="login">
<div class="login-header">
                    <h4>Register Here!</h4>
                </div>
                     <% 
                         HttpSession hhtp=request.getSession(false);
               String msg;
               Integer i=(Integer)httpS.getAttribute("flag");
               
               if(hhtp.getAttribute("error")==null)
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
<div class="login-form">
   
        <form method="post" action="User" enctype="multipart/form-data">
            <input type="hidden" name="p_name" value="user"/>
 <%
Connection con = null;
PreparedStatement ps = null;
    try
{
Class.forName(driverName);
con = DriverManager.getConnection(url,user,psw);
String sql = "SELECT * FROM BloodGroup";
ps = con.prepareStatement(sql);
ResultSet rs = ps.executeQuery(); 
%>
<input type="hidden" name="p_name" value="user"/>
<h3>Name</h3>
    <input type="text" placeholder="Name" name="name"/>

    <h3>Email</h3>
    <input type="email" placeholder="Email" name="email"/>


    <h3>Username</h3>
    <input type="text" placeholder="UserName"  name="uname"/>

    <h3>Password</h3>
    <input type="password" placeholder="Password" name="password"/>
 

    <h3>Mobile</h3>
    <input type="number" placeholder="Mobile" name="mobile"/>

  
    <h3>Gender</h3>
    <fieldset>
    Male<input type="radio" name="g" value="male"/>
    Female<input type="radio" name="g" value="female"/>
    Other<input type="radio" name="g" value="other"/><h3>Blood Group</h3>
    </fieldset>
        <select name="bg" style="height: 50px; width:500px;">
        <option>Select Blood Group</option>
    <%
        while(rs.next())
        {
        String fname = rs.getString("bgroup"); 
        %>
        <option value="<%=fname %>" name="<%=fname%>"><%=fname %></option>
<%
}
%>
   </select> 
   <%
}
catch(SQLException sqe)
{ 
out.println(sqe);
}
%>

<h3>Date Of Birth</h3>
<input type="date" name="date" /> 
    
    <h3>City</h3>
    <input type="text" name="city" placeholder="City"/>


    <h3>State</h3>
    <input type="text" name="state" placeholder="State">

    <h3>Profile Picture</h3>
    <input type="file" name="file" />
    <br><br>
    <input type="submit" value="Register" class="login-button"/>
    <br>
 
</form>
</div>
         </div>

        <%@include file="footer.jsp" %>
       
        <%  }
            else
            {
                RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            } 
        %>
    </body>
</html>
