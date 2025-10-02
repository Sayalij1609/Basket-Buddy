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
 * Servlet implementation class user_register
 */
public class user_register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public user_register() {
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
		
		String uname  = request.getParameter("name");
		String uemail = request.getParameter("email");
		String upassword = request.getParameter("password");
		String ucontact = request.getParameter("contact");
		String uaddress = request.getParameter("address");
		
		int uid = 0;
		
		
		
		PreparedStatement pstmt;
		try {
			pstmt = con.prepareStatement("Insert into user values (?,?,?,?,?,?)");
			pstmt.setInt(1,uid);
			pstmt.setString(2 ,uname );
			pstmt.setString(3,uemail);
			pstmt.setString(4,upassword);
			pstmt.setString(5,ucontact );
			pstmt.setString(6,uaddress);
			
		
			int i = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.sendRedirect("index.html");
		
		
		
		doGet(request, response);
	}

}
