package lk.ijse.ecommerce;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import lk.ijse.ecommerce.dto.CateDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@WebServlet(name = "AddCategory", value = "/addCategories")
@MultipartConfig
public class AddCategory extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<CateDTO> categoryList = new ArrayList<>();

        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT id, name, description, status, icon FROM categories";
            try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String id = rs.getString("id");
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    String status = rs.getString("status");
                    byte[] image = rs.getBytes("icon");

                    categoryList.add(new CateDTO(id, name, description, status, image));
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Error retrieving categories from database", e);
        }


        // Set the category list as a request attribute for JSP
        request.setAttribute("categoryList", categoryList);

        // Forward to the JSP
        request.getRequestDispatcher("/pages/addCategories.jsp").forward(request, response);
        response.sendRedirect("addCategories.jsp");
    }





    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        switch (action) {
            case "add-category":
                addCategory(req, resp);
                break;
            case "delete-category":
                deleteCategory(req, resp);
        }
    }

    private void addCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String status = req.getParameter("status");
        System.out.println(name + description + status);
        Part imagePart = req.getPart("categoryImage");
        InputStream imageInputStream = null;


        if (imagePart != null) {
            imageInputStream = imagePart.getInputStream();
        }

        Connection conn = null;
        try {
            conn = dataSource.getConnection();
            String sql = "INSERT INTO categories (name, description, status, icon) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, description);
            statement.setString(3, status);

            if (imageInputStream != null) {
                statement.setBlob(4, imageInputStream);
            } else {
                statement.setNull(4, java.sql.Types.BLOB);
            }

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {

                resp.sendRedirect("addCategories");

            } else {
                req.setAttribute("error", "Failed to add category.");
            }


            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void deleteCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String categoryId = req.getParameter("id");
        System.out.println(categoryId);

        try (Connection connection = dataSource.getConnection()) {
            String sql = "DELETE FROM categories WHERE id = ?";
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setInt(1, Integer.parseInt(categoryId));

            int i = pstm.executeUpdate();

            if (i > 0) {
                req.getSession().setAttribute("categoryMessage", "Category successfully deleted !");
                resp.setContentType("application/json");
                resp.getWriter().write("{\"status\":\"success\"}");
                resp.sendRedirect("/E_Commerce_supun_war_exploded/addCategories");
            } else {
                req.getSession().setAttribute("categoryError", "Failed to delete category !");
                resp.setContentType("application/json");
                resp.getWriter().write("{\"status\":\"error\"}");
                resp.sendRedirect("/pages/addCategories.jsp");
            }
        } catch (SQLException e) {
            req.getSession().setAttribute("categoryError", "Failed to delete category !");
            resp.sendRedirect("/pages/addCategories.jsp");
            throw new RuntimeException(e);
        }
    }

}
