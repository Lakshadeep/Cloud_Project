<%@page import="sun.security.krb5.internal.crypto.Des"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>


<%@ page import="java.sql.*"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE HTML>
<!--
	Aqueous: A responsive HTML5 website template by HTML5Templates.com
	Released for free under the Creative Commons Attribution 3.0 license (html5templates.com/license)
	Visit http://html5templates.com for more great templates or follow us on Twitter @HTML5T
-->
<html>
<head>
<title>Home</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<noscript>
<link rel="stylesheet" href="css/5grid/core.css" />
<link rel="stylesheet" href="css/5grid/core-desktop.css" />
<link rel="stylesheet" href="css/5grid/core-1200px.css" />
<link rel="stylesheet" href="css/5grid/core-noscript.css" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/style-desktop.css" />
</noscript>
<script src="css/5grid/jquery.js"></script>
<script src="css/5grid/init.js?use=mobile,desktop,1000px&amp;mobileUI=1&amp;mobileUI.theme=none"></script>
<!--[if IE 9]><link rel="stylesheet" href="css/style-ie9.css" /><![endif]-->
</head><body class="column1">
<div id="header-wrapper">
	<header id="header">
		<div class="5grid-layout">
			<div class="row">
				<div class="12u" id="logo"> <!-- Logo -->
					<h1><a href="#" class="mobileUI-site-name">Project Management Tool</a></h1>
					<p></p>
				</div>
			</div>
		</div>
        
        
        <%

			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();

		%>
        <%
			  if (user != null) {
	  		  pageContext.setAttribute("user", user);
	  		  String s = user.getNickname();
	  
  		%>
        <%
		String url = null;
		if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production) {
  		// Load the class that provides the new "jdbc:google:mysql://" prefix.
  		Class.forName("com.mysql.jdbc.GoogleDriver");
  		url = "jdbc:google:mysql://bold-column-369:data-store/cloud?user=root";
		} else {
  		// Local MySQL instance to use during development.
 		 Class.forName("com.mysql.jdbc.Driver");
  		 url = "jdbc:mysql://127.0.0.1:3306/cloud?user=root";
  		out.print("success");
		}

		Connection conn = DriverManager.getConnection(url,"root","");
        %>
        
        
        
		<div id="menu-wrapper">
			<div class="5grid-layout">
				<div class="row">
					<div class="12u" id="menu">
						<nav class="mobileUI-site-nav">
							<ul>
								<li class="current_page_item"><a href="">Home</a></li>
                                <li><a href="">Profile</a></li>
								<li ><a href="admin_pros.jsp">Admin</a></li>
								<li><a href="member_pro.jsp">Team</a></li>
								<li><a href="">Mentor</a></li>
                                <li><a href="new_pro.jsp">New Project</a></li>
                                <li><a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign Out</a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</header>
</div>
<div id="page-wrapper">
	<div id="page-bgtop">
		<div id="page-bgbtm">
			<div id="page" class="5grid-layout">
				<div id="page-content-wrapper">
					<div class="row">
						<div class="12u">
							<div class="row">
								<div class="8u">
									<section id="content">
      <%
		ResultSet rs = conn.createStatement().executeQuery("SELECT *  FROM Users where User_id='"+user.getNickname()+"';");
		if(!rs.next()){
	
			String statement = "INSERT INTO  Users(User_id) VALUES( ? )";
			String s1 = user.getNickname(); 
			PreparedStatement stmt = conn.prepareStatement(statement);
			stmt.setString(1,s1);
			int success = 2;
			success = stmt.executeUpdate();
			if (success == 1) {
			out.println("Success!...");
			}
			

			%>                              
                                    
										<h2>Welcome to Project Management Tool</h2>
										<p class="subtitle">Create new Project to get started</p>
								        <p></p>
										<br /><br />
										<p></p>
             <%
             }
				else{
  			 %>                           
                                        <h2>Invitations</h2>
              <%                          
                String p = user.getNickname();
	
				ResultSet rs1 = conn.createStatement().executeQuery("SELECT *  FROM Project_teams where User_id = '"+ p +"' and Status=0;");
				if(!rs1.next()){
				%>                   
                       <p class="subtitle">Currently you dont have any Invitations</p>   
               <% 
	
					}else{
						rs1.beforeFirst();
						while(rs1.next()){
		
						Integer name = rs1.getInt("Project_id");
						String description = rs1.getString("Desription");
						String role = rs1.getString("Role");
						String leader = rs1.getString("Leader");
		
						ResultSet rs4 = conn.createStatement().executeQuery("SELECT *  FROM Projects where Id = '"+ name +"';");
						//String pname = rs2.getString("Name");
						String pname;
						while(rs4.next()){
			 			pname = rs4.getString("Name");
		
		
		
		
		
		%>	                        </br>
									</br>
                                    <p class="subtitle"><% out.print(pname + " invited by "+ leader); %></p>
										<p><% out.print("Your role "+ role); %></p>
								        <p><% out.print("Description -"+description); %></p>
										
										<p><form action="/Confirm_member?pname=<% out.print(name);%>&uname=<%out.print(user.getNickname()); %>&c=1" method="post"></p>                      
										<table width="60%" border="0" cellspacing="4" cellpadding="5">
  										<tr>
    									<td> <input type="submit" value="Accept Invitation" class="button-style" /></td>
                                         </form>
                                        <form action="/Confirm_member?pname=<% out.print(name);%>&uname=<%out.print(user.getNickname()); %>&c=2" 	method="post">
    									
   									    
   										 <td> <input type="submit" value="Reject Invitation" class="button-style"/></td>
                                         </form>
  										</tr>
										</table>
										</form>
										</br>

                                        <%  }
											}
											}

										%>
									</section>
							  </div>
                               <div class="4u">
										<section id="sidebar">
										<h2>Upcoming Tasks</h2>
                                        <p class="subtitle"><% out.print("Logged in as "+s); %></p>
										<ul class="style1">
								
                  <% 
	
						String q = user.getNickname();
	
						ResultSet rs2 = conn.createStatement().executeQuery("SELECT *  FROM Tasks where User_id = '"+ q +"';");
						if(!rs2.next()){
				  %>
										
											<li class="first">
												<p class="date"><a href="#">MM/YY<b>DD</b></a></p>
												<p><a href="#">Currently you dont have any Invitations</a></p>
											</li>
											
										
                       <% 
	
						}else{
							rs2.beforeFirst();
							while(rs2.next()){
		
							Integer name1 = rs2.getInt("Project_id");
							String description = rs2.getString("Description");
							String deadline = rs2.getString("Deadline");
							String title = rs2.getString("Title");
		
							ResultSet rs3 = conn.createStatement().executeQuery("SELECT *  FROM Projects where Id = '"+ name1 +"';");
							//String pname = rs2.getString("Name");
							String pname;
							while(rs3.next()){
			 				pname = rs3.getString("Name");
		
		
		
		
	%>	                    
											<li class="first">
												<p class="date"> <a href="#"><% out.print(deadline.substring(5,7)+"/"+deadline.substring(0,4)); %><b><% out.print(deadline.substring(8,10)); %></b></a></p>
												<p><a href="#"><% out.print(pname + " - "+ title ); %></a></p>
                                                <p><a href="#"><% out.print(description); %></a></p>
                                                <p><form action="/Confirm_task_user?pname=<% out.print(name1);%>&uname=<%out.print(user.getNickname()); %>&c=1&task_id=<% out.print(rs2.getInt("Task_id")); %>" method="post">
     											<input type="submit" value="Submit for Admins approval" class="button-style1"/>
     											</form></p>
											</li>
											</br>
											
                                        <%
											}
										}
									}
								}

										 %>    
                                            
											
										</ul>
									</section>
								</div>
                                
                                
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="12u"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="copyright" class="5grid-layout">
	<section>
		<p>&copy; Your Site Name | Images: <a href="http://fotogrph.com/">Fotogrph</a> | Design: <a href="http://html5templates.com/">HTML5Templates.com</a></p>
	</section>
</div>
</body>
</html>

<%
} 
else {
    response.sendRedirect(userService.createLoginURL(request.getRequestURI()));
    
}

%>
