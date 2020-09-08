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

<script>
$(document).ready(function(){
	getbody("likenessBox");
});

function download(bookId) {
	layer.confirm('确认下载吗?', function(index){	  
		 $('#a_download p').trigger('click') ;
		 layer.close(index);
		});
		
}

function getbody(bodyName){//初始化内容，然后重新加载
	var bodyNumber;		
	$('#'+bodyName+' ul').html("");
	$.ajax({
		type : 'POST',
		data : {
			bookId : $('#bookId').text()
		},
		url : '${pageContext.request.contextPath}/getLikenessBook',
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
                           '<div style="margin-left: 10px;margin-top: 10px">'+
	                           '<a href=\"getBook/'+book.bookId+'\"><img src=\"'+book.bookPicture+'\" width=\"100px\" height=\"130px\"></img></a>'+
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

function addtoBookCase(){
	var userId = $('#userId').text();
	if(userId == '' || userId == null){
		layer.msg("此功能值适用于登录用户，请先登录...")
		return false;
	}
	var starText = $('#starText').text();
	if(starText == "点亮红星收藏图书"){	
	$.ajax({
		type : 'POST',
		data : {
			userId : $('#userId').text(),
			bookId : $('#bookId').text()	
		},
		url : '${pageContext.request.contextPath}/addtoBookCase',
		contentType:"application/x-www-form-urlencoded",
		async:true,
		datatype:"json",
		success : function(data) {	
			var result =  data;
			layer.msg(result.msg);
			if(result.msg == '图书收藏成功！'){
				$('#starText').text("已收藏");
				$('#toBookcase').css("color","#d92b1c");
			}		
		},
		error : function(){
			layer.msg("收藏图书失败，可能该图书已被您收藏");
		}
	});
	}
}

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

function smoothscroll(){
    var currentScroll = document.documentElement.scrollTop || document.body.scrollTop;
    if (currentScroll > 0) {
         window.requestAnimationFrame(smoothscroll);
         window.scrollTo (0,currentScroll - (currentScroll/5));
    }
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

layui.use('rate', function(){
    var rate = layui.rate;
   
    var ins1 = rate.render({
      elem: '#starRate' , //绑定元素
      readonly : true,
      value : $('#starEvaluation').text(),
      text: false 
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
                <input type="hidden" name="page" value="bookDetail"/>
                <input type="hidden" name="bookId" value="${book.bookId }"/>
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
    <div style="display: none;">
        <span id="userId">${user.userid}</span>
        <span id="bookId">${book.bookId}</span>
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
       <div id="body4">
	       <div id="bookdetail">
	          <div id="book">
	             <div id="bookPhoto">
	               <img src="${book.bookPicture }" width="240px" height="290px"></img>
	             </div>
	             <span id="starEvaluation" style="display: none;">${book.starEvaluation}</span>
	             <div id="bookIntroduce">	              
	                  <ul>
		                  <li style="margin-top: 10px; height: 40px;"><span style="line-height: 40px;font-weight: bold;font-size:17px">${book.bookName }</span><i class="layui-icon" style="margin-left: 15px;margin-top:10px ;font-size: 24px; color:#38b331;">&#xe705;</i></li>
		                  <li style=" height: 20px;">
			                 <span style="float: left;">标签：</span><c:forEach items="${fn:split(book.typeIdList,'#')}" var="type">
		                        <span class="layui-badge layui-bg-green" style="margin-left: 10px;">${type}</span>
		                      </c:forEach>
		                  </li>		                  
		                  <li style="width:100% ;margin-bottom: 10px;">
		                     <span style="float: left;margin-top: 10px;">推荐级别：</span><div id="starRate"></div>
		                  </li>
	                      <li style="height: 200px;margin-bottom: 5px;">
	                         <span>&nbsp;&nbsp;${book.introduce }</span>
	                      </li>	                      
	                  </ul>
	               
	             </div>
	             <div id="readBox">
	               <a style="cursor:pointer;float: left;" title="选择章节开始阅读" href="${pageContext.request.contextPath}/getchapterContent/${book.bookId}/1"><button class="layui-btn" style="margin-left: 8px;margin-top:5px;width: 245px">开始阅读</button></a>
	               <a style="cursor:pointer;float: left;" href="${pageContext.request.contextPath}/getChapter/${book.bookId}"><button class="layui-btn layui-btn-primary" style="margin-left: 8px;margin-top:5px;width: 100px;border-color:#388BFF; ">查看章节</button></a>
	               <span style="cursor:pointer;float: left;margin-left: 15px" onclick="download()" ><i class="layui-icon" style="font-size: 40px;color: #2E8B57;">&#xe601;</i>下 载</span>
	              <a id="a_download" href="${pageContext.request.contextPath}/download/${book.bookId}" style="display: none;"><p>跳转</p></a>
	              
	              <div style="float: right;width: 40ox;height: 70px;">
	                    <a href="javascript:;" onclick="addtoBookCase()" style="margin-left: 10px;float: left;cursor:pointer;"><i id="toBookcase" class="layui-icon" style="font-size: 40px;color: #2E8B57;">&#xe67a;</i></a>
	                    <span id="starText" style="margin-top:16px;float: left;color: #2E8B57">点亮红星收藏图书</span>
	              </div>            
	                         
	             </div>
	          </div>
	          <div id="author">
	             <ul>
		              <li style="margin-left: 105px;margin-top: 40px">
		               <img src="${book.authorVO.authorPicture }" style="width: 90px;height: 90px" class="layui-nav-img"/>
		              </li>
		              <li style="margin-left: 120px;margin-top: 2px"><span class="layui-badge layui-bg-orang">知名作家</span></li>
		              <li style="line-height: 40px;margin-top: 2px;font-weight: bold;font-size:17px"><div style="width:90px;text-align:center;display: block;margin:0 auto;">${book.authorVO.authorName}</div></li>
	                  <li style="height: 200px;margin-top: 5px;"><div style="width: 250px;margin:0 auto;">&nbsp;&nbsp;${book.authorVO.authorIntroduce}</div></li>
	             </ul>	             
	          </div>	          			  
	       </div>   
	       <div id="likenessBox">
	          <div class="likenessBox_tile" >
                  <center>相 | 似 | 图 | 书 </center>
              </div>
              <div>
                  <ul>                    
                  </ul>
              </div>              
	      </div>      
       </div>
       
       
       
       <div id="bottom" style="background: 	#2F4F4F; width: 100%;height: 200px;margin-top: 3px;"></div>
   </div>
 
</body>
</html>

