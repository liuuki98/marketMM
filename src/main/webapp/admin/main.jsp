<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<%
			String path = request.getContextPath();
			String basepath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
		%>
		<base href="<%=basepath%>"/>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="css/bootstrap.css" />
		<link rel="stylesheet" href="css/index.css" />
		<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="js/bootstrap.js"></script>
		<title></title>
		<%--<link href="css/main.css" rel="stylesheet" >--%>
		<style type="text/css">
		
		</style>
	</head>

	<body>
		<!--整体部分-->
		<div id="all">
			<!--上部分-->
			<div id="top">
				<div id="top1">
					<span>商品管理系统</span>
				</div>
				<div id="top2"></div>
				<div id="top3">
					<span>欢迎您，${name}</span>
				</div>
			</div>
			<!--下部分-->
			<div id="bottom">
				<!--下部分左边-->
				<div id="bleft">
					<div id="ltop">
						<div id="lts">
							<img src="images/logo.jpg" /><br />
							<p style="text-align: center;">管理员</p>
						</div>
					</div>
					<div id="lbottom">
						<ul>
							<a href="prod/getProList.do" target="myright" >
								<li class="two"><span class="glyphicon glyphicon-book" style="color: white;"></span>&nbsp;&nbsp;&nbsp;&nbsp;商品管理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-play" style="color: white;"></span> </li>
							</a>
							<a href="admin/err.jsp" target="myright">
								<li class="one"><span class="glyphicon glyphicon-sort" style="color: white;"></span>&nbsp;&nbsp;&nbsp;&nbsp;订单管理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-play" style="color: white;"></span> </li>
							</a>
							<a href="admin/err.jsp" target="myright">
								<li class="one"><span class="glyphicon glyphicon-user" style="color: white;"></span>&nbsp;&nbsp;&nbsp;&nbsp;用户管理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-play" style="color: white;"></span> </li>
							</a>
							<a href="admin/err.jsp" target="myright">
								<li class="one"><span class="glyphicon glyphicon-bullhorn" style="color: white"></span>&nbsp;&nbsp;&nbsp;&nbsp;通知公告&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-play" style="color: white;"></span> </li>
							</a>
						</ul>
					</div>
				</div>
				<!--下部分右边-->
				<div id="bright">
					<iframe frameborder="0" scrolling="no" name="myright" width="1235px" height="700px" ></iframe>
				</div>
			</div>
		</div>
	</body>

</html>