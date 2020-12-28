package Comments;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import BBS.BbsVO;

public class CommentDAO {
	
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
	
	public int insertNewComment(CommentVO comment) {
		int commentNO = getNewCommentNO();
		
		try {
			connDB();
			int parentNO = comment.getParentNO();
			String content = comment.getContent();
			String userid = comment.getUserid();

			
			String query = "INSERT INTO comments (commentNO, parentNO, content, userid)"
					+ " VALUES (?, ? ,?, ?)";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, commentNO);
			pstmt.setInt(2, parentNO);
			pstmt.setString(3, content);
			pstmt.setString(4, userid);
			pstmt.executeUpdate();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return commentNO;
	}
	
	// 게시글 번호 생성하기 
		private int getNewCommentNO() {
			try {
				connDB();
				String query = "SELECT  max(commentNO) from comments ";
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
		
		public List selectAllComments(int parentNO) {
			List commentList = new ArrayList();
			try {
				connDB();
				String query = "SELECT commentNO, content, writedate ,userid" 
				             + " from comments where parentNO=?"
						     + " ORDER BY commentNO DESC";
				//오라클의 계층형 sql문을 실행한다
				System.out.println(query);
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, parentNO);
				ResultSet rs = pstmt.executeQuery();
				while (rs.next()) {
					int commentNO = rs.getInt("commentNO");
					String content = rs.getString("content");
					String userid = rs.getString("userid");
					Date writedate = rs.getDate("writedate");
					CommentVO comment = new CommentVO();
					comment.setCommentNO(commentNO);
					comment.setUserid(userid);
					comment.setContent(content);
					comment.setParentNO(parentNO);
					comment.setWriteDate(writedate);
					commentList.add(comment);
				}
				rs.close();
				pstmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return commentList;
		}

}
