package Member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oracle.net.aso.a;

@WebServlet("/users/*")
public class MemberController extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	MemberDAO memberDAO; 

	public void init() throws ServletException {
		memberDAO = new MemberDAO();
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
	        try {
	        	if(action == null) {
	        		nextPage ="/login.jsp";
	        	// 2. 로그인 했을때 
	        	} else if (action.equals("/login.do")){
	        	
	        	} 
	        	// 3. sign-up form에서 정보를 받아와 데이터에 넣기 
	        	else if (action.equals("/addMember.do")) {
	        		System.out.println("회원 정보를 추가" + action);
		            String id = request.getParameter("userID");
		            String pd = request.getParameter("userPassword");
		            String name = request.getParameter("userName");
		            String email = request.getParameter("userEmail");
		            String mycourse = request.getParameter("course");
		            MemberVO memberVO = new MemberVO(id,pd,name,email, mycourse);
		            memberDAO.addMember(memberVO); 
		          //회원 등록후 다시 회원 목록을 출력 
		            PrintWriter pw = response.getWriter();
	        		pw.print("<script>" + "alert('새글을 추가했습니다.');" + "location.href = '" + request.getContextPath() 
	        				+ "/index.jsp';" + "</script>");
	        		nextPage = "/index.jsp";
	        		return;
		           
		            
	        }
	        RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
        	dispatch.forward(request, response);
        } catch (Exception e) {
        	e.printStackTrace();
        }   
	        
	}
}
