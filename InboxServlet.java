package com.mailapp;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/InboxServlet")
public class InboxServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        List<Map<String, String>> messages = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            String query = "SELECT * FROM Messages WHERE receiver_email = ? ORDER BY timestamp DESC";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, userEmail);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Map<String, String> msg = new HashMap<>();
                msg.put("id", rs.getString("message_id"));
                msg.put("sender", rs.getString("sender_email"));
                
                // Combining subject and body so the user can read the actual message in the table!
                String fullMessage = rs.getString("subject") + " — <span style='font-weight:normal; color:#64748b;'>" + rs.getString("body") + "</span>";
                msg.put("subject", fullMessage);
                
                msg.put("timestamp", rs.getString("timestamp")); // Fixed key to match JSP
                messages.add(msg);
            }
            
            // Sending the data under the name "messages"
            request.setAttribute("messages", messages);
            request.getRequestDispatcher("inbox.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}