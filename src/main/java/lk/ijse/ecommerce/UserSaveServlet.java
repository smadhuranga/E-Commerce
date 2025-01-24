package lk.ijse.ecommerce;//package lk.ijse.ecommerce;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import java.io.IOException;
//@WebServlet(name = "UserSaveServlet", value = "/pages/sigin")
//public class UserSaveServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // Retrieve form data
//        String userID = request.getParameter("userID");
//        String userName = request.getParameter("userName");
//        String fullName = request.getParameter("fullName");
//        String email = request.getParameter("email");
//        String password = request.getParameter("password");
//        String confirmPassword = request.getParameter("confirmPassword");
//        String role = request.getParameter("role");
//        String address = request.getParameter("address");
//        String phoneNumber = request.getParameter("phoneNumber");
//        String status = request.getParameter("status");
//        String data = request.getParameter("data");
//
//        // Validate required fields
//        if (userID == null || userID.isEmpty() ||
//                userName == null || userName.isEmpty() ||
//                fullName == null || fullName.isEmpty() ||
//                email == null || email.isEmpty() ||
//                password == null || password.isEmpty() ||
//                confirmPassword == null || confirmPassword.isEmpty() ||
//                role == null || role.isEmpty() ||
//                address == null || address.isEmpty() ||
//                phoneNumber == null || phoneNumber.isEmpty() ||
//                status == null || status.isEmpty()) {
//
//            request.setAttribute("error", "All fields are required except 'Additional Data'.");
//            request.getRequestDispatcher("signup.jsp").forward(request, response);
//            return;
//        }
//
//        // Check password confirmation
//        if (!password.equals(confirmPassword)) {
//            request.setAttribute("error", "Passwords do not match.");
//            request.getRequestDispatcher("signup.jsp").forward(request, response);
//            return;
//        }
//
//        // TODO: Save user details to the database
//        // For example:
//        // User user = new User(userID, userName, fullName, email, password, role, address, phoneNumber, status, data);
//        // userService.save(user);
//
//        // Redirect or send a success response
//        response.sendRedirect("success.jsp");
//    }
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        response.sendRedirect("signup.jsp"); // Redirect GET requests to the form
//    }
//}
