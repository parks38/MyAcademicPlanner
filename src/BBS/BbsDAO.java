package BBS;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.swing.plaf.basic.BasicInternalFrameTitlePane.SystemMenuBar;


public class BbsDAO {
	private Connection conn;
	private static final String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String user = "map";
	private static final String pwd = "map";
    private PreparedStatement pstmt;
    
    // DB connect 
	private void connDB() {
		try {
			// Driver는 oracle sql 에 접속하게 해주는 매개체 같은 역할 
			// 동적 로딩 방식 
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Oracle 드라이버 로딩 성공");
			conn = DriverManager.getConnection(url, user, pwd);
			// : DriverManager에 등록된 각 드라이버들을 사용해서 식별한다.
			System.out.println("Connection 생성 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List selectAllArticles() {
		List articlesList = new ArrayList();
		try {
			connDB();
			String query = "SELECT bbs_num,userid,bbs_title,bbs_content,bbs_re_count, bbs_date, bbs_seen" 
			             + " from bbs"
					     + " ORDER BY bbs_num DESC";
			//오라클의 계층형 sql문을 실행한다
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int bbs_num = rs.getInt("bbs_num");
				String userid = rs.getString("userid");
				String bbs_title = rs.getString("bbs_title");
				String bbs_content = rs.getString("bbs_content");
				int bbs_re_count = rs.getInt("bbs_re_count");
				Date bbs_date = rs.getDate("bbs_date");
				String bbs_seen = rs.getString("bbs_seen");
				BbsVO article = new BbsVO();
				article.setBbs_num(bbs_num);
				article.setUserid(userid);
				article.setBbs_title(bbs_title);
				article.setBbs_content(bbs_content);
				article.setBbs_re_count(bbs_re_count);
				article.setBbs_seen(bbs_seen);
				article.setBbs_date(bbs_date);
				articlesList.add(article);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return articlesList;
	}
	
	public int insertNewArticle(BbsVO article) {
		int bbs_num = getNewArticleNO();
		
		try {
			connDB();
			String bbs_title = article.getBbs_title();
			String bbs_content = article.getBbs_content();
			String userid = article.getUserid();
			String imageFileName = article.getBbs_file2();
			String file = article.getBbs_file();
			String bbs_seen = article.getBbs_seen();
			
			String query = "INSERT INTO bbs (bbs_num, bbs_title, bbs_content, bbs_file, bbs_file2, bbs_seen, userid, bbs_re_count)"
					+ " VALUES (?, ? ,?, ?, ?, ?, ?, ?)";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bbs_num);
			pstmt.setString(2, bbs_title);
			pstmt.setString(3, bbs_content);
			pstmt.setString(4, file);
			pstmt.setString(5, imageFileName);
			pstmt.setString(6, bbs_seen);
			pstmt.setString(7, userid);
			pstmt.setInt(8, 0);
			pstmt.executeUpdate();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return bbs_num;
	}
	
	// 게시글 번호 생성하기 
	private int getNewArticleNO() {
		try {
			connDB();
			String query = "SELECT  max(bbs_num) from bbs ";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery(query);
			if (rs.next())
				return (rs.getInt(1) + 1);
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	// 한개의 post view 하기
	public BbsVO selectArticle(int articleNO) {
		BbsVO  article = new BbsVO();
		try {
			connDB();
			String query = "select bbs_num, bbs_title, bbs_content, bbs_file, bbs_file2, userid, bbs_date from bbs where bbs_num=?";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, articleNO);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			int bbs_num = rs.getInt("bbs_num");
			String bbs_title = rs.getString("bbs_title");
			String bbs_content = rs.getString("bbs_content");
			String bbs_file2 = rs.getString("bbs_file2");
			String bbs_file = rs.getString("bbs_file");
			String userid = rs.getString("userid");
			Date bbs_date = rs.getDate("bbs_date");
			
			article.setBbs_num(bbs_num);
			article.setBbs_title(bbs_title);
			article.setBbs_content(bbs_content);
			article.setBbs_file(bbs_file);
			article.setBbs_file2(bbs_file2);
			article.setBbs_date(bbs_date);
			article.setUserid(userid);

			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return article;
	}
	
	// 게시글 수정하기
	public void updateArticle(BbsVO article) {
		int articleNO = article.getBbs_num();
		String title = article.getBbs_title();
		String content = article.getBbs_content();
		String file = article.getBbs_file();
		try {
			connDB();
			String query = "update bbs  set bbs_title=?,bbs_content=?";
			if (file != null && file.length() != 0) {
				query += ", bbs_file=?";
			}
			query += " where bbs_num=?";

			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			if (file != null && file.length() != 0) {
				pstmt.setString(3, file);
				pstmt.setInt(4, articleNO);
			} else {
				pstmt.setInt(3, articleNO);
			}
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 게시글 삭제 
	// 댓글 만든 이후 댓글도 모두 삭제 기능 추가 
	public void deleteArticle(int  articleNO) {
		try {
			connDB();
			String query = "DELETE FROM bbs ";
			query += "WHERE bbs_num=? ";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, articleNO);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
}
