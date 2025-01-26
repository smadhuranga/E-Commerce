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
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
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


        body.modal-open {
            overflow: hidden;
        }

        .modal-backdrop {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(5px);
            z-index: 1040;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .modal-backdrop.show {
            opacity: 1;
        }

        .modal {
            z-index: 1050;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="add-product-container">
        <form id="productForm" action="/E_Commerce_supun_war_exploded/addProduct" method="post"
              enctype="multipart/form-data">
            <div class="product-image-container">
                <img src="/api/placeholder/200/200" alt="Product Image" class="product-image" id="productImagePreview">
                <div class="image-upload-overlay">
                    <input type="file" id="productImage" name="productImage" accept="image/*" class="d-none">
                    <label for="productImage" class="m-0">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
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
                <input type="text" class="form-control" id="productName" name="productName"
                       placeholder="Enter product name" required>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="unitPrice" class="form-label">Unit Price</label>
                    <input type="number" class="form-control" id="unitPrice" name="unitPrice" placeholder="0.00"
                           step="0.01" min="0" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="qtyOnHand" class="form-label">Quantity on Hand</label>
                    <input type="number" class="form-control" id="qtyOnHand" name="qtyOnHand" placeholder="0" min="0"
                           required>
                </div>
            </div>

            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" id="description" name="description" rows="4"
                          placeholder="Enter product description" required></textarea>
            </div>

            <div class="mb-3">
                <label for="categoryID" class="form-label">Category</label>
                <select class="form-control" id="categoryID" name="categoryID" required>
                    <option value="" disabled selected>Select a category</option>
                    <%
                        // Retrieve the category list from the request attribute
                        List<ProductsDTO> categoryList = (List<ProductsDTO>) request.getAttribute("productList");
                        if (categoryList != null) {
                            for (ProductsDTO category : categoryList) {
                    %>
                    <option value="<%= category %>"><%= category %>
                    </option>
                    <%
                            }
                        }
                    %>
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
                List<ProductsDTO> productList = (List<ProductsDTO>) request.getAttribute("productList");
                if (productList != null && !productList.isEmpty()) {
                    for (ProductsDTO product : productList) {
            %>
            <tr>
                <td><%= product.getItemCode() %>
                </td>
                <td><%= product.getName() %>
                </td>
                <td><%= product.getUnitPrice() %>
                </td>
                <td><%= product.getQuantity() %>
                </td>
                <td><%= product.getDescription() %>
                </td>
                <td><%= product.getCategoryID() %>
                </td>
                <td>
                    <button onclick="openEditModal('<%= product.getItemCode() %>', '<%= product.getName() %>', <%= product.getUnitPrice() %>, <%= product.getQuantity() %>, '<%= product.getDescription() %>', '<%= product.getCategoryID() %>')"
                            class="btn btn-warning btn-custom">Edit
                    </button>
                    <button onclick="openDeleteModal('<%= product.getItemCode() %>', '<%= product.getName() %>')"
                            class="btn btn-danger btn-custom">Delete
                    </button>
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

    <!-- Edit Modal -->
    <div id="editModal" class="modal" style="display:none;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Product</h5>
                    <button type="button" class="btn-close" onclick="closeEditModal()"></button>
                </div>
                <form id="editForm" action="updateProduct" method="post">
                    <div class="modal-body">
                        <input type="hidden" id="editItemCode" name="itemCode">

                        <div class="mb-3">
                            <label class="form-label">Product Name</label>
                            <input type="text" class="form-control" id="editProductName" name="productName" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Unit Price</label>
                                <input type="number" class="form-control" id="editUnitPrice" name="unitPrice"
                                       step="0.01" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Quantity</label>
                                <input type="number" class="form-control" id="editQuantity" name="quantity" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" id="editDescription" name="description" rows="3"
                                      required></textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Category</label>
                            <select class="form-control" id="editCategory" name="categoryID" required>
                                <%
                                    List<String> categoryList2 = (List<String>) request.getAttribute("categoryList");
                                    if (categoryList2 != null) {
                                        for (String category : categoryList2) {
                                %>
                                <option value="<%= category %>"><%= category %>
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" onclick="closeEditModal()">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal" style="display:none;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirm Delete</h5>
                    <button type="button" class="btn-close" onclick="closeDeleteModal()"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="deleteItemCode">
                    <p>Are you sure you want to delete the product: <span id="deleteProductName"></span>?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeDeleteModal()">Cancel</button>
                    <button type="button" class="btn btn-danger" onclick="confirmDelete()">Delete</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('productImage').addEventListener('change', function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('productImagePreview').src = e.target.result;
            }
            reader.readAsDataURL(file);
        }
    });

    // Edit Modal Functions
    function openEditModal(itemCode, name, unitPrice, quantity, description, category) {
        document.getElementById('editItemCode').value = itemCode;
        document.getElementById('editProductName').value = name;
        document.getElementById('editUnitPrice').value = unitPrice;
        document.getElementById('editQuantity').value = quantity;
        document.getElementById('editDescription').value = description;
        document.getElementById('editCategory').value = category;
        document.getElementById('editModal').style.display = 'block';
    }

    function closeEditModal() {
        document.getElementById('editModal').style.display = 'none';
    }

    // Delete Modal Functions
    function openDeleteModal(itemCode, productName) {
        document.getElementById('deleteItemCode').value = itemCode;
        document.getElementById('deleteProductName').textContent = productName;
        document.getElementById('deleteModal').style.display = 'block';
    }

    function closeDeleteModal() {
        document.getElementById('deleteModal').style.display = 'none';
    }

    function confirmDelete() {
        var itemCode = document.getElementById('deleteItemCode').value;
        window.location.href = 'addProduct?id=' + itemCode;

    }

    // Close modals when clicking outside
    window.onclick = function (event) {
        var editModal = document.getElementById('editModal');
        var deleteModal = document.getElementById('deleteModal');

        if (event.target == editModal) {
            editModal.style.display = 'none';
        }
        if (event.target == deleteModal) {
            deleteModal.style.display = 'none';
        }
    }


    // JavaScript to handle blur backdrop
    function openEditModal(itemCode, name, unitPrice, quantity, description, category) {
        // Existing modal open logic
        document.getElementById('editItemCode').value = itemCode;
        document.getElementById('editProductName').value = name;
        document.getElementById('editUnitPrice').value = unitPrice;
        document.getElementById('editQuantity').value = quantity;
        document.getElementById('editDescription').value = description;
        document.getElementById('editCategory').value = category;

        // Add blur backdrop
        document.body.classList.add('modal-open');
        var backdrop = document.createElement('div');
        backdrop.classList.add('modal-backdrop');
        document.body.appendChild(backdrop);

        // Show modal
        setTimeout(() => {
            document.getElementById('editModal').style.display = 'block';
            backdrop.classList.add('show');
        }, 10);
    }

    function closeEditModal() {
        document.getElementById('editModal').style.display = 'none';

        // Remove blur backdrop
        var backdrop = document.querySelector('.modal-backdrop');
        backdrop.classList.remove('show');
        document.body.classList.remove('modal-open');

        setTimeout(() => {
            backdrop.remove();
        }, 300);
    }

    // Similar modifications for delete modal functions
    function openDeleteModal(itemCode, productName) {
        document.getElementById('deleteItemCode').value = itemCode;
        document.getElementById('deleteProductName').textContent = productName;

        // Add blur backdrop
        document.body.classList.add('modal-open');
        var backdrop = document.createElement('div');
        backdrop.classList.add('modal-backdrop');
        document.body.appendChild(backdrop);

        document.getElementById('deleteModal').onclick = function () {
            window.location.href = 'addProduct?id=' + itemCode;

            if (id) {
                const form = document.createElement('form');
                form.method = 'post';
                form.action = '/E_Commerce_supun_war_exploded/addProduct';

                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete-category';
                form.appendChild(actionInput);

                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = id;
                form.appendChild(idInput);

                document.body.appendChild(form);
                form.submit();
            }

        }

        // Show modal
        setTimeout(() => {
            document.getElementById('deleteModal').style.display = 'block';
            backdrop.classList.add('show');
        }, 10);
    }

    function closeDeleteModal() {
        document.getElementById('deleteModal').style.display = 'none';

        // Remove blur backdrop
        var backdrop = document.querySelector('.modal-backdrop');
        backdrop.classList.remove('show');
        document.body.classList.remove('modal-open');

        setTimeout(() => {
            backdrop.remove();
        }, 300);
    }

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>