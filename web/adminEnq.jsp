<%-- 
    Document   : adminJsp
    Created on : 26 Jun, 2019, 9:31:45 AM
    Author     : DELL
--%>

<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
       <link rel="stylesheet" type="text/css" href="css/index_css.css"/>
        <link rel="stylesheet" type="text/css" href="css/u_search.css"/>

    </head>
<%! String driverName = "com.mysql.cj.jdbc.Driver";%>
<%!String url = "jdbc:mysql://localhost:3306/bloodcamp";%>
<%!String user = "root";%>
<%!String psw = "";%>
<%  Connection con = null; 
Statement st=null;
%>
    <body style="background-color: white;">
         <% HttpSession httpS=request.getSession(false);
            String chck_Em = (String) httpS.getAttribute("admin");
            String chk_pass=(String)httpS.getAttribute("password");
            if(chck_Em!=null && chk_pass!=null)
            { %>
        <%@ include file="admin_menu.jsp" %>
        <div class="login-header">
            <br/>
            <h4>User Enquiries</h4>
            <br/>
        </div>
    <center>
        <div id="enquiry">
            <table class="responstable">
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Blood Group</th>
                    <th>Mobile</th>
                </tr>
            <% 
                try {
                        Class.forName(driverName);
                        con=DriverManager.getConnection(url,user,psw);
                        st=con.createStatement();
                        ResultSet rs=st.executeQuery("Select Name,Email,Blood_Group,Mobile from enquiries");
                        while(rs.next())
                        {
            %>
            
            <tr>
                <td><%=rs.getString("Name")%></td>
                <td><%=rs.getString("Email")%></td>
                <td><%=rs.getString("Blood_Group") %></td>
                <td><%=rs.getString("Mobile")%></td>
            </tr>
            <%
                        }
                    } catch (Exception e) {
                            PrintWriter outt=response.getWriter();
                            outt.print(e);
                    }
                
                
            %>
            </table>
        </div>    
    </center>
            <div id="div6">
                
            </div>
            
            <%  }
            else
            {
                RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            } 
        %>
    </body>
</html>
