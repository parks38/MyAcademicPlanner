<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="css/bulletin.css" />
  </head>
  <body>
  <!-- header -->
    <header>
      <div class="container">
        <div class="logo">
          <img style="width: 150px; height: 150px" src="image/logo.png" />
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
          <li class="active"><a href="index.jsp"> 나의 현황</a></li>
          <li><a href="bulletin.jsp">나만의 노트</a></li>
          <li class="dropBox">
            <a href="calendar.jsp">달력</a>
          </li>
          <li class="dropBox">
            <a href="student_list.jsp">학생 정보 </a>
          </li>
        </ul>
      </div>
    </nav>
    <!-- //nav -->
            <!-- container  -->
            <div class = "contianertable">
                <table style = "text-align: center;"">
                    <thead> <!--테이블의 속성을 알려준다 -->
                        <tr> <!-- 행: 한줄 -->
                            <th style = "background-color: #B5c7d3; text-align : center; width: 50px;"> 번호 </th>
                            <th style = "background-color: #B5c7d3; text-align : center;"> 제목  </th>
                            <th style = "background-color: #B5c7d3; text-align : center;"> 작성자  </th>
                            <th style = "background-color: #B5c7d3; text-align : center;"> 내용  </th>
                            <th style = "background-color: #B5c7d3; text-align : center;"> 작성일  </th>
                        </tr>
                    </thead>
                        <tbody>
                            <%-- <%
                                BbsDAO bbsDAO = new BbsDAO();
                                ArrayList<Bbs> list = bbsDAO.getList(pageNumber); //현재의 페이지에서 가져온 목록을 불러온다 
                                for(int i = 0; i < list.size(); i++) {
                            %>  --%>
                            <tr> <!-- 계시글 출력  현재의 index 의 정보 -->
                                    <td><%-- <%=list.get(i).getBbsID()%> --%></td>
                                <!--  현재의 글의 view page 를 링크로 걸어둔다.  -->
                                    <td><%-- <a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle()%> --%>
                                    </a></td>
                                    <td><%-- <%=list.get(i).getUserID()%>< --%>/td>
                                <!-- date format 변경  -->
                                <td> <%-- <%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13)
                                        + "시" + list.get(i).getBbsDate().substring(14,16) + "분" %> --%></td>
                            </tr>
                          <%--    <%
                                }
                            %>  --%>
                        </tbody>
                </table>
                    
                    <!-- 글을 쓸수있는 페이지로 옮겨가기  -->
            <a href = "write.jsp" class = "button"> 글쓰기 </a>
            <a href = "write.jsp" class = "button"> 파일 업로드하기 </a>
            </div>
  </body>
</html>
