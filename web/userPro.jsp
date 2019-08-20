<%@page import="java.sql.Statement"%>
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
        
        <%Class.forName(driverName);
        Connection con=DriverManager.getConnection(url,user,psw);
        Statement stmt=con.createStatement();
        ResultSet rs=stmt.executeQuery("Select * from users where Email='"+chck_Em+"'");
        while(rs.next())
                {
                    String pic_name=rs.getString("Profile_Pic");
                        String src="upload/"+pic_name;
                
                    %>
        <div class="login">
            <div class="login-header">
                <h3>Welcome !<br/><%=rs.getString("Name")%></h3>
            </div>
            <div class="login-form"><img src="<%=src%>"></div>
        </div>
        <div class="login-header">
            
        </div>
            <%}%>
            <br/>
            <br/>
            <br/>
            <br/>
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
