package Member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/users/*")
public class MemberController extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	MemberDAO memberDAO; 
	MemberService memberService;

	public void init() throws ServletException {
		memberDAO = new MemberDAO();
		memberService = new MemberService();
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
	        		nextPage ="/login.jsp";
	        	// 2. 로그인 했을때 
	        	} else if (action.equals("/login.do")){
	        		String id = request.getParameter("username");
	        		String password = request.getParameter("password");
	        		/*
	        		if(session.getAttribute(id) != null) {
	        			PrintWriter pw = response.getWriter();
	        			pw.println("<script>");
	        			pw.println("alert('이미 로그인 하셨습니다')");
	        			pw.println("location.href = '" + request.getContextPath() + "/index.jsp'");
	        			pw.println("</script>");
	        		}
	        		*/
	        		int result = memberDAO.loginCheck(id, password);
	        		if(result == 1) { //로그인 성공 - 세션 부여 
	        			session = request.getSession();
	        			session.setAttribute("userID", id); // 객체에 바인딩 
	        			nextPage = "/daily.jsp";
	        		} else if (result == 0) {
	        			PrintWriter pw = response.getWriter();
	        			pw.println("<script>");
	        			pw.println("alert('비밀번호가 일치하지 않습니다.')");
	        			pw.println("history.back()");
	        			pw.println("</script>");
	        			return;
	        		} else if (result == -1){
						PrintWriter pw = response.getWriter();
						pw.println("<script>");
						pw.println("alert('아이디가 존재하지 않습니다.')");
						/* userID 틀렸을때 alert  */
						pw.println("history.back()");
						/* 이전 페이지로 사용자를 돌려보낸다. 로그인 페이지로 돌려보낸다.  */
						pw.println("</script>");
						return;
					} else if(result == -2){
						PrintWriter pw = response.getWriter();
						pw.println("<script>");
						pw.println("alert('데이터베이스 에러')");
						pw.println("history.back()");
						/* 이전 페이지로 사용자를 돌려보낸다. 로그인 페이지로 돌려보낸다.  */
						pw.println("</script>");
						return;
					}	
	        	} 
	        	// 3. sign-up form에서 정보를 받아와 데이터에 넣기 
	        	else if (action.equals("/addMember.do")) {
		            String id = request.getParameter("userID");
		            String pd = request.getParameter("userPassword");
		            String name = request.getParameter("userName");
		            String email = request.getParameter("userEmail");
		            String mycourse = request.getParameter("course");
		            MemberVO memberVO = new MemberVO(id,pd,name,email, mycourse);
		            memberDAO.addMember(memberVO); 
		          //회원 등록후 다시 회원 목록을 출력 
		            PrintWriter pw = response.getWriter();
	        		pw.print("<script>" + "location.href = '" + request.getContextPath() 
	        				+ "/login.jsp';" + "</script>");
	        		nextPage = "/login.jsp";
	        		return;
		           
		            
	        } else if (action.equals("/logout.do")) {
	        	session = request.getSession();
	    		session.invalidate();
				PrintWriter pw = response.getWriter();
				pw.println("<script>");
				pw.println("location.href = '" + request.getContextPath() + "/index.jsp'");
				pw.println("</script>");
				return;
	    		
	        } else if (action.equals("/viewMember.do")) {
	        	List<MemberVO> memberList = memberService.listMember();
        		request.setAttribute("memberList", memberList);
        		nextPage = "/student_list.jsp";
	        }
	        RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
        	dispatch.forward(request, response);
        } catch (Exception e) {
        	e.printStackTrace();
        }   
	        
	}
}
