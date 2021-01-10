<%@page import="UserInfo.UserInfoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored = "false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "java.io.*,java.util.*, java.text.*" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%> 
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>마이 플래너</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- STYLE CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css" charset="utf-8"/>    
<!-- JQUERY -->
      <script
		  src="https://code.jquery.com/jquery-3.1.1.js"
		  integrity="sha256-16cdPddA6VdVInumRGo6IbivbERE8p7CQR3HzTBuELA="
		  crossorigin="anonymous"></script>
        <!-- JQUERY -->
    <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>

  </head>
  <body>
    <%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	
	%>
  <!-- header -->
    <header>
      <div class="container">
        <div class="logo">
          <img style="width: 125px; height: 135px" src="${pageContext.request.contextPath}/image/logo.png" />
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
          <li class="active"><a href="${pageContext.request.contextPath}/userinfo/view.do?userid=${sessionScope.userID}"> 나의 현황</a></li>
          <li ><a href="${pageContext.request.contextPath}/boards/listArticles.do">나만의 노트</a></li>
          <li >  <a href="${pageContext.request.contextPath}/calendar.jsp">달력</a></li>
          <li > <a href="${pageContext.request.contextPath}/users/viewMember.do">학생 정보 </a> </li>
        </ul>
      </div>
    </nav>
    <!-- //nav -->
    <div class="main">
      <div class="wrapper">
        
        <!-- 오늘 모두 제출 시  -->
   		<div id = "wizard">
        <div class="inner">
              <div class="form-content">
                <div class="form-header">
                  <h3>오늘 등록 완료</h3>
                  <div class = "info"> <span>${sessionScope.userID } 님! </span> 오늘의 정보입니다. </div>
                  <div class="form-holder w-100">
                  	<table class = "printinfo">
                  		<tr>
                  			<th><p>오늘의 출결 : &nbsp;</p> </th>
                  			<th>${userInfo.attendance } &nbsp; &nbsp;</th>
                  			<th> <p>오늘의 집중도 : &nbsp;</p>  </th>
                  			<th> ${userInfo.concentration} </th>
                  		</tr>
                  	</table>
                    <p>오늘의 노트 메세지 : </p>
                    <div>${userInfo.content }</div>
                    <p> 최근 완료한 일:</p>
                    <div>
                    	<c:choose>
                    		<c:when test = "${doneList == null} }" >
                    			<div> 오늘 일을 끝내보세요!!</div>
                    		</c:when>
                    		<c:when test = "${doneList.size() < 5} }" >
                    			<c:forEach var = "done" items = "${doneList }">
                    				<div class = "doneStyle"> ${done.todolist }</div>
                    			</c:forEach>
                    		</c:when>
                    		<c:otherwise>
                    			<c:forEach var = "done" begin = "${ doneList.size()-5}" end = "${ doneList.size()}" items = "${doneList }">
                    				<div> *  ${done.todolist } *</div> <br>
                    			</c:forEach>
                    		</c:otherwise>
                    	</c:choose>
                    </div>
                  </div>
                </div>
               </div>
             </div>
          </div>
       
        
        
        
        <div class="split_two">
          <!-- Box 2 -->
          <div class="wrapper2">
            <h3> 현재 진행 상태 :</h3><br><br />
            <label style= "color:black;">  출석률 : </label> <br /> <br>
 			<img width='250px' height='230px' id='canvas' src="${pageContext.request.contextPath}/image/s1.png" ></img> <br><br>
            <label style= "color:black;"> 집중력 : </label> <br>
            <img width='270px' height='250px' id='canvas' src="${pageContext.request.contextPath}/image/s2.png" ></img> <br>
          </div>

          <!-- Box 3 -->
          <div class="wrapper3">
            <div class="row">
              <div class="intro col-12">
                <h1>To Do 리스트 :</h1>
                <div>
                  <div class="border1"></div>
                </div>
              </div>
            </div>

            <div class="row">
              <div class="helpText col-12">
                <p id="first">
                  끝내야 하는 일의 목록을 적어주어. 
                </p>
                <p id="second" >생산성 있게 업무 관리를 하세요 </p>
                <p id="third">
                  일정 목록을 자주 체크하여 할일에 집중해보세요  </p>
              </div>
            </div>

            <div class="row">
              <div class="col-12">
              <form  method = "post" action="${contextPath}/userinfo/addtodolist.do">
              	<input type = "hidden" name = "userid" value = "${sessionScope.userID }">
              	<input type = "hidden" name = "content" value = "todolist">
                <input id="userInput"  name = "userInput" type="text"  placeholder="할일 입력..." maxlength="27" />
                <button id="enter">
                  <i class="fas fa-pencil-alt"></i>
                </button>
                </form>
              </div>
            </div>

            <!-- Empty List -->
            <div class="row">
              <div class="listItems col-12">
              
              <c:choose>
              	<c:when test = "${doList != null}">
              		<c:forEach var = "todo" items = "${doList }" >
              			<table class = "to_table">
              				<tr class = "list_t">
              					<td width = "300px"> ${todo.todolist } </td>
              					<td> <a  style = "color: #658dc6;" href = "${pageContext.request.contextPath}/userinfo/removetodo.do?todolist=${todo.todolist}&userid=${sessionScope.userID}"> X  &nbsp;</a></td>
              					<td> <a style = "color: green;" href = "${pageContext.request.contextPath}/userinfo/donetodo.do?todolist=${todo.todolist}&userid=${sessionScope.userID}"> <i class="fa fa-check" style="font-size:10px"></i> </a></td> 
              				</tr>
              			</table>
              		</c:forEach>
              	</c:when>
              </c:choose>
              </div>
            </div>
          </div>
        </div>
       
      </div>
      <!-- wrapper class end -->
      <!-- JQUERY STEP -->
      <script src="${pageContext.request.contextPath}/js/jquery.steps.js"></script>
      <script src="${pageContext.request.contextPath}/js/main.js"></script>
      <!-- Template created and distributed by Colorlib -->
    <!-- canvas  -->
      <script src="${pageContext.request.contextPath}/js/percentage.js"></script>

    </div>
  </body>
</html>


    
