<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.sayali.basketbuddy.*" %>
<%@ page import="java.sql.*, java.util.Base64" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Products - OfferMandi</title>
    <style>
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            display: flex;
            min-height: 100vh;
            background: url('bg.jpeg') no-repeat center center fixed;
            background-size: cover;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }

        .sidebar {
            width: 250px;
            background: linear-gradient(135deg, rgba(26, 42, 58, 0.9), rgba(44, 62, 80, 0.9));
            color: white;
            padding: 20px 0;
            height: 100vh;
            position: fixed;
            transition: all 0.3s;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            z-index: 1;
        }

        .sidebar-header {
            padding: 0 20px 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-header h1 {
            color: #f8c537;
            margin-bottom: 5px;
            font-size: 1.8rem;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
        }

        .sidebar-header p {
            color: #ecf0f1;
            font-size: 14px;
            opacity: 0.8;
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .sidebar-menu h3 {
            color: #f8c537;
            padding: 0 20px;
            margin-bottom: 10px;
            font-size: 16px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .sidebar-menu ul {
            list-style: none;
        }

        .sidebar-menu li {
            padding: 12px 20px;
            cursor: pointer;
            transition: all 0.3s;
            margin: 5px 10px;
            border-radius: 4px;
            display: flex;
            align-items: center;
        }

        .sidebar-menu li:before {
            margin-right: 10px;
            color: #f8c537;
            opacity: 0;
            transition: all 0.3s;
        }

        .sidebar-menu li:hover {
            background: rgba(248, 197, 55, 0.1);
            transform: translateX(5px);
            color: #f8c537;
        }

        .sidebar-menu li:hover:before {
            opacity: 1;
        }

        .sidebar-menu li.active {
            background: linear-gradient(90deg, #f8c537, #f39c12);
            color: #1a2a3a;
            font-weight: bold;
            box-shadow: 0 4px 8px rgba(248, 197, 55, 0.3);
        }

        .sidebar-menu li.active:before {
            opacity: 1;
            color: #1a2a3a;
        }

        .main-content {
            margin-left: 250px;
            width: calc(100% - 250px);
            min-height: 100vh;
            padding: 30px;
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .dashboard-header h2 {
            color: #2c3e50;
            font-size: 1.8rem;
        }

        .logout-btn {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
        }

        .logout-btn:hover {
            background: #c0392b;
        }

        .offers-container {
            background: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .content-header h3 {
            color: #2c3e50;
        }

        .filter-controls {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .filter-controls select,
        .filter-controls input {
            padding: 8px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .offer-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 15px rgba(26, 42, 58, 0.1);
        }

        .offer-table th,
        .offer-table td {
            padding: 12px 15px;
            text-align: left;
            border: 1px solid rgba(26, 42, 58, 0.15);
        }

        .offer-table th {
            background: linear-gradient(135deg, #1a2a3a, #2c3e50);
            color: #f8c537;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #f8c537;
        }

        .offer-table tr:nth-child(even) td {
            background-color: #f9f9f9;
        }

        .offer-table tr:hover td {
            background-color: rgba(248, 197, 55, 0.1);
        }

        .offer-table td:first-child {
            border-left: 2px solid #f8c537;
        }

        .offer-table td:last-child {
            border-right: 2px solid #f8c537;
        }

        .offer-table tr:last-child td {
            border-bottom: 2px solid #f8c537;
        }

        .action-buttons {
            display: flex;
            gap: 5px;
        }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
            font-size: 13px;
        }

        .btn-primary {
            background: #3498db;
            color: white;
        }

        .btn-primary:hover {
            background: #2980b9;
        }

        .btn-success {
            background: #2ecc71;
            color: white;
        }

        .btn-success:hover {
            background: #27ae60;
        }

        .btn-danger {
            background: #e74c3c;
            color: white;
        }

        .btn-danger:hover {
            background: #c0392b;
        }

        .btn-warning {
            background: #f39c12;
            color: white;
        }

        .btn-warning:hover {
            background: #e67e22;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            .main-content {
                margin-left: 0;
                width: 100%;
            }
            .filter-controls {
                flex-direction: column;
            }
            .offer-table {
                display: block;
                overflow-x: auto;
            }
        }
    
        .status-approved {
            color: #2ecc71;
            font-weight: bold;
        }
        .status-pending {
            color: #f39c12;
            font-weight: bold;
        }
        .status-rejected {
            color: #e74c3c;
            font-weight: bold;
        }
    .product-image {
    width: 150px;
    height: 150px;
    object-fit: cover;
    
    border: 1px solid #ccc;
}

    </style>
</head>
<body>
<%
    try {
        Connection con = DBconnection.connect();
        int aid = GetSet.getAid(); 
        PreparedStatement ps = con.prepareStatement("SELECT * FROM products WHERE aid = ?");
        ps.setInt(1, aid);
        ResultSet rs = ps.executeQuery();
%>

<div class="sidebar">
    <div class="sidebar">
        <div class="sidebar-header">
            <h1>OfferMandi</h1>
            <p>Advertiser Dashboard</p>
        </div>
        <div class="sidebar-menu">
            <h3>Navigation</h3>
            <ul>
                <li ><a href="advertiser_dashboard.html" style="color: inherit; text-decoration: none; display: block;">Dashboard</a></li>
                <li><a href="View_offer.jsp" style="color: inherit; text-decoration: none; display: block;">View Offers</a></li>
                <li><a href="create_offer.jsp" style="color: inherit; text-decoration: none; display: block;">Create Offer</a></li>
                <li><a href="update_offers.jsp" style="color: inherit; text-decoration: none; display: block;">Update Offers</a></li>
                <li ><a href="Delete_offers.jsp" style="color: inherit; text-decoration: none; display: block;">Delete Offers</a></li>
                <li><a href="product_add.jsp" style="color: inherit; text-decoration: none; display: block;">Add Products</a></li>
                <li  class="active"><a href="View_products.jsp" style="color: inherit; text-decoration: none; display: block;">View Products</a></li>
                <li><a href="Advertiser_profile.jsp" style="color: inherit; text-decoration: none; display: block;">Avertiser Profile</a></li>
                <li><a href="index.html" style="color: inherit; text-decoration: none; display: block;">Logout</a></li>
            </ul>
        </div>
    </div>
</div>

<div class="main-content">
    <div class="dashboard-header">
        <h2>Products</h2>
        <button class="logout-btn" onclick="window.location.href='index.html'">Logout</button>
    </div>

    <div class="offers-container">
        <div class="content-header">
            <h3>Products</h3>
            <div class="action-buttons">
                <button class="btn btn-success" onclick="window.location.href='create_offer.jsp'">Create New</button>
            </div>
        </div>

        <table class="offer-table">
            <thead>
                <tr>
                    <th>PID</th>
                    <th>Product Name</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Category</th>
                    <th>Brand</th>
                    <th>Quantity</th>
                    <th>Offer Id</th>
                    <th>Image</th>
                </tr>
            </thead>
            <tbody>
            <%
                while (rs.next()) {
                    // Convert image blob to Base64 string
                    Blob blob = rs.getBlob("productImage");
                    String base64Image = "";
                    if (blob != null) {
                        byte[] imageBytes = blob.getBytes(1, (int) blob.length());
                        base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    }
            %>
                <tr>
                    <td><%= rs.getInt("product_id") %></td>
                    <td><%= rs.getString("product_name") %></td>
                    <td><%= rs.getString("description") %></td>
                    <td><%= rs.getDouble("price") %></td>
                    <td><%= rs.getString("category") %></td>
                    <td><%= rs.getString("brand") %></td>
                    <td><%= rs.getInt("quantity") %></td>
                    <td><%= rs.getInt("oid") %></td>
                    <td>
                        <% if (!base64Image.isEmpty()) { %>
                            <img src="data:image/jpeg;base64,<%= base64Image %>" class="product-image" />
                        <% } else { %>
                            No Image
                        <% } %>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
