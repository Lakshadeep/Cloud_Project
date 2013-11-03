<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.net.URL" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<body>
<%
UserService userService = UserServiceFactory.getUserService();
User user = userService.getCurrentUser();
if (user != null) {
pageContext.setAttribute("user", user);

session.setAttribute("test1","successful");
%>

<p><a href="try2.jsp?name=lakshadeep">Try 2</a></p>
<p>Hello,  (You can
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign
out</a>.)</p>
<%
} else {
%>
<p>Hello!
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign
in</a>
to include your name with greetings you post.</p>
<%
}

%>
</body>
</html>