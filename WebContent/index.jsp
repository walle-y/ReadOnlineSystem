<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 导入Springmvc的表单标签库 -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Reader在线阅读平台首页</title>
<link rel="stylesheet" type="text/css" href="layui/css/layui.css"/>
<link rel="stylesheet" type="text/css" href="css/style.css"/>
<script src="js/jquery.js" type="text/javascript"></script>
<script src="layui/layui.js" type="text/javascript"></script>
<script>
$(document).ready(function(){
	$("#navigationBar ul li").mouseover(function() {
		$(this).css("background-color","#6c6669")
		var li_value = $(this).attr("value")
		$('#second').css("display","none")
			$('#li1').css("display","none")
			$('#li2').css("display","none")
			$('#li3').css("display","none")
			$('#li4').css("display","none")
			$('#li5').css("display","none")
			$('#li6').css("display","none")
		if(li_value == 'li1'){			
			$('#second').css("display","block")
			$('#li1').css("display","block")			
		}else if(li_value == 'li2'){			
			$('#second').css("display","block")
			$('#li2').css("display","block")			
		}else if(li_value == 'li3'){			
			$('#second').css("display","block")
			$('#li3').css("display","block")			
		}else if(li_value == 'li4'){			
			$('#second').css("display","block")
			$('#li4').css("display","block")			
		}else if(li_value == 'li5'){			
			$('#second').css("display","block")
			$('#li5').css("display","block")			
		}else if(li_value == 'li6'){			
			$('#second').css("display","block")
			$('#li6').css("display","block")			
		}
	});
	$("#navigationBar ul li").mouseout(function(e){
	    $(this).css("background-color","");	 
	   
	  });
	
	$("#navigationBar").mouseleave(function(e){
		 var x=parseInt(e.pageX)
	     var y=parseInt(e.pageY)
	     if(x<241 || x>1103 || y<111 || y>490){
	    	 $('#second').css("display","none")
			 $('#li1').css("display","none")
			 $('#li2').css("display","none")
			 $('#li3').css("display","none")
			 $('#li4').css("display","none")
			 $('#li5').css("display","none")
			 $('#li6').css("display","none")
	     }	    	 	 
	  });
	  $("#second").mouseleave(function(e){
			 var x=parseInt(e.pageX)
		     var y=parseInt(e.pageY)
		     if(x<241 || x>1100 || y<111 || y>490){
		    	 $('#second').css("display","none")
				 $('#li1').css("display","none")
				 $('#li2').css("display","none")
				 $('#li3').css("display","none")
				 $('#li4').css("display","none")
				 $('#li5').css("display","none")
				 $('#li6').css("display","none")
		     }	    	 	 
		  });
	  getbody("body3content");
	  getbody("body2content");	 
	  getbody("body5content");
	  getBookType();
	  getAuthor();
	  getRecommend();
});

function getbody(bodyName){//初始化body2内容，然后重新加载
	var bodyNumber;
	if(bodyName == "body2content")
		bodyNumber = "1";
	else  if(bodyName == "body3content")
		bodyNumber = "2";
	else  if(bodyName == "body5content")
		bodyNumber = "3";
	
	$('#'+bodyName+' ul').html("");
	$.ajax({
		type : 'POST',
		data : {
			bodyNumber : bodyNumber
		},
		url : '${pageContext.request.contextPath}/getBookByNumber',
		contentType:"application/x-www-form-urlencoded",
		async:true,
		datatype:"json",
		success : function(data) {
			var result =  data;
			var books = result.books;			
			$.each(books,function(i,book){
				    var typeIdList = book.typeIdList;
					var types = typeIdList.split('#');
					var liId = bodyName+"_li_"+i;
				   $("#"+bodyName+" ul").append('<li>'+
                           '<div style="margin-left: 30px;margin-top: 10px">'+
	                           '<a href=\"getBook/'+book.bookId+'\"><img src=\"'+book.bookPicture+'\" width=\"140px\" height=\"170px\"></img></a>'+
	                           '<div> 书名：&nbsp;&nbsp;'+book.bookName+'</div>'+
	                           '<div id=\"'+liId+'\">  标签：'+
		                        '</div>'+
			                   '<div> 作者：<a href=\"getBookByAuthor/'+book.authorVO.authorId+'\">&nbsp;&nbsp;'+book.authorVO.authorName+'</a></div>'+
                           '</div>'+                            
                    '</li>');	
				   $.each(types,function(a,type){
					   $("#"+liId+"").append('<span class=\"layui-badge layui-bg-green\" style=\"margin-left: 4px;\">'+type+'</span>');
				   });
			   });				
		},
		error : function(){
		}
	});
}

function getRecommend() {
	$('#recommendBooks ul').html("");
	$.ajax({
		type : 'POST',
		data : {
			bodyNumber : '0'
		},
		url : '${pageContext.request.contextPath}/getBookByNumber',
		contentType:"application/x-www-form-urlencoded",
		async:true,
		datatype:"json",
		success : function(data) {
			var result =  data;
			var books = result.books;			
			$.each(books,function(i,book){				    
				   $("#recommendBooks ul").append('<li>'+
				     '<div class=\"layui-anim layui-anim-scale\">'+
				        '<a href=\"getBook/'+book.bookId+'\"><img src=\"'+book.bookPicture+'\" width=\"100px\" height=\"110px\"></img></a>'+
				      '</div></li>');					  
			   });				
		},
		error : function(){
		}
	});
}

function getBookType() {
	$.ajax({
		type : 'POST',
		data : {},
		url : '${pageContext.request.contextPath}/getBookType',
		contentType:"application/x-www-form-urlencoded",
		async:true,
		success : function(data) {		
			var result =  data;
			var typeList = result.typeList;
			$.each(typeList,function(i,type){
				$('#li1 dl dd').append('<a href=\"${pageContext.request.contextPath}/getBookByType/'+type.typeName+'\">'+type.typeName+'</a>');
			});
		},
		error : function(){
			
		}
	}); 
	return false;
}

function getAuthor() {
	$.ajax({
		type : 'POST',
		data : {},
		url : '${pageContext.request.contextPath}/getAuthor',
		contentType:"application/x-www-form-urlencoded",
		async:true,
		success : function(data) {		
			var result =  data;
			var authorList = result.authorList;
			$.each(authorList,function(i,author){
				$('#li2 dl dd').append('<a href=\"${pageContext.request.contextPath}/getBookByAuthorId/'+author.authorId+'/'+author.authorName+'\">'+author.authorName+'</a>');
			});
		},
		error : function(){
			
		}
	}); 
	return false;
}

function userRegister() {
	$.ajax({
		type : 'POST',
		data : $('#registerFrom').serializeArray(),
		url : '${pageContext.request.contextPath}/userRegister',
		contentType:"application/x-www-form-urlencoded",
		async:true,
		success : function(data) {		
			layer.msg(data.msg);			
		},
		error : function(){
			layer.msg("登录失败");
		}
	}); 
	return false;
}

function closeDiv(id) {
	$("#"+id+"").slideUp();
}

function login(){
	$('#loginDiv').css("display","block");
	$('#loginBox').css("display","block");
}

function register(){
	$('#loginBox').css("display","none");
	$('#registerBox').css("display","block");
}

layui.use('element', function(){
	  var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块	  
	  //监听导航点击
	  element.on('nav(demo)', function(elem){
	    layer.msg(elem.text());
	  });
	});
layui.use('carousel', function(){
	  var carousel = layui.carousel;
	  //建造实例
	  carousel.render({
	    elem: '#scroll'
	    ,width: '100%' //设置容器宽度
	    ,arrow: 'hover' //始终显示箭头
	    ,anim: 'fade' //切换动画方式
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
	  			layer.msg(data.msg+"  进行自动登录..");
	  			var index = layer.load(0, {shade: false});
	  			$('#login_name').val(data.user.loginName);
	  			$('#login_passw').val(data.user.password);
	  			$('#userLogin').submit();
	  		},
	  		error : function(){
	  		}
	  	});   
	    }); 
	    return false;//禁止跳转，否则会提交两次，且页面会刷新
	  });
	});

</script>
</head>
<body> 
    <div style="display: none">
            <span id="userId">${user.userid }</span>
     </div>
    <div id="loginDiv">
        <div id="loginBox">
           <form class="layui-form" id="userLogin" action="userLogin">            
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
                <a href="${pageContext.request.contextPath}/toUserCenter/${user.userid}"><img src="image/2.jpg" class="layui-nav-img">我</a>
               <dl class="layui-nav-child">
                 <dd><a href="javascript:;">修改信息</a></dd>
                 <dd><a href="javascript:;">安全管理</a></dd>
                 <dd><a href="${pageContext.request.contextPath}/logout">退了</a></dd>
              </dl>
             </c:if>
             
          </li>
         </ul>
       </div>
       <div id="body">
           <div id="body1">
              <div id="body1Center">
                  <div id="navigationBar" class="navigationBar">
                     <ul>
                        <li value="li1"><span>作品分类<i class="layui-icon" style="margin-left: 15px;font-size: 25px; color: #9BCD9B;">&#xe656;</i></span></li>
                        <li value="li2"><span>作者专区<i class="layui-icon" style="margin-left: 15px;font-size: 25px; color: #8B7E66;">&#xe613;</i></span></li>
                        <li value="li3"><span>男生专区<i class="layui-icon" style="margin-left: 15px;font-size: 25px; color: #2E8B57;">&#xe662;</i></span></li>
                        <li value="li4"><span>女生专区<i class="layui-icon" style="margin-left: 15px;font-size: 25px; color: #FF6A6A;">&#xe661;</i></span></li>
                        <li value="li5"><span>杂志读物专区<i class="layui-icon" style="margin-left: 15px;font-size: 25px; color: #9BCD9B;">&#xe705;</i></span></li>
                        <li value="li6"><span>教育书籍专区<i class="layui-icon" style="margin-left: 15px;font-size: 25px; color: #698B69;">&#xe66c;</i></span></li>
                     </ul>
                  </div>
                  <div id="second" class="none">
                      <div id="li1" class="second_content none">
                         <dl>
                           <dt><a href="#" style="color: red;">分类</a></dt>
                           <dd>
                           </dd>
                         </dl>
                      </div>
                      <div id="li2" class="second_content none">
                         <dl>
                           <dt><a href="#" style="color: red;">作者</a></dt>
                           <dd>
                           </dd>
                         </dl>
                      </div>
                      <div id="li3" class="second_content none">
                         <dl>
                           <dt><a href="#" style="color: red;">男生分区</a></dt>
                           <dd>
                              <a href="${pageContext.request.contextPath}/getBookByType/玄幻">玄幻</a>
                              <a href="${pageContext.request.contextPath}/getBookByType/武侠">武侠</a>               
                           </dd>
                         </dl>
                      </div>
                      <div id="li4" class="second_content none">
                         <dl>
                           <dt><a href="#" style="color: red;">女生分区</a></dt>
                           <dd>
                              <a href="${pageContext.request.contextPath}/getBookByType/爱情">爱情</a>
                              <a href="${pageContext.request.contextPath}/getBookByType/童话">童话</a>                              
                           </dd>
                         </dl>
                      </div>
                      <div id="li5" class="second_content none">
                         <dl>
                           <dt><a href="#" style="color: red;">读物</a></dt>
                           <dd>
                              <a href="#">读者</a>
                              <a href="#">青年文摘</a>                             
                           </dd>
                         </dl>
                      </div>
                      <div id="li6" class="second_content none">
                         <dl>
                           <dt><a href="#" style="color: red;">教育</a></dt>
                           <dd>
                              <a href="#">马克思主义哲学</a>
                              <a href="#">毛泽东思想</a>                             
                           </dd>
                         </dl>
                      </div>
                  </div>
                  <div style="width: 788px;height: 400px;float: left;">
                     <div id="scroll"  class="layui-carousel">
						 <div carousel-item>
						   <div style="background: url('image/scroll3.jpg') no-repeat;"></div>
						   <div style="background: url('image/scroll1.jpg') no-repeat;"></div>
						   <div style="background: url('image/scroll4.jpg') no-repeat;"></div>
						 </div>                      
                    </div>
                    <div id="recommend">
                        <div style="float:left ;margin-top:15px;width: 100px;height: 35px; background-color:yellow;transform:rotate(10deg);color: #483D8B">
                           <center>小叶推荐</center>
                        </div>
                        <div id="recommendBooks" style="width:680px;height:120px;float: right;">
                           <ul>                              
                           </ul>
                        </div>
                    </div>
                  </div>
                  
              </div>
           </div>
           <div id="body2">
                     <div class="body2_tile" >
                           <center>科 | 幻 | 首 | 推</center>
                     </div>
                     <div id="body2content" class="body2_content">
                        <ul> </ul>
                   </div>
           </div>
           <div id="body3">
                    <div class="body2_tile" style="background: 	#90EE90">
                           <center>文 | 学 | 首 | 推</center>
                     </div>
                     <div id="body3content" class="body2_content">
                        <ul> </ul>
                   </div>
           </div> 
           <div id="body5" class="bodyStlye">
                    <div class="body2_tile" style="background: 	#90EE90">
                           <center>武 | 侠 | 首 | 推</center>
                     </div>
                     <div id="body5content" class="body2_content">
                        <ul> </ul>
                   </div>
           </div> 
                  
       </div>
       <div id="bottom" style="background: 	#2F4F4F; width: 100%;height: 200px;margin-top: 3px;"></div>
   </div>
 
</body>
</html>