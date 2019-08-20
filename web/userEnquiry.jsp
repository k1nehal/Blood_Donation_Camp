<%-- 
    Document   : userEnquiry
    Created on : 29 Jun, 2019, 12:13:54 AM
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
    </head>
    <body style="background-color: white;">
        <% HttpSession httpS=request.getSession(false);
            String chck_Em = (String) httpS.getAttribute("email");
            String chk_pass=(String)httpS.getAttribute("password");
            if(chck_Em!=null && chk_pass!=null)
            { %>
        <%@include file="userHeader.jsp" %>
        <div class="login">
            <br/>
            <br/>
            
            <div class="login-header">
                <h4>Enquire About Blood Group</h4>
            </div>
            <% if(httpS.getAttribute("enquiry")!=null)
            {
                String hh=(String)httpS.getAttribute("enquiry");
                %>
                <br/>
                <div  style="color:green; background-color: rgb(0,255,0,0.15); padding: 15px; border: 2px solid green "><%=hh%></div>
           <%} %>
            <div class="login-form">
        <form action="Enquiry" method="post">
               <%
                try
                {
                    Class.forName(driverName);
                    con = DriverManager.getConnection(url,user,psw);
                    String sql = "SELECT * FROM BloodGroup";
                    ps = con.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery(); 
            %>  
            <h3>Blood Group</h3>
            <select name="bg" style="height: 50px; width:500px;">
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
                    <input type="submit" value="Enquiry"/>
            </form>
            </div>
        </div>
                    <div style="height: 240px;">
                    </div>
                    <br/>
                    <br/>
                    <%@include file="footer.jsp" %>
                    <%
                     httpS.setAttribute("enquiry", null);%>
                     <%  }
                       
            else
            {
                RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            } 
        %>
    </body>
</html>
