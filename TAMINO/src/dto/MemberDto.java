package dto;

import java.io.Serializable;

public class MemberDto implements Serializable{
	private int Member_seq;
	private String Email;
	private String password;
	private String address;
	private String phoneNumber;
	private String userName;
	private String Member_date;
	private int auth;
	
	public MemberDto() {
	}

	public MemberDto(int member_seq, String Email, String password, String address, String phoneNumber, String userName,
			String member_date, int auth) {
		super();
		this.Member_seq = member_seq;
		this.Email = Email;
		this.password = password;
		this.address = address;
		this.phoneNumber = phoneNumber;
		this.userName = userName;
		this.Member_date = member_date;
		this.auth = auth;
	}
	
	public MemberDto(String Email, String password, String address, String phoneNumber, String userName, int auth) {
		super();
		this.Email = Email;
		this.password = password;
		this.address = address;
		this.phoneNumber = phoneNumber;
		this.userName = userName;
		this.auth = auth;
	}
	
	public MemberDto(String Email, String password, String address, String phoneNumber, String userName) {
		super();
		this.Email = Email;
		this.password = password;
		this.address = address;
		this.phoneNumber = phoneNumber;
		this.userName = userName;
	}
	
	public MemberDto(String password, String address, String phoneNumber, String userName) {
		super();
		this.password = password;
		this.address = address;
		this.phoneNumber = phoneNumber;
		this.userName = userName;
	}
	
	public String getEmail() {
		return Email;
	}

	public void setEmail(String Email) {
		this.Email = Email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}



	public int getMember_seq() {
		return Member_seq;
	}



	public void setMember_seq(int member_seq) {
		Member_seq = member_seq;
	}



	public String getMember_date() {
		return Member_date;
	}



	public void setMember_date(String member_date) {
		Member_date = member_date;
	}



	@Override
	public String toString() {
		return "MemberDto [Member_seq=" + Member_seq + ", Email=" + Email + ", password=" + password + ", address="
				+ address + ", phoneNumber=" + phoneNumber + ", userName=" + userName + ", Member_date=" + Member_date
				+ ", auth=" + auth + "]";
	}
	

}