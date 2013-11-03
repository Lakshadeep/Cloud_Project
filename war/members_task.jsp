<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>


<%@ page import="java.sql.*"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Project Members</title>

<style type="text/css"> 
<!-- 
body  {
	font: 100% Verdana, Arial, Helvetica, sans-serif;
	background: #666666;
	margin: 0; 
	padding: 0;
	text-align: center;
	color: #000000;
}


.twoColElsLtHdr #container { 
	width: auto;  
	background: #FFFFFF;
	margin: 0 auto;
	border: 1px solid #000000;
	text-align: left; 
} 
.twoColElsLtHdr #header { 
	background: #000; 
	padding: 0 10px;  
	color:#FFF;    
} 
.twoColElsLtHdr #header h1 {
	margin: 0; 
	padding: 10px 0;
}

/* Tips for sidebar1:
1. Be aware that if you set a font-size value on this div, the overall width of the div will be adjusted accordingly.
2. Since we are working in ems, it's best not to use padding on the sidebar itself. It will be added to the width for standards compliant browsers creating an unknown actual width. 
3. Space between the side of the div and the elements within it can be created by placing a left and right margin on those elements as seen in the ".twoColElsLtHdr #sidebar1 p" rule.
*/
.twoColElsLtHdr #sidebar1 {
	float: left; 
	width: 12em; /* since this element is floated, a width must be given */
	background: #EBEBEB; /* the background color will be displayed for the length of the content in the column, but no further */
	padding: 15px 0; /* top and bottom padding create visual space within this div */
}
.twoColElsLtHdr #sidebar1 h3, .twoColElsLtHdr #sidebar1 p {
	margin-left: 10px; /* the left and right margin should be given to every element that will be placed in the side columns */
	margin-right: 10px;
}


.twoColElsLtHdr #mainContent {
	margin: 0 1.5em 0 13em; 
	height:100%;
	min-height:34em
} 
.twoColElsLtHdr #footer { 
	padding: 0 10px; 
	background:#000;
	color:#FFF
} 
.twoColElsLtHdr #footer p {
	margin: 0; 
	padding: 10px 0; 
	
}


.fltrt {
	float: right;
	margin-left: 8px;
}
.fltlft { 
	float: left;
	margin-right: 8px;
}
.clearfloat { 
	clear:both;
    height:0;
    font-size: 1px;
    line-height: 0px;
}
--> 
</style></head>

 <%

	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	String s = user.getNickname();
%>	

<body class="twoColElsLtHdr">

<div id="container">
  <div id="header">
    <h1>Project Management Tool</h1>
 </div>
  <div id="sidebar1">
    <h5 align="center"><% out.print("Logged in as "+s); %></h3>
   <table width="100%" border="0" cellspacing="4" align="left">
  <tr bgcolor="#CCCCCC">
    <td align="left">&nbsp;<a href="home.jsp">Home</a></td>
  </tr>
  <tr>
    <td bgcolor="#CCCCCC" align="left">&nbsp;Admin Projects</td>
  </tr>
  <tr>
    <td bgcolor="#CCCCCC" align="left">&nbsp;Team Projects</td>
  </tr>
  <tr>
    <td bgcolor="#CCCCCC" align="left">&nbsp;Mentored Projects</td>
  </tr>
  <tr>
    <td bgcolor="#CCCCCC" align="left">&nbsp;<a href="new_pro.jsp">Create New Project</a></td>
  </tr>
  <tr>
    <td bgcolor="#CCCCCC" align="left">&nbsp;<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign
out</a></td>
  </tr>
</table>

  <!-- end #sidebar1 --></div>
  <div id="mainContent">
    <h1>Team Members</h1>
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
	s = user.getNickname();

	Connection conn = DriverManager.getConnection(url,"root","");
	
	ResultSet rs = conn.createStatement().executeQuery("SELECT *  FROM Project_teams where Project_id = '"+ session.getAttribute("pro_name") +"';");
	if(!rs.next()){
		%>
		<table width="80%" border="0"cellspacing="4" cellpadding="3px" >
  		<tr>
    	<td bgcolor="#CCCCFF">Currently there are no members working on this project.</td>
    	</tr>
   
		</table>
		<% 
	}else{
		rs.beforeFirst();
		while(rs.next()){
		
		String name = rs.getString("User_id");
		session.setAttribute("user_id",request.getParameter("name"));
		
		
	
	

%>
    <form action="new_task.jsp?pname=<%out.print(rs.getString("Project_id"));%>&uname=<%out.print(rs.getString("User_id")); %>" method="post">
    <table width="80%" border="0"cellspacing="4" cellpadding="3px" >
  <tr>
    <td bgcolor="#CCCCFF" width="80%">&nbsp;<% out.print(name); %></td>
    <td bgcolor="#CCCCFF" width="20%"><input type="submit" value="Admin Console" /></td>

    </tr>
    <tr><td bgcolor="#CCCCCC" colspan="2">&nbsp;<%  %></td>
    	  
  </tr>
</table>
</form>
</br>
<%
	}
	}
	
%>


	<!-- end #mainContent --></div>
	
   <div id="footer">
    <p align="center">Copyright notice</p>
  <!-- end #footer --></div>
<!-- end #container --></div>
</body>
</html>
