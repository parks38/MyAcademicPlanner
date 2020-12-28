<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>  
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/write.css" type="text/css" charset="utf-8"/>
	   <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript">
      /* 업로드 하기 전 이미지 확인하기  */
      function readURL(input) {
        if (input.files && input.files[0]) {
          var reader = new FileReader();
          reader.onload = function (e) {
            $("#preview").attr("src", e.target.result);
          };
          /* 해당 파일의내용 읽어오기  */
          reader.readAsDataURL(input.files[0]);
        }
      }
      // BoardController -> /listArticles.do ( 게시판 목록으로 가기 )
      function backToList(obj) {
        obj.action = "${contextPath}/boards/listArticles.do";
        obj.submit();
      }
      
      function doOpenCheck(chk){
    	    var obj = document.getElementsByName("seen");
    	    for(var i=0; i<obj.length; i++){
    	        if(obj[i] != chk){
    	            obj[i].checked = false;
    	        }
    	    }
    	}

      $(document).ready(function () {
        var fileTarget = $(".filebox .upload-hidden");

        fileTarget.on("change", function () {
          if (window.FileReader) {
            var filename = $(this)[0].files[0].name;
          } else {
            var filename = $(this).val().split("/").pop().split("/").pop();
          }

          $(this).siblings(".upload-name").val(filename);
        });
      });
    </script>    
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
          <li><a href="sign-up.jsp">회원가입</a></li>
          <li><a href="login.jsp">로그인</a></li>
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
          <li class="active"><a href="index.html"> 나의 현황</a></li>
          <li><a href="galary.jsp">나만의 노트</a></li>
          <li class="dropBox">
            <a href="calendar.html">달력</a>
          </li>
          <li class="dropBox">
            <a href="student_list.html">학생 정보 </a>
          </li>
        </ul>
      </div>
    </nav>
    <!-- //nav -->
    <!-- container -->
    <div class="widget-post" aria-labelledby="post-header-title">
      <div class="widget-post__header">
        <h2 class="widget-post__title" id="post-header-title">
          <i class="fa fa-pencil" aria-hidden="true"></i>
          write post
        </h2>
      </div>
      <form id="widget-form" class="widget-post__form" method="post" name="bbs_form" action="${contextPath}/boards/addArticles.do" enctype="multipart/form-data">
        <input type = "hidden" name = "userid" value  = " <%=userID %>" >
        
        <div class="widget-post__content">
          <label for="post-content" class="sr-only">오늘의 자료를 업로드하세요 </label>
          <tr>
            <br />
            <td align="right">
              <label class="bbs_title"> <b>글 제목</b></label>
            </td>
            <td colspan="2">
              <input
                class="post-title"
                type="text"
                size="67"
                maxlength="500"
                name="title"
              />
            </td>
            <br /><br />
          </tr>
          <tr>
            <td>
              <label class="bbs_content"> <b>글 내용 </b></label>
            </td>
            <br />
            <textarea
              name="content"
              id="post-content"
              class="widget-post__textarea scroller"
              placeholder="share your moments"
            ></textarea>
          </tr>
          <div class="filebox">
            <label class="attachment_btns" for="ex_filename">업로드</label>
            <input type="file" id="ex_filename" name = "file" class="upload-hidden" />
            <input class="upload-name" value="파일선택" disabled="disabled" />
            <tr>
              <td align="right">
                <label for="imageFile" class="attachment_btns">
                  이미지 업로드
                </label>
              </td>
              <!-- readURL - 업로드전 이미지 화인  -->
              <td>
                <input
                  type="file"
                  id="imageFile"
                  name="imageFileName"
                  accept="image/png, image/jpeg, image/jpg"
                  multiple
                  onchange="readURL(this);"
                />
              </td>
              <td align="right">
                <img
                  id="preview"
                  class="preview"
                  src="${pageContext.request.contextPath}/image/preview.png"
                  width="200"
                  height="200"
                />
              </td>
            </tr>
          </div>
        </div>
                <div class="widget-post__actions post--actions">
          <div class="post-actions__attachments">
            <label class="seen--btn">
              <input type="checkbox" name="seen" value="공개" onclick="doOpenCheck(this);" checked/> 공개

            </label>
            <label class="seen--btn">
              <input type="checkbox" name="seen" value="비공개" onclick="doOpenCheck(this);" /> 비공개
            </label>
          </div>
          <div class="post-actions__widget">
            <button class="btn post-actions__publish" onClick="backToList(this.form)">돌아가기</button>
            <input type = "submit" class="btn post-actions__publish" value = "업로드하기" />
          </div>
        </div>
      </form>
    </div>
  </body>
</html>
