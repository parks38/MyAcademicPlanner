package Member;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {
	private Connection conn;
	private static final String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String user = "map";
	private static final String pwd = "map";
    private PreparedStatement pstmt;
    
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
	
	
    public List<MemberVO> listMembers(){
        List<MemberVO> list = new ArrayList<MemberVO>();
        try {
            connDB();
            
            // SQL문 생성 -> pstmt
            String query = "select * from user_member";
            System.out.println("pstmt : " + query);
            pstmt = conn.prepareStatement(query);
            
            // SQL 결과 담을 객체
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                String id = rs.getString("id");
                String pwd = rs.getString("pwd");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String course = rs.getString("course");
                Date joinDate = rs.getDate("joinDate");
                MemberVO vo = new MemberVO();
                vo.setId(id);
                vo.setPwd(pwd);
                vo.setName(name);
                vo.setEmail(email);
                vo.setJoinDate(joinDate);
                list.add(vo);
            }
            
            // close (생성순 거꾸로)
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
            if(conn != null) conn.close();            
        }catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public void addMember(MemberVO m) {
        try {
        	connDB();
        	String id = m.getId();
            String pwd = m.getPwd();
            String name = m.getName();
            String email = m.getEmail();
            String mycourse = m.getMycourse();
            String query = "INSERT INTO user_member(userid, password, name, email, mycourse)" + " VALUES(?, ? ,? ,?, ?)";
            System.out.println(query);
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, id);
            pstmt.setString(2, pwd);
            pstmt.setString(3, name);
            pstmt.setString(4, email);
            pstmt.setString(5, mycourse);
            pstmt.executeUpdate();  //SQL문 실행
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    //회원 정보 조회 
    public MemberVO findMember(String _id) {
    	MemberVO memInfo = null;
    	try {
    		connDB();
    		String query = "select * from  user_member where id=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, _id);
			System.out.println(query);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			String id = rs.getString("id");
			String pwd = rs.getString("pwd");
			String name = rs.getString("name");
			String email = rs.getString("email");
			String mycourse = rs.getString("mycourse");
			Date joinDate = rs.getDate("joinDate");
			memInfo = new MemberVO(id, pwd, name, email, mycourse, joinDate);
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memInfo;
    }
    // 전달된 수정회원 정보를 update 통해서 수정 
    public void modMember(MemberVO memberVO) {
		String id = memberVO.getId();
		String pwd = memberVO.getPwd();
		String name = memberVO.getName();
		String email = memberVO.getEmail();
		try {
			connDB();
			String query = "update t_menber set pwd=?,name=?,email=?  where id=?";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, pwd);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			pstmt.setString(4, id);
			pstmt.executeUpdate();
			pstmt.close(); // SQL 문 실행 
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

    // 회원 탈퇴 
	public void delMember(String id) {
		try {
			connDB();
			String query = "delete from t_menber where id=?";
			//delete문을 통해 ID의 회원 정보를 삭제 
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,id);
			pstmt.executeUpdate(); //sql문 실행 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
