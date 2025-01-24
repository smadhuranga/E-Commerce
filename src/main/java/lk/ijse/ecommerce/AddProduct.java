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
import java.sql.Types;
import java.util.ArrayList;

@WebServlet(name = "AddProduct", value = "/addProduct")
@MultipartConfig
public class AddProduct extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    String categoryName = String.valueOf(new ArrayList<>());


    public void getCategory(){
        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            String sql = "SELECT name FROM categories";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.executeQuery();
            categoryName = sql;
        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        getCategory();
        System.out.println(categoryName);
        String name = req.getParameter("name");
String description = req.getParameter("description");
String unitPrice = req.getParameter("unitPrice");
String quantity = req.getParameter("quantity");
String categoryID = req.getParameter("categoryID");
System.out.println(name+description+unitPrice+quantity+categoryID);



        InputStream imageInputStream = null;

        Part imagePart = req.getPart("productImage");
        if (imagePart != null) {
            imageInputStream = imagePart.getInputStream();
        }

        Connection conn = null;
        try {
            conn = dataSource.getConnection();
            String sql = "INSERT INTO products (name, description, unitPrice, quantity, categoryID, image) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, description);
            statement.setDouble(3, Double.parseDouble(unitPrice));
            statement.setInt(4, Integer.parseInt(quantity));
            statement.setInt(5, Integer.parseInt(categoryID));

            if (imageInputStream != null) {
                statement.setBlob(6, imageInputStream);
            } else {
                statement.setNull(6, Types.BLOB);
            }

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                req.setAttribute("success", "Product added successfully.");
                req.getRequestDispatcher("pages/addProduct.jsp").forward(req, resp);

            } else {
                resp.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
