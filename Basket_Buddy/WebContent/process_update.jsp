<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="com.sayali.basketbuddy.*" %>
<%@ page import ="java.sql.*" %>

<%
    try { 
        Connection con = DBconnection.connect(); 
        
        int oid = Integer.parseInt(request.getParameter("oid"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String discount = request.getParameter("discount");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String shopName = request.getParameter("shopName");
        String city = request.getParameter("city");
        String address = request.getParameter("address");
        String products = request.getParameter("products");
        
        PreparedStatement pstmt = con.prepareStatement(
            "UPDATE offer SET title=?, description=?, discount=?, startDate=?, endDate=?, shopName=?, city=?, address=?, products=? WHERE oid=?");
        
        pstmt.setString(1, title);
        pstmt.setString(2, description);
        pstmt.setString(3, discount);
        pstmt.setString(4, startDate);
        pstmt.setString(5, endDate);
        pstmt.setString(6, shopName);
        pstmt.setString(7, city);
        pstmt.setString(8, address);
        pstmt.setString(9, products);
        pstmt.setInt(10, oid);
        
        int i = pstmt.executeUpdate();
        
        if (i > 0) {
            response.sendRedirect("view_offer.jsp?success=Offer updated successfully");
        } else {
            response.sendRedirect("view_offer.jsp?error=Failed to update offer");
        }
    } catch (Exception e) {
        response.sendRedirect("View_offer.jsp?error=" + e.getMessage());
    }
%>