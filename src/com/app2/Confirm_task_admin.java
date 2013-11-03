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


public class Confirm_task_admin extends HttpServlet {
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
				String cf = req.getParameter("c");
				String task_id = req.getParameter("task_id");
				Integer x = Integer.valueOf(task_id);
				
				
				
				
				
					String statement = "Update Tasks set Admin_status = "+cf+" where Task_id="+x+";";
					java.sql.PreparedStatement stmt = conn.prepareStatement(statement);
					
					
				    int success = 2;
					success = stmt.executeUpdate();
					if (success == 1) {
						out.println("<html><head></head><body>Success! Redirecting in 3 seconds...</body></html>");
					} else if (success == 0) {out.println("<html><head></head><body>Failure! Please try again! " +"Redirecting in 3 seconds...</body></html>");
					
					}
				
		} finally {
			conn.close();	
		}
} catch (SQLException e) {
e.printStackTrace();
}
resp.setHeader("Refresh", "3; url=/home.jsp");
}
}

