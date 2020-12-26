package BBS;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;

public class BbsVO {
	private int bbs_num;
	private String bbs_name;
	private String bbs_title;
	private String bbs_content;
	private String bbs_file;
	private String bbs_file2;
	private Date bbs_date;
	private String userid;
	private int bbs_re_count;
	private String bbs_seen;
	
	public BbsVO() {
		
	}
	
	public int getBbs_num() {
		return bbs_num;
	}
	public void setBbs_num(int bbs_num) {
		this.bbs_num = bbs_num;
	}
	public String getBbs_name() {
		return bbs_name;
	}
	public void setBbs_name(String bbs_name) {
		this.bbs_name = bbs_name;
	}
	public String getBbs_title() {
		return bbs_title;
	}
	public void setBbs_title(String bbs_title) {
		this.bbs_title = bbs_title;
	}
	public String getBbs_content() {
		return bbs_content;
	}
	public void setBbs_content(String bbs_content) {
		this.bbs_content = bbs_content;
	}
	public String getBbs_file() {
		return bbs_file;
	}
	public void setBbs_file(String bbs_file) {
		try {
	         if (bbs_file != null && bbs_file.length() != 0) {
	             this.bbs_file = URLEncoder.encode(bbs_file, "UTF-8"); // 파일이름에 특수문자가 있을 경우 인코딩합니다.
	          }			
		} catch (UnsupportedEncodingException e){
			e.printStackTrace();
		}
	}
	public String getBbs_file2() {
		return bbs_file2;
	}
	public void setBbs_file2(String bbs_file2) {
		try {
	         if (bbs_file2 != null && bbs_file2.length() != 0) {
	             this.bbs_file2 = URLEncoder.encode(bbs_file2, "UTF-8"); // 파일이름에 특수문자가 있을 경우 인코딩합니다.
	          }			
		} catch (UnsupportedEncodingException e){
			e.printStackTrace();
		}
	}
	public Date getBbs_date() {
		return bbs_date;
	}
	public void setBbs_date(Date bbs_date) {
		this.bbs_date = bbs_date;
	}
	public String getBbs_seen() {
		return bbs_seen;
	}
	public void setBbs_seen(String bbs_seen) {
		this.bbs_seen = bbs_seen;
	}
	public int getBbs_re_count() {
		return bbs_re_count;
	}
	public void setBbs_re_count(int bbs_re_count) {
		this.bbs_re_count = bbs_re_count;
	}
	
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	
	
}
