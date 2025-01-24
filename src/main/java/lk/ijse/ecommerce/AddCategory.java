package lk.ijse.ecommerce;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "AddCategory" , value = "/addCategories")
@MultipartConfig
public class AddCategory extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String status = req.getParameter("status");
        System.out.println(name+description+status);
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
                req.setAttribute("message", "Category added successfully.");
                req.getRequestDispatcher("/pages/addCategories.jsp").forward(req, resp);

            } else {
                req.setAttribute("error", "Failed to add category.");
            }


            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
