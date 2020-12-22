<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored = "false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" href="css/style.css?after" type="text/css" 
       charset="utf-8"/>    <!-- JQUERY -->
      <script
  src="https://code.jquery.com/jquery-3.1.1.js"
  integrity="sha256-16cdPddA6VdVInumRGo6IbivbERE8p7CQR3HzTBuELA="
  crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
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
    <div class="main">
      <div class="wrapper">
        <form action="" id="wizard">
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
                  <div
                    class="form-holder"
                    style="align-self: flex-end; transform: translateY(4px)"
                  >
                    <label> <b>오늘의 출석 현황 : </b></label> <br />
                    <div class="checkbox-tick">
                      <label class="attend">
                        <input
                          type="radio"
                          name="gender"
                          value="male"
                          checked
                        />
                        출석 완료 <br />
                        <span class="checkmark"></span>
                      </label>
                      <label class="early_leave">
                        <input type="radio" name="gender" value="female" /> 조퇴
                        <br />
                        <span class="checkmark"></span>
                      </label>
                      <label class="late">
                        <input type="radio" name="gender" value="female" /> 지각
                        <br />
                        <span class="checkmark"></span>
                      </label>
                    </div>
                    <br />

                    <label> <b>오늘의 집중도: </b></label>
                    <div class="checkbox-tick">
                      <label class="low">
                        <input
                          type="radio"
                          name="gender"
                          value="male"
                          checked
                        />
                        하 <br />
                        <span class="checkmark"></span>
                      </label>
                      <label class="low-mid">
                        <input type="radio" name="gender" value="female" />
                        중-하
                        <br />
                        <span class="checkmark"></span>
                      </label>
                      <label class="mid">
                        <input type="radio" name="gender" value="female" /> 중
                        <br />
                        <span class="checkmark"></span>
                      </label>
                      <label class="mid-high">
                        <input type="radio" name="gender" value="female" />
                        중-상
                        <br />
                        <span class="checkmark"></span>
                      </label>
                      <label class="high">
                        <input type="radio" name="gender" value="female" /> 상
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
                    파일1: <input type="file" name="file1" /><br />
                    파일2: <input type="file" name="file2" /><br />
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-holder w-100">
                    <label for="subject"> 댓글: </label>
                    <textarea
                      name=""
                      id=""
                      placeholder="파일과 함께 업드로드할 댓글 입력하세요!"
                      class="form-control"
                      style="height: 99px"
                    ></textarea>
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
                <p>%% 님의 오늘의 현황입니다.</p>
                <div class="form-row">
                  <!-- 오늘의 내용을 print 하는 창  -->
                  <div class="form-holder w-100">
                    <p>오늘의 출결 : 출석 완료</p>
                    <p>오늘의 노트 : 업로드 완료</p>
                    <p>오늘의 집중도 : 4/5</p>
                    <p>다가오는 완료일 : 12/31 일</p>
                  </div>
                </div>
                <div class="form-row">
                  <!-- link for motivation notes  
                    데이터 베이스에 100개의 명언을 입력하여 랜덤하게 돌린다. -->
                  <div>"no pain, no gain " - 김연아</div>
                </div>
              </div>
            </div>
          </section>
        </form>
        <div class="split_two">
          <!-- Box 2 -->
          <div class="wrapper2">
            <h3>전체 출석 경황:</h3>
            <br />

            다이어그램 <br />

            <label> 정리학습 제출 경황 : </label>
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
                  Enter text into the input field to add items to your list.
                </p>
                <p id="second">Click the item to mark it as complete.</p>
                <p id="third">
                  Click the "X" to remove the item from your list.
                </p>
              </div>
            </div>

            <div class="row">
              <div class="col-12">
                <input
                  id="userInput"
                  type="text"
                  placeholder="New item..."
                  maxlength="27"
                />
                <button id="enter">
                  <i class="fas fa-pencil-alt"></i>
                </button>
              </div>
            </div>

            <!-- Empty List -->
            <div class="row">
              <div class="listItems col-12">
                <ul
                  id="myList"
                  class="col-12 offset-0 col-sm-8 offset-sm-2"
                ></ul>
              </div>
            </div>
          </div>
          <script type="text/javascript" src="/js/wrapper3_script.js"></script>
        </div>
      </div>
      <!-- wrapper class end -->

      <!-- JQUERY -->
      <script src="js/jquery-3.3.1.min.js"></script>

      <!-- JQUERY STEP -->
      <script src="js/jquery.steps.js"></script>
      <script src="js/main.js"></script>
      <!-- Template created and distributed by Colorlib -->

      <!-- Box 3 -->
    </div>
  </body>
</html>
