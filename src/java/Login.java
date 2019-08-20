/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
public class Login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);

         String name=request.getParameter("email");
         String passw=request.getParameter("pass");
         PrintWriter out=response.getWriter();
         HttpSession httpS=request.getSession();
            try 
            {
             String url="jdbc:mysql://localhost/bloodcamp",user="root",pass="";
         String driver="com.mysql.cj.jdbc.Driver"   ;      
                Class.forName(driver);
                Connection con=DriverManager.getConnection(url,user,pass);
                PreparedStatement ps=con.prepareCall("Select * from users where email=? and password=?");
                ps.setString(1,name);
                ps.setString(2,passw);
                ResultSet i=ps.executeQuery();
                boolean rs_i=false;
                rs_i=i.next();
               
//                Statement stmt=con.createStatement();
//                int i=stmt.executeQuery("Select * from users where email ='"+name+"' and password = '"+passw+"'");
               if(rs_i==true)
                {
                    httpS.setAttribute("error",null);
                    httpS.setAttribute("email", name);
                    httpS.setAttribute("password",passw);
                    httpS.setAttribute("flag",null);
                    RequestDispatcher rd=request.getRequestDispatcher("userPro.jsp");
                    rd.forward(request, response);
                   
                }
               else
               {
                   
                   httpS.setAttribute("error","Invalid user name or password!!");
                   httpS.setAttribute("flag",0);
                   RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
                   rd.forward(request, response);
                   
               }
            }
            catch (Exception e) 
            {
                e.printStackTrace();
            }
         

    
    }
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
