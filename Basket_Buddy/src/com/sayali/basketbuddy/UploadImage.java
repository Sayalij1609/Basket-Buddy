package com.sayali.basketbuddy;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(maxFileSize = 16177215) // Limit file size to 16MB
public class UploadImage extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UploadImage() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int aid = GetSet.getAid(); // get advertiser id
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        String price = request.getParameter("price");
        String category = request.getParameter("category");
        String brand = request.getParameter("brand");
        String quantity = request.getParameter("quantity");
        String offerId = request.getParameter("OfferId");

        Part filePart = request.getPart("productImage");
        InputStream inputStream = null;
        byte[] imageBytes = null;

        if (filePart != null) {
            inputStream = filePart.getInputStream();

            // Convert InputStream to byte[]
            ByteArrayOutputStream buffer = new ByteArrayOutputStream();
            byte[] data = new byte[1024];
            int nRead;
            while ((nRead = inputStream.read(data, 0, data.length)) != -1) {
                buffer.write(data, 0, nRead);
            }
            imageBytes = buffer.toByteArray();
        }

        String message;
        Connection con = null;

        try {
            con = DBconnection.connect();

            String sql = "INSERT INTO products (product_name, description, price, category, brand, quantity, oid, aid, productImage) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = con.prepareStatement(sql);

            statement.setString(1, productName);
            statement.setString(2, description);
            statement.setString(3, price);
            statement.setString(4, category);
            statement.setString(5, brand);
            statement.setInt(6, Integer.parseInt(quantity));
            statement.setInt(7, Integer.parseInt(offerId));
            statement.setInt(8, aid);
            statement.setBytes(9, imageBytes); // Store image as byte array

            int row = statement.executeUpdate();
            message = (row > 0) ? "Product added successfully!" : "Failed to add product!";

        } catch (Exception ex) {
            ex.printStackTrace();
            message = " ERROR: " + ex.getMessage();
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Send response to browser
        response.sendRedirect("product_add.jsp");
        PrintWriter out = response.getWriter();
        out.println("<html><head><title>Upload Result</title></head><body>");
        out.println("<h3>" + message + "</h3>");
        out.println("<a href='product_add.jsp'>Go Back</a>");
        out.println("</body></html>");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }
}
