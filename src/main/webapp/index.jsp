<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <head>
        <%
            String path = request.getContextPath();
            String basepath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
        %>
        <base href="<%=basepath%>"/>
        <title>Insert title here</title>
        <script type="text/javascript" src="js/jquery-1.8.0.min.js"></script>
        <script>
            $(function (){
                window.location.href="admin/login.jsp";
            })
        </script>
    </head>
<body>

</body>
</html>