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
 * Servlet implementation class Advertiser_login
 */
public class Advertiser_login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Advertiser_login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String email = request.getParameter("aemail");
		System.out.println("Email : "+email);
		String password = request.getParameter("apassword");
		System.out.println("Password : "+password);
		
		Connection con = DBconnection.connect(); 
		
         
		try {
			PreparedStatement ps = con.prepareStatement("SELECT * FROM Advertiser WHERE email = ? AND password = ?");
			ps.setString(1, email);
		    ps.setString(2, password);
		    

		    ResultSet rs = ps.executeQuery();
		   
		    
		
	    if (rs.next()) {
            // Login successful
	    	int aid = rs.getInt(1);
	    	GetSet.setAid(aid);
            response.sendRedirect("advertiser_dashboard.html");
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
