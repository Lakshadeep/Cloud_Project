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
<title>Project Console</title>
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
</head><body class="column2">
<div id="header-wrapper">
	<header id="header">
		<div class="5grid-layout">
			<div class="row">
				<div class="12u" id="logo"> <!-- Logo -->
					<h1><a href="#" class="mobileUI-site-name">Project Management Tool</a></h1>
					<p></p>
				</div>
			</div>
            
         <%

			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			String s = user.getNickname();
			session.setAttribute("pro_name",request.getParameter("name"));
	
		  %>	
   
		</div>
		<div id="menu-wrapper">
			<div class="5grid-layout">
				<div class="row">
					<div class="12u" id="menu">
						<nav class="mobileUI-site-nav">
							<ul>
								<li ><a href="">Home</a></li>
                                <li><a href="">Profile</a></li>
								<li><a href="admin_pros.jsp">Admin</a></li>
								<li><a href="member_pro.jsp">Team</a></li>
								<li><a href="">Mentor</a></li>
                                <li ><a href="new_pro.jsp">New Project</a></li>
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
								<div class="4u">
									<section id="sidebar">
										
										<p class="subtitle"><% out.print("Logged in as "+user.getNickname()); %></p>
										<ul class="style1">
											<li class="first">
												
												<p><a href="task.jsp">Tasks</a></p>
											</li>
											<li>
												
												<p><a href="members_task.jsp">Create New Task</a></p>
											</li>
											<li>
												
												<p><a href="new_member.jsp">Invite Members</a></p>
											</li>
											<li>
												
												<p><a href="#">Message Members</a></p>
											</li>
											<li>
												
												<p><a href="#">Remove Members</a></p>
											</li>
										</ul>
									</section>
								</div>
								<div class="8u mobileUI-main-content">
									<section id="content">
									<p class="subtitle">Invite Member </p>
   <form action="/New_mem_invite?pro_name=<% out.print(session.getAttribute("pro_name")); %>" method="post">
  <table width="100%" border="0" cellspacing="4" cellpadding="5" bgcolor="#FFFFFF" cellspacing="3">
  <tr>
    <td>Email_id:</td>
    <td><input type="text" name="email_id"  size="25">@gmail.com</td>
  </tr>
  <tr>
    <td>Role</td>
    <td><input type="text" name="role" size="45"></td>
  </tr>
  <tr>
    <td>Job Description</td>
    <td><textarea name="description" rows="4" cols="40"></textarea></td>
  </tr>
  
  <tr>
    
    <td><input type="submit" value="Send"  class="button-style"/></td>
    
  </tr>
</table>
</form>	
                                        
										
									
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
