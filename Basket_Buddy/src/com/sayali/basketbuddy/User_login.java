package com.sayali.basketbuddy;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class User_login
 */
public class User_login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public User_login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String email = request.getParameter("uemail");
		System.out.println("Email : "+email);
		String password = request.getParameter("upassword");
		System.out.println("Password : "+password);
		
		Connection con = DBconnection.connect(); 
		
         
		try {
			PreparedStatement ps = con.prepareStatement("SELECT * FROM user WHERE uemail = ? AND upassword = ?");
			ps.setString(1, email);
		    ps.setString(2, password);

		    ResultSet rs = ps.executeQuery();
		    
		
	    if (rs.next()) {
            // Login successful
	    	int uid = rs.getInt(1);
	    	GetSet1.setUid(uid);
            response.sendRedirect("View_user_dashboard.jsp");
            System.out.println("Login Successfully");
            return;
        } else {
            // Invalid login
            response.sendRedirect("Login_failed.html");
            System.out.println("Invalid password or username");
            return;
        }

	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
