package member;

public class MemberInfo {

	public MemberInfo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MemberInfo(String userId, String userPw, String userName, String userPhoto) {
		super();
		this.userId = userId;
		this.userPw = userPw;
		this.userName = userName;
		this.userPhoto = userPhoto;
	}

	private String userId;
	private String userPw;
	private String userName;
	private String userPhoto;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPhoto() {
		return userPhoto;
	}

	public void setUserPhoto(String userPhoto) {
		this.userPhoto = userPhoto;
	}	

	@Override
	public String toString() {
		return "MemberInfo [userId=" + userId + ", userPw=" + userPw + ", userName=" + userName + ", userPhoto="
				+ userPhoto + "]";
	}

}
