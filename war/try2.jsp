<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<body>
<%
UserService userService = UserServiceFactory.getUserService();
User user = userService.getCurrentUser();
%>
<form action="/sign" method="post">
<div><textarea name="content" rows="3" cols="60"></textarea></div>
<div><input type="submit" value="Post Greeting" /></div>
</form>
<%
out.print(session.getAttribute("test1"));

out.print(request.getParameter("name"));



%>


<p>Hello </p>

</body>
</html>