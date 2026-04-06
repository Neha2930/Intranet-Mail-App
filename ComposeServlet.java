package com.mailapp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ComposeServlet")
public class ComposeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String senderEmail = (String) session.getAttribute("userEmail");

        if (senderEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String receiverEmail = request.getParameter("receiver").trim();
        String subject = request.getParameter("subject");
        String body = request.getParameter("body");

        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO Messages (sender_email, receiver_email, subject, body) VALUES (?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, senderEmail);
            pst.setString(2, receiverEmail);
            pst.setString(3, subject);
            pst.setString(4, body);
            
            int result = pst.executeUpdate();
            if (result > 0) {
                response.sendRedirect("compose.jsp?msg=sent");
            } else {
                response.sendRedirect("compose.jsp?error=failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}