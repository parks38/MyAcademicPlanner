<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />     
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">

<title>로그인</title>
</head>
<body>
	
<section class="wrapper">
<img class = "logo" src = "${pageContext.request.contextPath}/image/logo_login.png"/>
  <div class="content">
    <header>
      <h2>오늘도 접속한 당신은 성장하고 있습니다.</h2>
      
    </header>
    <section>
      <div class="social-login">
        <button><img src="https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg" alt="google" width="20"><span>Google</span></button>
        <button><img src="https://cdn.freebiesupply.com/logos/large/2x/facebook-2-logo-svg-vector.svg" alt="facebook" width="10"><span>Facebook</span></button>
      </div>
      <form method="post"   action="${contextPath}/users/login.do" class="login-form">
	        <div class="input-group">
		          <label for="username">아이디</label>
		          <input type="text" placeholder="Username" name = "username" id="username">
	        </div>
	        <div class="input-group">
		          <label for="password">비밀번호</label>
		          <input type="password" placeholder="Password" name = "password" id="password">
	        </div>
	        <div class="input-group">
	        	<button>로그인</button>
	        </div>
      </form>
    </section>
    <footer>
    	<a href = "sign-up.jsp">회원가입 </a>
        <a href = "" > 비밀번호 확인</a>
    </footer>
  </div>
</section>

</body>
</html>