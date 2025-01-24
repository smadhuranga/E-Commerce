<%@ page import="lk.ijse.ecommerce.dto.ProductsDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #3498db;
            --background-light: #2059aa;
            --table-header-color: #e9ecef;
        }

        body {
            background: linear-gradient(135deg, var(--background-light) 0%, #e9ecef 100%);
        }

        .add-product-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            padding: 40px;
            max-width: 600px;
            margin: 50px auto;
        }

        .product-image-container {
            position: relative;
            width: 200px;
            height: 200px;
            margin: 0 auto 20px;
        }

        .product-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 15px;
            border: 3px solid var(--primary-color);
        }

        .image-upload-overlay {
            position: absolute;
            bottom: 10px;
            right: 10px;
            background: var(--primary-color);
            color: white;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }

        .form-control {
            border-radius: 8px;
        }

        .table-container {
            margin: 50px auto;
            max-width: 800px;
        }

        .table th {
            background-color: var(--table-header-color);
        }

        .btn-custom {
            margin-right: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="add-product-container">
        <form id="productForm" action="/E_Commerce_supun_war_exploded/addProduct" method="post" enctype="multipart/form-data">
            <div class="product-image-container">
                <img src="/api/placeholder/200/200" alt="Product Image" class="product-image" id="productImagePreview">
                <div class="image-upload-overlay">
                    <input type="file" id="productImage" name="productImage" accept="image/*" class="d-none">
                    <label for="productImage" class="m-0">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M23 19a2 2 0 0 1-2 2h-18a2 2 0 0 1-2-2v-14a2 2 0 0 1 2-2h4l2 3h8l2-3h4a2 2 0 0 1 2 2z"></path>
                            <line x1="12" y1="11" x2="12" y2="17"></line>
                            <line x1="9" y1="14" x2="15" y2="14"></line>
                        </svg>
                    </label>
                </div>
            </div>

            <h2 class="text-center mb-4">Add New Product</h2>

            <div class="mb-3">
                <label for="productName" class="form-label">Product Name</label>
                <input type="text" class="form-control" id="productName" name="productName" placeholder="Enter product name" required>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="unitPrice" class="form-label">Unit Price</label>
                    <input type="number" class="form-control" id="unitPrice" name="unitPrice" placeholder="0.00" step="0.01" min="0" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="qtyOnHand" class="form-label">Quantity on Hand</label>
                    <input type="number" class="form-control" id="qtyOnHand" name="qtyOnHand" placeholder="0" min="0" required>
                </div>
            </div>

            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" id="description" name="description" rows="4" placeholder="Enter product description" required></textarea>
            </div>

            <div class="mb-3">
                <label for="categoryID" class="form-label">Category</label>
                <select class="form-control" id="categoryID" name="categoryID" required>
                    <option value="" disabled selected>Select a category</option>
                    <option value="1">Category 1</option>
                    <option value="2">Category 2</option>
                    <option value="3">Category 3</option>
                    <!-- Add more categories as needed -->
                </select>
            </div>

            <button type="submit" class="btn btn-primary w-100">Add Product</button>
        </form>
    </div>

    <div class="table-container">
        <h2 class="text-center mb-4">Product List</h2>
        <table class="table table-bordered">
            <thead>
            <tr>
                <th>Item Code</th>
                <th>Product Name</th>
                <th>Unit Price</th>
                <th>Quantity</th>
                <th>Description</th>
                <th>Category</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="productTableBody">
            <%
                // Assuming you have a list of products in a request attribute
                List<ProductsDTO> productList = (List<ProductsDTO>) request.getAttribute("productList");
                if (productList != null) {
                    for (ProductsDTO product : productList) {
            %>
            <tr>
                <td><%= product.getItemCode() %></td>
                <td><%= product.getName() %></td>
                <td><%= product.getUnitPrice() %></td>
                <td><%= product.getQuantity() %></td>
                <td><%= product.getDescription() %></td>
                <td><%= product.getCategoryID() %></td> <!-- Assuming you have a method to get category ID -->
                <td>
                    <a href="editProduct?id=<%= product.getItemCode() %>" class="btn btn-warning btn-custom">Edit</a>
                    <a href="deleteProduct?id=<%= product.getItemCode() %>" class="btn btn-danger btn-custom">Delete</a>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="7" class="text-center">No products found</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script>

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>