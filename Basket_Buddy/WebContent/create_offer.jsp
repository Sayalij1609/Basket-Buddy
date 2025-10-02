<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.sayali.basketbuddy.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Offer - OfferMandi</title>
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

        .form-group textarea {
            min-height: 100px;
            resize: vertical;
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

        .offer-preview {
            background: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .preview-header {
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .preview-header h3 {
            color: #2c3e50;
        }

        .offer-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .detail-item {
            margin-bottom: 15px;
        }

        .detail-item h4 {
            color: #2c3e50;
            margin-bottom: 5px;
        }

        .detail-item p {
            color: #7f8c8d;
            line-height: 1.5;
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

        .offer-details-table {
            margin-top: 30px;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .offer-details-table table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .offer-details-table th {
            background-color: #f8c537;
            color: #1a2a3a;
            padding: 10px;
            text-align: left;
        }

        .offer-details-table td {
            padding: 10px;
            border: 1px solid #ddd;
        }

        .offer-details-table tr:nth-child(even) {
            background-color: #f9f9f9;
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
            .offer-details {
                grid-template-columns: 1fr;
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
                <li><a href="advertiser_dashboard.html" style="color: inherit; text-decoration: none; display: block;">Dashboard</a></li>
                <li><a href="View_offer.jsp" style="color: inherit; text-decoration: none; display: block;">View Offers</a></li>
                <li class="active"><a href="create_offer.jsp" style="color: inherit; text-decoration: none; display: block;">Create Offer</a></li>
                <li><a href="update_offers.jsp" style="color: inherit; text-decoration: none; display: block;">Update Offers</a></li>
                <li><a href="Delete_offers.jsp" style="color: inherit; text-decoration: none; display: block;">Delete Offers</a></li>
                <li><a href="product_add.jsp" style="color: inherit; text-decoration: none; display: block;">Add Products</a></li>
                <li><a href="View_products.jsp" style="color: inherit; text-decoration: none; display: block;">View Products</a></li>
                <li><a href="Advertiser_profile.jsp" style="color: inherit; text-decoration: none; display: block;">Avertiser Profile</a></li>
                <li><a href="index.html" style="color: inherit; text-decoration: none; display: block;">Logout</a></li>
            </ul>
        </div>
    </div>

    <div class="main-content">
        <div class="dashboard-header">
            <h2>Create New Offer</h2>
            <button class="logout-btn" onclick="window.location.href='index.jsp'">Logout</button>
        </div>

        <div class="offer-form-container">
            <div class="form-header">
                <h3>Offer Details</h3>
            </div>
            <form class="offer-form" id="offerForm" method="POST" action="create_offer.jsp" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="title">Offer Title</label>
                    <input type="text" id="title" name="title" required>
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                    <input type="text" name="description" required>
                </div>
                <div class="form-group">
                    <label for="discount">Discount (%)</label>
                    <input type="text" id="discount" name="discount" required>
                </div>
                <div class="form-group">
                    <label for="startDate">Start Date</label>
                    <input type="date" id="startDate" name="startDate" required onchange="validateDates()">
                </div>
                <div class="form-group">
                    <label for="endDate">End Date</label>
                    <input type="date" id="endDate" name="endDate" required>
                </div>
                <div class="form-group">
                    <label for="shopName">Shop Name</label>
                    <input type="text" id="shopName" name="shopName" required>
                </div>
                <div class="form-group">
                    <label for="city">City</label>
                    <input type="text" id="city" name="city" required>
                </div>
                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" required>
                </div>
                <div class="form-group">
                    <label for="products">Products</label>
                    <input type="text" name="products" placeholder="List products separated by commas" required>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-success">Create Offer</button>
                </div>
            </form>
            
            <%-- Server-side processing --%>
            <%
            try { 
                Connection con = DBconnection.connect(); 
                
                String title = request.getParameter("title");
                if (title != null) { 
                    String description = request.getParameter("description");
                    String discount = request.getParameter("discount");
                    String startDate = request.getParameter("startDate");
                    String endDate = request.getParameter("endDate");
                    String shopName = request.getParameter("shopName");
                    String city = request.getParameter("city");
                    String address = request.getParameter("address");
                    String products = request.getParameter("products");
                    
                    // Server-side date validation
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date today = new Date();
                    Date start = sdf.parse(startDate);
                    Date end = sdf.parse(endDate);
                    
                    if (start.before(today)) {
                        out.println("<div class='error-message'>");
                        out.println("Error: Start date cannot be before today");
                        out.println("</div>");
                    } else if (end.before(start)) {
                        out.println("<div class='error-message'>");
                        out.println("Error: End date must be after start date");
                        out.println("</div>");
                    } else {
                        int oid = 0; 
                        int aid = GetSet.getAid();
                        String status = "pending";
                        
                        PreparedStatement pstmt = con.prepareStatement("INSERT INTO offer VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                        pstmt.setInt(1, oid);
                        pstmt.setString(2, title);
                        pstmt.setString(3, description);
                        pstmt.setString(4, discount);
                        pstmt.setString(5, startDate);
                        pstmt.setString(6, endDate);
                        pstmt.setString(7, shopName);
                        pstmt.setString(8, city);
                        pstmt.setString(9, address);
                        pstmt.setString(10, products);
                        pstmt.setInt(11, aid);
                        pstmt.setString(12, status);
                        
                        int i = pstmt.executeUpdate();
                        
                        if (i > 0) {
                            out.println("<div class='success-message'>");
                            out.println("Offer added successfully!");
                            out.println("</div>");
                            
                            out.println("<div class='offer-details-table'>");
                            out.println("<h3>Submitted Offer Details</h3>");
                            out.println("<table border='1'>");
                            out.println("<tr style='background-color:#f8c537;color:#1a2a3a;'>");
                            out.println("<th>Field</th><th>Value</th>");
                            out.println("</tr>");
                            
                            out.println("<tr><td>Title</td><td>" + title + "</td></tr>");
                            out.println("<tr><td>Description</td><td>" + description + "</td></tr>");
                            out.println("<tr><td>Discount</td><td>" + discount + "%</td></tr>");
                            out.println("<tr><td>Validity</td><td>" + startDate + " to " + endDate + "</td></tr>");
                            out.println("<tr><td>Shop Name</td><td>" + shopName + "</td></tr>");
                            out.println("<tr><td>Location</td><td>" + city + ", " + address + "</td></tr>");
                            out.println("<tr><td>Products</td><td>" + products + "</td></tr>");
                            
                            out.println("</table>");
                            out.println("<div style='margin-top:20px;'>");
                            out.println("<a href='View_offer.jsp' class='btn btn-primary'>View All Offers</a>");
                            out.println("</div>");
                            out.println("</div>");
                        }
                    }
                }
            } catch (SQLException e) {
                out.println("<div class='error-message'>");
                out.println("Error: " + e.getMessage());
                out.println("</div>");
                e.printStackTrace();
            } catch (Exception e) {
                out.println("<div class='error-message'>");
                out.println("Error: " + e.getMessage());
                out.println("</div>");
                e.printStackTrace();
            }
            %>
        </div>
    </div>

    <script>
        // Set today's date as min for start date when page loads
        window.onload = function() {
            var today = new Date().toISOString().split('T')[0];
            document.getElementById("startDate").setAttribute('min', today);
        };

        // Validate dates when start date changes
        function validateDates() {
            var startDate = document.getElementById("startDate").value;
            var endDate = document.getElementById("endDate").value;
            
            if (startDate) {
                // Set end date min to start date
                document.getElementById("endDate").setAttribute('min', startDate);
                
                // If end date is before start date, reset it
                if (endDate && endDate < startDate) {
                    document.getElementById("endDate").value = "";
                    alert("End date must be after start date");
                }
            }
        }

        // Form validation before submission
        function validateForm() {
            var startDate = document.getElementById("startDate").value;
            var endDate = document.getElementById("endDate").value;
            var today = new Date().toISOString().split('T')[0];
            
            // Check if start date is before today
            if (startDate < today) {
                alert("Start date cannot be before today");
                return false;
            }
            
            // Check if end date is before start date
            if (endDate && endDate < startDate) {
                alert("End date must be after start date");
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>