<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="com.sayali.basketbuddy.*" %>
<%@ page import ="java.sql.*" %>

<%
    String id = request.getParameter("id");
    String action = request.getParameter("action");
    
    if(id != null && action != null) {
        Connection con = DBconnection.connect();
        PreparedStatement ps = con.prepareStatement("UPDATE offer SET status = ? WHERE oid = ?");
        
        if(action.equals("approve")) {
            ps.setString(1, "approved");
        } else if(action.equals("reject")) {
            ps.setString(1, "rejected");
        }
        
        ps.setInt(2, Integer.parseInt(id));
        ps.executeUpdate();
        
    }
    
    response.sendRedirect("View_offer_admin.jsp");
%>