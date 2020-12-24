package Member;

import java.util.Date;

public class MemberVO {
	private String userid;
    private String password;
    private String name;
    private String email;
    private String mycourse;
    private Date joinDate;
    
    public MemberVO() {
    	System.out.println("MemberVO 생성자 호출");
    }
    
    
    public MemberVO(String userid, String password, String name, String email, String mycourse) {
    	this.userid = userid;
    	this.password = password;
    	this.name = name;
    	this.email = email;
    	this.mycourse = mycourse;
    }
   
    
    public MemberVO(String userid, String password, String name, String email, String mycourse, Date joinDate) {
    	this.userid = userid;
    	this.password = password;
    	this.name = name;
    	this.email = email;
    	this.mycourse = mycourse;
    	this.joinDate = joinDate;
    }
    
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMycourse() {
		return mycourse;
	}
	public void setMycourse(String mycourse) {
		this.mycourse = mycourse;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}	
	
}
