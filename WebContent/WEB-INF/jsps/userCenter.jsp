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
   width: 1320px;
   height:40px;
   margin: 0 auto;
   padding-top: 6px;
}
#chapterContent{
   width: 1200px;
   height:450px;
   background: #FFFFFF;
   margin: 0 auto;
}
#bookBox{
  position: relative;
  width: 1050px;
  height: 500px;
  margin-left:20px;
  border-radius: 10px;
  box-shadow:10px 10px 10px #888888;
  float: left;
  background:url(image/bookcase2.jpg);
  background-size:1050px 500px;
  background-repeat:no-repeat;
}
#userContent{
  width: 250px;
  height: 350px;
  background: #658071;
  border-radius:10px 10px 10px 10px;
  float: left;
  margin-left: 100px;
}
.book_1{
  width: 120px;
  height: 187px;
  float: left;
  margin-left:20px;
  margin-top:25px;
  margin-right:30px;

}
.book_1 img{
  width: 120px;
  height: 140px;
  box-shadow:4px 4px 4px #4F4F4F;
  border-radius:7px 7px 7px 7px;
}
#userDiv{ 
	 display: none;
     position: absolute;
     top: 0%;  left: 0%;  width: 100%;  height: 100%;
     background-color:rgb(28,28,28,.7) ;  z-index:1001;
     -moz-opacity: 0.7; filter: alpha(opacity=70);
}
#alterUser{
  width: 400px;
  height: 500px;
  margin-left:550px;
  margin-top:150px;
  background: #E8E8E8;
   z-index:1001;
}
</style>
<script>
$(document).ready(function(){
	getBookcase();
	
});

function getBookcase() {
	$('#bookBox').html("");
	$.ajax({
		type : 'POST',
		data : {
			userId : $('#userId').text()
		},
		url : '${pageContext.request.contextPath}/getBookBox',
		contentType:"application/x-www-form-urlencoded",
		async:true,
		datatype:"json",
		success : function(data) {	
			var result =  data;
			var userId = result.userId;
			var bookList = result.bookList;
			$.each(bookList,function(i,bookcase){
				var book = bookcase.book;
				$('#bookBox').append('<div class=\"book_1\"><a href=\"getchapterContent/'+book.bookId+'/'+bookcase.chapterNumber+'\"><img src=\"'+book.bookPicture+'\"></img></a><button  class=\"layui-btn\" onclick=\"removeBookInBox('+book.bookId+','+userId+')\" style=\"margin-top:5px;width: 120px;cursor:pointer;\">移除图书</button></div>');
			});			
		},
		error : function(){
		}
	});
}

function closeDiv(id) {
	$("#"+id+"").slideUp();
}

function openRevertDiv(id) {
	$("#"+id+"").slideDown();
}

function removeBookInBox(bookId,userId) {
	$.ajax({
		type : 'POST',
		data : {
			bookId : bookId,
			userId : userId
		},
		url : '${pageContext.request.contextPath}/removeBookInBox',
		contentType:"application/x-www-form-urlencoded",
		async:true,
		datatype:"json",
		success : function(data) {	
			var result =  data;
			layer.msg(result.msg);
			getBookcase();
		},
		error : function(){
			layer.msg("除移图书失败");
		}
	});
}

layui.use(['form', 'jquery', 'laydate'], function(){
	  var form = layui.form
	  ,layer = layui.layer
	  ,layedit = layui.layedit
	  ,laydate = layui.laydate;


	  //监听提交
	  form.on('submit(alterUser)', function(data){
	    layui.use('jquery',function(){
	      var $=layui.$;
	      $.ajax({
	  		type : 'POST',
	  		data : $('#userFrom').serializeArray(),
	  		url : '${pageContext.request.contextPath}/alterUser',
	  		contentType:"application/x-www-form-urlencoded",
	  		async:true,
	  		success : function(data) {		
	  			var status = data.status;
	  			if(status == '1'){
	  				layer.msg(data.msg);
	  				setTimeout(function () {
                        window.location.reload();
                    }, 1500);

	  			}else
	  				layer.msg(data.msg);  			
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

</script>
</head>
<body>
   <div id="userDiv">
     <div id="alterUser">
           <form class="layui-form" id="userFrom" action="">                            
                <input type="hidden" name="userid" value="${user.userid }"></input>
                <div class="layui-field-box" style="font-size: 20px;margin-bottom: 20px">
                                 用户信息修改
                  <span onclick="closeDiv('userDiv')" style="cursor:pointer;font-size: 27px;color:#363636;margin-left: 17px;float: right;"><i style="font-size: 27px;color:#363636;" class="layui-icon">&#x1006;</i></span>
                  <hr class="layui-bg-red" style="height: 3px"/>
                </div>
                <div class="layui-form-item">
                  <label class="layui-form-label"><i class="layui-icon" style="font-size: 25px;margin-left:50px;float: left;">&#xe66f;</i></label>
                  <div class="layui-input-block">
                    <input type="text" name="userName" id="userName" style="float: left;width: 230px;" required lay-verify="required" placeholder="原昵称：${user.userName }" autocomplete="off" class="layui-input"/>
                  </div>
                </div>
                <div class="layui-form-item">
                  <label class="layui-form-label"><i class="layui-icon" style="font-size: 25px;margin-left:50px;float: left;">&#xe673;</i></label>
                  <div class="layui-input-block">
                    <input type="password" name="password" id="password" style="float: left;width: 230px;" required lay-verify="required" placeholder="请输入需要修改密码" autocomplete="off" class="layui-input"/>
                  </div>
                </div>
                <div class="layui-form-item">
                   <label class="layui-form-label">性别</label>
                   <div class="layui-input-block">
				      <input type="radio" name="userSex" value="男" title="男"/>
				      <input type="radio" name="userSex" value="女" title="女" checked/>
				   </div>
               </div>
               <div class="layui-form-item layui-form-text">
                   <label class="layui-form-label">个性签名</label>
                   <div class="layui-input-block">
                      <textarea name="remark" placeholder="旧：${user.remark }" class="layui-textarea" style="width: 250px;height: 50px"></textarea>
                   </div>
               </div>    
                <button class="layui-btn" lay-submit lay-filter="alterUser" style="margin-left: 80px; width: 250px;margin-top: 30px">修 改</button>        
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
               <dd><a href="${pageContext.request.contextPath}/logout">退了</a></dd>
              </dl>
             </c:if>
             
          </li>
         </ul>
       </div>
       
       <div style="display: none;">
            <span id="userId">${user.userid }</span>
       </div>   
         
       <div id="chapterBody">
	       <div id="bodyHead">
	           <ur>
	              <li style="width: 100%;height:40px;"> 
	                <span style="color: #646f6f;font-size: 15px;margin-left: 5px;">当前位置：&nbsp;<a href="#" style="color: #e06012">首页</a>&nbsp;&nbsp;&gt;<a href="${pageContext.request.contextPath}/toUserCenter/${user.userid}">&nbsp;&nbsp;个人中心</a></span>
	                <hr class="layui-bg-black"/>
	              </li>              
	           </ur>         
	       </div>       
	       <div id="body1">
		      <div id="userContent">
		             <ul>
			              <li style="margin-left: 80px;margin-top: 40px">
			                 <img src="${user.photo }" style="width: 90px;height: 90px" class="layui-nav-img"/>
			              </li>
			              <li style="margin-left: 95px;margin-top: 3px"><span class="layui-badge layui-bg-orang">${user.userLevel }</span></li>
			              <li style="line-height: 40px;margin-top: 2px;font-weight: bold;font-size:17px;color: 	#363636"><div style="width:150px;text-align:center;display: block;margin:0 auto;">${user.userName}</div></li>
		                  <li style="height: 90px;margin-top: 15px;"><div style="width: 230px;margin:0 auto;">个性签名：&nbsp;&nbsp;${user.remark}</div></li>		                   		                     	                  
		             </ul>	
		             <button class="layui-btn layui-btn-radius" onclick="openRevertDiv('userDiv')" style="margin-top:5px;width: 120px;cursor:pointer;margin-left: 60px">修改个人信息</button>             
		     </div>	          	          
		     <div id="bookBox">           
		     </div>          			  
	      </div>
         
       </div>
         
       </div>
       <div id="bottom" style="background: 	#2F4F4F; width: 100%;height: 200px;margin-top: 3px;"></div>
   </div>
 
</body>
</html>