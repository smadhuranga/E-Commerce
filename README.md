# E-Commerce Website

A full-featured e-commerce website built with JSP, HTML, CSS, Bootstrap, and MySQL.

## Features

- User Authentication & Authorization
- Product Management (CRUD Operations)
- Shopping Cart Functionality
- Product Categories
- Responsive Design using Bootstrap
- Database Integration with MySQL

## Technologies Used

- **Frontend:**
  - HTML5
  - CSS3
  - Bootstrap
  - JavaScript

- **Backend:**
  - Java Server Pages (JSP)
  - Java Servlets
  - JDBC for database connectivity

- **Database:**
  - MySQL

## Prerequisites

- JDK 8 or higher
- Apache Tomcat Server
- MySQL Server
- Any Java IDE (Eclipse, NetBeans, etc.)

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/smadhuranga/E-Commerce.git
   ```

2. Import the project into your preferred IDE

3. Configure MySQL Database:
   - Create a new database
   - Import the provided SQL file
   - Update database configuration in the project

4. Deploy the application on Tomcat Server

5. Access the application through your web browser:
   ```
   http://localhost:8080/E-Commerce
   ```

## Database Schema

The project uses MySQL database with the following main tables:
- Users
- Products
- Categories
- Cart
- Orders

## Project Structure

```
E-Commerce/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── (Java source files)
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       ├── css/
│   │       ├── js/
│   │       └── (JSP files)
└── README.md
```

## Contributing

Feel free to fork this repository and submit pull requests.

## Author

- [Madhuranga](https://github.com/smadhuranga)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
