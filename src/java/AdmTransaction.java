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
public class AdmTransaction extends HttpServlet {

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
String driverName = "com.mysql.cj.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/bloodcamp";
String user = "root";
String psw = "";
String name,email,bg,state, date,type,city;
int quantity;
name=request.getParameter("name");
email=request.getParameter("email");
bg=request.getParameter("bg");
date=request.getParameter("d_date");
type=request.getParameter("type");
city=request.getParameter("city");
state=request.getParameter("state");
quantity=Integer.parseInt(request.getParameter("quantity"));
PrintWriter out=response.getWriter();
        System.out.println(type);
int in_stock=0;
 HttpSession hs=request.getSession();
        try {          
            if(type.equals("in"))
            {
                hs.setAttribute("msg","");
                Class.forName(driverName);
                Connection con=DriverManager.getConnection(url, user, psw);
                String sql1="update bloodgroup set Stock=Stock+"+quantity+" where bgroup='"+bg+"'";
                Statement stmt=con.createStatement();
                stmt.executeUpdate(sql1);   
                PreparedStatement ps=con.prepareStatement("insert into transaction(Name,Email,Blood_Group,Quantity,Date,Type,City,State) values(?,?,?,?,?,?,?,?)"); 
                ps.setString(1,name);
                ps.setString(2,email);
                ps.setString(3,bg);
                ps.setInt(4,quantity);
                ps.setString(5,date);
                ps.setString(6,type);
                ps.setString(7,city);
                ps.setString(8,state);
                ps.executeUpdate();
                RequestDispatcher rd=request.getRequestDispatcher("adminTrans.jsp");
                rd.forward(request, response);
                
            }
            else
            {
                
                Class.forName(driverName);
                Connection con=DriverManager.getConnection(url, user, psw);
                Statement stmt1=con.createStatement();
                ResultSet rs=stmt1.executeQuery("Select * from bloodgroup where bgroup='"+bg+"'");
                while(rs.next())
                {
                in_stock=rs.getInt("Stock");
                System.out.println(in_stock+" "+quantity);
                }
                if(in_stock>=quantity)
                {
                    hs.setAttribute("msg","");
                String sql1="update bloodgroup set Stock=Stock-"+quantity+" where bgroup='"+bg+"'";
                Statement stmt=con.createStatement();
                stmt.executeUpdate(sql1);   
                PreparedStatement ps=con.prepareStatement("insert into transaction(Name,Email,Blood_Group,Quantity,Date,Type,City,State) values(?,?,?,?,?,?,?,?)"); 
                ps.setString(1,name);
                ps.setString(2,email);
                ps.setString(3,bg);
                ps.setInt(4,quantity);
                ps.setString(5,date);
                ps.setString(6,type);
                ps.setString(7,city);
                ps.setString(8,state);
                ps.executeUpdate();
                 
                RequestDispatcher rd=request.getRequestDispatcher("adminTrans.jsp");
                rd.forward(request, response);
               
                }
                else
                {
                   
                    hs.setAttribute("msg", "Not enough Stock!!");
                    RequestDispatcher rd=request.getRequestDispatcher("adminTrans.jsp");
                    rd.forward(request, response);
                }
            }
                
//            Statement st=con.createStatement();
//            String sql1="Select Stock from bloodgroup where bgroup= '"+bg+"'";
//            ResultSet rs=st.executeQuery(sql);
//            in_stock=rs.getInt("Stock");
//            if(in_stock>=quantity)
//            {
//                String sql2="update bloodgroup set Stock=Stock-"+quantity+" where bgroup='"+bg+"'";
//                Statement stmt=con.createStatement();
//                stmt.executeUpdate(sql2);
//            }
//          
//            else
//            {
//                RequestDispatcher rd=request.getRequestDispatcher("adminTrans.jsp");
//                rd.forward(request, response);
//            }
            
//            }
         
         hs.setAttribute("trans","complete");
           
      
        } catch (Exception e) {
            hs.setAttribute("trans","incomplete");
            RequestDispatcher rd=request.getRequestDispatcher("adminTrans.jsp");
rd.forward(request, response);        }

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
