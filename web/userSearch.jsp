<%-- 
    Document   : userSearch
    Created on : 29 Jun, 2019, 12:10:23 AM
    Author     : DELL
--%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>



<%! String driverName = "com.mysql.cj.jdbc.Driver";%>
<%!String url = "jdbc:mysql://localhost:3306/bloodcamp";%>
<%!String user = "root";%>
<%!String psw = "";%>
<%  Connection con = null;
  PreparedStatement ps = null; %>

  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="css/index_css.css"/>
        <link rel="stylesheet" type="text/css" href="css/u_search.css"/>
    </head>
    
    <body style="background-color: white;">
        
        <% HttpSession httpS=request.getSession(false);
            String chck_Em = (String) httpS.getAttribute("email");
            String chk_pass=(String)httpS.getAttribute("password");
            if(chck_Em!=null && chk_pass!=null)
            { %>
               <%@include file="userHeader.jsp" %>
               <div class="login-form">
                   <div class="login-header">
                    <h4>Our Donors!</h4>
                </div> 
                   <div class="login">
                       <br/>
            <form action="userSearch.jsp" method="post"> 
              <%
    try
{
Class.forName(driverName);
con = DriverManager.getConnection(url,user,psw);
String sql = "SELECT * FROM BloodGroup";
ps = con.prepareStatement(sql);
ResultSet rs = ps.executeQuery(); 
%>
<h3> Select Blood Group</h3>
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
catch(Exception sqe)
{ 
out.println(sqe);
}
%>
<input type="submit" value="Search"/>
            </form>
                   </div>
        </div>


<% String query, bg_name=request.getParameter("bg");
if(bg_name==null)
{
    query="SELECT Name,Mobile,Blood_Group,Profile_Pic FROM users";
}
else
{
    query="Select Name,Mobile,Blood_Group,Profile_Pic  from users where Blood_Group='"+bg_name+"'";
}
%>
        <div>       
            <center>
            <table  class="responstable">
                <tr>
                    <th>Profile Picture</th>
                    <th>Name</th>
                    <th>Blood Group</th>
                    <th>Mobile</th>
                </tr>
           <%
                try
                {
                    Class.forName(driverName);
                    con = DriverManager.getConnection(url,user,psw);
//                    String sql = "SELECT Name,Mobile,Blood_Group,Profile_Pic FROM users";
                    ps = con.prepareStatement(query);
                    ResultSet rs = ps.executeQuery(); 
                    while(rs.next())
                    {
                      
                        String pic_name=rs.getString("Profile_Pic");
                        String src="upload/"+pic_name;
                     
                   %>
                <tr>
                    <td><img src="<%=src%>" width="80" />
                       
                    <td>
                        <%=rs.getString("Name") %>
                        
                    </td>
                    <td>
                        <%=rs.getString("Blood_Group") %>
                    </td>
                    <td>
                        <%=rs.getString("Mobile") %>
                    </td>
                        
                </tr>
                <%
                    }
                }
                    catch(Exception e)
                            {
                            System.out.println(e);
                            }
            %>
            </table>
            </center>
        </div>
            
            <br>
            <br>
            <%@include file="footer.jsp" %>
            <%}
else
{
RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
}%>
    </body>
</html>
