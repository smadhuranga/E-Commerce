<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>E-Commerce Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-color: #3498db;
      --secondary-color: #2ecc71;
      --background-dark: #2c3e50;
      --background-light: #5675a8;
      --text-color: #34495e;
    }

    * {
      transition: all 0.3s ease;
    }

    body {
      background: linear-gradient(135deg, var(--background-dark) 0%, #34495e 100%);
      font-family: 'Inter', sans-serif;
      color: var(--text-color);
    }

    .dashboard-container {
      background: white;
      border-radius: 20px;
      box-shadow:
              0 20px 50px rgba(0,0,0,0.1),
              0 10px 20px rgba(0,0,0,0.05);
      padding: 40px;
      margin: 50px auto;
      max-width: 900px;
      position: relative;
      overflow: hidden;
    }

    /*.dashboard-container::before {*/
    /*  content: '';*/
    /*  position: absolute;*/
    /*  top: -50%;*/
    /*  left: -50%;*/
    /*  width: 200%;*/
    /*  height: 200%;*/
    /*  background: linear-gradient(*/
    /*          45deg,*/
    /*          transparent,*/
    /*          rgba(52,152,219,0.1),*/
    /*          transparent*/
    /*  );*/
    /*  transform: rotate(-45deg);*/
    /*}*/

    .dashboard-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
      padding-bottom: 20px;
      border-bottom: 2px solid rgba(52,152,219,0.1);
    }

    .dashboard-buttons {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 25px;
    }

    .dashboard-btn {
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 25px;
      border-radius: 20px;
      font-size: 18px;
      font-weight: 600;
      position: relative;
      overflow: hidden;
      text-decoration: none;
      color: white;
      transform: perspective(1px) translateZ(0);
    }

    .dashboard-btn::before {
      content: '';
      position: absolute;
      z-index: -1;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(135deg, rgba(255,255,255,0.1), transparent);
      transform: scaleX(0);
      transform-origin: 0 50%;
      transition: transform 0.3s ease-out;
    }

    .dashboard-btn:hover::before {
      transform: scaleX(1);
    }

    .dashboard-btn:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.15);
    }

    .btn-icon {
      margin-right: 15px;
      opacity: 0.8;
    }

    .category-btn {
      background: linear-gradient(135deg, #3498db, #2980b9);
    }

    .add-item-btn {
      background: linear-gradient(135deg, #2ecc71, #27ae60);
    }

    .user-profile {
      display: flex;
      align-items: center;
    }

    .user-avatar {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      margin-right: 15px;
      border: 3px solid var(--primary-color);
    }

    @media (max-width: 768px) {
      .dashboard-buttons {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="dashboard-container">
    <div class="dashboard-header">
      <div class="user-profile">
        <img src="/api/placeholder/50/50" alt="User Avatar" class="user-avatar">
        <div>
          <h4 class="mb-0">John Doe</h4>
          <small class="text-muted">Admin</small>
        </div>
      </div>
      <div>
        <a href="../index.jsp">
      <button class="btn btn-outline-primary" >Logout</button></a>
      </div>
    </div>

    <div class="dashboard-buttons">
      <a href="/E_Commerce_supun_war_exploded/addCategories" class="dashboard-btn category-btn">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="btn-icon">
          <path d="M22 19a2 2 0 0 1-2 2h-16a2 2 0 0 1-2-2v-14a2 2 0 0 1 2-2h6l2 3h8a2 2 0 0 1 2 2z"></path>
        </svg>
        Manage Categories
      </a>

      <a href="/E_Commerce_supun_war_exploded/addProduct" class="dashboard-btn add-item-btn">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="btn-icon">
          <circle cx="12" cy="12" r="10"></circle>
          <line x1="12" y1="8" x2="12" y2="16"></line>
          <line x1="8" y1="12" x2="16" y2="12"></line>
        </svg>
        Manage Item
      </a>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>