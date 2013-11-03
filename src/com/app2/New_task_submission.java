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


public class New_task_submission extends HttpServlet {
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
				String task = req.getParameter("task");
				String points = req.getParameter("points");
				Integer y = Integer.valueOf(points);
				String description = req.getParameter("description");
				String ddate = req.getParameter("ddate");
				
				String project_name = req.getParameter("pro_name");
				String user_name = req.getParameter("uname");
				Integer x = Integer.valueOf(project_name);
				
				if (task == "" || points == "" || description == "" || ddate == "") {
					out.println("<html><head></head><body>You are missing some input! Try again! " +
"Redirecting in 3 seconds...</body></html>");
				} else {
					String statement = "INSERT INTO Tasks(Project_id,User_id,Title,Description,Deadline,Weightage)VALUES( ?,?,?,?,STR_TO_DATE(?,'%Y/%m/%d'),? )";
					java.sql.PreparedStatement stmt = conn.prepareStatement(statement);
					stmt.setInt(1,x);
					stmt.setString(2,user_name);
					stmt.setString(3,task);
					stmt.setString(4,description);
					stmt.setString(5,ddate);
					stmt.setInt(6,y);
					
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
resp.setHeader("Refresh", "3; url=/members_task.jsp");
}
}

