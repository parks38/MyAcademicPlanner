<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var = "userID" value = "${sessionScope.userID}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.1.1.js"
  integrity="sha256-16cdPddA6VdVInumRGo6IbivbERE8p7CQR3HzTBuELA="
  crossorigin="anonymous"></script>
        <!-- JQUERY -->
      <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/daily.css" type="text/css" />

</head>
<body>
    <%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	
	%>
<div class="container-form">
		<form action="${contextPath}/userinfo/addStatus.do" id="wizard" method = "post" name = "form" enctype="multipart/form-data">
        <input type = "hidden" name = "userid" value = "${sessionScope.userID }" >
          <!-- SECTION 1 -->
          <h2></h2>
          <section>
            <div class="inner">
              <div class="form-content">
              
                <div class="form-header">
                  <h3>오늘의 출결 내용 :</h3>
                </div>
                <p>오늘의 정보를 입력해 주세요</p>

                <div class="form-row">
                  <div  class="form-holder" style="align-self: flex-end; transform: translateY(4px)" >
                   
                    <label> <b>오늘의 출석 현황 : </b></label> <br /> <br />
                    <div class="checkbox-tick">
                      <label class="attend">
                        <input type="radio"  name="attend"   value="출석"   checked /> 출석 완료 <br />
                        <span class="checkmark"></span>
                      </label>
                      <label class="early_leave">
                        <input type="radio" name="attend" value="조퇴" /> 조퇴
                        <br />
                        <span class="checkmark"></span>
                      </label>
                      <label class="late">
                        <input type="radio" name="attend" value="지각" /> 지각
                        <br />
                        <span class="checkmark"></span>
                      </label>
                      <label class="late">
                        <input type="radio" name="attend" value="결석" /> 결석
                        <br />
                        <span class="checkmark"></span>
                      </label>
                    </div>
                    <br />

                    <label> <b>오늘의 집중도: </b></label> <br /> <br />
                    <div class="checkbox-tick">
                      <label class="low">
                        <input type="radio" name="concentration"  value="low" checked /> 하 <br />
                        <span class="checkmark"></span>
                      </label>
                      <label class="low-mid">
                        <input type="radio" name="concentration" value="low-mid" />
                        중-하
                        <br />
                        <span class="checkmark"></span>
                      </label>
                      <label class="mid">
                        <input type="radio" name="concentration" value="mid" /> 중
                        <br />
                        <span class="checkmark"></span>
                      </label>
                      <label class="mid-high">
                        <input type="radio" name="concentration" value="mid-high" />
                        중-상
                        <br />
                        <span class="checkmark"></span>
                      </label>
                      <label class="high">
                        <input type="radio" name="concentration" value="high" /> 상
                        <br />
                        <span class="checkmark"></span>
                      </label>
                    </div>
                  </div>
                </div>

                <div class="checkbox-circle">
                  <br />
                  <label>
                    자가 진단임으로 실제 출석과 오차가 있을수 있습니다.
                  </label>
                </div>
              </div>
            </div>
          </section>

          <!-- SECTION 2 -->
          <h2></h2>
          <section>
            <div class="inner">
              <div class="form-content">
                <div class="form-header">
                  <h3>오늘 업로드 할 내용:</h3>
                </div>
                <p>올리실 정보를 입력해 주세요</p>

                <div class="form-row">
                  <div class="form-holder w-100">
                    파일1: <input type="file" name="file1" /><br /> <br />
                    파일2: <input type="file" name="file2" /><br /> <br />
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-holder w-100">
                    <label class = "label" for="subject"> 내용 : </label> <br /> <br>
                    <textarea  name="content"   id=""  placeholder="파일과 함께 업드로드할 댓글 입력하세요!"  class="form-control"  style="height: 150px; width: 400px;" ></textarea>
                  </div>
                </div>
              </div>
            </div>
          </section>

          <!-- SECTION 3 -->
          <h2></h2>
          <section>
            <div class="inner">
              <div class="form-content">
                <div class="form-header">
                  <h3>오늘 등록 완료</h3>
                </div>
                <p>${sessionScope.userID } 님의 정보를 제출하시겠습니까?</p>

                <div class="form-row">
              		<img class = "logo" style = "width:200px;" src = "${pageContext.request.contextPath}/image/logo.png"/>
                </div>
                <button class="submit"> 제출 &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;<i class="fa fa-check" style="font-size:17px"></i></button>
              </div>
            </div>
          </section>
          </form>
          
           <!-- wrapper class end -->
      <!-- JQUERY STEP -->
      <script src="${pageContext.request.contextPath}/js/jquery.steps.js"></script>
      <script src="${pageContext.request.contextPath}/js/main.js"></script>
      <!-- Template created and distributed by Colorlib -->
      <!-- Box 3 -->


	</div>

</body>
</html>