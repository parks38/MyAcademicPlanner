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
}
