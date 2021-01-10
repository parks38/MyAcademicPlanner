<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var = "userID" value = "${sessionScope.userID}" />
<%
  request.setCharacterEncoding("UTF-8");
%>  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student.css" />

</head>
<body>
    <%
	// 로그인이 된 경우 
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	%>
  <!-- header -->
    <header>
      <div class="container">
        <div class="logo">
          <img style="width: 150px; height: 150px" src="${pageContext.request.contextPath}/image/logo.png" />
        </div>
        <%
            //로그인 되어있지 않을 경우
            if(userID == null) {
        %>
        <ul class="sidemenu">
          <li><a href="${pageContext.request.contextPath}/sign-up.jsp">회원가입</a></li>
          <li><a href="${pageContext.request.contextPath}/login.jsp">로그인</a></li>
        </ul>
        <%
            } else {
        %>
         <ul class="sidemenu">
          <li><a href=""> <%= userID %> 님</a></li>
          <li><a href="${pageContext.request.contextPath}/users/logout.do"> 로그아웃 </a></li>
        </ul>       
        <%
            }
        %>
      </div>
    </header>
    <!-- //header -->

    <!-- nav --------------------------------------------- -->
    <nav>
      <div class="container">
        <ul class="leftMenu">
          <li ><a href="${pageContext.request.contextPath}/boards/index.do"> 나의 현황</a></li>
          <li class="active"><a href="${pageContext.request.contextPath}/boards/listArticles.do">나만의 노트</a></li>
          <li class="dropBox">
            <a href="${pageContext.request.contextPath}/calendar.jsp">달력</a>
          </li>
          <li class="active"><a href="${pageContext.request.contextPath}/users/viewMember.do">학생 정보 </a></li>
        </ul>
      </div>
    </nav>
    <!-- //nav -->
        
         <div class = "contianertable">
                <table style = "text-align: center;">
                    <thead> <!--테이블의 속성을 알려준다 -->
                        <tr> <!-- 행: 한줄 -->
                            <th style = "background-color: #B5c7d3; text-align : center; width: 100px;"> 아이디 </th>
                            <th style = "background-color: #B5c7d3; text-align : center; width: 100px;">이름</th>
                            <th style = "background-color: #B5c7d3; text-align : center; width: 300px;;"> 수강 강좌   </th>
                            <th style = "background-color: #B5c7d3; text-align : center; width: 500px;"> 이메일  </th>
                            <th style = "background-color: #B5c7d3; text-align : center; width: 150px;"> 가입  </th>
                        </tr>
                    </thead>
                    <tbody>
					<c:choose>
					  <c:when test="${memberList ==null }" >
					    <tr  height="10">
					      <td colspan="4">
					         <p align="center">
					            <b><span style="font-size:9pt;">등록된 글이 없습니다.</span></b>
					        </p>
					      </td>  
					    </tr>
					  </c:when>
					  
					  <c:when test="${memberList != null}" >
					    <c:forEach  var="member" items="${memberList }" >  
	                            <tr align = "center"> <!-- 계시글 출력  현재의 index 의 정보 -->
	                                <td>${member.userid}</td>
	                                <td>${member.name}</td>
	                                <td>${member.mycourse}</td>
	                                <td>${member.email }</td>
	                                <td> ${ member.joinDate} </td>
	                               
	                            </tr>
                            </c:forEach> 
					  </c:when>
					</c:choose>
                  </tbody>
               </table>
       </div>
       
    </body>
</body>
</html>