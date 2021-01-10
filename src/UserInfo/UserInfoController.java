package UserInfo;

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

@WebServlet("/userinfo/*")
public class UserInfoController extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private static String ARTICLE_IMAGE_REPO = "/Users/sunnypark/Desktop/android/board";

	UserInfoDAO userInfoDAO; 
	UserInfoVO userinfoVO;
	UserInfoService userInfoService;

	public void init() throws ServletException {
		userInfoDAO = new UserInfoDAO();
		userinfoVO = new UserInfoVO();
		userInfoService = new UserInfoService();
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
	        	if(action == null) {
	        		nextPage ="/index.jsp";
	        	// 2. 로그인 했을때 
	        	} else if (action.equals("/addStatus.do")){
	        		Map<String, String> statusMap = upload(request, response);
	        		String userid = statusMap.get("userid");
	        		System.out.println(userid);
	        		String attend = statusMap.get("attend");
	        		System.out.println(attend);
	        		String concentration = statusMap.get("concentration");
	        		String file1 =  statusMap.get("file1");
	        		String file2 =  statusMap.get("file2");
	        		String content =  statusMap.get("content");
	        		
	        		UserInfoVO userInfoVO = new UserInfoVO(userid, attend, concentration, file1, file2, content);
	        		userInfoService.addStatus(userInfoVO);
	        		nextPage = "/userinfo/view.do?userid=" + userid;
	
	        	} else if (action.equals("/view.do")) {
	        		List<UserInfoVO> todolist = new ArrayList<UserInfoVO>();
	        		List<UserInfoVO> doneList = new ArrayList<UserInfoVO>();
	        		String userid = request.getParameter("userid");
	        		System.out.println(userid);
	        		userinfoVO = userInfoService.viewStatus(userid);
	        		todolist = userInfoService.findtodoList(userid);
	        		doneList = userInfoService.finddoneList(userid);
	        		request.setAttribute("userInfo", userinfoVO);
	        		request.setAttribute("doneList", doneList);
	        		request.setAttribute("doList", todolist);
	        		nextPage = "/index.jsp";
	        	} else if (action.equals("/addtodolist.do")) {
	        		String userid = request.getParameter("userid");
	        		String todolist = request.getParameter("userInput");
	        		System.out.println(todolist);
	        		String content = request.getParameter("content");
	        		userinfoVO.setUserid(userid);
	        		userinfoVO.setTodolist(todolist);
	        		userinfoVO.setContent(content);
	        		
	        		userInfoService.addToDoList(userinfoVO);
	        		nextPage = "/userinfo/view.do?userid=" + userid;
	        	} else if (action.equals("/removetodo.do")) {
	        		String todotask = request.getParameter("todolist");
	        		String userid = request.getParameter("userid");
	        		userInfoService.deleteTask(todotask);
	        		System.out.println(userid);
	        		nextPage = "/userinfo/view.do?userid="+userid;
	        		System.out.println(nextPage);
					PrintWriter pw = response.getWriter();
					pw.print("<script>" + "location.href='" + request.getContextPath()
							+ "/userinfo/view.do?userid="+userid+ "'"+"</script>");
					return;
	        	} else if (action.equals("/donetodo.do")) {
	        		String todotask = request.getParameter("todolist");
	        		String userid = request.getParameter("userid");
	        		userInfoService.finishedTask(todotask);
	        		nextPage = "/userinfo/view.do?userid="+userid;
	        		System.out.println(nextPage);
					PrintWriter pw = response.getWriter();
					pw.print("<script>" + "location.href='" + request.getContextPath()
							+ "/userinfo/view.do?userid="+userid+ "'"+"</script>");
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
