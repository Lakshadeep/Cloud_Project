package com.app2;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.google.appengine.api.utils.SystemProperty;


public class Comment_submission extends HttpServlet {
@Override
public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	
	UserService userService = UserServiceFactory.getUserService();
	com.google.appengine.api.users.User user = userService.getCurrentUser();	
	
String url = null;
Integer x = 0,y=0;
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
				String comment = req.getParameter("comment");
				
				//String description = req.getParameter("description");
				String user_id = user.getNickname();
				
				
				String project_name = req.getParameter("post_id");
				 x = Integer.valueOf(project_name);
				 
				 String project_name2 = req.getParameter("pro_name");
				 y = Integer.valueOf(project_name2);
				 
				
				if (comment == "" ) {
					out.println("<html><head></head><body>You are missing some input! Try again! " +
"Redirecting in 3 seconds...</body></html>");
				} else {
					String statement = "INSERT INTO Comments(Comment,User_id,CTime,Post_id)VALUES('"+comment+"','"+user_id+"',now(),"+x+")";
					java.sql.PreparedStatement stmt = conn.prepareStatement(statement);
				
					//stmt.setString(1,comment);
					//stmt.setString(2,user_id);
					//stmt.setInt(4,x);
					

				
					    int success = 2;
					success = stmt.executeUpdate();
					if (success == 1) {
						out.println("<html><head></head><body>Success! Redirecting in 3 seconds...</body></html>");
					} else if (success == 0) {out.println("<html><head></head><body>Failure! Please try again! " +"Redirecting in 3 seconds...</body></html>");
					
					}
				}
		} finally {
			conn.close();	
		}
} catch (SQLException e) {
e.printStackTrace();
}
resp.setHeader("Refresh", "2; url=/admin_console.jsp?name="+y);
}
}
