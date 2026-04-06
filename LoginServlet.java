package com.mailapp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM Users WHERE email = ? AND password = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("userEmail", rs.getString("email"));
                session.setAttribute("userName", rs.getString("full_name"));
                response.sendRedirect("InboxServlet");
            } else {
                response.sendRedirect("login.jsp?error=1");
            }
         } catch (Exception e) {
            e.printStackTrace();
            // This forces Tomcat to print the error on your blank screen!
            response.setContentType("text/html");
            response.getWriter().println("<div style='font-family: sans-serif; padding: 20px;'>");
            response.getWriter().println("<h2 style='color: #d9534f;'>🚨 LoginServlet Crashed!</h2>");
            response.getWriter().println("<p><strong>The exact error is:</strong></p>");
            response.getWriter().println("<pre style='background: #f4f4f4; padding: 15px; border-radius: 5px;'>" + e.toString() + "</pre>");
            if (e.getCause() != null) {
                response.getWriter().println("<p><strong>Caused by:</strong> " + e.getCause().toString() + "</p>");
            }
            response.getWriter().println("</div>");
        }
    }
}