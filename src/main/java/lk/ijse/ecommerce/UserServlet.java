package lk.ijse.ecommerce;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;


import javax.sql.DataSource;
import java.io.*;
import java.sql.*;

@WebServlet(name = "userServlet" , value = "/signup" )
@MultipartConfig
public class UserServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("signup".equalsIgnoreCase(action)) {
            handleSignUp(request, response);
        } else if ("signin".equalsIgnoreCase(action)) {
            handleSignIn(request, response);
        }
    }

    private void handleSignUp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("userName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber");
        String role = request.getParameter("role");
        String status = request.getParameter("status");



        Part imagePart = request.getPart("profilePicture");
        InputStream imageInputStream = null;

        if (imagePart != null) {
            imageInputStream = imagePart.getInputStream();
        }


        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement pst = null;
        try {
            // Establish connection
            conn = dataSource.getConnection();

            // Check if the user already exists by email
            String checkEmailQuery = "SELECT * FROM users WHERE email = ?";
            pst = conn.prepareStatement(checkEmailQuery);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                request.setAttribute("error", "Email is already registered.");
                request.getRequestDispatcher("/pages/signup.jsp").forward(request, response);
                return;
            }

            // Insert the new user
            String insertQuery = "INSERT INTO users (username, email, password, role, fullName, address, phoneNumber, status, image) VALUES (?, ?, ?, ?, ?, ?, ?,?,?)";
            pst = conn.prepareStatement(insertQuery);
            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, password);
            pst.setString(4, role);
            pst.setString(5, fullName);
            pst.setString(6, address);
            pst.setString(7, phoneNumber);
            pst.setString(8, status);

            if (imageInputStream != null) {
                pst.setBlob(9, imageInputStream);
            }else {
                pst.setNull(9, Types.BLOB);
            }

            int rowsAffected = pst.executeUpdate();

            if (rowsAffected > 0) {
                request.setAttribute("success", "Account created successfully! Please log in.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "An error occurred. Please try again.");
                request.getRequestDispatcher("/pages/signup.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error. Please try again later.");
            request.getRequestDispatcher("/pages/signup.jsp").forward(request, response);
        } finally {
            try {
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void handleSignIn(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            // Establish connection
            conn = dataSource.getConnection();

            // Check user credentials
            String query = "SELECT * FROM users WHERE email = ? AND password = ?";
            pst = conn.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            rs = pst.executeQuery();

            if (rs.next()) {
                // User found, set session and redirect to welcome page
                String username = rs.getString("username");
                if (rs.getString("role").equals("Admin")) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", username);
                    response.sendRedirect("pages/dashBoard.jsp");
                }else if ( rs.getString("role").equals("Customer")) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", username);
                    response.sendRedirect("pages/home.jsp");
                }

            } else {
                // Invalid credentials
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error. Please try again later.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
