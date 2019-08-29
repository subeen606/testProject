package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import DB.DBClose;
import DB.DBConnection;
import dto.MemberDto;
import dto.MyOrderListDto;

public class MemberDao implements iMemberDao{
private static MemberDao memberDao = new MemberDao();
	
	private MemberDao() {
		DBConnection.initConnection();
	}
	
	public static MemberDao getInstance() {	//Singleton
		return memberDao;	
	}
	
	@Override
	public boolean addMember(MemberDto dto) {
		String sql = " INSERT INTO MEMBER "
				   + " (MEMBER_SEQ ,EMAIL,PASSWORD,ADDRESS,PHONENUMBER,USERNAME,MEMBER_DATE,AUTH) "
				   + " VALUES (MEMBER_SEQ.NEXTVAL,?,?,?,?,?,SYSDATE,?) ";
				

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("addMember 1/6 suc");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getEmail());
			psmt.setString(2, dto.getPassword());
			psmt.setString(3, dto.getAddress());
			psmt.setString(4, dto.getPhoneNumber());
			psmt.setString(5, dto.getUserName());
			psmt.setInt(6, dto.getAuth());
			System.out.println("addMember 2/6 suc");
			count = psmt.executeUpdate();
			System.out.println("addMember 3/6 suc");
		} catch (Exception e) {
			System.out.println("addMember fail");
			e.printStackTrace();

		} finally {
			DBClose.close(psmt, conn, null);
		}

		return count > 0 ? true : false;
	}

	@Override
	public MemberDto login(String email, String password) {
		System.out.println("eamil:"+email+", pwd:"+password);

		String sql = " SELECT EMAIL,PASSWORD,ADDRESS,PHONENUMBER,USERNAME,AUTH "
				   + " FROM MEMBER " 
				   + " WHERE EMAIL=? AND PASSWORD=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		MemberDto mem = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("login success 1/4");

			psmt = conn.prepareStatement(sql);

			psmt.setString(1, email);
			psmt.setString(2, password);
			System.out.println("login success 2/4");

			rs = psmt.executeQuery();

			if (rs.next()) {
				
				mem = new MemberDto(rs.getString(1),
								 	rs.getString(2),
								 	rs.getString(3),
								 	rs.getString(4),
								 	rs.getString(5),
							  	     rs.getInt(6));
				System.out.println("login success 3/4");
			}

		} catch (Exception e) {
			System.out.println("login failed");
			e.printStackTrace();
		} finally {

			System.out.println("login success 4/4");
			DBClose.close(psmt, conn, rs);

		}

		return mem;
	
	}

	@Override
	public MemberDto findMember(String email) {
		String sql = " SELECT EMAIL,PASSWORD,ADDRESS, "
				   + " PHONENUMBER,AUTH,USERNAME "
				   + " FROM MEMBER "
				   + " WHERE EMAIL=? ";
		

		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		MemberDto memDto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("findMember 1/6 suc");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			System.out.println("findMember 2/6 suc");
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				memDto = new MemberDto(rs.getString(1),
									rs.getString(2),
									 rs.getString(3),
							     rs.getString(4),
							        rs.getString(6),
							            rs.getInt(5));
			}
			System.out.println("findMember 3/6 suc");
		} catch (Exception e) {
			System.out.println("findMember fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return memDto;
	}

	@Override
	public boolean updateInfo(MemberDto dto) {
		
		String sql = " UPDATE MEMBER "
				   + " SET USERNAME=?,PASSWORD=?,PHONENUMBER=?,ADDRESS=? "
				   + " WHERE MEMBER_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0 ;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("updateInfo 1/6 suc");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getUserName());
			psmt.setString(2, dto.getPassword());
			psmt.setString(3, dto.getPhoneNumber());
			psmt.setString(4, dto.getAddress());
			psmt.setInt(5, dto.getMember_seq());
			System.out.println("updateInfo 2/6 suc");
			count = psmt.executeUpdate();
			System.out.println("updateInfo 3/6 suc");
		} catch (Exception e) {
			System.out.println("updateInfo fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
			return count>0?true:false;
	
	}

	@Override
	public String findEmail(String name, String phone) {
		String sql = " SELECT EMAIL "
			   	   + " FROM MEMBER "
			   	   + " WHERE USERNAME=? AND PHONENUMBER=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String email = "";
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 findEmail suc");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, name);
			psmt.setString(2, phone);
			System.out.println("2/6 findEmail suc");
			
			rs=psmt.executeQuery();
			
			if(rs.next()) {
				
				email = rs.getString(1);
				System.out.println("3/6 findEmail suc");
			}

		} catch (Exception e) {
			System.out.println("findEmail fail");			
			e.printStackTrace();
		} DBClose.close(psmt, conn, rs);
		
		return email;
	}

	@Override
	public boolean emailCheck(String email) {
		String sql = " SELECT EMAIL "
				   + " FROM MEMBER "
				   + " WHERE EMAIL=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		boolean a = true;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 emailCheck suc");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			System.out.println("2/6 emailCheck suc");
			rs = psmt.executeQuery();
			if(rs.next()) {
			
				a = true;
				System.out.println("3/6 emailCheck suc");
			}
			else {
				a = false;
				System.out.println("3/6 emailCheck suc");
			}
			

		} catch (Exception e) {
			System.out.println("emailCheck fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return a;
	}
	
	@Override
	public List<MyOrderListDto> getMyOrder(String email) {
		String sql = " SELECT ORDER_DATE, " 
				+ " LISTAGG(ORDER_PRODUCT_NAME, ',') WITHIN GROUP (ORDER BY ORDER_PRODUCT_NAME) AS ORDER_PRODUCT_NAME, " 
				+ " LISTAGG(ORDER_PRODUCT_IMAGE, ',') WITHIN GROUP (ORDER BY ORDER_PRODUCT_NAME) AS ORDER_PRODUCT_NAME, " 
				+ " LISTAGG(ORDER_PRODUCT_SIZE, ',') WITHIN GROUP (ORDER BY ORDER_PRODUCT_NAME) AS ORDER_PRODUCT_NAME, " 
				+ " LISTAGG(ORDER_PRODUCT_COUNT, ',') WITHIN GROUP (ORDER BY ORDER_PRODUCT_NAME) AS ORDER_PRODUCT_NAME, " 
				+ " LISTAGG(ORDER_PRODUCT_PRICE, ',') WITHIN GROUP (ORDER BY ORDER_PRODUCT_NAME) AS ORDER_PRODUCT_NAME, " 
				+ " LISTAGG(ORDER_DELIVERYSTATUS, ',') WITHIN GROUP (ORDER BY ORDER_PRODUCT_NAME) AS ORDER_PRODUCT_NAME " 
				+ "	FROM ORDERLIST "
				+ "	WHERE ORDER_EMAIL = ? " 
				+ " GROUP BY ORDER_DATE ";
				
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<MyOrderListDto> list = new ArrayList<MyOrderListDto>();
		
		try {
		conn = DBConnection.getConnection();
		System.out.println("1/6 getMyOrder Success");	
		
		psmt = conn.prepareStatement(sql);
		System.out.println("2/6 getMyOrder Success");
		
		
		psmt.setString(1, email);
		
		System.out.println("3/6 getMyOrder Success");
		rs = psmt.executeQuery();
		System.out.println("4/6 getMyOrder Success");
		
		while(rs.next()) {
			int i = 1;
			MyOrderListDto dto = new MyOrderListDto(rs.getString(i++),
												rs.getString(i++),
												rs.getString(i++),
												rs.getString(i++),
												rs.getString(i++),
												rs.getString(i++),
												rs.getString(i++));
			
			list.add(dto);
		}
		
		
		} catch (Exception e) {
		System.out.println("resultlist Fail");
		e.printStackTrace();
		} finally {
		DBClose.close(psmt, conn, null);			
		}
		
		return list;
	}
	
	
	@Override
	public MemberDto findPwd(String email, String phone) {
		
		
		
		String sql = " SELECT MEMBER_SEQ,EMAIL,PASSWORD,ADDRESS, "
				   + " PHONENUMBER,USERNAME,MEMBER_DATE,AUTH "
				   + " FROM MEMBER "
				   + " WHERE EMAIL=? AND PHONENUMBER=?  ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		MemberDto memDto = null;
		try {
			conn = DBConnection.getConnection();
			System.out.println("findPwd 1/6 suc");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			psmt.setString(2, phone);
			System.out.println("findPwd 2/6 suc");
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				memDto = new MemberDto(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),
							rs.getString(6),rs.getString(7),rs.getInt(8));
			}
			System.out.println("findPwd 3/6 suc");
		} catch (Exception e) {
			System.out.println("findPwd fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
				
		return memDto;
		
	
	}

}
