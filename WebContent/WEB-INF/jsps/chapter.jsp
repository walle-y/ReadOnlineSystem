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
<title>悦读网图书章节页面</title>
<link rel="stylesheet" type="text/css" href="layui/css/layui.css"/>
<link rel="stylesheet" type="text/css" href="css/style.css"/>
<script src="js/jquery.js" type="text/javascript"></script>
<script src="layui/layui.js" type="text/javascript"></script>
<style>
#chapterBody{
  background: -webkit-linear-gradient(#ebecef,#FFFFFF); 
  background: -o-linear-gradient(#ebecef,#FFFFFF); 
  background: -moz-linear-gradient(#ebecef,#FFFFFF);
  background: linear-gradient(#ebecef,#FFFFFF); 
  width: 1519px;
  height:700px; 
  padding-top: 30px;
}
#bodyHead{
   width: 1200px;
   height:150px;
   margin: 0 auto;
   padding-top: 6px;
}
#chapterContent{
   width: 1200px;
   height:450px;
   background: #FFFFFF;
   margin: 0 auto;
}
</style>
<script>
function login(){
	$('#loginDiv').css("display","block");
	$('#loginBox').css("display","block");
}

function closeDiv(id) {
	$("#"+id+"").slideUp();
}

function register(){
	$('#loginBox').css("display","none");
	$('#registerBox').css("display","block");
}
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
	  			layer.msg(data.msg+"  进行自动登录..");
	  			var index = layer.load(0, {shade: false});
	  			$('#login_name').val(data.user.loginName);
	  			$('#login_passw').val(data.user.password);
	  			$('#userLogin').submit();
	  		},
	  		error : function(){
	  			layer.msg("登录失败");
	  		}
	  	});   
	    }); 
	    return false;//禁止跳转，否则会提交两次，且页面会刷新
	  });
	});

layui.use('element', function(){
	  var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块	  
	  //监听导航点击
	  element.on('nav(demo)', function(elem){
	    layer.msg(elem.text());
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
                <input type="hidden" name="page" value="chapter"/>
                <input type="hidden" name="bookId" value="${book.bookId }"/>
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
       <div id="chapterBody">
	       <div id="bodyHead">
	           <ur>
	              <li style="width: 100%;height:40px;">
	                <span style="color: #646f6f;font-size: 15px;margin-left: 5px;">当前位置：&nbsp;<a href="#" style="color: #e06012">首页</a>&nbsp;&gt;<c:forEach items="${fn:split(book.typeIdList,'#')}" var="type"><a href="getBookByType/${type}" style="color: #3e968e">&nbsp;|&nbsp;${type}</a></c:forEach>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/getBook/${book.bookId }">${book.bookName}</a></span>
	                <hr class="layui-bg-black"/>
	              </li>
	              <li style="margin-top:5px;width: 100%;height:40px;text-align:center;font-size: 20px;text-shadow: 1px 1px #828282;">${book.bookName }</li>
	              <li style="text-align:center;"><span style="color: #696969">作者：</span><span>${book.authorVO.authorName}</span><span style="margin-left: 10px;color: #696969;">上传时间：</span><span>${book.uploadTime }</span></li>
	              <li style="margin-top: 40px"> <hr></li>
	           </ur>         
	       </div>       
	       <div id="chapterContent">
	           <ul>
	              <li style="width: 100%;height: 50px;font-weight:bolder;font-size: 20px;margin-left: 5px;"><span style="color: #e47307;font-size: 25px;margin-right: 5px">|</span>章节列表<span style="color: 	#008B8B;font-size: 15px;margin-left: 9px;">共&nbsp;${fn:length(chapterList)}&nbsp;章</span></li>
	              <c:forEach items="${chapterList }" var="chapter" varStatus="status">	                      
	                   <li><a style="cursor:pointer;" title="选择章节开始阅读" href="${pageContext.request.contextPath}/getchapterContent/${book.bookId}/${chapter.chapterNumber}">
	                      <span style="width: 380px;height: 40px;float: left;padding-left: 5px;line-height:40px ">${chapter.chapterName }</span>
	                      </a>
	                   </li>
	                   <c:if test="${(status.index+1)%3==0}">
                          <HR style="BORDER-RIGHT: #00686b 1px dotted; BORDER-TOP: #00686b 1px dotted; BORDER-LEFT: #00686b 1px dotted; BORDER-BOTTOM: #00686b 1px dotted" noShade SIZE=1>      
                       </c:if>
	             </c:forEach>
	              

	           </ul>
	       </div>
         
       </div>
       <div id="bottom" style="background: 	#2F4F4F; width: 100%;height: 200px;margin-top: 3px;"></div>
   </div>
 
</body>
</html>