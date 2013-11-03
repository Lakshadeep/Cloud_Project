package com.app2;

import java.io.IOException;

import javax.servlet.http.*;

import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.google.appengine.api.utils.SystemProperty;
//import com.google.appengine.repackaged.com.google.storage.onestore.v3.proto2api.OnestoreEntity.User;
import com.google.cloud.sql.jdbc.Connection;
import com.google.cloud.sql.jdbc.PreparedStatement;


public class New_pro_submission extends HttpServlet {
@Override
public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	
	UserService userService = UserServiceFactory.getUserService();
	com.google.appengine.api.users.User user = userService.getCurrentUser();	
	
String url = null;
try {
if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production) {
// Load the class that provides the new "jdbc:google:mysql://"prefix.
Class.forName("com.mysql.jdbc.GoogleDriver");
url = "jdbc:google:mysql://bold-column-369:data-store/cloud?user=root";
} else {
// Local MySQL instance to use during development.
Class.forName("com.mysql.jdbc.Driver");
url = "jdbc:mysql://127.0.0.1:3306/cloud?user=root";
}
} catch (Exception e) {
e.printStackTrace();
return;
}
PrintWriter out = resp.getWriter();
try {  
	    java.sql.Connection conn = DriverManager.getConnection(url,"root","");
		try {
				String name = req.getParameter("name");
				String domain = req.getParameter("domain");
				String description = req.getParameter("description");
				String leader = user.getNickname();
				String sdate = req.getParameter("sdate");
				String edate = req.getParameter("edate");
				
				if (name == "" ) {
					out.println("<html><head></head><body>You are missing either a message or name! Try again! " +
"Redirecting in 3 seconds...</body></html>");
				} else {
					String statement = "INSERT INTO Projects(Name,Domain,Description,Leader,Start_date,End_date)VALUES( ?,?,?,?,?,? )";
					java.sql.PreparedStatement stmt = conn.prepareStatement(statement);
					stmt.setString(1, name);
					stmt.setString(2, domain);
					stmt.setString(3, description);
					stmt.setString(4, leader);
					stmt.setString(5, sdate);
					stmt.setString(6, edate);
					int success = 2;
					success = stmt.executeUpdate();
					if (success == 1) {
						out.println("<html><head></head><body>Success! Redirecting in 3 seconds...</body></html>");
					} else if (success == 0) {out.println("<html><head></head><body>Failure! Please try again! " +
"Redirecting in 3 seconds...</body></html>");
					}
				}
		} finally {
			conn.close();	
		}
} catch (SQLException e) {
e.printStackTrace();
}
resp.setHeader("Refresh", "3; url=/new_pro.jsp");
}
}