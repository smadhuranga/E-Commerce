<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Organic - Grocery Store | Sign Up</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="format-detection" content="telephone=no">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <link rel="stylesheet" type="text/css" href="../css/loging.css">
  <style>
    /* Include your CSS styles here or keep them linked externally */
    /* (CSS omitted here for brevity, as provided in your original code) */
  </style>
</head>
<body>
<div class="container">
  <div class="signin-container">
    <div class="signin-left">
      <div class="brand-content">
        <h1>ShopEase</h1>
        <p>Join our community and start shopping smarter today!</p>
      </div>
    </div>
    <div class="signin-right">
      <form action="/E_Commerce_supun_war_exploded/signup" method="post" enctype="multipart/form-data" class="signin-form">
        <input type="hidden" name="action" value="signup">
        <h2>Create Account</h2>
        <p class="subtitle">Fill in your details to get started</p>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
        <div class="error-message" style="color: red; margin-bottom: 15px;"><%= error %></div>
        <% } %>

        <% String success = (String) request.getAttribute("success"); %>
        <% if (success != null) { %>
        <div class="success-message" style="color: green; margin-bottom: 15px;"><%= success %></div>
        <% } %>

        <div class="form-group">
          <label for="userName">Username</label>
          <input type="text" id="userName" name="userName" placeholder="Enter a username" required />
        </div>

        <div class="form-group">
          <label for="fullName">Full Name</label>
          <input type="text" id="fullName" name="fullName" placeholder="John Doe" required />
        </div>

        <div class="form-group">
          <label for="email">Email Address</label>
          <input type="email" id="email" name="email" placeholder="your@email.com" required />
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" placeholder="Create a strong password" required />
        </div>

        <div class="form-group">
          <label for="confirm-password">Confirm Password</label>
          <input type="password" id="confirm-password" name="confirmPassword" placeholder="Confirm your password" required />
        </div>

        <div class="form-group">
          <label for="role">Role</label>
          <select id="role" name="role" required>
            <option value="Customer">Customer</option>
          </select>
        </div>
        <div>
          <label for="role">Choose Profile Picture</label>
          <input type="file" id="profilePicture" name="profilePicture" accept="image/*" required>

        </div>

        <div class="form-group">
          <label for="address">Address</label>
          <textarea id="address" name="address" placeholder="Enter your address" rows="3" required></textarea>
        </div>

        <div class="form-group">
          <label for="phoneNumber">Phone Number</label>
          <br>
          <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="123-456-7890" required />
        </div>

        <div class="form-group">
          <label for="status">Status</label>
          <select id="status" name="status" required>
            <option value="Active">Active</option>
            <option value="Inactive">Inactive</option>
          </select>
        </div>

        <div class="form-options">
          <label class="remember-me">
            <input type="checkbox" required />
            <span>I agree to the Terms & Conditions</span>
          </label>
        </div>

        <button type="submit" class="signin-button">Create Account</button>

        <p class="signup-link">
          Already have an account? <a href="../index.jsp">Sign in</a>
        </p>
      </form>
    </div>
  </div>
</div>

<script src="../js/jquery-1.11.0.min.js"></script>
</body>
</html>
