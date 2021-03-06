package BBS;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;



@WebServlet("/boards/*")
public class BbsController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private static String ARTICLE_IMAGE_REPO = "/Users/sunnypark/Desktop/android/board";
	BbsVO bbsVO; 
	BbsService bbsService;

	public void init() throws ServletException {
		bbsService = new BbsService();
		bbsVO = new BbsVO();
	}
	protected void doGet(HttpServletRequest request,HttpServletResponse response)
            throws ServletException, IOException {
		doHandle(request, response);
	}
	protected void doPost(HttpServletRequest request,HttpServletResponse response)
            throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		String nextPage = null;
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        String action = request.getPathInfo(); 
        System.out.println("action : " + action);
        HttpSession session; // userid 저장해주기 위한 
        try {
        	List<BbsVO> articlesList = new ArrayList<BbsVO>();
    		List<BbsVO> commentList = new ArrayList<BbsVO>();

        	if(action == null) {
        		articlesList = bbsService.listArticles();
        		request.setAttribute("articlesList", articlesList);
        		nextPage ="/bulletin.jsp";
        	} else if (action.equals("/listArticles.do")){
        		articlesList = bbsService.listArticles();
        		request.setAttribute("articlesList", articlesList);
        		nextPage = "/bulletin.jsp";
        	}else if (action.equals("/writeArticle.do")) {
        		nextPage = "/write.jsp";
        	} else if (action.equals("/*")){
				nextPage = "/boards/listArticles.do";
        	} else if (action.equals("/addArticles.do")){
        		int articleNO = 0;
        		Map<String, String> articleMap = upload(request, response);
        		String bbs_title = articleMap.get("title");
        		String bbs_content = articleMap.get("content");
        		String bbs_file = articleMap.get("file");
        		String bbs_file2 = articleMap.get("imageFileName");
        		String bbs_seen = articleMap.get("seen");
        		String bbs_id = articleMap.get("userid");
        	
        		bbsVO.setBbs_title(bbs_title);
        		bbsVO.setBbs_content(bbs_content);
        		bbsVO.setUserid(bbs_id);
        		bbsVO.setBbs_file(bbs_file);
        		bbsVO.setBbs_file2(bbs_file2);
        		bbsVO.setBbs_seen(bbs_seen);

                // 테이블에 새 글을 추가한 후 새 글에 대한 글 번호를 가져옵니다.
                articleNO= bbsService.addArticle(bbsVO);
        		
                // 파일을 첨부한 경우에만 수행합니다.
        		if(bbs_file != null && bbs_file.length() != 0) {
        			File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + bbs_file);
        			//CURR_IMAGE_REPO_PATH의 경로 하위에 글 번호로 폴더를 생성합니다.
        			File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
        			destDir.mkdirs();
        			//temp 폴더의 파일을 글 번호를 이름으로 하는 폴더로 이동시킨다. 
                    FileUtils.moveFileToDirectory(srcFile, destDir, true);
                    srcFile.delete();
        		}
        		if(bbs_file2 != null && bbs_file2.length() != 0) {
        			File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + bbs_file2);
        			//CURR_IMAGE_REPO_PATH의 경로 하위에 글 번호로 폴더를 생성합니다.
        			File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
        			destDir.mkdirs();
        			//temp 폴더의 파일을 글 번호를 이름으로 하는 폴더로 이동시킨다. 
                    FileUtils.moveFileToDirectory(srcFile, destDir, true);
                    srcFile.delete();
        		}
        		
        		// 새글 등록 메세지를 나타낸 후 자바 스크립트 location 객체를 이용 hreft 속성을 이용해 글 목록을 요청 
        		PrintWriter pw = response.getWriter();
        		pw.print("<script>" + "alert('새글을 추가했습니다.');" + "location.href = '" + request.getContextPath() 
        				+ "/boards/listArticles.do';" + "</script>");
        		nextPage = "/listArticles.do";  
        		return;
        	}  else if (action.equals("/viewArticle.do")) {
        		
        		// 글 상세창을 요구할 경우 articleNO 를 받아온다 
        		int articleNO = Integer.parseInt(request.getParameter("articleNO"));
        		System.out.println(articleNO);
        		// articleNO 에 대한 글 정보 조회하고 article 속성으로바인딩 
        		bbsVO = bbsService.viewArticle(articleNO);
        		commentList = bbsService.findComments(articleNO);
        	    
        		request.setAttribute("article", bbsVO);
        		request.setAttribute("commentList", commentList);
        		nextPage = "/view.jsp";
        	} else if(action.equals("/modArticle.do")) {
        		Map<String, String> articleMap = upload(request, response);
				int articleNO = Integer.parseInt(articleMap.get("bbs_num"));
				bbsVO.setBbs_num(articleNO);
				String title = articleMap.get("title");
				String content = articleMap.get("content");
				String file = articleMap.get("file");
				String userid = articleMap.get("userid");
				bbsVO.setUserid(userid);
				bbsVO.setBbs_title(title);
				bbsVO.setBbs_content(content);
				bbsVO.setBbs_file(file);
				bbsService.modArticle(bbsVO);
				if (file != null && file.length() != 0) {
					String originalFileName = articleMap.get("originalFileName");
					File srcFile = new File(ARTICLE_IMAGE_REPO + "/" + "temp" + "/" + file);
        			//CURR_IMAGE_REPO_PATH의 경로 하위에 글 번호로 폴더를 생성합니다.
        			File destDir = new File(ARTICLE_IMAGE_REPO + "/" + articleNO);
					destDir.mkdirs();
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
					File oldFile = new File(ARTICLE_IMAGE_REPO + "/" + articleNO + "/" + originalFileName);
					oldFile.delete();
				} 
				PrintWriter pw = response.getWriter();
				pw.print("<script>" + "  alert('글을 수정했습니다.');" + " location.href='" + request.getContextPath()
						+ "/boards/viewArticle.do?articleNO=" + articleNO + "';" + "</script>");
				return;
        	} else if (action.equals("/removeArticle.do")) {
				int articleNO = Integer.parseInt(request.getParameter("bbs_num"));
				bbsService.removeArticle(articleNO);
				File imgDir = new File(ARTICLE_IMAGE_REPO + "/" + articleNO);
					if (imgDir.exists()) {
						FileUtils.deleteDirectory(imgDir);
					}

				PrintWriter pw = response.getWriter();
				pw.print("<script>" + "  alert('글을 삭제했습니다.');" + " location.href='" + request.getContextPath()
						+ "/boards/listArticles.do';" + "</script>");
				return;
			} else if (action.equals("/index.do")) {
				nextPage = "/index.jsp";
			} else if (action.equals("/addComment.do")) {
				int bbs_num = Integer.parseInt(request.getParameter("bbs_num"));
				System.out.println(bbs_num);
				String bbs_title = request.getParameter("title");
				String bbs_content = request.getParameter("bbs_content");
				String bbs_seen = request.getParameter("bbs_seen");
				String userid = request.getParameter("userid");
				
				bbsVO.setParentNO(bbs_num);
				bbsVO.setBbs_title(bbs_title);
				bbsVO.setBbs_content(bbs_content);
				bbsVO.setBbs_seen(bbs_seen);
				bbsVO.setUserid(userid);
				
				bbsService.addComment(bbsVO);
				nextPage = "/boards/viewArticle.do?articleNO=" + bbs_num;
			} else if (action.equals("/removeComment.do")) {
				int bbs_num = Integer.parseInt(request.getParameter("bbs_num"));
				int commentNO = Integer.parseInt(request.getParameter("bbs_commentNO"));
				bbsService.removeComment(commentNO);
				nextPage = "/boards/viewArticle.do?articleNO=" + bbs_num;
				System.out.println(nextPage);
				PrintWriter pw = response.getWriter();
				pw.print("<script>" + "location.href='" + request.getContextPath()
						+ "/boards/viewArticle.do?articleNO=" + bbs_num+ "'"+"</script>");
				return;
			}
        	RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
        	dispatch.forward(request, response);
        } catch (Exception e) {
        	e.printStackTrace();
        }   
	}
	
	private Map<String, String> upload (HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		Map<String, String> articleMap = new HashMap<String, String>();
		String encoding = "utf-8";
		File currentDirPath = new File(ARTICLE_IMAGE_REPO);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(currentDirPath);
		factory.setSizeThreshold(1024*1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List items = upload.parseRequest(request);
			for(int i = 0; i < items.size(); i++) {
				FileItem fileItem = (FileItem)items.get(i);
						if(fileItem.isFormField()) {
							System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
							articleMap.put(fileItem.getFieldName(), fileItem.getString(encoding));
							
						} else {
							System.out.println("파라미터명: " + fileItem.getFieldName());
							System.out.println("파일크기 : " + fileItem.getSize() + "bytes");
							if(fileItem.getSize() > 0) {
								int idx = fileItem.getName().lastIndexOf("\\");
								if(idx == -1 ) {
									idx = fileItem.getName().lastIndexOf("/");
								}
								String fileName = fileItem.getName().substring(idx+1);
								System.out.println(fileItem.getFieldName());
								articleMap.put(fileItem.getFieldName(), fileName);
								//익스플로어에서 업로드 파일의 경로 제거 후 map 파일명 저장 
								File uploadFile = new File(currentDirPath + "\\temp\\" + fileName);
								fileItem.write(uploadFile);
							} 
						}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return articleMap;
	}
	
}
