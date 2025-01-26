package lk.ijse.ecommerce;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import lk.ijse.ecommerce.dto.ProductsDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AddProduct", value = "/addProduct")
@MultipartConfig
public class AddProduct extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;


    List<String> categoryName = new ArrayList<>();


    public String getCategoryId(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;

        String getCategoryname = req.getParameter("categoryID");
        String gotId = "";


        try {
            conn = dataSource.getConnection();
            String sql = "SELECT id FROM categories WHERE name = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, getCategoryname);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                gotId = resultSet.getString("id");
            }


        } catch (Exception e) {
            e.printStackTrace();
        }

        return gotId;
    }


    public void getCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        String name = null;

        try {
            conn = dataSource.getConnection();
            String sql = "SELECT name FROM categories";
            PreparedStatement statement = conn.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                categoryName.add(resultSet.getString("name"));

            }
            req.setAttribute("categoryList", categoryName);


        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        String name = req.getParameter("productName");
        String description = req.getParameter("description");
        String unitPrice = req.getParameter("unitPrice");
        int quantity = Integer.parseInt(req.getParameter("qtyOnHand"));
        String categoryID = getCategoryId(req, resp);


        System.out.println(name + description + unitPrice + quantity + categoryID);


        InputStream imageInputStream = null;

        Part imagePart = req.getPart("productImage");
        if (imagePart != null) {
            imageInputStream = imagePart.getInputStream();
        }

        Connection conn = null;
        try {
            conn = dataSource.getConnection();
            String sql = "INSERT INTO products (name, description, unitPrice, qtyOnHand, categoryID, image) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, description);
            statement.setDouble(3, Double.parseDouble(unitPrice));
            statement.setInt(4, quantity);
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


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        getCategory(req, resp);

        List<ProductsDTO> productList = new ArrayList<>();

        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT * FROM products";
            try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int itemCode = rs.getInt("itemCode");
                    String name = rs.getString("name");
                    double unitPrice = rs.getDouble("unitPrice");
                    String description = rs.getString("description");
                    int quantity = rs.getInt("qtyOnHand");
                    byte[] image = rs.getBytes("image");
                    int categoryID = rs.getInt("categoryID");

                    productList.add(new ProductsDTO(itemCode, name, unitPrice, description, quantity, image, categoryID));
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Error retrieving products from database", e);
        }


        req.setAttribute("productList", productList);

        req.getRequestDispatcher("pages/addProduct.jsp").forward(req, resp);

    }


}
