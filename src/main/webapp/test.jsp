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
        <script type="text/javascript" src="js/jquery-3.3.1.js"></script>


    </head>
<body>
<body>
<input type="file" id="file_input">
<img src="" class="img" />

<script>
    $("input[type='file']").change(function(){
        var file = this.files[0];
        if (window.FileReader) {
            var reader = new FileReader();
            reader.readAsDataURL(file);
            //监听文件读取结束后事件
            reader.onloadend = function (e) {
                console.log(e.target.result);
                $(".img").attr("src",e.target.result);    //e.target.result就是最后的路径地址
            };
        }
    });

</script>
</body>
</html>