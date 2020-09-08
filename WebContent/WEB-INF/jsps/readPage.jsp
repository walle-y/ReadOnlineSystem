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
<title>悦读网图书阅读页面</title>
<link rel="stylesheet" type="text/css" href="layui/css/layui.css"/>
<link rel="stylesheet" type="text/css" href="css/style.css"/>
<script src="js/jquery.js" type="text/javascript"></script>
<script src="layui/layui.js" type="text/javascript"></script>
<style>
#chapterBody{
  background: -webkit-linear-gradient(#FFE4B5,#FFFFFF); 
  background: -o-linear-gradient(#FFE4B5,#FFFFFF); 
  background: -moz-linear-gradient(#FFE4B5,#FFFFFF);
  background: linear-gradient(#FFE4B5,#FFFFFF); 
  width: 1519px;
   height:auto;
  padding-top: 30px;
}
#bodyHead{
   width: 1200px;
   height:150px;
   margin: 0 auto;
   padding-top: 6px;
}
#chapterContent{
   width: 1000px;
   height:auto;
   background: #FFFACD;
   margin: 0 auto;
}
#set{
  width: 70px;
  height: 360px;
  position:fixed;
  top:250px;
  left:180px;
}
#set ul li{
  width: 70px;
  height: 80px;
  margin-bottom: 5px;
  background: #bfc3c2;
  cursor:pointer;
}
#set ul li:hover{
  background:#D3D3D3;
}
#buttonBox a{
width: 150px;height: 40px;
}
#evaluation{
   width: 1000px;
   height:auto;
}
#inputBox{
   display:none;
   width:860px; 
   height: 140px;
   background: 	#FFFFFF;
   border-radius:10px 10px 10px 10px;
   box-shadow:5px 5px 5px #888888;
   float: left;
   margin-bottom: 15px;
   padding-top: 20px;
}
#content{
   width: 860px;
   height:auto;
   background: 	#FFF5EE;
   text-align: center;
   margin-left: 70px;margin-right: 70px;
   padding-bottom: 10px;
}
#content ul li{
   width: 860px;
   height:auto;
   margin-bottom: 15px;
}
.span1{
 color:	#6d605a;font-weight:bold;font-size: 18px; text-align:left;width: 300px;height: 40px;float: left;margin-top:5px;padding-left: 15px;
}
.span2{
 width: 700px;height: 60px;float: left;position: relative;left: 14px;top:5px ;text-align: left;font-size: 15px;
}
.span3{
 width: 700px;height: 25px;float: left;position: relative;left: 78px;top:-20px ;text-align: left;font-size: 17px;
}
.revertContent{
  display: none;
  width: 650px;
  height: auto;
  background: #FFFAFA;
  float:left;
  margin-left: 120px;
  margin-bottom: 9px;
}
.revertDiv{
  width: 650px;
  height: auto;
  background: #FFFAFA;
}
.span4{
 color:	#6d605a;font-weight:bold;font-size: 14px; text-align:left;width: 570px;height: 30px;float: left;margin-top:2px;padding-left: 15px;
}
.span5{
 width: 550px;height: 30px;float: left;position: relative;left: 15px;text-align: left;font-size: 15px;
}


</style>
<script>
$(document).ready(function(){
	$("#setSize").mouseover(function() {
		$('#div1').slideDown();
	});
	
	$("#setSize").mouseleave(function(e){		
		$('#div1').slideUp();	  
	});	
	
	$('#toTop').click(function () {
		smoothscroll();
	});
	
	$('#toEvaluation').click(function () {
		toEvaluation();
	});
	
	$('#showInputBox').click(function () {
		showInputBox();
	});	 
	getEvaluation();
	
});

function closeRevertDiv(id) {
	var name = id.id;
	$("#"+name+"").slideUp();
}

function closeDiv(id) {
	$("#"+id+"").slideUp();
}

function openRevertDiv(id) {
	var name = id.id;
	$("#"+name+"").slideDown();
}

function showInputBox() {
	var userId = $('#userId').text();
	if(userId == '' || userId == null)
		layer.msg("此功能针对登录用户，请先登录..")
	else
	   $('#inputBox').slideDown();
}

function login(){
	$('#loginDiv').css("display","block");
	$('#loginBox').css("display","block");
}
function register(){
	$('#loginBox').css("display","none");
	$('#registerBox').css("display","block");
}

function smoothscroll(){
    var currentScroll = document.documentElement.scrollTop || document.body.scrollTop;
    if (currentScroll > 0) {
         window.requestAnimationFrame(smoothscroll);
         window.scrollTo (0,currentScroll - (currentScroll/5));
    }
}

function toEvaluation() {
	$("html,body").animate({scrollTop:$('#evaluation').offset().top},300);
}

function addEvaluationLikes(evaluationId,userId) {
	$.ajax({
		type : 'POST',
		data : {
			evaluationId : evaluationId,
			userId : userId
		},
		url : '${pageContext.request.contextPath}/addEvaluationLikes',
		contentType:"application/x-www-form-urlencoded",
		async:true,
		datatype:"json",
		success : function(data) {
			var status = data.status;
			if(status == '1'){
				layer.msg("评论点赞成功");				
			}else if(status == '2'){
				layer.msg("取消评论点赞成功");
			}	
			getEvaluation();
		},
		error : function(){			
		}
});
}

function addRevertLikes(revertId,userId) {
	$.ajax({
		type : 'POST',
		data : {
			revertId : revertId,
			userId : userId
		},
		url : '${pageContext.request.contextPath}/addRevertLikes',
		contentType:"application/x-www-form-urlencoded",
		async:true,
		datatype:"json",
		success : function(data) {
			var status = data.status;
			if(status == '1'){
				layer.msg("回复点赞成功");				
			}else if(status == '2'){
				layer.msg("取消回复点赞成功");
			}	
			getEvaluation();
		},
		error : function(){			
		}
});
}

function getEvaluation(){//初始化评论列表，然后重新加载
	 $('#content ul').html("");
	$.ajax({
		type : 'POST',
		data : {
			bookId : $('#bookId').text(),
			chapterNumber : $('#chapterNumber').text()
		},
		url : '${pageContext.request.contextPath}/getEveluation',
		contentType:"application/x-www-form-urlencoded",
		async:true,
		datatype:"json",
		success : function(data) {
			var userId = $('#userId').text();
			var result =  data;
			var evaluationList = result.evaluationList;
			$.each(evaluationList,function(i,evaluation){
				var revertList= evaluation.revertList;
				var liID = "li_"+i;
				$('#content ul').append('<li><img src=\"'+evaluation.userVO.photo+'\" style=\"width: 60px;height: 60px;margin-top:10px;float: left;\" class=\"layui-nav-img\"/>'+
				                          '<span class=\"span1\">'+evaluation.userVO.userName+'</span>'+
				                          '<span class=\"span2\">'+evaluation.evaluationContent+'</span>'+
				                          '<span class=\"span3\">'+
				                             '<span style=\"float: left;color: #6d605a;\">'+evaluation.evaluationTime+'</span>'+
				                             '<span onclick=\"openRevertDiv('+liID+')\" style=\"float: right;cursor:pointer;\">'+
				                                '<i class=\"layui-icon\" style=\"font-size: 25px;color:#2F4F4F;\">&#xe63a;</i>&nbsp;'+revertList.length+
				                             '</span>'+
				                             '<span onclick=\"addEvaluationLikes('+evaluation.evaluationId+','+userId+')\" style=\"float: right;margin-right: 20px;cursor:pointer;\">'+
				                                '<i class=\"layui-icon\" style=\"font-size: 25px;color:#2F4F4F;\">&#xe6c6;</i>&nbsp;'+evaluation.likes+
				                             '</span>'+
				                          '</span>'+
				                          '<div id=\"'+liID+'\" class=\"revertContent\"></div>'+
				                          '<hr style=\"background: #2E8B57;\"/></li>');
		   		
			   if(revertList.length > 0){
				   var formId = "revertForm_"+i;
				   $("#"+liID+"").append('<span onclick=\"closeRevertDiv('+liID+')\" style=\"cursor:pointer;font-size: 27px;color:#363636;margin-right: 5px;float: right;"><i style=\"font-size: 27px;color:#363636;\" class=\"layui-icon\">&#x1006;</i></span>');
				   $.each(revertList,function(a,revert){
					   $("#"+liID+"").append('<div style=\"margin-bottom:10px;float: left;\"><img src=\"'+revert.uservo.photo+'\" style=\"width: 40px;height: 40px;margin-top:10px;float: left;\" class=\"layui-nav-img\"/>'+
		                          '<span class=\"span4\"><span style=\"float: left;\">'+revert.uservo.userName+'&nbsp;&nbsp;回复&nbsp;&nbsp;'+evaluation.userVO.userName+'</span>'+
		                             '<span style=\"float: left;color:#00868B;margin-top:4px;margin-left:20px;\">'+revert.revertTime+'</span>'+ 
		                             '<span onclick=\"addRevertLikes('+revert.revertId+','+userId+')\" style=\"float: right;\">'+
		                                '<i class=\"layui-icon\" style=\"font-size: 25px;color:#2F4F4F;cursor:pointer;\">&#xe6c6;</i>&nbsp;'+revert.likes+
		                             '</span>'+
		                          '</span>'+
		                          '<span class=\"span5\">'+revert.revertContent+'</span>'+	                          
		                     '</div>');				   
				   });
				   $("#"+liID+"").append('<div>'+
                           '<form id=\"'+formId+'\" class=\"layui-form\" action=\"\" style=\"width:580px;height:140px;float:left;margin-left:30px;margin-top:30px;\">'+
							  '<textarea name=\"revertContent\" style=\"width: 580px;height: 40px;\" placeholder=\"请输入回复内容...\" class=\"layui-textarea\" lay-verify=\"required\"></textarea>'+
							  '<input type=\"hidden" name=\"userId\" value=\"'+userId+'\"/>'+
                              '<input type=\"hidden\" name=\"evaluationId\" value=\"'+evaluation.evaluationId+'\"/>'+
                              '<button lay-filter="revertSub" lay-submit class=\"layui-btn\" style=\"float: right;\">提交回复</button>'+
							  '<button type=\"reset\" style=\"float:right;margin-right:15px;\" class=\"layui-btn layui-btn-primary\">重置</button>'+
                           '</form>'+	                         
                    '</div>');
				   
			   }else{
				   var formId = "revertForm_"+i;
				   $("#"+liID+"").append('<span style=\"float: left;margin-left:30px;color:	#7A8B8B\">暂无用户回复此评论...</span>'+
				              '<span onclick=\"closeRevertDiv('+liID+')\" style=\"cursor:pointer;font-size: 27px;color:#363636;margin-right: 5px;float: right;"><i style=\"font-size: 27px;color:#363636;\" class=\"layui-icon\">&#x1006;</i></span>'+
	                          '<div>'+
	                             '<form id=\"'+formId+'\" class=\"layui-form\" action=\"\" style=\"width:600px;height:140px;float:left;margin-left:30px;margin-top:15px;\">'+
									 '<textarea name=\"revertContent\" style="width: 580px;height: 40px;" placeholder=\"请输入回复内容...\" class=\"layui-textarea\" lay-verify=\"required\"></textarea>'+
									 '<input type=\"hidden" name=\"userId\" value=\"'+userId+'\"/>'+
		                             '<input type=\"hidden\" name=\"evaluationId\" value=\"'+evaluation.evaluationId+'\"/>'+
		                             '<button lay-filter="revertSub" lay-submit class=\"layui-btn\" style="float: right;">提交回复</button>'+
									 '<button type=\"reset\" style="float:right;margin-right:15px;" class=\"layui-btn layui-btn-primary\">重置</button>'+
		                          '</form>'+	                         
	                          '</div>');	
			   }			   
			});
			
		},
		error : function(){	
		}
	});
}

function addRevert(id){//回复评论
	var userId = $('#userId').text();
	if(userId == '' || userId == null){
		layer.msg("此功能针对登录用户，请先登录..");
		return false;
	}		
	var name = id.id;
	$.ajax({
		type : 'POST',
		data : $("#"+name+"").serializeArray(),
		url : '${pageContext.request.contextPath}/addRevert',
		contentType:"application/x-www-form-urlencoded",
		async:true,
		datatype:"json",
		success : function(data) {
			var status = data.status;
			if(status == '1'){
				layer.msg("回复章节评论成功");
				getEvaluation();
			}else{
				layer.msg("回复章节评论失败");
			}					
		},
		error : function(){			
		}
	});
	return true;
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
	  
	  form.on('submit(evaluationSub)', function(data){
		    layui.use('jquery',function(){
		      var $=layui.$;
		      $.ajax({
		  		type : 'POST',
		  		data : $('#evaluationForm').serializeArray(),
		  		url : '${pageContext.request.contextPath}/addEvaluation',
		  		contentType:"application/x-www-form-urlencoded",
		  		async:true,
		  		success : function(data) {		
		  			var status = data.status;
		  			if(status == '1'){
		  				layer.msg("评论成功");
		  			   getEvaluation();
		  			}else
		  				layer.msg("评论失败");
		  		},
		  		error : function(){	  			 
		  		}
		  	});   
		    }); 
		    return false;//禁止跳转，否则会提交两次，且页面会刷新
		  });
	  
	  form.on('submit(revertSub)', function(data){		    
		    layui.use('jquery',function(){
		      var name = data.form.id;
		      var $=layui.$;
		      var userId = $('#userId').text();
		  	  if(userId == '' || userId == null){
		  		layer.msg("此功能针对登录用户，请先登录..");
		  		return false;
		  	  }	  	
		  	$.ajax({
		  		type : 'POST',
		  		data : $("#"+name+"").serializeArray(),
		  		url : '${pageContext.request.contextPath}/addRevert',
		  		contentType:"application/x-www-form-urlencoded",
		  		async:true,
		  		datatype:"json",
		  		success : function(data) {
		  			var status = data.status;
		  			if(status == '1'){
		  				layer.msg("回复章节评论成功");
		  				getEvaluation();
		  			}else{
		  				layer.msg("回复章节评论失败");
		  			}					
		  		},
		  		error : function(){		  			
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

layui.use('colorpicker', function(){	   //使用颜色选择器
	var colorpicker = layui.colorpicker;	   
	  colorpicker.render({
		  elem: '#textColor',
		    size: 'lg',
		    color: '#363636',
	    change: function(color){
	    	$('#txtContent').css("color",color);
	    }
	  }); 
	  colorpicker.render({
		  elem: '#bgColor',
		    size: 'lg',
		    color: '#FFFACD',
	    change: function(color){
	    	$('#chapterContent').css("background",color);
	    }
	  });
	});

layui.use('slider', function(){  //使用滑块
	  var slider = layui.slider;
	  
	  slider.render({
		  elem: '#textSize',
		  showstep: true,
		  max:30,
		  min:10,
		  change: function(value){
		    $('#txtContent').css("font-size",""+value+"px");
		  }
		});
});
	
</script>
</head>
<body>
   <div id="loginDiv">
        <div id="loginBox">
           <form class="layui-form" id="userLogin" action="userLogin">            
                <input type="hidden" name="page" value="readPage"/>
                <input type="hidden" name="bookId" value="${book.bookId }"/>
                <input type="hidden" name="chapterNumber" value="${chapter.chapterNumber }"/>
                <div class="layui-field-box" style="font-size: 20px;margin-bottom: 20px">
                                 账号登录
                   <span onclick="closeDiv('loginDiv')" style="cursor:pointer;font-size: 27px;color:#363636;margin-left: 17px;float: right;"><i style="font-size: 27px;color:#363636;" class="layui-icon">&#x1006;</i></span>
                  <hr class="layui-bg-red" style="height: 3px"/>
                </div>
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
          <div style="display: none">
            <span id="bookId">${book.bookId }</span>
            <span id="chapterNumber">${chapter.chapterNumber }</span>
            <span id="userId">${user.userid }</span>
          </div>
	       <div id="bodyHead">
	           <ur>
	              <li style="width: 100%;height:40px;">
	                <span style="color: #646f6f;font-size: 15px;margin-left: 5px;">当前位置：&nbsp;<a href="#" style="color: #e06012">首页</a>&nbsp;&gt;<c:forEach items="${fn:split(book.typeIdList,'#')}" var="type"><a href="getBookByType/${type}" style="color: #3e968e">&nbsp;|&nbsp;${type}</a></c:forEach>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/getBook/${book.bookId }">${book.bookName}</a></span>
	                <hr class="layui-bg-black"/>
	              </li>
	              <li style="margin-top:5px;width: 100%;height:40px;text-align:center;font-size: 20px;text-shadow: 1px 1px #828282;">${chapter.chapterName}</li>
	              <li style="text-align:center;"><span style="color: #696969">作者：</span><span>${book.authorVO.authorName}</span><span style="margin-left: 10px;color: #696969;">&nbsp;|&nbsp;字数：</span><span>${fn:length(chapterContent)}</span><span style="margin-left: 10px;color: #696969;">&nbsp;|&nbsp;更新时间：</span><span>${book.uploadTime}</span></li>
	              <li style="margin-top: 40px"> <hr></li>
	           </ur>      
	       </div> 
	       <div id="set">
	          <ul>
	             <li><span id="textColor" style="float: left;margin-left: 10px;margin-top: 4px"></span><span style="text-align:center;margin-top: 5px;float: left;margin-left: 7px">字体颜色</span></li>
	             <li id="setSize">
	                <i class="layui-icon" style="font-size: 35px;color: #2F4F4F;margin-left: 17px;margin-right: 20px;">&#xe62b;</i><span style="display:block ;text-align:center;margin-top: 5px;">字体大小</span>
	                <div id="div1" style="display:none;width: 200px;height: 40px;position: relative;left: 80px;top:-60px;background: rgba(54,54,54,.4);padding-top: 35px">
	                 <span id="textSize"></span>
	                 </div>
	             </li>
	             <li><span id="bgColor" style="float: left;margin-left: 10px;margin-top: 4px"></span><span style="text-align:center;margin-top: 5px;float: left;margin-left: 7px">背景颜色</span></li>
	             <li id="toTop"><i class="layui-icon" style="font-size: 30px;color: #2F4F4F;margin-left: 20px;;margin-right: 20px;">&#xe609;</i><span style="display:block ;text-align:center;margin-top: 5px;">回到顶部</span></li>
	             <li id="toEvaluation" style="position: relative;left: 1090px;top:-336px"><i class="layui-icon" style="font-size: 30px;color: #2F4F4F;margin-left: 20px;;margin-right: 20px;">&#xe609;</i><span style="display:block ;text-align:center;margin-top: 5px;">跳转至评论区</span></li>
	          </ul>		                   
	       </div>
	       <div> 
	       <c:if test="${empty chapterContent}">
	           <div style="width: 1000px;height: 400px;margin-left: 400px;font-size: 17px">
	                        对不起，暂未找到该书资源...
	           </div>
	       </c:if>  
	        <c:if test="${!empty chapterContent}">
	           <div id="chapterContent">
	           <div id="txtContent" style="margin-left: 70px;margin-right: 70px">
	             ${chapterContent }
	           </div>	           
	           <div style="margin-top:40px; width:1000px;height: 100px;">
	              <div id="buttonBox" style="text-align:center;">
	                 <c:if test="${chapter.chapterNumber != 1}">
	                   <a href="${pageContext.request.contextPath}/getchapterContent/${book.bookId}/${chapter.chapterNumber-1}" class="layui-btn">上一章</a>
	                 </c:if>	                 
	                 <a href="${pageContext.request.contextPath}/getChapter/${bookId}" class="layui-btn">目&nbsp;&nbsp;录</a>
	                 <c:if test="${chapter.chapterNumber != listSize}">
	                   <a href="${pageContext.request.contextPath}/getchapterContent/${book.bookId}/${chapter.chapterNumber+1}" class="layui-btn">下一章</a>
	                 </c:if>
	                 
	              </div>
	           </div>
	           
	          <div id="evaluation">
	             <div style="margin-left: 70px;margin-right: 70px;height:auto;">
	                <span style="color:	#2F4F4F;font-weight:bold;font-size: 20px;margin-left: 5px;float: left;">章节评论</span>
	                <button class="layui-btn layui-btn-primary" id="showInputBox" style="border-color:red;float: right;margin-right: 10px;margin-bottom: 6px">发表章评</button>
	                <div id="inputBox">
	                    <i class="layui-icon" style="font-size: 40px;color: #3CB371;margin-left: 30px;float: left;">&#xe6b2;</i>
	                    <form id="evaluationForm" class="layui-form" action="" style="width: 700px;height: 100px;float: left;margin-left: 30px;">
							 <textarea name="evaluationContent" placeholder="请输入内容评论..." class="layui-textarea" lay-verify="required"></textarea>
							 <input type="hidden" name="userId" value="${user.userid}"/>
                             <input type="hidden" name="bookId" value="${book.bookId }"/>
                             <input type="hidden" name="chapterNumber" value="${chapter.chapterNumber }"/>  
                             <div class="layui-input-block" style="float: right;">
							     <button class="layui-btn" lay-submit lay-filter="evaluationSub">提交评论</button>
							     <button type="reset" class="layui-btn layui-btn-primary">重置</button>
							</div>
	                    </form>
	                    <span onclick="closeDiv('inputBox')" style="cursor:pointer;font-size: 27px;color:#363636;margin-left: 17px;float: left;"><i style="font-size: 27px;color:#363636;" class="layui-icon">&#x1006;</i></span>
	                </div>
	                <hr style="background: #2E8B57"/>               
	             </div>
	                
	             <div id="content">
	                <ul></ul>
	            </div>
	         </div>
	      </div>
	       </c:if>    
	       
         
       </div>
       <div id="bottom" style="background: 	#2F4F4F; width: 100%;height: 200px;margin-top: 3px;"></div>
   </div>
 
</body>
</html>