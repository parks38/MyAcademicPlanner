<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/view.css" />
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
   <script type="text/javascript" >
   
   	function goBack() {
	   window.history.back();
	 }
   	
     function backToList(obj){
	    obj.action="${contextPath}/boards/listArticles.do";
	    obj.submit();
     }
     
     function fn_comment(obj){
    	 obj.action = "${contextPath}/boards/addComment.do";
    	 obj.submit();
     }
 
	 function fn_enable(obj){
		 document.getElementById("i_title").disabled=false;
		 document.getElementById("i_title").style.border ="#00A2ED 2px solid";
		 document.getElementById("i_title").style.borderRadius ="10px";
		 document.getElementById("i_content").disabled=false;
		 document.getElementById("i_content").style.border ="#00A2ED 2px solid";
		 document.getElementById("i_FileName").disabled=false;
		 document.getElementById("i_FileName").style.border ="#00A2ED 2px solid";
		 document.getElementById("i_FileName").style.borderRadius ="10px";
		 document.getElementById("tr_btn_modify").style.display="block";
		 document.getElementById("tr_btn").style.display="none";
		 document.getElementById("textarea").style.border = "1ps solid #C0C0C0";
	 }
	 
	 function fn_modify_article(obj){
		 obj.action="${contextPath}/boards/modArticle.do";
		 obj.submit();
	 }
	 
	 function fn_remove_article(url,bbs_num){
		 var form = document.createElement("form");
		 form.setAttribute("method", "post");
		 form.setAttribute("action", url);
	     var articleNOInput = document.createElement("input");
	     articleNOInput.setAttribute("type","hidden");
	     articleNOInput.setAttribute("name","bbs_num");
	     articleNOInput.setAttribute("value", bbs_num);
		 
	     form.appendChild(articleNOInput);
	     document.body.appendChild(form);
	     form.submit();
	 
	 }
	 
	 
	 function readURL(input) {
	     if (input.files && input.files[0]) {
	         var reader = new FileReader();
	         reader.onload = function (e) {
	             $('#preview').attr('src', e.target.result);
	         }
	         reader.readAsDataURL(input.files[0]);
	     }
     } 
	 
	 function removeComment(url, bbs_commentNO, parentNO) {
		 var form = document.createElement("form");
		 form.setAttribute("method", "post");
		 form.setAttribute("action", url);
	     var articleNOInput = document.createElement("input");
	     articleNOInput.setAttribute("type","hidden");
	     articleNOInput.setAttribute("name","bbs_commentNO");
	     articleNOInput.setAttribute("value", bbs_commentNO);
	     
	     var bbs_numInout = document.createElement("input");
	     articleNOInput.setAttribute("type","hidden");
	     articleNOInput.setAttribute("name","bbs_num");
	     articleNOInput.setAttribute("value", parentNO);
		 
	     form.appendChild(articleNOInput);
	     form.appendChild(bbs_numInout);
	     document.body.appendChild(form);
	     form.submit();
	 }
    


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
    </header>
    <!-- //header -->


    <!-- nav --------------------------------------------- -->
    <nav>
      <div class="container">
        <ul class="leftMenu">
          <li><a href="${pageContext.request.contextPath}/index.jsp"> 나의 현황</a></li>
          <li class="active" ><a href="${pageContext.request.contextPath}/boards/listArticles.do">나만의 노트</a></li>
          <li class="dropBox">
            <a href="${pageContext.request.contextPath}/calendar.jsp">달력</a>
          </li>
          <li class="dropBox">
            <a href="${pageContext.request.contextPath}/student_list.jsp">학생 정보 </a>
          </li>
        </ul>
      </div>
    </nav>
    <!-- //nav -->

    <!-- container -->
    <div class="body">

      <div class="box2">
        <div class="widget-post__header">
          <h2 class="widget-post__title" id="post-header-title">
            <i class="fa fa-pencil" aria-hidden="true"></i>
            게시글
          </h2>
        </div>
        <div class="widget-post__content">
          <form name= "frmArticle" method="post"  action="${contextPath}"  enctype="multipart/form-data">
            <table width="90%"> 
                <tr> 
                    <td  width="0">&nbsp;</td> 
                    <td align="center" width="120"><b>제목</b></td> 
                    <td><input type=text value="${article.bbs_title }"  name="title"  id="i_title" disabled /></td>	
                    <td align="left" width="120"><b>글쓴이</b></td> 
                    <td><input type=text value="${article.userid }" name="userid"  disabled /></td> 
                </tr> 
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="5" width="100%">
                    </td>
                </tr> 
 
                <tr> 
                    <td width="0">&nbsp;</td> 
                    <td align="center" width="120"><b>글 번호</b></td> 
                     <td><input type="text"  name="bbs_num" value="${article.bbs_num }"  disabled />
                     <!-- 글 수정시 보내는 게시글 번호  --> 
                     <input type="hidden"  name="bbs_num" value="${article.bbs_num }" /> </td>
                    <td align="left" width="120"><b>작성일</b></td> 
                    <td ><input type=text value="<fmt:formatDate value="${article.bbs_date}" />" disabled /> </td> 
               </tr> 
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="5" width="100%"></td>
                </tr> 
 
                <tr> <td width="0">&nbsp;</td> 
                    <td align="center" width="120"><b>첨부 파일</b></td> 
                    <td width="500"><%--<input  type= hidden  name="originalFile" value="${article.bbs_file }" disabled/>
                    <a href = "#this" class= "link" name = "originalFile"> ${article.bbs_file } --%></a>
                    </td>
                    <td align="left" width="120"><b>수정 파일</b></td> 
                    <td width="500"><input  type= "file"   name="file" id = "i_FileName" value="${article.bbs_file }" disabled/> </td>
                </tr> 
               
            </table>
                           
                <div style= "height: 2px; background-color:#dddddd; width:895px; margin-left:48px;"></div> 
                <c:if test="${not empty article.bbs_file2 && article.bbs_file2!='null' }">  
		                <table class = "image-table">
		                    <tr>
		                        <td>
		                            <div style ="text-align:center; margin-left:20px;"><b>첨부 이미지 </b></div> 
		                        </td>
		                        <td width = "500">
		                        	<a class= "link" href = "#this" name = "originalFileName" value ="${article.bbs_file2 }"></a>
		                        </td>
		                    </tr>
		                </table>
		                <table>
		                    <tr> <td  width="0">&nbsp;</td> </tr>
		                    <tr>
		                        <td>
			                    <img style = "width: 500px;" src="${contextPath}/download.do?articleNO=${article.bbs_num}&imageFileName=${article.bbs_file2}" id="preview"  /><br>     
		                        </td>
		                        <td>&nbsp;</td> 
		                        <td>&nbsp;</td> 
		                        <td class = "textarea">
		                            <textarea rows="24" cols="80"  name="content"  id="i_content"  disabled >${article.bbs_content }</textarea> 
		
		                        </td>
		                    </tr>
		                    <tr> <td  width="0">&nbsp;</td> </tr>
		
		                </table>
                
	            </c:if>
	            
	            <c:if test="${empty article.bbs_file2 || article.bbs_file2 =='null' }"> 
	                        <br /><br />

			            <textarea  rows="27" cols="100" name="content" id="i_content" disabled> ${article.bbs_content }</textarea>
            			<br /><br>
	            </c:if>
                
        	<div  class="post-actions__widget" >
        		<div id = "tr_btn">
				    <input type=button class="btn post-actions__publish" value = "목록"  onClick="backToList(this.form)">
<%-- 				     <c:if test="${sessionScope.userID == article.userid}">
 --%>					    <input type=button class="btn post-actions__publish" value="수정" onClick="javascript:fn_enable(this.form)">	    			
		    			<input type=button class="btn post-actions__publish" value="삭제" onClick="fn_remove_article('${contextPath}/boards/removeArticle.do', ${article.bbs_num})">
<%-- 	        		</c:if>
 --%>	        	</div>
        	
           <div id="tr_btn_modify">
                <input type="button" class="btn post-actions__publish" value="수정 완료"   onClick="fn_modify_article(frmArticle)"  >
                <input type="button" class="btn post-actions__publish" value="취소"  onClick="goBack()">
            </div>
        </div>
                      
        </form>
      </div>
     </div>
           <div class="box1">
        <div class="chatHeader">
          <h2>댓글창</h2>
        </div>
        <div class="chatContent">
		<c:if test="${commentList != null}">
			<c:forEach var="comment" items="${commentList}">
			<table>
	            <tr>
	                <!-- 아이디, 작성날짜 -->
	                <td width="150">
	                    <div>
	                        ${comment.userid}<br>
	                    </div>
	                </td>
	                <!-- 본문내용 -->
	                <td width="300px">
	                    <div class="text_wrapper">
	                        ${comment.bbs_content}
	                    </div>
	                </td>
	                <!-- 버튼 -->
	                <td width="100">
	                    <div id="btn" style="text-align:center;">
	                        <font size ="1" color = "lightgray"> ${comment.bbs_date }</font>
	                    <c:if test="${comment.userid == sessionScope.userID}">
	                        <a class = "close" href = "${pageContext.request.contextPath}/boards/removeComment.do?bbs_num=${article.bbs_num}&bbs_commentNO=${comment.bbs_commentNO}">X</a>
	                    </c:if>        
	                    </div>
	                </td>
	            </tr>
            </table>
            
        </c:forEach>
		</c:if>

        </div>
        <div class="chatText">
         	<c:if test = "${sessionScope.userID != null }">
        	<form method = "post" name = "form" action="${contextPath}"  enctype="utf-8">
	        		<input type = "hidden" name = "bbs_num" value = "${article.bbs_num }" />
	        		<input type = "hidden" name = "title" value = "답변" />
	        		<input type = "hidden" name = "bbs_seen" value = "공개" />
	        		
	        		<input type = "hidden" name = "userid" value = "${sessionScope.userID }" />
	        		<textarea name="bbs_content" class="chatTextArea" placeholder="댓글을 달아주세요" id = "textarea" > </textarea>
		        		
		     </c:if> 
		     
		     <c:if test = "${sessionScope.userID == null }" > 
		        	<textarea name="post" class="chatTextArea" placeholder="로그인 후 이용해주세요" id = "textarea" disabled> </textarea>
		      </c:if>
		          

       
		        <div class="submit">
		          <input type = "button" class="btn post-action_publish" OnClick = "fn_comment(form)" value = "댓글 등록">
		        </div>
       		 </form>
         </div>
      </div>
      </div>
  </body>
</html>
