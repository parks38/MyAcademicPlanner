package Comments;

import java.util.List;
import java.util.Map;

public class CommentService {
	CommentDAO commentDAO;
	
	public CommentService() {
		commentDAO = new CommentDAO();
		
	}
		
	public int addComment(CommentVO comment) {
		return commentDAO.insertNewComment(comment);
	}
	
	public List<CommentVO> listComments(int parentNO) {
		List<CommentVO>commentList = commentDAO.selectAllComments(parentNO);
		return commentList;
	}

}
