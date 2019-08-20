
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>JSP Page</title>
         <link rel="stylesheet" type="text/css" href="css/index_css.css"/>
        <link href='https://fonts.googleapis.com/css?family=Ubuntu:500' rel='stylesheet' type='text/css'>
    </head>
    <body style="background-color: white;">
        <% HttpSession httpS=request.getSession(false);
            String chck_Em = (String) httpS.getAttribute("admin");
            String chk_pass=(String)httpS.getAttribute("password");
            if(chck_Em!=null && chk_pass!=null)
            { %>
        <%@ include file="admin_menu.jsp" %>
        <%! String driverName = "com.mysql.cj.jdbc.Driver";%>
<%!String url = "jdbc:mysql://localhost:3306/bloodcamp";%>
<%!String user = "root";%>
<%!String psw = "";%>
<div class="login">
    <div class="login-header">
        <br/>
        <h4>Enter user Details</h4></div>
    <br/>
     <% 
                         HttpSession hhtp=request.getSession(false);
               String msg;
               Integer i=(Integer)httpS.getAttribute("flag2");
               
               if(hhtp.getAttribute("error2")==null)
               {
                   msg="";
               }
               else
               {
                   msg=(String)httpS.getAttribute("error2");
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
            <input type="hidden" name="p_name"  value="admin"/>
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
<h3>Name</h3>
<input type="text" name="name" placeholder="Name"/>

<h3>Email</h3>
<input type="email" name="email" placeholder="Email"/>
<h3>Username</h3>
<input type="text" name="uname" placeholder="Username"/>

<h3>Password</h3>
<input type="password" name="password" placeholder="Password"/>

<h3>Mobile</h3>
<input type="number" name="mobile" placeholder="Mobile"/>

<h3>Gender</h3>
<fieldset>
        Male<input type="radio" name="g" value="male"/>
        Female<input type="radio" name="g" value="female"/>
        Other<input type="radio" name="g" value="other"/>
</fieldset>

<h3>Blood Group</h3> 
<select name="bg" style="height: 50px; width:450px;">
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
catch(Exception sqe)
{ 
out.println(sqe);
}
%>
<h3>Date Of Birth</h3>
<input type="date" name="date"/>

<h3>City</h3>
<input type="text" name="city" placeholder="City"/>

<h3>State</h3>
<input type="text" name="state" placeholder="State">

<h3>Profile Picture</h3>
<input type="file" name="image"/>
<br/><br/>
<input type="submit" value="Register"/>
        </form></div>
</div>
<%  hhtp.setAttribute("flag2", null);
            hhtp.setAttribute("error2", null); }
            else
            {
                RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            } 
        %>
 </body>
</html>
