<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="css/view.css" />
  </head>
  <body>
    <!-- header -->
    <header>
      <div class="container">
        <div class="logo">
          <img style="width: 150px; height: 150px" src="${pageContext.request.contextPath}/image/logo.png" />
        </div>
        <ul class="sidemenu">
          <li><a href="sign-up.jsp">회원가입</a></li>
          <li><a href="login.jsp">로그인</a></li>
        </ul>
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
    <div class="body">
      <div class="box1">
        <div class="chatHeader">
          <h2>댓글창</h2>
        </div>
        <div class="chatContent"></div>
        <div class="chatText">
          <textarea
            name="post"
            class="chatTextArea"
            placeholder="댓글을 달아주세요"
          >
          </textarea>
        </div>
        <div class="submit">
          <button class="btn post-action_publish">업로드</button>
        </div>
      </div>
      <div class="box2">
        <div class="widget-post__header">
          <h2 class="widget-post__title" id="post-header-title">
            <i class="fa fa-pencil" aria-hidden="true"></i>
            게시글
          </h2>
        </div>
        <div class="widget-post__content">
          <form name="frmArticle" method="post"  action="${contextPath}"  enctype="multipart/form-data">
            <table width="90%"> 
                <tr> 
                    <td  width="0">&nbsp;</td> 
                    <td align="center" width="100"><b>제목</b></td> 
                    <td width="500"><input type=text value="${article.title }"  name="title"  id="i_title" disabled /></td>	
                    <td width="0">&nbsp;</td> 
                </tr> 
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407">

                    </td>
                </tr> 
                <tr> 
                    <td width="0">&nbsp;</td> 
                    <td align="center" width="100"><b>글쓴이</b></td> 
                    <td width="500"><input type=text value="${article.id }" name="writer"  disabled />/td> 
                    <td width="0">&nbsp;</td> 
                </tr> 
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407">

                    </td>
                </tr> 
                <tr> 
                    <td width="0">&nbsp;</td> 
                    <td align="center" width="100"><b>글 번호</b></td> 
                     <td width="700"><input type="text"  value="${article.articleNO }"  disabled /> </td>
   					 <td width="500"><input type="hidden" name="articleNO" value="${article.articleNO}"  />	 </td>
                    <td width="0">&nbsp;</td> 
                </tr> 
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr> 
                <tr> <td width="0">&nbsp;</td> 
                    <td align="center" width="100"><b>작성일</b></td> 
                    <td width="500"><input type=text value="<fmt:formatDate value="${article.writeDate}" />" disabled /></td> 
                    <td width="0">&nbsp;</td> 
                </tr> 
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr> 
                <tr> <td width="0">&nbsp;</td> 
                    <td align="center" width="100"><b>첨부 파일</b></td> 
                    <td width="500"><input  type= "hidden"   name="originalFileName" value="${article.imageFileName }" /> </td>
    				<td><img style = "width: 500px;" src="${contextPath}/download.do?articleNO=${article.articleNO}&imageFileName=${article.imageFileName}" id="preview"  /><br></td> 
                    <td width="0">&nbsp;</td> 
                </tr> 
                
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr> 
                <tr> <td width="0">&nbsp;</td> 
                    <td align="center" width="100"><b>첨부 이미지 </b></td> 
                    <td width="500"><input  type= "hidden"   name="originalFileName" value="${article.imageFileName }" /> </td>
    				<td><img style = "width: 500px;" src="${contextPath}/download.do?articleNO=${article.articleNO}&imageFileName=${article.imageFileName}" id="preview"  /><br></td> 
                    <td width="0">&nbsp;</td> 
                </tr> 
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407">
                    </td>
                </tr> 
                <tr> <td width="0"></td> 
                    <td width="600" colspan="2" height="400">
                    	<textarea rows="20" cols="60"  name="content"  id="i_content"  disabled >${article.content }</textarea> 
                    </td> 
                </tr> 
            </table>
        </div>
        <div class="post-actions__widget">
          <button class="btn post-actions__publish">이전</button>
          <button class="btn post-actions__publish">목록</button>
          <button class="btn post-actions__publish">수정</button>
          <button class="btn post-actions__publish">삭제</button>
          <button class="btn post-actions__publish">이후</button>
        </div>
      </div>
    </div>
  </body>
</html>
