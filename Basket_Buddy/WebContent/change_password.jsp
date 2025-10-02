<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.sayali.basketbuddy.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password - OfferMandi</title>
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

        .sidebar-menu li:hover {
            background: rgba(248, 197, 55, 0.1);
            transform: translateX(5px);
            color: #f8c537;
        }

        .sidebar-menu li.active {
            background: linear-gradient(90deg, #f8c537, #f39c12);
            color: #1a2a3a;
            font-weight: bold;
            box-shadow: 0 4px 8px rgba(248, 197, 55, 0.3);
        }

        .main-content {
            margin-left: 250px;
            width: calc(100% - 250px);
            min-height: 100vh;
            background-color: rgba(249, 249, 249, 0.95);
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

        .password-container {
            background: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            max-width: 600px;
            margin: 0 auto;
        }

        .content-header {
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .content-header h3 {
            color: #2c3e50;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            transition: border 0.3s;
        }

        .form-group input:focus {
            border-color: #f8c537;
            outline: none;
            box-shadow: 0 0 0 2px rgba(248, 197, 55, 0.2);
        }

        .btn-primary {
            background: #3498db;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            font-size: 16px;
            transition: all 0.3s;
            width: 100%;
        }

        .btn-primary:hover {
            background: #2980b9;
        }

        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
            text-align: center;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
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
        }
    </style>
</head>
<body>
    <%
    String message = "";
    String messageClass = "";
    
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        
        if (currentPassword == null || newPassword == null || confirmPassword == null) {
            message = "All fields are required.";
            messageClass = "error";
        } else if (!newPassword.equals(confirmPassword)) {
            message = "New passwords do not match.";
            messageClass = "error";
        } else {
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            
            try {
                con = DBconnection.connect();
                int uid = GetSet1.getUid();
                
                
                String query = "SELECT * FROM user WHERE uid = ? AND upassword = ?";
                ps = con.prepareStatement(query);
                ps.setInt(1, uid);
                ps.setString(2, currentPassword);
                rs = ps.executeQuery();
                
                if (rs.next()) {
                    String updateQuery = "UPDATE user SET upassword = ? WHERE uid = ?";
                    ps = con.prepareStatement(updateQuery);
                    ps.setString(1, newPassword);
                    ps.setInt(2, uid);
                    
                    int rowsAffected = ps.executeUpdate();
                    if (rowsAffected > 0) {
                        message = "Password changed successfully!";
                        messageClass = "success";
                    } else {
                        message = "Failed to change password. Please try again.";
                        messageClass = "error";
                    }
                } else {
                    message = "Current password is incorrect.";
                    messageClass = "error";
                }
            } catch (SQLException e) {
                e.printStackTrace();
                message = "Database error occurred. Please try again later.";
                messageClass = "error";
            } 
            }
        }
    
        
    %>
    <div class="sidebar">
        <div class="sidebar-header">
            <h1>OfferMandi</h1>
            <p>User Dashboard</p>
        </div>
        <div class="sidebar-menu">
            <h3>Navigation</h3>
            <ul>
                <li><a href="View_user_dashboard.jsp" style="color: inherit; text-decoration: none; display: block;">Search Offers</a></li>
                <li><a href="View_user_product.jsp" style="color: inherit; text-decoration: none; display: block;">View Products</a></li>
                <li class="active"><a href="change_password.jsp" style="color: inherit; text-decoration: none; display: block;">Change Password</a></li>
                <li><a href="user_profile.jsp" style="color: inherit; text-decoration: none; display: block;">My Profile</a></li>
                <li><a href="index.html" style="color: inherit; text-decoration: none; display: block;">Logout</a></li>
            </ul>
        </div>
    </div>

    <div class="main-content">
        <div class="dashboard-header">
            <h2>Change Password</h2>
            <button class="logout-btn" onclick="window.location.href='index.html'">Logout</button>
        </div>

        <div class="password-container">
            <div class="content-header">
                <h3>Update Your Password</h3>
            </div>
            
            <% if (!message.isEmpty()) { %>
                <div class="message <%= messageClass %>">
                    <%= message %>
                </div>
            <% } %>
            
            <form method="POST" action="change_password.jsp">
                <div class="form-group">
                    <label for="currentPassword">Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword" required>
                </div>
                
                <div class="form-group">
                    <label for="newPassword">New Password</label>
                    <input type="password" id="newPassword" name="newPassword" required>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>
                
                <button type="submit" class="btn-primary">Change Password</button>
            </form>
        </div>
    </div>
</body>
</html>