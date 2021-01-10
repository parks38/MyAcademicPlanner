package UserInfo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;

import javax.print.event.PrintJobAttributeEvent;

public class UserInfoVO {
	private String userid;
	private String attendance;
	private Date loginDate;
	private String concentration;
	private String file1;
	private String file2;
	private String content;
	private String todolist;
	private int today; 
	
	
	public UserInfoVO() {
	}
	
	public UserInfoVO(String userid, String attendance, String concentration, String file1, String file2, String content) {
		this.userid = userid;
		this.attendance  = attendance;
		this.concentration = concentration;
		this.file1 = file1;
		this.file2 = file2;
		this.content = content;
	}
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getAttendance() {
		return attendance;
	}
	public void setAttendance(String attendance) {
		this.attendance = attendance;
	}
	public Date getLoginDate() {
		return loginDate;
	}
	public void setLoginDate(Date loginDate) {
		this.loginDate = loginDate;
	}
	public String getConcentration() {
		return concentration;
	}
	public void setConcentration(String concentration) {
		this.concentration = concentration;
	}
	public String getFile1() {
		return file1;
	}
	public void setFile1(String file1) {
		try {
	         if (file1 != null && file1.length() != 0) {
	             this.file1 = URLEncoder.encode(file1, "UTF-8"); // 파일이름에 특수문자가 있을 경우 인코딩합니다.
	          }			
		} catch (UnsupportedEncodingException e){
			e.printStackTrace();
		}
	}
	public String getFile2() {
		return file2;
	}
	public void setFile2(String file2) {
		try {
	         if (file2 != null && file2.length() != 0) {
	             this.file2 = URLEncoder.encode(file2, "UTF-8"); // 파일이름에 특수문자가 있을 경우 인코딩합니다.
	          }			
		} catch (UnsupportedEncodingException e){
			e.printStackTrace();
		}
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTodolist() {
		return todolist;
	}
	public void setTodolist(String todolist) {
		this.todolist = todolist;
	}

	public int getToday() {
		return today;
	}

	public void setToday(int today) {
		this.today = today;
	}
	
	
	
	
	
}
