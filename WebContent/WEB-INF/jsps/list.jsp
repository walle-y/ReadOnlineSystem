<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html">
<head>
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>  
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Reader在线阅读平台首页</title>
<link rel="stylesheet" type="text/css" href="layui/css/layui.css"/>
<link rel="stylesheet" type="text/css" href="css/style.css"/>
<script src="js/jquery.js" type="text/javascript"></script>
<script src="layui/layui.js" type="text/javascript"></script>
<style>
#bookList{
 height:auto;
}
.listIsNull{
  position: relative;
  width: 1250px;
  height: 400px;
  margin:0 auto;
  border-radius: 10px;
  background: #f9f9f7;
  padding-top: 10px;
}
.book1{
  position: relative;
  width: 1200px;
  height: 200px;
  margin:0 auto;
  border-radius: 10px;
  box-shadow:10px 10px 10px #888888;
  background: #f9f9f7;
  margin-bottom: 20px;
}
</style>
<script>

function login(){
	$('#loginDiv').css("display","block");
	$('#loginBox').css("display","block");
}
function register(){
	$('#loginBox').css("display","none");
	$('#registerBox').css("display","block");
}

function closeDiv(id) {
	$("#"+id+"").slideUp();
}

layui.use('element', function(){
	  var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块	  
	  //监听导航点击
	  element.on('nav(demo)', function(elem){
	    layer.msg(elem.text());
	  });
	});	
	
layui.use(['form', 'jquery', 'laydate'], function(){
	  var form = layui.form
	  ,layer = layui.layer
	  ,layedit = layui.layedit
	  ,laydate = layui.laydate;


	  //监听提交
	  form.on('submit(userRegisterButton)', function(data){
	    layui.use('jquery',function(){
	      var $=layui.$;
	      $.ajax({
	  		type : 'POST',
	  		data : $('#registerFrom').serializeArray(),
	  		url : '${pageContext.request.contextPath}/userRegister',
	  		contentType:"application/x-www-form-urlencoded",
	  		async:true,
	  		success : function(data) {		
	  			alert(data.msg+"  进行自动登录..");
	  			var index = layer.load(0, {shade: false});
	  			$('#login_name').val(data.user.loginName);
	  			$('#login_passw').val(data.user.password);
	  			$('#userLogin').submit();
	  		},
	  		error : function(){
	  			 alert("登录失败");
	  		}
	  	});   
	    }); 
	    return false;//禁止跳转，否则会提交两次，且页面会刷新
	  });
	});
</script>
</head>
<body>
   <div id="loginDiv">
        <div id="loginBox">
           <form class="layui-form" id="userLogin" action="userLogin">            
                <div class="layui-field-box" style="font-size: 20px;margin-bottom: 20px">
                                 账号登录
                   <span onclick="closeDiv('loginDiv')" style="cursor:pointer;font-size: 27px;color:#363636;margin-left: 17px;float: right;"><i style="font-size: 27px;color:#363636;" class="layui-icon">&#x1006;</i></span>
                  <hr class="layui-bg-red" style="height: 3px"/>
                </div>
                <input type="hidden" name="page" value="list"/>
                <input type="hidden" name="searchName" value="${searchName } "/>
                <input type="hidden" name="bookType" value="${bookType } "/>
                <div class="layui-form-item">
                  <label class="layui-form-label"><i class="layui-icon" style="font-size: 25px;margin-left:50px;float: left;">&#xe66f;</i></label>
                  <div class="layui-input-block">
                    <input type="text" name="loginName" id="login_name" style="float: left;width: 230px;" required lay-verify="required" placeholder="请输入账号" autocomplete="off" class="layui-input"/>
                  </div>
                </div>
                <div class="layui-form-item">
                  <label class="layui-form-label"><i class="layui-icon" style="font-size: 25px;margin-left:50px;float: left;">&#xe673;</i></label>
                  <div class="layui-input-block">
                    <input type="password" name="password" id="login_passw" style="float: left;width: 230px;" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input"/>
                  </div>
                </div>   
                <button class="layui-btn" onClick="document.formName.submit()" lay-submit lay-filter="formDemo" style="margin-left: 80px; width: 250px;margin-top: 30px">登 录</button>
                <center style="margin-top:15px;"><a href="#">忘记密码<a/>   |   <a href="javascript:register();">免费注册<a/> </center>           
           </form>
        </div>
        <div id="registerBox">
             <form class="layui-form" id="registerFrom" action="">            
                <div class="layui-field-box" style="font-size: 20px;margin-bottom: 20px">
                                 账号注册
                   <span onclick="closeDiv('loginDiv')" style="cursor:pointer;font-size: 27px;color:#363636;margin-left: 17px;float: right;"><i style="font-size: 27px;color:#363636;" class="layui-icon">&#x1006;</i></span>
                  <hr class="layui-bg-red" style="height: 3px"/>
                </div>
                <div class="layui-form-item">
                  <label class="layui-form-label"><i class="layui-icon" style="font-size: 25px;margin-left:50px;float: left;">&#xe66f;</i></label>
                  <div class="layui-input-block">
                    <input type="text" name="userName" id="userName" style="float: left;width: 230px;" required lay-verify="required" placeholder="请输入昵称" autocomplete="off" class="layui-input"/>
                  </div>
                </div>
                <div class="layui-form-item">
                  <label class="layui-form-label"><i class="layui-icon" style="font-size: 25px;margin-left:50px;float: left;">&#xe62e;</i></label>
                  <div class="layui-input-block">
                    <input type="text" name="loginName" id="loginName" style="float: left;width: 230px;" required lay-verify="required" placeholder="请输入登录账号" autocomplete="off" class="layui-input"/>
                  </div>
                </div>
                <div class="layui-form-item">
                  <label class="layui-form-label"><i class="layui-icon" style="font-size: 25px;margin-left:50px;float: left;">&#xe673;</i></label>
                  <div class="layui-input-block">
                    <input type="password" name="password" id="password" style="float: left;width: 230px;" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input"/>
                  </div>
                </div>
                <div class="layui-form-item">
                   <label class="layui-form-label">性别</label>
                   <div class="layui-input-block">
				      <input type="radio" name="sex" value="男" title="男"/>
				      <input type="radio" name="sex" value="女" title="女" checked/>
				   </div>
               </div>
               <div class="layui-form-item layui-form-text">
                   <label class="layui-form-label">个性签名</label>
                   <div class="layui-input-block">
                      <textarea name="remark" placeholder="请输入内容" class="layui-textarea" style="width: 250px;height: 50px"></textarea>
                   </div>
               </div> 
                <button class="layui-btn" lay-submit lay-filter="userRegisterButton" style="margin-left: 80px; width: 250px;margin-top: 10px">注  册</button>          
           </form>
        </div>
    </div>
   <div id="all">
       <div id="head" style="background: #323334; width: 1519px;height: 65px;"> 
         <img src="image/head.png" style="margin-left: 20px;margin-top:4px;float: left;"></img>
         <ul class="layui-nav" style="background: #323334; height: 65px; float: left;" >
			  <li class="layui-nav-item layui-this"><a href="">首页</a></li>
			  <li class="layui-nav-item"><a href="">产品</a></li>
			  <li class="layui-nav-item"><a href="">看点</a></li>
			  <li class="layui-nav-item"><a href="javascript:;">解决方案</a></li>
              <li class="layui-nav-item"><a href="">论坛</a></li>
        </ul>
        <div class="container">
           <form action="bookforName" class="parent">
             <input type="text" name="bookName" class="search" placeholder="搜索"/>
             <input type="image" src="image/search1.png" class="btn" onClick="document.formName.submit()"/>
           </form>
        </div>

         <ul class="layui-nav" style="background: #323334; height: 65px; float: right;">
           <li class="layui-nav-item">
              <a href="">控制台</a>
           </li>
           <li class="layui-nav-item">
             <a href="">个人中心</a>
          </li>
          <li class="layui-nav-item" lay-unselect="">
             <c:if test="${empty user}">
               <a href="javascript:login();">登录 / 注册<i class="layui-icon" style="font-size: 30px;color: #228B22">&#xe62e;</i></a>
             </c:if> 
             <c:if test="${!empty user}">
                <a href="${pageContext.request.contextPath}/toUserCenter/${user.userid}"><img src="${user.photo }" class="layui-nav-img">我</a>
               <dl class="layui-nav-child">
                 <dd><a href="javascript:;">修改信息</a></dd>
                 <dd><a href="javascript:;">安全管理</a></dd>
               <dd><a href="${pageContext.request.contextPath}/logout">退了</a></dd>
              </dl>
             </c:if>
             
          </li>
         </ul>
       </div>
       
       <c:if test="${empty books}">
          <div id="body1">
            <div class="listIsNull">
	           <fieldset class="layui-elem-field" >
	            <legend>搜索结果</legend>
	            <div class="layui-field-box">
	                 <c:if test="${!empty bookType}">
	                    <span>共搜到0部 “ ${bookType } ” 类型的图书</span>
	                 </c:if>
	                 <c:if test="${!empty searchName}">
	                   <span>共搜到0部与 “ ${searchName } ” 相关结果</span>
	                 </c:if>
	                 <c:if test="${!empty authorName}">
	                   <span>共搜到0部作者为 “ ${authorName } ” 图书</span>
	                 </c:if>	                 
	            </div>
	            </fieldset>
           </div>          
           </div>
       </c:if>
       <c:if test="${!empty books}">
          <div class="listIsNull">
	           <fieldset class="layui-elem-field" >
	            <legend>搜索结果</legend>	            
	            <div class="layui-field-box">
	               <c:if test="${!empty bookType}">
	                   <span>共搜到&nbsp;<span id="amount" style="color: #f03c2d">${fn:length(books)}</span>&nbsp;部类型为 &nbsp;“ <span style="color: #f03c2d">${bookType }</span> ”&nbsp;的图书</span>	                
	               </c:if>
	               <c:if test="${!empty searchName}">
	                   <span>共搜到&nbsp;<span id="amount" style="color: #f03c2d">${fn:length(books)}</span>&nbsp;部与 &nbsp;“ <span style="color: #f03c2d">${searchName }</span> ”&nbsp;相关的结果</span>	                
	               </c:if>
	               <c:if test="${!empty authorName}">
	                   <span>共搜到&nbsp;<span id="amount" style="color: #f03c2d">${fn:length(books)}</span>&nbsp;部作者为 &nbsp;“ <span style="color: #f03c2d">${authorName }</span> ”&nbsp;的图书</span>	                
	               </c:if>
	            </div>
	            </fieldset>
           </div> 
          <div style="height:auto;position: relative;top:-300px">        
           <div id="bookList">
             <c:forEach items="${books }" var="book">
	           <div class="book1">
	             <div style="width: 150px;height: 190px;margin-left: 4px;margin-top: 4px;float: left;">
	                <a href="${pageContext.request.contextPath}/getBook/${book.bookId }" title="点击查看图书详情"><img src="${book.bookPicture }" width="150px" height="190px"></img></a>
	             </div>  
	             <div style="width:1000px;height: 190px;float: left;margin-top: 4px;margin-left: 10px; ">
	                <ul>
	                   <li>
	                       <span style="line-height: 40px;margin-left: 10px;font-weight: bold;font-size:17px">
	                         <a href="${pageContext.request.contextPath}/getBook/${book.bookId }" title="点击查看图书详情"> ${book.bookName }</a>
	                       </span>
	                   </li>
	                   <li>
	                      <c:forEach items="${fn:split(book.typeIdList,'#')}" var="type">
	                        <span class="layui-badge layui-bg-green" style="margin-left: 10px;">${type}</span>
	                      </c:forEach>                      
	                   </li>
	                   <li><span style="line-height: 30px;margin-left: 10px;font-weight: bold;font-size:14px;color:#bf4c06;">作者：${book.authorVO.authorName}</span></li>
	                   <li style=" height: 100px;margin-bottom: 10px;">
	                         <span>&nbsp;&nbsp;${book.introduce }</span>
	                    </li>
	                </ul>
	             </div>              
	           </div>
           </c:forEach>
          </div>                 
         </div>
       </c:if>   
       <div id="bottom" style="background: 	#2F4F4F; width: 100%;height: 200px;margin-top: 3px;"></div>
   </div>
 
</body>
</html>