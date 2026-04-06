package com.mailapp;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ViewMessageServlet")
public class ViewMessageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        String messageId = request.getParameter("id");

        if (messageId == null || messageId.trim().isEmpty()) {
            response.sendRedirect("InboxServlet");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {
            // SECURITY: Notice we check BOTH message_id AND receiver_email. 
            // This prevents User A from guessing User B's message ID in the URL.
            String query = "SELECT * FROM Messages WHERE message_id = ? AND receiver_email = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, messageId);
            pst.setString(2, userEmail);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                Map<String, String> msgDetails = new HashMap<>();
                msgDetails.put("id", rs.getString("message_id"));
                msgDetails.put("sender", rs.getString("sender_email"));
                msgDetails.put("subject", rs.getString("subject"));
                msgDetails.put("body", rs.getString("body"));
                msgDetails.put("timestamp", rs.getString("timestamp"));
                
                // Optional bonus: Update the database to mark it as "read"
                PreparedStatement updateRead = con.prepareStatement("UPDATE Messages SET is_read = TRUE WHERE message_id = ?");
                updateRead.setString(1, messageId);
                updateRead.executeUpdate();

                request.setAttribute("messageDetails", msgDetails);
                request.getRequestDispatcher("view.jsp").forward(request, response);
            } else {
                // If message isn't found or doesn't belong to them, kick them to inbox
                response.sendRedirect("InboxServlet?error=notfound");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("InboxServlet");
        }
    }
}