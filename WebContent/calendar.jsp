<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="css/calendar.css" />
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
  <div class = "body">
    <iframe
      src="https://calendar.google.com/calendar/embed?height=700&amp;wkst=1&amp;bgcolor=%23ffffff&amp;ctz=Asia%2FSeoul&amp;src=a2VuZGUxaDBoMmJtdWFic2dnZG5ubHF1amtAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ&amp;color=%23009688"
      style="border-width: 0"
      width="1000"
      height="700"
      frameborder="0"
      scrolling="no"
    ></iframe>

    <!--  todo list  -->
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
</div>
<!-- wrapper class end -->
  </body>
</html>
