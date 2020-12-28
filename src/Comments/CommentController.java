package Comments;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/comment.do")
public class CommentController  extends HttpServlet{
	private static final long serialVersionUID = 1L;
	CommentVO commentVO; 
	CommentService commentService;

	public void init() throws ServletException {
		commentService = new CommentService();
		commentVO = new CommentVO();
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
        	List<CommentVO> commentList = new ArrayList<CommentVO>();
        	if(action.equals("/addComments.do")) {
        		int articleNO = 0;
        		int parentNO = Integer.parseInt(request.getParameter("comment_board"));
        		String content = request.getParameter("comment_content");
        		String userid = request.getParameter("commen_id");
        	
        		commentVO.setParentNO(parentNO);
        		commentVO.setContent(content);
        		commentVO.setUserid(userid);

                // 테이블에 새 글을 추가한 후 새 글에 대한 글 번호를 가져옵니다.
                articleNO= commentService.addComment(commentVO);
                nextPage = "/comments/listComments.do";
        		
        		
        	} else if (action.equals("/listComments.do")) {
        		
        		int parentNO =Integer.parseInt(request.getParameter("comment_board"));
        		commentList = commentService.listComments(parentNO);
        		request.setAttribute("commentList", commentList);
        		PrintWriter out = response. getWriter();
        		out.print("location.href = '" + request.getContextPath() 
				+ "/board/listArticles.do';" + "</script>");
        		nextPage= "/view.jsp";
        	}
        	RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
        	dispatch.forward(request, response);
        	
        } catch (Exception e) {
        	e.printStackTrace();
        }
	}

}
