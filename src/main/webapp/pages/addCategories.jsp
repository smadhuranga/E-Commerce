<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Base64" %>
<%@ page import="lk.ijse.ecommerce.dto.CateDTO" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2ecc71;
            --background-light: #f4f6f9;
            --text-dark: #2c3e50;
            --background-gradient-start: #1c48b6;
            --background-gradient-end: #ffffff;
            --animation-duration: 3s;
        }

        body {
            background: linear-gradient(to right, var(--background-gradient-start) 0%, var(--background-gradient-end) 100%);
            animation: background-animation var(--animation-duration) ease infinite alternate;
            font-family: 'Inter', sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }

        @keyframes background-animation {
            from {
                background-position: 0 0;
            }
            to {
                background-position: 100% 0;
            }
        }

        .add-category-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1), 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 40px;
            width: 100%;
            max-width: 500px;
            text-align: center;
            margin-bottom: 30px;
        }

        .category-image-container {
            position: relative;
            width: 150px;
            height: 150px;
            margin: 0 auto 30px;
        }

        .category-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid var(--primary-color);
            transition: transform 0.3s ease;
        }

        .category-image:hover {
            transform: scale(1.05);
        }

        .image-upload-overlay {
            position: absolute;
            bottom: 0;
            right: 0;
            background: var(--primary-color);
            color: white;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .image-upload-overlay:hover {
            background: var(--secondary-color);
        }

        .form-label {
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
            text-align: left;
        }

        .form-control, .form-select {
            border-radius: 10px;
            padding: 12px 15px;
            border-color: #e0e0e0;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            border-radius: 10px;
            padding: 12px 20px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #2980b9;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .category-table {
            width: 100%;
            max-width: 800px;
            margin-top: 20px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }

        .category-table th, .category-table td {
            padding: 15px;
            text-align: center;
        }

        .category-table th {
            background-color: var(--primary-color);
            color: white;
        }

        .category-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .modal-backdrop {
            backdrop-filter: blur(5px);
        }

        @media (max-width: 576px) {
            .add-category-container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>

<div class="add-category-container">
    <form id="categoryForm" method="post" action="/E_Commerce_supun_war_exploded/addCategories"
          enctype="multipart/form-data">
        <input type="hidden" name="action" value="add-category">
        <div class="category-image-container">
            <img src="" alt="Category Image" class="category-image" id="categoryImagePreview">
            <div class="image-upload-overlay">
                <input type="file" id="categoryImage" name="categoryImage" accept="image/*" class="d-none">
                <label for="categoryImage" class="m-0">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M23 19a2 2 0 0 1-2 2h-18a2 2 0 0 1-2-2v-14a2 2 0 0 1 2-2h4l2 3h8l2-3h4a2 2 0 0 1 2 2z"></path>
                        <line x1="12" y1="11" x2="12" y2="17"></line>
                        <line x1="9" y1="14" x2="15" y2="14"></line>
                    </svg>
                </label>
            </div>
        </div>
        <h2 class="mb-4">Add New Category</h2>
        <div class="mb-3 text-start">
            <label for="categoryName" class="form-label">Category Name</label>
            <input type="text" class="form-control" id="categoryName" name="name" placeholder="Enter category name"
                   required>
        </div>
        <div class="mb-3 text-start">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" rows="4"
                      placeholder="Enter category description" required></textarea>
        </div>
        <div class="mb-3 text-start">
            <label for="status" class="form-label">Status</label>
            <select class="form-select" id="status" name="status" required>
                <option value="">Select Status</option>
                <option value="Active">Active</option>
                <option value="Draft">Inactive</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary w-100">Add Category</button>
    </form>
</div>

<h2 class="text-center">Manage Categories</h2>

<table class="category-table table table-striped">
    <thead>
    <tr>
        <th>Image</th>
        <th>Name</th>
        <th>Description</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody id="categoryTableBody">
    <%
        List<CateDTO> categoryList = (List<CateDTO>) request.getAttribute("categoryList");
        if (categoryList != null && !categoryList.isEmpty()) {
            for (CateDTO category : categoryList) {
    %>
    <tr>
        <td>
            <%
                String base64Image = category.getImage() != null
                        ? Base64.getEncoder().encodeToString(category.getImage())
                        : "";
            %>
            <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Category Image" class="category-image"
                 style="width:100px;height:100px;">
        </td>
        <td><%= category.getName() %>
        </td>
        <td><%= category.getDescription() %>
        </td>
        <td><%= category.getStatus() %>
        </td>
        <td>
            <button class="btn btn-warning btn-custom"
                    onclick="openEditModal(<%= category.getId() %>, '<%= category.getName() %>', '<%= category.getDescription() %>', '<%= category.getStatus() %>')">
                Edit
            </button>
            <button class="btn btn-danger btn-custom" onclick="openDeleteConfirmation(<%= category.getId() %>)">Delete
            </button>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="5" class="text-center">No categories found</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">Edit Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editCategoryForm" method="post" action="/E_Commerce_supun_war_ex ploded/editCategory">
                    <input type="hidden" id="editCategoryId" name="id">
                    <div class="mb-3">
                        <label for="editCategoryName" class="form-label">Category Name</label>
                        <input type="text" class="form-control" id="editCategoryName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="editDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="editDescription" name="description" rows="4"
                                  required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="editStatus" class="form-label">Status</label>
                        <select class="form-select" id="editStatus" name="status" required>
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Update Category</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteConfirmationModal" tabindex="-1" aria-labelledby="deleteConfirmationModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteConfirmationModalLabel">Delete Confirmation</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete this category?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" id="confirmDeleteButton">Delete</button>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('categoryImage').addEventListener('change', function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('categoryImagePreview').src = e.target.result;
            }
            reader.readAsDataURL(file);
        }
    });

    function openEditModal(id, name, description, status) {
        document.getElementById('editCategoryId').value = id;
        document.getElementById('editCategoryName').value = name;
        document.getElementById('editDescription').value = description;
        document.getElementById('editStatus').value = status;
        var editModal = new bootstrap.Modal(document.getElementById('editModal'));
        editModal.show();
    }

    function openDeleteConfirmation(id) {
        document.getElementById('confirmDeleteButton').onclick = function () {
            window.location.href = 'addCategories?id=' + id;

            if (id) {
                const form = document.createElement('form');
                form.method = 'post';
                form.action = '/E_Commerce_supun_war_exploded/addCategories';

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
        var deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmationModal'));
        deleteModal.show();
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>