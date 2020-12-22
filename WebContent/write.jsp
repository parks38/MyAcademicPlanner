<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="css/write.css" />
  </head>
  <body>
    <!-- header -->
    <header>
      <div class="container">
        <div class="logo">
          <img style="width: 150px; height: 150px" src="images/logo.png" />
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
    <div class="widget-post" aria-labelledby="post-header-title">
      <div class="widget-post__header">
        <h2 class="widget-post__title" id="post-header-title">
          <i class="fa fa-pencil" aria-hidden="true"></i>
          write post
        </h2>
      </div>
      <form
        id="widget-form"
        class="widget-post__form"
        name="form"
        aria-label="post widget"
      >
        <div class="widget-post__content">
          <label for="post-content" class="sr-only"
            >오늘의 자료를 업로드하세요
          </label>
          <textarea
            name="post"
            id="post-content"
            class="widget-post__textarea scroller"
            placeholder="share your moments"
          ></textarea>
        </div>
        <div class="widget-post__actions post--actions">
          <div class="post-actions__attachments">
            <button
              type="button"
              class="btn post-actions__upload attachments--btn"
            >
              <label for="upload-image" class="post-actions__label">
                <i class="fa fa-upload" aria-hidden="true"></i>
                파일 업로드
              </label>
            </button>
            <input type="file" id="upload-image" accept="image/*" multiple />
          </div>
          <div class="post-actions__widget">
            <button class="btn post-actions__publish">돌아가기</button>
            <button class="btn post-actions__publish">업로드하기</button>
          </div>
        </div>
      </form>
    </div>
  </body>
</html>
