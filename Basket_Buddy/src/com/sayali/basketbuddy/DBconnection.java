package com.sayali.basketbuddy;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBconnection {

		
	public static Connection connect(){
			
			Connection con = null;
			
			try {
				
				//System.out.println("Class Loaded Successfully!!");
				
				Class.forName("com.mysql.jdbc.Driver");
				
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/basketbuddydb","root","");
				
				//System.out.println("Connection Established Successfully......");
				
			} catch (ClassNotFoundException e) {
				
				e.printStackTrace();
				
			}
			catch (SQLException e) {
				
				e.printStackTrace();
			}
			
			return con;
			
		}

}
	
	

