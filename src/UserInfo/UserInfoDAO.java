package UserInfo;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;



public class UserInfoDAO {
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
	
	public void addStatus(UserInfoVO m) {
		try {
			connDB();
			String userid = m.getUserid();
			String attend = m.getAttendance();
			String concentration = m.getConcentration();
			String file1 = m.getFile1();
			String file2 = m.getFile2();
			String content = m.getContent();
			String query = "INSERT INTO userinfo (userid, attendance, concentration, file1, file2, content, today)" + " VALUES(?, ? ,? ,?, ?,?, 0)";
	        System.out.println(query);
	        pstmt = conn.prepareStatement(query);
	        pstmt.setString(1, userid);
	        pstmt.setString(2, attend);
	        pstmt.setString(3, concentration);
	        pstmt.setString(4, file1);
	        pstmt.setString(5, file2);
	        pstmt.setString(6, content);
	        pstmt.executeUpdate();  //SQL문 실행
	        pstmt.close();
	        conn.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
		
	}
	
	public void updateToday() {
		try {
			connDB();
			String query = "UPDATE userinfo SET today=1 WHERE TO_DATE(logindate, 'YY-MM-DD') != TO_DATE(SYSDATE, 'YY-MM-DD')";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
	        pstmt.executeUpdate();
	        pstmt.close();
	        conn.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	public UserInfoVO viewStatus(String userid) {
		UserInfoVO user = new UserInfoVO();
		try {
			connDB();
			String query = "select attendance, loginDate, concentration, file1, file2, content, today from userinfo where userid =? and today = 0";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				String attendance = rs.getString("attendance");
				Date loginDate = rs.getDate("loginDate");
				String concentration = rs.getString("concentration");
				String file1 = rs.getString("file1");
				String file2 = rs.getString("file2");
				String content = rs.getString("content");
				int today = rs.getInt("today");
				
				user.setUserid(userid);
				user.setAttendance(attendance);
				user.setConcentration(concentration);
				user.setContent(content);
				user.setFile1(file1);
				user.setFile2(file2);
				user.setLoginDate(loginDate);
				user.setToday(today);
			}

			rs.close();
			pstmt.close();
			conn.close();
		}catch (Exception e) {
			e.printStackTrace();
		}	
		return user;
	}
	
	public void addTodoList(UserInfoVO m) {
		try {
			connDB();
			String userid = m.getUserid();
			String todolist = m.getTodolist();
			String content = m.getContent();
			String query = "INSERT INTO userinfo (userid, todolist, content)" + " VALUES(?, ?, ?)";
			System.out.println(query);
	        pstmt = conn.prepareStatement(query);
	        pstmt.setString(1, userid);
	        pstmt.setString(2, todolist);
	        pstmt.setString(3, content);
	        pstmt.executeUpdate();  //SQL문 실행
	        pstmt.close();
	        conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List findAllToDoList (String userid) {
		List todolist = new ArrayList();
		try {
			connDB();
			String query = "select todolist, logindate from userinfo where userid=? and content = 'todolist'"
							+ " ORDER BY logindate ASC";
			System.out.println(query);
	        pstmt = conn.prepareStatement(query);
	        pstmt.setString(1,  userid);
	        ResultSet rs = pstmt.executeQuery();
	        while(rs.next()) {
	        	String todolistString = rs.getString("todolist");
	        	Date logindate = rs.getDate("logindate");
	        	UserInfoVO todo = new UserInfoVO();
	        	todo.setTodolist(todolistString);
	        	todo.setLoginDate(logindate);
	        	todo.setContent("todolist");
	        	todolist.add(todo);
	        }
	        rs.close();
	        pstmt.close();
	        conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return todolist;
	}
	
	public void deleteTask(String todotask) {
		try {
			connDB();
			String query = "DELETE FROM userinfo ";
			query += "WHERE todolist=? ";
			System.out.println(query);
			System.out.println(todotask);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, todotask);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void finishedTask(String todotask) {
		try {
			connDB();
			String query = "update userinfo set content = 'done'";
			query += " WHERE todolist=? ";
			System.out.println(query);
			System.out.println(todotask);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, todotask);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List finddoneToday(String userid) {
		List doneList = new ArrayList();
		try {
			connDB();
			String query = "select todolist from userinfo where userid = ? and content = 'done' ORDER BY logindate ASC";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String todolist = rs.getString("todolist");
				UserInfoVO user = new UserInfoVO();
				user.setTodolist(todolist);
				user.setUserid(userid);
				user.setContent("done");
				doneList.add(user);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return doneList;
	}	
	
}
