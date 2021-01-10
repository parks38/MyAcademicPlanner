<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sign-up.css" type="text/css" 
       charset="utf-8"/>
<title>Insert title here</title>
</head>
<body>

<!--  sign-up form  -->
	<div class="container-form">
		<form method="post" action="${contextPath}/users/addMember.do" style="border: 3px solid white">
			<h2>회원 가입</h2>
			<p>회원가입을 위해 폼을 작성해 주세요.</p>
			<hr>
			<div class="block-form">
				<label for="userid"><b>아이디</b> </label> <br>
				 <input
					type="text" placeholder="user ID " name="userID" maxlength="20">
				<br> <label for="userPw"><b>비밀번호</b> </label> <br>
				<input type="password" placeholder="user password "
					name="userPassword" maxlength="20"> <br> 
					<label for="username"><b>이름</b> </label><br> 
					<input
					type="text" placeholder="user full name " name="userName"
					maxlength="20"> <br>

				<label for="usermail"><b>이메일</b> </label> <br> 
				<input
					type="email" placeholder="user email " name="userEmail"
					maxlength="20"> <br> 
				
				  <label for="course"><b>수강하는 강좌 :</b></label>
					  <select name="course" id="cars">
					    <option value=백엔드/서버>백엔드/ 서버</option>
					    <option value="웹 디자인/프로트앤드">웹 디자인/ 프로트앤드</option>
					    <option value="빅데이터">빅데이터</option>
					    <option value="단과반">단과반</option>
					  </select>
				
				</div>
				<input type="submit"value="회원 가입">
			    <footer>
			    	<a href = "login.jsp">로그인 하기 </a>
			    </footer>

			</form>


	</div>

</body>
</html>