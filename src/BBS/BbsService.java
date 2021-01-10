package BBS;

import java.util.List;


public class BbsService {
	BbsDAO bbsDAO;
	public BbsService() {
		bbsDAO = new BbsDAO();
	}
	
	public List<BbsVO> listArticles() {
		List<BbsVO> articlesList = bbsDAO.selectAllArticles();
		return articlesList;
	}
	
	public int addArticle(BbsVO article) {
		return bbsDAO.insertNewArticle(article);
	}
	
	// 컨트롤러에서 전달받은 글 번호로 다시 selectArticle(articleNO)메소드를 호출 
	public BbsVO viewArticle(int articleNO) {
		BbsVO article = null;
		article = bbsDAO.selectArticle(articleNO);
		return article;
	}
	
	// 게시글 수정
	public void modArticle(BbsVO article) {
		bbsDAO.updateArticle(article);
	}	
	
	// 게시글 삭제 
	public void removeArticle(int  articleNO) {
		// 관련 게시글 삭제하기 
		bbsDAO.deleteArticle(articleNO);
	}
	
	public int addComment(BbsVO bbsvo) {
		return bbsDAO.insertNewComment(bbsvo);
	}
	
	public List<BbsVO> findComments(int articleNO) {
		List<BbsVO> commentList = bbsDAO.findAllComments(articleNO); 
		return commentList;
	}
	
	public void removeComment (int commentNO) {
		bbsDAO.deleteComment(commentNO);
	}
}
