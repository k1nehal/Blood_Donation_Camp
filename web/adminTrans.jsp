<%-- 
    Document   : adminTrans
    Created on : 27 Jun, 2019, 10:43:48 PM
    Author     : DELL
--%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%! String driverName = "com.mysql.cj.jdbc.Driver";%>
<%!String url = "jdbc:mysql://localhost:3306/bloodcamp";%>
<%!String user = "root";%>
<%!String psw = "";%>
 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="css/index_css.css"/>
        <link href='https://fonts.googleapis.com/css?family=Ubuntu:500' rel='stylesheet' type='text/css'>
    </head>
    <body style="background-color: white;">
        
           
        <%@include file="admin_menu.jsp" %>
            <div class="login">
                    <br/>
                    <div class="login-header">
                        <h4>Enter Transaction Details</h4></div>
                    <% HttpSession httpS=request.getSession(false);
            String chck_Em = (String) httpS.getAttribute("admin");
            String chk_pass=(String)httpS.getAttribute("password");
            if(chck_Em!=null && chk_pass!=null)
            { %>
                    <% HttpSession hs=request.getSession(false);
                    String msg,msg2;
                    if(hs.getAttribute("msg")==null)
                    {
                       msg="";
                       if(hs.getAttribute("trans")==null)
                       {
                           msg2="";
                       }
                       else
                       {
                           msg2=(String)hs.getAttribute("trans");
                           if(msg2.equals("complete"))
                           {
                           %>
                           <div><%=msg2%></div>
                           <%
                               }
                               else
                               {
                                       %>
                                       <div>Unsuccessful Transaction</div>
                                       <%
                                       }
                               
                       }
                       
                       %>
                       <div><%=msg%></div>
                       <%
                    }
                    else
                    {
                       msg=(String)hs.getAttribute("msg");
                    
                    %>
                    <br/><br/>
                    <div style="border:2px solid red; color: red; background-color: rgb(255,0,0,0.15); padding: 15px;">
                        <%=msg%>
                    </div>
                        <% }
%>

<% String status;
if(hs.getAttribute("trans")==null)
{
   status="";
   %>
   <div><%=status%></div>
   <%    
}
else
{
status=(String)hs.getAttribute("trans");
if(status.equals("complete"))
{
    %>
    <div>Successful Transaction</div>
    <%
}
else
{
%>
<div>Unsuccessful Transaction!</div>
<%
}
}


   %>
                
                    
                <div class="login-form">
                    <form method="post" action="AdmTransaction">
                        <h3>Name</h3>
                        <input type="text" placeholder="Name" name="name"/>

                        <h3>Email</h3>
                        <input type="email" name="email" placeholder="Email"/>

                        <h3>Blood_Group</h3>
                        <select name="bg" style="height: 50px; width:500px;">
                            <option>-Select Blood Group-</option>
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
hs.setAttribute("trans", null);
hs.setAttribute("msg", null);
}
                            
                            %>

                            <h3>Quantity</h3>
                            <input type="number" name="quantity" placeholder="Quantity"/>

                            <h3>Date</h3>
                            <input type="date" name="d_date"/>
                    
                            <h3>Type</h3>
                            <select name="type" style="height: 50px; width:500px;">
                                <option>-Choose Type-</option>
                                <option name="in" value="in">In</option>
                        <option name="out" value="out">Out</option>
                    </select>
         
                    <h3>City</h3>
                    <input type="text" name="city" placeholder="City"/>

                    <h3>State</h3>
                    <input type="text" name="state" placeholder="State"/>
                    
                    <input type="submit"  value="Transaction"/>
                </form>
            </div>
        </div>
                   
                  
    </body>
</html>
    