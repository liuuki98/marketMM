<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <%
        String path = request.getContextPath();
        String basepath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <base href="<%=basepath%>"/>
    <meta charset="UTF-8">

    <script type="text/javascript">
        if ("${msg}" != "") {
            alert("${msg}");
        }
    </script>

    <c:remove var="msg"></c:remove>

    <link rel="stylesheet" href="css/bootstrap.css"/>
    <link rel="stylesheet" href="css/bright.css"/>
    <link rel="stylesheet" href="css/addBook.css"/>
    <script type="text/javascript" src="js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <title></title>
</head>
<script type="text/javascript">
    $(function (){
        //条件查询
        $("#select").click(function (){
            $("#hiddenPName").val($("#pName").val());
            $("#hiddenTypeId").val($("#typeId").val());
            $("#hiddenLPrice").val($("#lPrice").val());
            $("#hiddenHPrice").val($("#hPrice").val());
            ajaxsplit(1);

        });
        //重置条件查询项，resetBtn的type=“reset”，且id不可为reset会冲突
        $("#resetBtn").click(function (){
            $("#hiddenPName").val("");
            $("#hiddenTypeId").val("");
            $("#hiddenLPrice").val("");
            $("#hiddenHPrice").val("");
            $("#myform")[0].reset();
            ajaxsplit(1);
        })
    })

    function allClick() {
        //取得全选复选框的选中未选 中状态
        var ischeck=$("#all").prop("checked");
        //将此状态赋值给每个商品列表里的复选框
        $("input[name=ck]").each(function () {
            this.checked=ischeck;
        });
    }

    function ckClick() {
        //取得所有name=ck的被选中的复选框
        var length=$("input[name=ck]:checked").length;
//取得所有name=ck的复选框
        var len=$("input[name=ck]").length;
        //比较
        if(len == length){
            $("#all").prop("checked",true);
        }else
        {
            $("#all").prop("checked",false);
        }
    }

</script>
<body>
<input type="hidden" id="hiddenPage" value="${info.pageNum}">
<input type="hidden" id="hiddenPName" >
<input type="hidden" id="hiddenTypeId" >
<input type="hidden" id="hiddenLPrice" >
<input type="hidden" id="hiddenHPrice" >
<div id="brall">
    <div id="nav">
        <p>商品管理>商品列表</p>
    </div>
    <div id="condition" style="text-align: center">
        <form id="myform">
            商品名称：<input name="pName" id="pName">&nbsp;&nbsp;&nbsp;
            商品类型：<select name="typeId" id="typeId">
            <option value="-1">请选择</option>
            <c:forEach items="${ptlist}" var="pt">
                <option value="${pt.typeId}"
                        <c:if test="${pt.typeId==typeId}">
                            selected="selected"
                        </c:if>
                >${pt.typeName}</option>
            </c:forEach>
        </select>&nbsp;&nbsp;&nbsp;
            价格：<input name="lPrice" id="lPrice">-<input name="hPrice" id="hPrice">
            <input type="button" value="查询" id="select">
            <input type="reset" value="重置" id="resetBtn">
        </form>
    </div>
    <br>
    <div id="table">

        <c:choose>
            <c:when test="${info.list.size()!=0}">

                <div id="top">
                    <input type="checkbox" id="all" onclick="allClick()" style="margin-left: 50px">&nbsp;&nbsp;全选
                    <a href="admin/addproduct.jsp">

                        <input type="button" class="btn btn-warning" id="addBtn"
                               value="新增商品">
                    </a>
                    <input type="button" class="btn btn-warning" id="deleteBtn"
                           value="批量删除" onclick="deleteBatch()">
                </div>
                <!--显示分页后的商品-->
                <div id="middle">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th></th>
                            <th>商品名</th>
                            <th>商品介绍</th>
                            <th>定价（元）</th>
                            <th>商品图片</th>
                            <th>商品数量</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${info.list}" var="p">
                            <tr>
                                <td valign="center" align="center"><input type="checkbox" name="ck" id="ck" value="${p.pId}" onclick="ckClick()"></td>
                                <td>${p.pName}</td>
                                <td>${p.pContent}</td>
                                <td>${p.pPrice}</td>
                                <td><img width="55px" height="45px"
                                         src="image_big/${p.pImage}"></td>
                                <td>${p.pNumber}</td>
                                    <%--<td><a href="admin/product?flag=delete&pid=${p.pId}" onclick="return confirm('确定删除吗？')">删除</a>--%>
                                    <%--&nbsp;&nbsp;&nbsp;<a href="admin/product?flag=one&pid=${p.pId}">修改</a></td>--%>
                                <td>
                                    <button type="button" class="btn btn-info "
                                            onclick="goUpdate(${p.pId},${info.pageNum})">编辑
                                    </button>
                                    <button type="button" class="btn btn-warning" id="mydel"
                                            onclick="del(${p.pId},'${p.pImage}',${info.pageNum})">删除
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <!--分页栏-->
                    <div id="bottom">
                        <div>
                            <nav aria-label="..." style="text-align:center;">
                                <ul class="pagination">
                                    <li>
                                            <%--                                        <a href="prod/split.action?page=${info.prePage}" aria-label="Previous">--%>
                                        <a href="javascript:ajaxsplit(${info.prePage})" aria-label="Previous">

                                            <span aria-hidden="true">«</span></a>
                                    </li>
                                    <c:forEach begin="1" end="${info.pages}" var="i">
                                        <c:if test="${info.pageNum==i}">
                                            <li>
                                                    <%--                                                <a href="prod/split.action?page=${i}" style="background-color: grey">${i}</a>--%>
                                                <a href="javascript:ajaxsplit(${i})"
                                                   style="background-color: grey">${i}</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${info.pageNum!=i}">
                                            <li>
                                                    <%--                                                <a href="prod/split.action?page=${i}">${i}</a>--%>
                                                <a href="javascript:ajaxsplit(${i})">${i}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <li>
                                        <%--  <a href="prod/split.action?page=1" aria-label="Next">--%>
                                        <a href="javascript:ajaxsplit(${info.nextPage})" aria-label="Next">
                                            <span aria-hidden="true">»</span></a>
                                    </li>
                                    <li style=" margin-left:150px;color: #0e90d2;height: 35px; line-height: 35px;">总共&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${info.pages}</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <c:if test="${info.pageNum!=0}">
                                            当前&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${info.pageNum}</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                        <c:if test="${info.pageNum==0}">
                                            当前&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">1</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div>
                    <h2 style="width:1200px; text-align: center;color: orangered;margin-top: 100px">暂时没有符合条件的商品！</h2>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>

<script type="text/javascript">
    function mysubmit() {
        $("#myform").submit();
    }

    //批量删除
    function deleteBatch() {

            //取得所有被选中删除商品的pid
            var pId=$("input[name=ck]:checked");
            var page=$("#hiddenPage").val();
            var str="";
            var id="";
            if(pId.length==0){
                alert("请选择将要删除的商品！");
            }else{
                // 有选中的商品，则取出每个选 中商品的ID，拼提交的ID的数据
                if(confirm("您确定删除"+pId.length+"条商品吗？")){
                //拼接ID
                    $.each(pId,function (index,item) {

                        id=$(item).val();
                        if(id!=null)
                            str += id+",";
                    });
                    $.ajax({
                        url:"prod/deleteProductByIds.do",
                        data:{
                            "pId":str,
                        },
                        type:"post",
                        dataType:"json",
                        success:function (data){
                            if(data){
                                var pName=$("#hiddenPName").val().trim();
                                var typeId=$("#hiddenTypeId").val().trim();
                                var lPrice=$("#hiddenLPrice").val().trim();
                                var hPrice=$("#hiddenHPrice").val().trim();
                                window.location.href="prod/deleteProductById.do?&page="+page+"&pName="+pName+"&typeId="+typeId+"&lPrice="+lPrice+"&hPrice="+hPrice;
                            }else {
                                alert("删除失败！");

                            }
                        }
                    })
                    //发送请求到服务器端
                   // window.location="prod/deletebatch.action?str="+str;
                }
        }
    }
    //单个删除
    function del(pId,pImage,page) {

        if (confirm("确定删除吗")) {
          //向服务器提交请求完成删除
            var pName=$("#hiddenPName").val().trim();
            var typeId=$("#hiddenTypeId").val().trim();
            var lPrice=$("#hiddenLPrice").val().trim();
            var hPrice=$("#hiddenHPrice").val().trim();
            window.location.href="prod/deleteProductById.do?pId="+pId+"&pImage="+pImage+"&page="+page+"&pName="+pName+"&typeId="+typeId+"&lPrice="+lPrice+"&hPrice="+hPrice;
        }
    }

    function goUpdate(pid, ispage) {
        var pName=$("#hiddenPName").val().trim();
        var typeId=$("#hiddenTypeId").val().trim();
        var lPrice=$("#hiddenLPrice").val().trim();
        var hPrice=$("#hiddenHPrice").val().trim();
        location.href = "prod/goUpdate.do?pId="+pid+"&page="+ispage+"&pName="+pName+"&typeId="+typeId+"&lPrice="+lPrice+"&hPrice="+hPrice;
    }
</script>

<!--分页的AJAX实现-->
<script type="text/javascript">
    function ajaxsplit(page) {
        //异步ajax分页请求
        $.ajax({
        url:"prod/ajaxPageList.do",
            data:{
                "page":page,
                "pName":$("#hiddenPName").val().trim(),
                "typeId":$("#hiddenTypeId").val().trim(),
                "lPrice":$("#hiddenLPrice").val().trim(),
                "hPrice":$("#hiddenHPrice").val().trim(),
            },
            type:"post",
            success:function () {
                //重新加载分页显示的组件table
                //location.href---->http://localhost:8080/admin/login.action

                $("#table").load("admin/product.jsp #table");
            }
        })
    };

</script>

</html>