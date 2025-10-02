<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="com.sayali.basketbuddy.*" %>
<%@ page import ="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Offer - OfferMandi</title>
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
            content: "→";
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

        .offer-form-container {
            background: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }

        .form-header {
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .form-header h3 {
            color: #2c3e50;
        }

        .offer-form {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: bold;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            transition: all 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            border-color: #f8c537;
            outline: none;
            box-shadow: 0 0 0 3px rgba(248, 197, 55, 0.2);
        }

        .form-actions {
            grid-column: span 2;
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 20px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
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

        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 4px;
            margin-top: 20px;
        }

        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 4px;
            margin-top: 20px;
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
            .offer-form {
                grid-template-columns: 1fr;
            }
            .form-actions {
                grid-column: span 1;
            }
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <h1>OfferMandi</h1>
            <p>Advertiser Dashboard</p>
        </div>
        <div class="sidebar-menu">
            <h3>Navigation</h3>
            <ul>
               <li ><a href="advertiser_dashboard.html" style="color: inherit; text-decoration: none; display: block;">Dashboard</a></li>
                <li ><a href="View_offer.jsp" style="color: inherit; text-decoration: none; display: block;">View Offers</a></li>
                <li><a href="create_offer.jsp" style="color: inherit; text-decoration: none; display: block;">Create Offer</a></li>
                <li class="active"><a href="update_offers.jsp" style="color: inherit; text-decoration: none; display: block;">Update Offers</a></li>
                <li ><a href="Delete_offers.jsp" style="color: inherit; text-decoration: none; display: block;">Delete Offers</a></li>
                <li><a href="product_add.jsp" style="color: inherit; text-decoration: none; display: block;">Add Products</a></li>
                <li><a href="View_products.jsp" style="color: inherit; text-decoration: none; display: block;">View Products</a></li>
                <li><a href="Advertiser_profile.jsp" style="color: inherit; text-decoration: none; display: block;">Avertiser Profile</a></li>
                <li><a href="index.html" style="color: inherit; text-decoration: none; display: block;">Logout</a></li>
            </ul>
        </div>
    </div>

    <div class="main-content">
        <div class="dashboard-header">
            <h2>Update Offer</h2>
            <button class="logout-btn" onclick="window.location.href='index.html'">Logout</button>
        </div>

        <%
        // Show success/error messages if they exist
        String success = request.getParameter("success");
        String error = request.getParameter("error");
        
        if(success != null) {
            out.println("<div class='success-message'>" + success + "</div>");
        }
        if(error != null) {
            out.println("<div class='error-message'>" + error + "</div>");
        }
        
        Connection con = DBconnection.connect();
        String id = request.getParameter("id");
        
        if(id != null && !id.isEmpty()) {
            try {
                PreparedStatement ps = con.prepareStatement("SELECT * FROM offer WHERE oid = ?");
                ps.setInt(1, Integer.parseInt(id));
                ResultSet rs = ps.executeQuery();
                
                if(rs.next()) {
        %>
        <div class="offer-form-container">
            <div class="form-header">
                <h3>Update Offer Details</h3>
            </div>
            
            <form class="offer-form" method="POST" action="process_update.jsp">
                <input type="hidden" name="oid" value="<%= rs.getInt(1) %>">
                
                <div class="form-group">
                    <label for="title">Offer Title</label>
                    <input type="text" id="title" name="title" value="<%= rs.getString(2) %>" required>
                </div>
                
                <div class="form-group">
                    <label for="description">Description</label>
                    <input type="text" id="description" name="description" value="<%= rs.getString(3) %>" required>
                </div>
                
                <div class="form-group">
                    <label for="discount">Discount (%)</label>
                    <input type="text" id="discount" name="discount" value="<%= rs.getString(4) %>" required>
                </div>
                
                <div class="form-group">
                    <label for="startDate">Start Date</label>
                    <input type="date" id="startDate" name="startDate" value="<%= rs.getString(5) %>" required>
                </div>
                
                <div class="form-group">
                    <label for="endDate">End Date</label>
                    <input type="date" id="endDate" name="endDate" value="<%= rs.getString(6) %>" required>
                </div>
                
                <div class="form-group">
                    <label for="shopName">Shop Name</label>
                    <input type="text" id="shopName" name="shopName" value="<%= rs.getString(7) %>" required>
                </div>
                
                <div class="form-group">
                    <label for="city">City</label>
                    <input type="text" id="city" name="city" value="<%= rs.getString(8) %>" required>
                </div>
                
                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" value="<%= rs.getString(9) %>" required>
                </div>
                
                <div class="form-group">
                    <label for="products">Products</label>
                    <input type="text" id="products" name="products" value="<%= rs.getString(10) %>" required>
                </div>
                
                <div class="form-actions">
                    <button type="button" class="btn btn-warning" onclick="window.location.href='view_offers.jsp'">Cancel</button>
                    <button type="submit" class="btn btn-success">Update Offer</button>
                </div>
            </form>
        </div>
        <%
                } else {
                    out.println("<div class='error-message'>No offer found with ID: " + id + "</div>");
                }
            } catch(Exception e) {
                out.println("<div class='error-message'>Error: " + e.getMessage() + "</div>");
            }
        } else {
            out.println("<div class='error-message'>No offer ID provided</div>");
        }
        %>
    </div>
</body>
</html>