package Member;

import java.util.List;


public class MemberService {
	MemberDAO memberDAO;
	
	public MemberService() {
		memberDAO = new MemberDAO();
	}
	
	public List<MemberVO> listMember() {
		List<MemberVO> memberList = memberDAO.listMembers();
		return memberList;
	}
		
}
