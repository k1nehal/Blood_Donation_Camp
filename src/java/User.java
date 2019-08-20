/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Calendar;
import java.util.List;
import java.util.Random;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author DELL
 */
@MultipartConfig

public class User extends HttpServlet {

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
        String p_name,name,email,username,password,mobile,city,gender,bg,state,dob;      
       
        int i=0;
        
        name="";
        email="";
        username="";
        password="";
        mobile="";
        city="";
        gender="";
        bg="";
        state="";
        dob="";
        p_name="";
        
        String url="jdbc:mysql://localhost/bloodcamp",user="root",pass="";
        String driver="com.mysql.cj.jdbc.Driver"   ;
        
        String filepath = getServletContext().getRealPath("") + File.separator + "upload";
        
        try 
        {
             String pic_name = "";
             String filename="";
            if(ServletFileUpload.isMultipartContent(request)){
                try 
                {
                   
                    List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                    for(FileItem item : multiparts)
                    {
                        if(!item.isFormField())
                        {	
                            Random r = new Random();
                            int abc = r.nextInt();
                            
                            //filename = Calendar.getInstance().getTime().toString() + "_" + abc + item.getName();
                            filename = "_" + abc + item.getName();
                            File fl = new File(filepath + File.separator + filename);
                            item.write(fl);
                            //String SAVE_DIR="C:\\Users\\DELL\\Documents\\NetBeansProjects\\BloodDonationjsp\\build\\assets";              
                            //pic_name = new File(item.getName()).getName();
                            //item.write( new File(filepath + File.separator + pic_name));
                        }
                        else
                        {
                            if(item.getFieldName().equalsIgnoreCase("name"))
                            {
                                name = item.getString();
                            }
                            else if(item.getFieldName().equalsIgnoreCase("email"))
                            {
                                email = item.getString();
                            }
                            else if(item.getFieldName().equalsIgnoreCase("uname"))
                            {
                                username = item.getString();
                            }
                            else if(item.getFieldName().equalsIgnoreCase("password"))
                            {
                                password = item.getString();
                            }
                            else if(item.getFieldName().equalsIgnoreCase("mobile"))
                            {
                                mobile = item.getString();
                            }
                            else if(item.getFieldName().equalsIgnoreCase("city"))
                            {
                                city = item.getString();
                            }
                            else if(item.getFieldName().equalsIgnoreCase("g"))
                            {
                                gender = item.getString();
                            }
                            else if(item.getFieldName().equalsIgnoreCase("bg"))
                            {
                                bg = item.getString();
                            }
                            else if(item.getFieldName().equalsIgnoreCase("state"))
                            {
                                state = item.getString();
                            }
                            else if(item.getFieldName().equalsIgnoreCase("date"))
                            {
                                dob = item.getString();
                            }
                            else if(item.getFieldName().equalsIgnoreCase("p_name"))
                            {
                                p_name=item.getString();
                            }
                            /*name=request.getParameter("name");
                            email=request.getParameter("email");
                            username=request.getParameter("uname");
                            password=request.getParameter("password");
                            mobile=request.getParameter("mobile");
                            city=request.getParameter("city");
                            gender=request.getParameter("g");
                            bg=request.getParameter("bg");
                            state=request.getParameter("state");
                            dob=request.getParameter("date");
                            */    
                        }
                    }
                }
                catch (Exception ex) 
                {
                    System.out.println("File Upload Failed due to " + ex);
                }          
         
            }
            else
            {
                System.out.println("Sorry this Servlet only handles file upload request");
            }    
            Class.forName(driver);
            Connection con=DriverManager.getConnection(url,user,pass);
            PreparedStatement st=con.prepareStatement("insert into users(Name,Email,Username,Password,Mobile,Gender,Blood_Group,Date_of_Birth,City,State,Profile_Pic) values(?,?,?,?,?,?,?,?,?,?,?)");
            st.setString(1,name);
            st.setString(2,email);
            st.setString(3,username);
            st.setString(4,password);
            st.setString(5,mobile);
            st.setString(6,gender);
            st.setString(7,bg);
            st.setString(8,dob);
            st.setString(9,city);
            st.setString(10,state);
            st.setString(11,filename); 
            i=st.executeUpdate();
            if(i>0)
            {
                HttpSession httpS=request.getSession(false);
                HttpSession hhtp=request.getSession();
               if(p_name.equalsIgnoreCase("user"))
               {
                    hhtp.setAttribute("flag", 1);
                    hhtp.setAttribute("error","Successful registration");
                    RequestDispatcher rd=request.getRequestDispatcher("userReg.jsp");
                    rd.forward(request, response);
               }
               else if(p_name.equalsIgnoreCase("new_user"))
               {
                   httpS.setAttribute("error","Successful Registration! Login Here");
                   httpS.setAttribute("flag",1);
                   RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
                   rd.forward(request, response);
               }
               else
               {
                   hhtp.setAttribute("error2","Successful Registration");
                   hhtp.setAttribute("flag2",1);
               RequestDispatcher rd=request.getRequestDispatcher("adminReg.jsp");
               rd.forward(request, response);
               }
            }
       }
       catch (Exception e) 
       {
           System.out.println(e);
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
