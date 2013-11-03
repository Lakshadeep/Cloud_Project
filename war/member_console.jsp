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

<%

	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	String s = user.getNickname();
	session.setAttribute("pro_name",request.getParameter("name"));
	
%>	



<title>Team Console</title>

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

<body class="twoColElsLtHdr">

<div id="container">
  <div id="header">
    <h1>Project Management Tool</h1>
 </div>
  <div id="sidebar1">
   <h5 align="center"><% out.print("Logged in as "+ user.getNickname()); %></h3>
   <table width="100%" border="0" cellspacing="4" align="left">
  <tr>
    <td bgcolor="#CCCCCC" align="left">&nbsp;Admin Projects</td>
  </tr>
  <tr>
    <td bgcolor="#CCCCCC" align="left">&nbsp;<a href="task.jsp">Tasks</a></td>
  </tr>
  <tr>
    <td bgcolor="#CCCCCC" align="left">&nbsp;<a href="new_member.jsp">Invite Members</a></td>
  </tr>
  <tr>
    <td bgcolor="#CCCCCC" align="left">&nbsp;<a href="members_task.jsp">Create New Task</a></td>
  </tr>
  <tr>
    <td bgcolor="#CCCCCC" align="left">&nbsp;Message Members</td>
  </tr>
   <tr>
    <td bgcolor="#CCCCCC" align="left">&nbsp;Remove Members</td>
  </tr>
</table>
     <!-- end #sidebar1 --></div>
    <div id="mainContent">
    <h1><% out.print(request.getParameter("name")); %></h1>
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
	//String pid = session.getAttribute("pro_name");
	//Integer y = (Integer)session.getAttribute("pro_name");
	int y = Integer.valueOf((String) session.getAttribute("pro_name"));

	Connection conn = DriverManager.getConnection(url,"root","");
	%>
	 <form action="/Post_submission?pro_name=<% out.print(session.getAttribute("pro_name")); %>" method="post">
   <table width="80%" border="0" cellspacing="4" cellpadding="5" bgcolor="#CCCCCC" cellspacing="3">
  <tr>
    <td>Title</td>
    <td><input type="text" name="title" ></td>
  </tr>
  <tr>
    <td>Description</td>
    <td><textarea name="description" rows="4" cols="40"></textarea></td>
  </tr>
  
  <tr>
    
    <td><input type="submit" value="Post" /></td>
    
  </tr>
</table>
</form>
	
	
	
	
	<%
	ResultSet rs = conn.createStatement().executeQuery("SELECT *  FROM Posts where Project_id = "+ y+ ";");
	if(!rs.next()){

		%>
		<table width="100%" border="0" cellspacing="4" cellpadding="3px">
		  <tr bgcolor="#CCCCFF" height="auto">
		    <td>Currently you there are no posts to show</td>
		    </tr>
		 
		</table>
	<% 
	
	}else{
		rs.beforeFirst();
		while(rs.next()){
		
		Integer name1 = rs.getInt("Project_id");
		String description = rs.getString("Description");
		//String deadline = rs.getString("Deadline");
		String title = rs.getString("Heading");
		String userp = rs.getString("User_id");
		
		//ResultSet rs3 = conn.createStatement().executeQuery("SELECT *  FROM Projects where Id = '"+ name1 +"';");
		//String pname = rs2.getString("Name");
		//String pname;
		//while(rs3.next()){
			// pname = rs3.getString("Name");
		
		
		
		
	%>		

 
  
    <table width="80%" border="0" cellspacing="4" cellpadding="5" bgcolor="#CCCCCC">
  <tr>
    <td>&nbsp;<% out.print(title + rs.getInt("Post_id")); %></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;<% out.print("Posted by "+userp); %></td>
    <td>&nbsp;<% out.print(rs.getTimestamp("Time")); %></td>
  </tr>
   <tr>
    <td colspan="2">&nbsp;<% out.print(description); %></td>
    
  </tr>
</table>


	<%
	ResultSet rs5 = conn.createStatement().executeQuery("SELECT *  FROM Comments where Post_id ="+ rs.getInt("Post_id")+ ";");
	if(!rs5.next()){

		%>
		<table width="100%" border="0" cellspacing="4" cellpadding="3px">
		  <tr bgcolor="#CCCCFF" height="auto">
		    <td>Currently there are no comments on this post</td>
		    </tr>
		 
		</table>
		 <form action="/Comment_submission?post_id=<% out.print(rs.getInt("Post_id")); %>&pro_name=<% out.print(session.getAttribute("pro_name")); %>" method="post">
    	<table width="80%" border="0" cellspacing="4" cellpadding="5">
  		<tr>
    	
  		</tr>
  <tr>
    <td>&nbsp;<textarea name="comment" rows="2" cols="40"></textarea></td>
    <td>&nbsp;<input type="submit" value="Comment" />></td>
  </tr>
</table>
</form>
	<% 
	
	}else{
		rs5.beforeFirst();
		while(rs5.next()){
		
		//Integer name1 = rs.getInt("Project_id");
		String comment = rs5.getString("Comment");
		//String deadline = rs.getString("Deadline");
		//String title = rs.getString("Heading");
		String userc = rs5.getString("User_id");
		
		//ResultSet rs3 = conn.createStatement().executeQuery("SELECT *  FROM Projects where Id = '"+ name1 +"';");
		//String pname = rs2.getString("Name");
		//String pname;
		//while(rs3.next()){
			// pname = rs3.getString("Name");
		
		
		
		
	%>		


   
    <form action="/Comment_submission?post_id=<% out.print(rs.getInt("Post_id")); %>&pro_name=<% out.print(session.getAttribute("pro_name")); %>" method="post">
    <table width="80%" border="0" cellspacing="4" cellpadding="5">
  <tr>
    <td width="50%">&nbsp;<% out.print(comment); %></td>
    <td width="50%">&nbsp;<% out.print(userc); %></td>
  </tr>
  <%
		}
  %>
  <tr>
    <td>&nbsp;<textarea name="comment" rows="2" cols="40"></textarea></td>
    <td>&nbsp;<input type="submit" value="Comment" />></td>
  </tr>
</table>
</form>

<%
		//}
		//}
		}
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
