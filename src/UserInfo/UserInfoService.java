package UserInfo;

import java.util.List;

public class UserInfoService {
	UserInfoDAO userInfoDAO;
	
	public UserInfoService() {
		userInfoDAO = new UserInfoDAO();
	}
	
	public UserInfoVO viewStatus(String userid) {
		UserInfoVO user = null;
		user = userInfoDAO.viewStatus(userid);
		return user;
	}
	
	public void addStatus(UserInfoVO userInfoVO) {
		userInfoDAO.addStatus(userInfoVO);
		//userInfoDAO.updateToday();
	}
	
	public void addToDoList(UserInfoVO userInfoVO) {
		userInfoDAO.addTodoList(userInfoVO);
	}
	
	public List<UserInfoVO> findtodoList(String userid) {
		List<UserInfoVO> todolist = userInfoDAO.findAllToDoList(userid);
		return todolist;
	}
	
	public void deleteTask(String todotask) {
		userInfoDAO.deleteTask(todotask);
	}
	
	public void finishedTask(String todotask) {
		userInfoDAO.finishedTask(todotask);
	}
	
	public List<UserInfoVO> finddoneList(String userid) {
		List<UserInfoVO> doneList = userInfoDAO.finddoneToday(userid);
		return doneList;
	}
}


