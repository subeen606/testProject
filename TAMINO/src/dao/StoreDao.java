package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.catalina.storeconfig.StoreAppender;

import DB.DBClose;
import DB.DBConnection;
import dto.MemberDto;
import dto.MyOrderListDto;
import dto.ProductDto;
import dto.ScheduleDto;
import dto.StoreQnADto;

public class StoreDao implements iStoreDao{
	
private static StoreDao storeDao = new StoreDao();
	
	private StoreDao() {
		DBConnection.initConnection();;
	}
	
	public static StoreDao getInstance() {	
		return storeDao;	
	}
	
	@Override
	public int getPageCount(String product_category) {
		String sql = " SELECT COUNT(*) "
					+ " FROM SHOP ";
		
		if(!product_category.equals("all")) {
			sql += " WHERE CODE_NUMBER=? ";
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int rowcount = 0;
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			if(!product_category.equals("all")) {
				psmt.setString(1, product_category.trim());
			}
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				rowcount = rs.getInt(1);
				System.out.println("rowcount = " + rowcount);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
			
		}
		if(rowcount%6 == 0) {
			rowcount = rowcount / 6;
		}else {
			rowcount = (rowcount / 6) + 1;
		}
		return rowcount;
	}
	
	@Override
	public List<ProductDto> getProductList(String product_category, int page) {
		String sql = " SELECT PRODUCT_SEQ,CODE_NUMBER,PRODUCT_NAME,PRICE,PRODUCT_EXPLAIN,PRODUCT_IMAGE, "
				   + " COUNT_S,COUNT_M,COUNT_L,COUNT_O,PRODUCT_SIZE "
				   + " FROM "
				   + " (SELECT ROW_NUMBER() OVER(ORDER BY PRODUCT_SEQ DESC) AS RNUM, "
				   + " PRODUCT_SEQ,CODE_NUMBER,PRODUCT_NAME,PRICE,PRODUCT_EXPLAIN,PRODUCT_IMAGE, " 
				   + " COUNT_S,COUNT_M,COUNT_L,COUNT_O,PRODUCT_SIZE" 
				   + " FROM SHOP " ;
		
		if(product_category.equals("all")) {
			sql += ") WHERE RNUM >= ? AND RNUM <= ? ";
		}else {
			sql +=  " WHERE CODE_NUMBER=?)"
				+ " WHERE RNUM >= ? AND RNUM <= ? ";
		}
				  
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ProductDto> list = new ArrayList<ProductDto>();
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			if(product_category.equals("all")) {
				psmt.setInt(1, (6 * page)-5);
				psmt.setInt(2, 6 * page);
			}else {
				psmt.setString(1, product_category.trim());
				psmt.setInt(2, (6 * page)-5);
				psmt.setInt(3, 6 * page);
			}
			
			rs = psmt.executeQuery();
			while(rs.next()) {
				int i = 1;
				ProductDto dto = new ProductDto(rs.getInt(i++), 
												rs.getString(i++), 
												rs.getString(i++), 
												rs.getInt(i++), 
												rs.getString(i++), 
												rs.getString(i++), 
												rs.getInt(i++), 
												rs.getInt(i++), 
												rs.getInt(i++), 
												rs.getInt(i++), 
												rs.getString(i++));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return list;
	}
	/*
	@Override
	public MemberDto login(String loginid, String loginpw) {
		String sql = " SELECT * "
					+ " FROM MEMBER "
					+ " WHERE EMAIL=? AND PASSWORD=? ";
		System.out.println(loginid + loginpw);
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto dto = null;

		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, loginid.trim());
			psmt.setString(2, loginpw.trim());
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				int i = 1;
				
				dto = new MemberDto(rs.getString(i++), 
									rs.getString(i++), 
									rs.getString(i++), 
									rs.getString(i++), 
									rs.getInt(i++),
									rs.getString(i++));
				System.out.println(dto.toString());
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}

		return dto;
	}
	*/
	
	@Override
	public int getQnAPageCount(int product_seq) {
		String sql = " SELECT COUNT(*) "
					+ " FROM STORE_QNA "
					+ " WHERE QNA_PRODUCT_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int pagecount = 0;
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, product_seq);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				pagecount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		if(pagecount%10 == 0) {
			pagecount = pagecount / 10;
		}else {
			pagecount = (pagecount / 10) + 1;
		}
		return pagecount;
	}

	@Override
	public List<StoreQnADto> getQnAList(int product_seq, int page) {
		String sql = " SELECT QNA_SEQ, QNA_PRODUCT_SEQ, "
					+ " QNA_TITLE, QNA_CATEGORY, QNA_CONTENT, QNA_WDATE, QNA_EMAIL, QNA_DEL, "
					+ " QNA_REF, QNA_STEP, QNA_DEPTH, QNA_PARENT "
					+ " FROM ( SELECT ROW_NUMBER() OVER(PARTITION BY(QNA_PRODUCT_SEQ) ORDER BY QNA_WDATE DESC) AS RNUM, "
							+ " QNA_SEQ, QNA_PRODUCT_SEQ, QNA_TITLE, QNA_CATEGORY, QNA_CONTENT, QNA_WDATE, QNA_EMAIL, QNA_DEL,"
							+ " QNA_REF, QNA_STEP, QNA_DEPTH, QNA_PARENT "
							+ " FROM STORE_QNA "
							+ " WHERE QNA_PRODUCT_SEQ=? )"
					+ " WHERE RNUM>=? AND RNUM<=? "
					+ " ORDER BY QNA_REF DESC, QNA_STEP ASC ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<StoreQnADto> list = new ArrayList<StoreQnADto>();
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, product_seq);
			psmt.setInt(2, (10 * page)-9); 
			psmt.setInt(3, (10 * page)); 
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				int i = 1;
				StoreQnADto dto = new StoreQnADto(rs.getInt(i++), 
												  rs.getInt(i++), 
												  rs.getString(i++), 
												  rs.getString(i++), 
												  rs.getString(i++), 
												  rs.getString(i++), 
												  rs.getString(i++), 
												  rs.getInt(i++),
												  rs.getInt(i++), 
												  rs.getInt(i++), 
												  rs.getInt(i++),
												  rs.getInt(i++));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return list;
	}

	@Override
	public boolean writeQnA(StoreQnADto dto) {
		String sql = " INSERT INTO STORE_QNA (QNA_SEQ, QNA_PRODUCT_SEQ, QNA_TITLE, QNA_CATEGORY, QNA_CONTENT, QNA_WDATE, QNA_EMAIL, QNA_DEL, " 
					+ " QNA_REF, QNA_STEP, QNA_DEPTH, QNA_PARENT) "
					+ " VALUES(STORE_QNA_SEQ.NEXTVAL, ?, ?, ?, ?, SYSDATE, ?, 0, (SELECT NVL(MAX(QNA_REF), 0)+1 FROM STORE_QNA), 0, 0, 0)";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;

		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, dto.getQna_product_seq());
			psmt.setString(2, dto.getQna_title());
			psmt.setString(3, dto.getQna_category());
			psmt.setString(4, dto.getQna_content());
			psmt.setString(5, dto.getQna_email());
			
			count = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		
		return count>0?true:false;
	}
	

	@Override
	public StoreQnADto deatilQnA(int seq) {
		String sql = " SELECT * "
					+ " FROM STORE_QNA "
					+ " WHERE QNA_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		StoreQnADto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				int i = 1;
				dto = new StoreQnADto(rs.getInt(i++), 
						  rs.getInt(i++), 
						  rs.getString(i++), 
						  rs.getString(i++), 
						  rs.getString(i++), 
						  rs.getString(i++), 
						  rs.getString(i++), 
						  rs.getInt(i++),
						  rs.getInt(i++), 
						  rs.getInt(i++), 
						  rs.getInt(i++),
						  rs.getInt(i++));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}
	
	@Override
	public boolean updateQnA(StoreQnADto dto) {
		String sql = " UPDATE STORE_QNA "
					+ " SET QNA_TITLE=?, QNA_CATEGORY=?, QNA_CONTENT=? "
					+ " WHERE QNA_SEQ=? ";
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getQna_title());
			psmt.setString(2, dto.getQna_category());
			psmt.setString(3, dto.getQna_content());
			psmt.setInt(4, dto.getQna_seq());
			
			count = psmt.executeUpdate();
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		
		return count>0?true:false;
	}

	@Override
	public boolean deleteQnA(int seq) {
		String sql = " UPDATE STORE_QNA "
					+ " SET QNA_DEL=1 "
					+ " WHERE QNA_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			count = psmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		
		return count>0?true:false;
	}

	@Override
	public ProductDto detailProduct(int seq) {
		String sql = " SELECT * "
					+ " FROM SHOP "
					+ " WHERE PRODUCT_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		ProductDto dto = null;
	
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				int i = 1;
				dto = new ProductDto(rs.getInt(i++), 
												rs.getString(i++), 
												rs.getString(i++), 
												rs.getInt(i++), 
												rs.getString(i++), 
												rs.getString(i++), 
												rs.getInt(i++), 
												rs.getInt(i++), 
												rs.getInt(i++), 
												rs.getInt(i++), 
												rs.getString(i++));
				
				System.out.println("dao detail : " + dto.toString());
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
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

	
	
	
	

}
