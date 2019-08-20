
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
public class Enquiry extends HttpServlet {

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
            throws ServletException, IOException
    {
        PrintWriter out=response.getWriter();
        String url="jdbc:mysql://localhost/bloodcamp",user="root",pass="";
        String driver="com.mysql.cj.jdbc.Driver";    
        try {
            HttpSession httpS=request.getSession(false);
            String em = (String) httpS.getAttribute("email");
            String bg=request.getParameter("bg");
            String name,mob;
            Class.forName(driver);
            Connection con=DriverManager.getConnection(url,user,pass);
            Statement st=con.createStatement();
            String sql="select Name,Mobile from users where Email='"+em+"'";
            ResultSet rs=st.executeQuery(sql);
            while(rs.next())
            {
            name=rs.getString("Name");
            mob=rs.getString("Mobile");
                String sqll="insert into enquiries(Name,Email,Blood_Group,Mobile) values('"+name+"','"+em+"','"+bg+"','"+mob+"')";
                Statement st1=con.createStatement();
                st1.executeUpdate(sqll);
                httpS.setAttribute("enquiry","Enquiry Send!");
                RequestDispatcher rd=request.getRequestDispatcher("userEnquiry.jsp");
                rd.forward(request, response);
            }
        } catch (Exception e) {
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
