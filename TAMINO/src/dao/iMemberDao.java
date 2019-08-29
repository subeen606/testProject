package dao;

import java.util.List;

import dto.MemberDto;
import dto.MyOrderListDto;

public interface iMemberDao {
	public boolean addMember(MemberDto dto);
	
	public MemberDto login(String email, String password);
	
	public MemberDto findMember(String email);
	
	public boolean updateInfo(MemberDto dto);
	
	public String findEmail(String name,String phone);
	
	public boolean emailCheck(String email);
	
	public List<MyOrderListDto> getMyOrder(String email);
	
	public MemberDto findPwd(String email,String phone);
}
