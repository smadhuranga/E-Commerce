<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Organic - Grocery Store | Sign In</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="format-detection" content="telephone=no">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="author" content="">
  <meta name="keywords" content="">
  <meta name="description" content="">
  <link rel="stylesheet" type="text/css" href="css/loging.css">
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
        <p>Discover amazing products at amazing prices</p>
      </div>
    </div>
    <div class="signin-right">
      <form class="signin-form" action="/E_Commerce_supun_war_exploded/signup" method="post">
        <input type="hidden" name="action" value="signin">
        <h2>Welcome Back!</h2>
        <p class="subtitle">Please sign in to your account</p>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
        <div class="error-message" style="color: red; margin-bottom: 15px;"><%= error %></div>
        <% } %>

        <div class="form-group">
          <label for="email">Email Address</label>
          <input type="email" id="email" name="email" placeholder="your@email.com" required />
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" placeholder="Enter your password" required />
        </div>

        <div class="form-options">
          <label class="remember-me">
            <input type="checkbox" name="rememberMe" />
            <span>Remember me</span>
          </label>
          <a href="#" class="forgot-password">Forgot Password?</a>
        </div>

        <button type="submit" class="signin-button">Sign In</button>

        <p class="signup-link">
          Don't have an account? <a href="pages/signup.jsp">Sign up now</a>
        </p>
      </form>
    </div>
  </div>
</div>

<script src="../js/jquery-1.11.0.min.js"></script>
<script src="../js/login.js"></script>
</body>
</html>
