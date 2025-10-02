package com.sayali.basketbuddy;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class advertiser_register
 */
public class advertiser_register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public advertiser_register() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
     Connection con = DBconnection.connect();
		
		String name  = request.getParameter("name");
		String bname  = request.getParameter("bname");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String contact = request.getParameter("contact");
		String city = request.getParameter("city");
		String address = request.getParameter("address");
		
		int id = 0;
		
		
		
		PreparedStatement pstmt;
		try {
			pstmt = con.prepareStatement("Insert into advertiser values (?,?,?,?,?,?,?,?)");
			pstmt.setInt(1,id);
			pstmt.setString(2 ,name );
			pstmt.setString(3,bname);
			pstmt.setString(4,email);
			pstmt.setString(5,password);
			pstmt.setString(6,contact );
			pstmt.setString(7,city);
			pstmt.setString(8,address);
			
		
			int i = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.sendRedirect("index.html");
		
		
		
		doGet(request, response);
	}

}
