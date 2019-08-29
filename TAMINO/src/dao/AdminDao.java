package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DB.DBClose;
import DB.DBConnection;
import dto.ScheduleDto;
import dto.StoreQnADto;
import dto.MemberDto;
import dto.OrderListDto;
import dto.ProductDto;

public class AdminDao implements iAdminDao{
	
	private static AdminDao dao = new AdminDao();
	
	private AdminDao() {
		DBConnection.initConnection();
	}
	
	public static AdminDao getInstance() {
		return dao;
	}
	
	@Override
	public int getSchedulePages(String searchCategory, String searchTxt) {
		
		String sql = " SELECT COUNT(*) "
					+ " FROM SCHEDULE ";
		
		if(searchCategory.equals("선택")) {
			sql += " WHERE 1=1 ";
		}else if(searchCategory.equals("공연명")) {
			sql += " WHERE SCHEDULE_TITLE LIKE ? ";
		}else if(searchCategory.equals("내용")) {
			sql += " WHERE SCHEDULE_CONTENT LIKE ? ";
		}else if(searchCategory.equals("장소")) {
			sql += " WHERE SCHEDULE_PLACE LIKE ? ";
		}else if(searchCategory.equals("공연일시")) {
			sql += " WHERE SCHEDULE_DATE LIKE ? ";
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int pages = 0;

		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			if(searchCategory.equals("선택")) {
				rs = psmt.executeQuery();
			}else {
				psmt.setString(1,"%" + searchTxt.trim() + "%");
				rs = psmt.executeQuery();
			}
			
			while(rs.next()) {
				pages = rs.getInt(1);
			}
	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		
		if(pages % 10 == 0) {
			pages = pages / 10;
		}else {
			pages = (pages / 10) + 1; 
		}
		
		return pages;
	}

	@Override
	public List<ScheduleDto> getScheduleList(String searchCategory, String searchTxt, int page) {
		
		System.out.println("searchCategory : " +  searchCategory);
		System.out.println("searchTxt : " + searchTxt);
		System.out.println("page : " + page);
		
		String sql = " SELECT SCHEDULE_SEQ, SCHEDULE_DATE, SCHEDULE_TIME, "
				+ " SCHEDULE_PLACE, SCHEDULE_TITLE, SCHEDULE_CONTENT, TICKETLINK, SCHEDULE_POSTER "
				+ " FROM ( SELECT ROW_NUMBER()OVER(ORDER BY SCHEDULE_SEQ DESC) AS RNUM, "
				+ " SCHEDULE_SEQ, SCHEDULE_DATE, SCHEDULE_TIME, "
				+ " SCHEDULE_PLACE, SCHEDULE_TITLE, SCHEDULE_CONTENT, TICKETLINK, SCHEDULE_POSTER "
				+ " FROM SCHEDULE ";
				
			//	+ " ORDER BY SCHEDULE_DATE ASC, SCHEDULE_TIME ASC ";
		
			if(searchCategory.equals("선택")) {
				sql += " WHERE 1=1 ";
			}else if(searchCategory.equals("공연명")) {
				sql += " WHERE SCHEDULE_TITLE LIKE ? ";
			}else if(searchCategory.equals("내용")) {
				sql += " WHERE SCHEDULE_CONTENT LIKE ? ";
			}else if(searchCategory.equals("장소")) {
				sql += " WHERE SCHEDULE_PLACE LIKE ? ";
			}else if(searchCategory.equals("공연일시")) {
				sql += " WHERE SCHEDULE_DATE LIKE ? ";
			}
			sql += " ORDER BY SCHEDULE_DATE ASC, SCHEDULE_TIME ASC ) ";
			sql += " WHERE RNUM>=? AND RNUM<=? ";
			
			
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ScheduleDto> list = new ArrayList<ScheduleDto>();
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			if(searchCategory.equals("선택")) {
				psmt.setInt(1, (20 * page)-19);
				psmt.setInt(2, (20 * page));
			}else if(!searchCategory.equals("선택")){
				psmt.setString(1,"%" + searchTxt.trim() + "%");
				psmt.setInt(2, (10 * page)-9);
				psmt.setInt(3, (10 * page));
			}
			rs = psmt.executeQuery();
			while(rs.next()) {
				int i = 1;
				ScheduleDto dto = new ScheduleDto(rs.getInt(i++), 
												  rs.getString(i++), 
												  rs.getString(i++), 
												  rs.getString(i++), 
												  rs.getString(i++), 
												  rs.getString(i++), 
												  rs.getString(i++),
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
	
	@Override
	public boolean writeSchedule(ScheduleDto dto) {
		String sql = " INSERT INTO SCHEDULE "
					+ " VALUES(SCHEDULE_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?) ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		System.out.println("writeSchedule dao : "+dto.toString());
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, dto.getSchedule_date());
			psmt.setString(2, dto.getSchedule_time());
			psmt.setString(3, dto.getSchedule_place());
			psmt.setString(4, dto.getSchedule_title());
			psmt.setString(5, dto.getSchedule_content());
			psmt.setString(6, dto.getTicketLink());
			psmt.setString(7, dto.getSchedule_poster());
			
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
	public ScheduleDto ScheduleDetail(int seq) {
		String sql = " SELECT * "
					+ " FROM SCHEDULE "
					+ " WHERE SCHEDULE_SEQ=? ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		ScheduleDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				int i = 1;
				dto = new ScheduleDto(rs.getInt(i++), 
									rs.getString(i++), 
									rs.getString(i++), 
									rs.getString(i++), 
									rs.getString(i++), 
									rs.getString(i++), 
									rs.getString(i++), 
									rs.getString(i++));
				
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
	public boolean updateSchedule(ScheduleDto dto) {
		String sql = " UPDATE SCHEDULE "
				+ " SET SCHEDULE_DATE=?, SCHEDULE_TIME=?, SCHEDULE_PLACE=?, SCHEDULE_TITLE=?, "
				+ " SCHEDULE_CONTENT=?, TICKETLINK=?, SCHEDULE_POSTER=? "
				+ " WHERE SCHEDULE_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		System.out.println("updateSchedule dao : "+dto.toString());
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getSchedule_date().trim());
			psmt.setString(2, dto.getSchedule_time().trim());
			psmt.setString(3, dto.getSchedule_place().trim());
			psmt.setString(4, dto.getSchedule_title().trim());
			psmt.setString(5, dto.getSchedule_content().trim());
			psmt.setString(6, dto.getTicketLink().trim());
			psmt.setString(7, dto.getSchedule_poster().trim());
			psmt.setInt(8, dto.getSeq());
			
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
	public boolean deleteSchedule(String[] seq) {
		String sql = " DELETE "
					+ " FROM SCHEDULE "
					+ " WHERE SCHEDULE_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int[] count = new int[seq.length];
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			
			psmt = conn.prepareStatement(sql);
			
			for (int i = 0; i < seq.length; i++) {
				psmt.setInt(1, Integer.parseInt(seq[i]));
				psmt.addBatch();
			}
			count = psmt.executeBatch();
			
			conn.commit();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			DBClose.close(psmt, conn, null);
		}
		
		boolean delcheck = true;
		for (int i = 0; i < count.length; i++) {
			if(count[i] != -2) {
				delcheck = false;
				break;
			}
		}
		
		return delcheck;
	}
	
	@Override
	public boolean addProduct(ProductDto dto) {
		String sql = " INSERT INTO SHOP "
				   + " (PRODUCT_SEQ,CODE_NUMBER,PRODUCT_NAME,PRICE, "
				   + " PRODUCT_EXPLAIN,PRODUCT_IMAGE,COUNT_S,COUNT_M, "
				   + " COUNT_L,COUNT_O,PRODUCT_SIZE) "
				   + " VALUES(PRODUCT_SEQ.NEXTVAL,?,?,?,?,?,?,?,?,?,?) ";
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("addProduct 1/6 suc");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getCode());
			psmt.setString(2, dto.getProductName());
			psmt.setInt(3, dto.getPrice());
			psmt.setString(4, dto.getProductExplain());
			psmt.setString(5, dto.getProductImage());
			psmt.setInt(6, dto.getCount_s());
			psmt.setInt(7, dto.getCount_m());
			psmt.setInt(8, dto.getCount_l());
			psmt.setInt(9, dto.getCount_o());
			psmt.setString(10, dto.getProductSize());
			System.out.println("addProduct 2/6 suc");
			
			count = psmt.executeUpdate();
			System.out.println("addProduct 3/6 suc");
			
			
		} catch (Exception e) {
			System.out.println("addProduct fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		
		return count>0?true:false;
	}

	@Override
	public List<ProductDto> getProduct(int pCount) {
		String sql = " SELECT PRODUCT_SEQ,CODE_NUMBER,PRODUCT_NAME,PRICE,PRODUCT_EXPLAIN,PRODUCT_IMAGE, "
				   + " COUNT_S,COUNT_M,COUNT_L,COUNT_O,PRODUCT_SIZE "
				   + " FROM "
				   + " (SELECT ROW_NUMBER()OVER(ORDER BY PRODUCT_SEQ DESC) AS RNUM, " 
				   + " PRODUCT_SEQ,CODE_NUMBER,PRODUCT_NAME,PRICE,PRODUCT_EXPLAIN,PRODUCT_IMAGE, "
				   + " COUNT_S,COUNT_M,COUNT_L,COUNT_O,PRODUCT_SIZE "
				   + " FROM SHOP "
				   + " ORDER BY PRODUCT_SEQ DESC) "
				   + " WHERE RNUM >= ? AND RNUM <= ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ProductDto> list = new ArrayList<ProductDto>();
		int start, end;
		start = 1 + 10 * pCount;
		end = 10 + 10 * pCount;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getProduct suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/6 getProduct suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getProduct suc");
			
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
			System.out.println("4/6 getProduct suc");
			
		} catch (Exception e) {
			System.out.println("getProduct fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);			
		}
		
		return list;
	}

	@Override
	public ProductDto detailProduct(int seq) {
		String sql = " SELECT PRODUCT_SEQ,CODE_NUMBER,PRODUCT_NAME,PRICE,PRODUCT_EXPLAIN,PRODUCT_IMAGE, "
				+ " COUNT_S,COUNT_M,COUNT_L,COUNT_O,PRODUCT_SIZE "
				+ " FROM SHOP "
			    + " WHERE PRODUCT_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		ProductDto dto = null;
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 detailProduct suc");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 detailProduct suc");
			rs = psmt.executeQuery();
			System.out.println("3/6 detailProduct suc");
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
			}
			System.out.println("4/6 detailProduct suc");
		} catch (Exception e) {
			System.out.println("detailProduct fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}

		return dto;
	}

	@Override
	public boolean updateProduct(ProductDto dto) {
		String sql = " UPDATE SHOP "
				+ " SET CODE_NUMBER=?,PRODUCT_NAME=?,COUNT_S=?, "
				+ " COUNT_M=?,COUNT_L=?,COUNT_O=?,PRICE=?,PRODUCT_EXPLAIN=?,PRODUCT_IMAGE=?, "
				+ " PRODUCT_SIZE=? " 
				+ " WHERE PRODUCT_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 updateProduct suc");
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, dto.getCode());
			psmt.setString(2, dto.getProductName());
			psmt.setInt(3, dto.getCount_s());
			psmt.setInt(4, dto.getCount_m());
			psmt.setInt(5, dto.getCount_l());
			psmt.setInt(6, dto.getCount_o());
			psmt.setInt(7, dto.getPrice());
			psmt.setString(8, dto.getProductExplain());
			psmt.setString(9, dto.getProductImage());
			psmt.setString(10, dto.getProductSize());
			psmt.setInt(11, dto.getSeq());
			System.out.println("2/6 updateProduct suc");
			count = psmt.executeUpdate();
			System.out.println("3/6 updateProduct suc");
		} catch (Exception e) {
			System.out.println("updateProduct fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		
		return count>0?true:false;
	}

	@Override
	public boolean deleteProduct(int seq) {
		String sql1 = " DELETE FROM ORDERLIST "
					+ " WHERE ORDER_PRODUCT_SEQ=? ";

		String sql2 = " DELETE FROM STORE_QNA "
					+ " WHERE QNA_PRODUCT_SEQ=? ";
		
		String sql3 = " DELETE FROM SHOP "
				    + " WHERE PRODUCT_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;

		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);

			psmt = conn.prepareStatement(sql1);
			psmt.setInt(1, seq);
			
			count = psmt.executeUpdate();
			psmt.clearParameters();
			
			psmt = conn.prepareStatement(sql2);
			psmt.setInt(1, seq);
			
			count = psmt.executeUpdate();
			psmt.clearParameters();
			
			psmt = conn.prepareStatement(sql3);
			psmt.setInt(1, seq);
			count = psmt.executeUpdate();
			conn.commit();
			
		} catch (Exception e) {
			System.out.println("deleteProduct fail");
			try {
				conn.rollback();
			} catch (SQLException e1) {}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBClose.close(psmt, conn, null);
		}
		
		return count>0?true:false;
	}

	@Override
	public String findImg(int seq) {
		String sql = " SELECT PRODUCT_IMAGE "
				   + " FROM SHOP "
				   + " WHERE PRODUCT_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String str = "";
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 findImg suc");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 findImg suc");
			rs = psmt.executeQuery();
			System.out.println("3/6 findImg suc");
			while(rs.next()) {
				str = rs.getString(1);
			}
			System.out.println("4/6 findImg suc");
		} catch (Exception e) {
			System.out.println("findImg fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return str;
	}

	@Override
	public int countProduct() {
		String sql = " SELECT COUNT(*) " + 
				 	" FROM SHOP ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int productCount = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 countProduct suc");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 countProduct suc");
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				productCount = rs.getInt(1);
			}
			System.out.println("3/6 countProduct suc");
			} catch (Exception e) {
				System.out.println("countProduct fail");
				e.printStackTrace();
			} finally {
				DBClose.close(psmt, conn, rs);		
			}		
		return productCount;
	}

	@Override
	public int findingCount(String sel, String fText) {
		String sql = " SELECT COUNT(*) "  
				+ " FROM SHOP ";
	
		if(sel.trim().equals("상품명")) {
			sql += " GROUP BY PRODUCT_NAME "
				 + " HAVING PRODUCT_NAME LIKE '%'||?||'%' ";
	
		}
		else if(sel.trim().equals("분류")) {
			sql += " GROUP BY CODE_NUMBER "
				 + " HAVING CODE_NUMBER=? ";
	
		}
		else if(sel.trim().equals("가격")) {
			sql += " GROUP BY PRICE "
				 + " HAVING PRICE=? ";
	
		}
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int productCount = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 findingCount suc");
			
			psmt = conn.prepareStatement(sql);
			if(sel.trim().equals("가격")) {
				psmt.setInt(1, Integer.parseInt(fText));
			}
			else {
				psmt.setString(1, fText);
			}
			System.out.println("2/6 findingCount suc");
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				productCount = rs.getInt(1);
			}
			System.out.println("3/6 findingCount suc");
			} catch (Exception e) {
				System.out.println("findingCount fail");
				e.printStackTrace();
			} finally {
				DBClose.close(psmt, conn, rs);		
	}		
		return productCount;
	}

	@Override
	public List<ProductDto> findProduct(String sel, String fText, int pCount) {
		
		String sql = " SELECT PRODUCT_SEQ,CODE_NUMBER,PRODUCT_NAME,PRICE,PRODUCT_EXPLAIN,PRODUCT_IMAGE, "
				   + " COUNT_S,COUNT_M,COUNT_L,COUNT_O,PRODUCT_SIZE "
				   + " FROM "
				   + " (SELECT ROW_NUMBER()OVER(ORDER BY PRODUCT_SEQ DESC) AS RNUM, " 
				   + " PRODUCT_SEQ,CODE_NUMBER,PRODUCT_NAME,PRICE,PRODUCT_EXPLAIN,PRODUCT_IMAGE, " 
				   + " COUNT_S,COUNT_M,COUNT_L,COUNT_O,PRODUCT_SIZE "
				   + " FROM SHOP ";
	
		
		if(sel.trim().equals("상품명")) {
			sql += " WHERE PRODUCT_NAME LIKE '%'||?||'%' "
				 + " ORDER BY PRODUCT_SEQ DESC) ";
		}
		else if(sel.trim().equals("분류")) {
			sql += " WHERE CODE_NUMBER=? "
			     + " ORDER BY PRODUCT_SEQ DESC) ";
		}
		else if(sel.trim().equals("가격")) {
			sql += " WHERE PRICE=? "
				 + " ORDER BY PRODUCT_SEQ DESC) ";
		}
		
		sql += " WHERE RNUM >= ? AND RNUM <= ? ";
		
		int start, end;
		start = 1 + 10 * pCount;
		end = 10 + 10 * pCount;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		List<ProductDto> list = new ArrayList<ProductDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 findProduct suc");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 findProduct suc");
			if(sel.trim().equals("가격")) {
				psmt.setInt(1, Integer.parseInt(fText));
				psmt.setInt(2, start);
				psmt.setInt(3, end);
				
			}
			else {
				psmt.setString(1, fText);
				psmt.setInt(2, start);
				psmt.setInt(3, end);
				
			}
			
			rs = psmt.executeQuery();
			System.out.println("3/6 findProduct suc");
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
				
				System.out.println("find dao: "+dto.toString());
				list.add(dto);
			}
			System.out.println("4/6 findProduct suc");
		} catch (Exception e) {
			System.out.println("findProduct fail");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}

		return list;
	}

	@Override
	public int getQnAPageCount(String category, String search, String searchtxt) {
								//     분류				검색항목			검색어
		String sql = " SELECT COUNT(*) "
					+ " FROM STORE_QNA ";
					
		
		if(category.equals("분류선택") && search.equals("선택")) {
				sql += " WHERE 1=1 ";
		}else {
			sql += " WHERE QNA_CATEGORY LIKE ? ";
			if(search.equals("작성자")) {
				sql += " AND QNA_EMAIL LIKE ? ";
			}else if(search.equals("제목")) {
				sql += " AND QNA_TITLE LIKE ? ";
			}else if(search.equals("내용")) {
				sql += " AND QNA_CONTENT LIKE ? ";
			}else if(search.equals("작성일")) {
				sql += " AND QNA_WDATE LIKE ? ";
			}else if(search.equals("선택")) {
				sql += " AND 1=1 ";
			}
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int pagecount = 0;
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			if(category.equals("분류선택") && search.equals("선택")) {
				rs = psmt.executeQuery();
			}else {
				if(category.equals("분류선택")) {
					psmt.setString(1, "%%");
				}else if(!category.equals("분류선택")){
					psmt.setString(1, "%" + category.trim() + "%");
					
				}
				if(!search.equals("선택")) {
					psmt.setString(2, "%" + searchtxt.trim() + "%");
				}
				rs = psmt.executeQuery();
			}
					
			while(rs.next()) {
				pagecount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		if(pagecount%20 == 0) {
			pagecount = pagecount / 20;
		}else {
			pagecount = (pagecount / 20) + 1;
		}
		return pagecount;
	}

	@Override
	public List<StoreQnADto> getQnAList(String category, String search, String searchtxt, int page) {
											//	     분류				검색항목			검색어
		String sql = " SELECT QNA_SEQ, QNA_PRODUCT_SEQ, "
				+ " QNA_TITLE, QNA_CATEGORY, QNA_CONTENT, QNA_WDATE, QNA_EMAIL, QNA_DEL, "
				+ " QNA_REF, QNA_STEP, QNA_DEPTH, QNA_PARENT "
				+ " FROM ( SELECT ROW_NUMBER() OVER(ORDER BY QNA_WDATE DESC) AS RNUM, "
						+ " QNA_SEQ, QNA_PRODUCT_SEQ, QNA_TITLE, QNA_CATEGORY, QNA_CONTENT, QNA_WDATE, QNA_EMAIL, QNA_DEL,"
						+ " QNA_REF, QNA_STEP, QNA_DEPTH, QNA_PARENT "
						+ " FROM STORE_QNA ";
		
		System.out.println("qna category : " + category);
		System.out.println("search category : " + search);
		System.out.println("searchtext : " + searchtxt);
				
		if(category.equals("분류선택") && search.equals("선택")) {
				sql += " WHERE 1=1 )";
				sql += " WHERE RNUM>=? AND RNUM<=? ";
				sql += " ORDER BY QNA_REF DESC, QNA_STEP ASC ";
		}else {
				sql += " WHERE QNA_CATEGORY LIKE ? ";
				if(search.equals("작성자")) {
					sql += " AND QNA_EMAIL LIKE ? )";
				}else if(search.equals("제목")) {
					sql += " AND QNA_TITLE LIKE ? )";
				}else if(search.equals("내용")) {
					sql += " AND QNA_CONTENT LIKE ? )";
				}else if(search.equals("작성일")) {
					sql += " AND QNA_WDATE LIKE ? )";
				}else if(search.equals("선택")) {
					sql += " AND 1=1 )";
				}
						
			sql += " WHERE RNUM>=? AND RNUM<=? ";
			sql += " ORDER BY QNA_REF DESC, QNA_STEP ASC ";
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<StoreQnADto> list = new ArrayList<StoreQnADto>();
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			if(category.equals("분류선택") && search.equals("선택")) {
				psmt.setInt(1, (20 * page)-19);
				psmt.setInt(2, (20 * page));
			}else {
				if(category.equals("분류선택")) {
					psmt.setString(1, "%%");
				}else {
					psmt.setString(1, "%" + category + "%");
				}
				if(!search.equals("선택")) {
					psmt.setString(2, "%" + searchtxt.trim() + "%");
					psmt.setInt(3, (20 * page)-19);
					psmt.setInt(4, (20 * page));
				}else {
					psmt.setInt(2, (20 * page)-19);
					psmt.setInt(3, (20 * page));
				}
				
			}
			
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
	public StoreQnADto detailQnA(int seq) {
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
	public boolean replyQnA(int seq, StoreQnADto dto) {
		// update
	
		String sql1 = " UPDATE STORE_QNA "
					+ " SET QNA_STEP=QNA_STEP+1 "
					+ " WHERE QNA_STEP>(SELECT QNA_STEP FROM STORE_QNA WHERE QNA_SEQ=?)"
					+ " AND QNA_REF=(SELECT QNA_REF FROM STORE_QNA WHERE QNA_SEQ=?) ";
		
		// insert
		String sql2 = " INSERT INTO STORE_QNA "
					+ " (QNA_SEQ, QNA_PRODUCT_SEQ, QNA_TITLE, QNA_CATEGORY, QNA_CONTENT, QNA_WDATE, QNA_EMAIL, QNA_DEL, "
					+ "  QNA_REF, QNA_STEP, QNA_DEPTH, QNA_PARENT) "
					+ " VALUES(STORE_QNA_SEQ.NEXTVAL, ?, ?, ?, ?, SYSDATE, ?, 0, "
					+ "(SELECT QNA_REF FROM STORE_QNA WHERE QNA_SEQ=?), "		// REF
					+ "(SELECT QNA_STEP FROM STORE_QNA WHERE QNA_SEQ=?)+1, "		// STEP
					+ "(SELECT QNA_DEPTH FROM STORE_QNA WHERE QNA_SEQ=?)+1, "	// DEPTH
					+ " ? )";
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);


			//update
			psmt = conn.prepareStatement(sql1);
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			
			count = psmt.executeUpdate();
			
			psmt.clearParameters();
			
			//insert
			psmt = conn.prepareStatement(sql2);
			psmt.setInt(1, dto.getQna_product_seq());
			
			psmt.setString(2, dto.getQna_title());
			psmt.setString(3, dto.getQna_category());
			psmt.setString(4, dto.getQna_content());
			psmt.setString(5, dto.getQna_email());
			
			psmt.setInt(6, seq);	// ref
			psmt.setInt(7, seq);	// step
			psmt.setInt(8, seq);	// depth
			
			psmt.setInt(9, seq);
			
			count = psmt.executeUpdate();
			conn.commit();
		} catch (SQLException e) {
			System.out.println("reply fail");
			try {
				conn.rollback();
			} catch (SQLException e1) {}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBClose.close(psmt, conn, null);
		}
				
		return count>0?true:false;
	}

	@Override
	public boolean deleteQnA(String[] seq) {
		String sql = " DELETE "
				+ " FROM STORE_QNA "
				+ " WHERE QNA_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int[] count = new int[seq.length];
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			
			psmt = conn.prepareStatement(sql);
			
			for (int i = 0; i < seq.length; i++) {
				psmt.setInt(1, Integer.parseInt(seq[i]));
				psmt.addBatch();
			}
			count = psmt.executeBatch();
			
			conn.commit();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			DBClose.close(psmt, conn, null);
		}
		
		boolean delcheck = true;
		for (int i = 0; i < count.length; i++) {
			if(count[i] != -2) {
				delcheck = false;
				break;
			}
		}
		
		return delcheck;
		
	}

	@Override
	public boolean updatecount(int product_seq, String product_size, int product_count, int num) {
		String sql = " UPDATE SHOP "
				+ " SET ";
				if (product_size.equals("S")) {
					sql = sql + "COUNT_S";
				}else if(product_size.equals("M")){
					sql = sql + "COUNT_M";
				}else if(product_size.equals("L")){
					sql = sql + "COUNT_L";
				}else if(product_size.equals("해당없음")){
					sql = sql + "COUNT_O";
				}
				sql = sql + " = ? "
				+ " WHERE PRODUCT_SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, num-product_count);
			psmt.setInt(2, product_seq);
			
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
	public int searchnum(int product_seq, String product_size) {
		String sql = " SELECT ";   
		if (product_size.equals("S")) {
			sql = sql + "COUNT_S";
		}else if(product_size.equals("M")){
			sql = sql + "COUNT_M";
		}else if(product_size.equals("L")){
			sql = sql + "COUNT_L";
		}else if(product_size.equals("해당없음")){
			sql = sql + "COUNT_O";
		}
		sql = sql + " FROM SHOP "
		   + " WHERE PRODUCT_SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int itemcount = 0;
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 findnum suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, product_seq); 
			System.out.println("2/6 findnum suc");
			
			rs =  psmt.executeQuery();
			System.out.println("3/6 findnum suc");
			while(rs.next()) {
			 itemcount = rs.getInt(1);
			}
			System.out.println("4/6 findnum suc");
		} catch (Exception e) {
			System.out.println("findnum fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		System.out.println("daonum"+itemcount);
		return itemcount;
	}
	
	@Override
	public List<OrderListDto> TodayOrderList(String today) {
		String sql = " SELECT * "
				   + " FROM ORDERLIST "
				   + " WHERE SUBSTR(ORDER_DATE,1,8)=? ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		List<OrderListDto> TodayOrderList = new ArrayList<OrderListDto>();
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 TodayOrderList suc");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, today);
			System.out.println("2/6 TodayOrderList suc");
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				System.out.println("여기들어옴?");
				int i = 1;
				OrderListDto dto = new OrderListDto(rs.getInt(i++),
												    rs.getString(i++),
												    rs.getString(i++),
												    rs.getString(i++),
												    rs.getString(i++),
												    rs.getString(i++),
												    rs.getString(i++),
												    rs.getInt(i++),
												    rs.getString(i++),
												    rs.getString(i++),
												    rs.getString(i++),
												    rs.getInt(i++),
												    rs.getInt(i++),
												    rs.getInt(i));
				TodayOrderList.add(dto);
				System.out.println("여기지나감?");
			}
			System.out.println("3/6 TodayOrderList suc");
		} catch (Exception e) {
			System.out.println("TodayOrderList fail");
			e.printStackTrace();
		} DBClose.close(psmt, conn, rs);
		
		
		
		return TodayOrderList;
	}
	
	@Override
	public List<StoreQnADto> TodayQnAList(String today) {

		String sql = " SELECT * "
				   + " FROM STORE_QNA "
				   + " WHERE TO_CHAR(QNA_WDATE,'YYYYMMDD')=? ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		List<StoreQnADto> TodayQnAList = new ArrayList<StoreQnADto>();
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 TodayQnAList suc");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, today);
			System.out.println("2/6 TodayQnAList suc");
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
						 						  rs.getInt(i));
				TodayQnAList.add(dto);
				
			}
			System.out.println("3/6 TodayQnAList suc");
		} catch (Exception e) {
			System.out.println("TodayQnAList fail");
			e.printStackTrace();
		} DBClose.close(psmt, conn, rs);
		
				
		return TodayQnAList;
	}
	
	@Override
	public List<MemberDto> getMember(int mCount) {
		String sql = " SELECT MEMBER_SEQ,EMAIL,PASSWORD,ADDRESS,PHONENUMBER, "
				   + " USERNAME,MEMBER_DATE,AUTH "
				   + " FROM "
				   + " (SELECT ROW_NUMBER()OVER(ORDER BY MEMBER_SEQ DESC) AS RNUM, " 
				   + " MEMBER_SEQ, EMAIL, PASSWORD, ADDRESS, PHONENUMBER, " 
				   + " USERNAME, MEMBER_DATE, AUTH "
				   + " FROM MEMBER "
				   + " ORDER BY MEMBER_SEQ DESC) "
				   + " WHERE RNUM >= ? AND RNUM <= ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<MemberDto> list = new ArrayList<MemberDto>();
		int start, end;
		start = 1 + 10 * mCount;
		end = 10 + 10 * mCount;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getMember suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/6 getMember suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getMember suc");
			
			while(rs.next()) {
				int i = 1;
				MemberDto dto = new MemberDto(rs.getInt(i++),
										  rs.getString(i++),
										  rs.getString(i++),
										  rs.getString(i++),
										  rs.getString(i++),
										  rs.getString(i++),
										  rs.getString(i++),
										  rs.getInt(i));
						
				list.add(dto);
			}	
			System.out.println("4/6 getMember suc");
			
		} catch (Exception e) {
			System.out.println("getMember fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);			
		}
		
		return list;
	}
	
	@Override
	public int CountMember() {
		String sql = " SELECT COUNT(*) "  
			 	+" FROM MEMBER ";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	int MemberCount = 0;
	
	try {
		conn = DBConnection.getConnection();
		System.out.println("1/6 CountMember suc");
		
		psmt = conn.prepareStatement(sql);
		System.out.println("2/6 CountMember suc");
		
		rs = psmt.executeQuery();
		
		if(rs.next()) {
			MemberCount = rs.getInt(1);
		}
		System.out.println("3/6 CountMember suc");
		} catch (Exception e) {
			System.out.println("CountMember fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);			
		}		
	return MemberCount;
	}

	@Override
	public int findCountMember(String sel, String fText) {
		String sql = " SELECT COUNT(*) "  
		 	    +" FROM MEMBER ";

		if(sel.trim().equals("이메일")) {
			sql += " WHERE EMAIL=? ";
		}
		else if(sel.trim().equals("이름")) {
			sql += " WHERE USERNAME LIKE '%'||?||'%' ";
		}
		else if(sel.trim().equals("전화번호")) {
			sql += " WHERE PHONENUMBER=? ";
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
	
		int MemberCount = 0;

	try {
		conn = DBConnection.getConnection();
		System.out.println("1/6 findCountMember suc");
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, fText);
		System.out.println("2/6 findCountMember suc");
		
		rs = psmt.executeQuery();
		
		if(rs.next()) {
			MemberCount = rs.getInt(1);
		}
		System.out.println("3/6 findCountMember suc");
		} catch (Exception e) {
			System.out.println("findCountMember fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);			
		}		
		return MemberCount;
	}
	
	
	@Override
	public List<MemberDto> findMember(String sel, String fText, int mCount) {

		String sql = " SELECT MEMBER_SEQ,EMAIL,PASSWORD,ADDRESS,PHONENUMBER, "
				   + " USERNAME,MEMBER_DATE,AUTH "
				   + " FROM "
				   + " (SELECT ROW_NUMBER()OVER(ORDER BY MEMBER_SEQ DESC) AS RNUM, " 
				   + " MEMBER_SEQ, EMAIL, PASSWORD, ADDRESS, PHONENUMBER, " 
				   + " USERNAME, MEMBER_DATE, AUTH "
				   + " FROM MEMBER ";

		
		if(sel.trim().equals("이메일")) {
			sql += " WHERE EMAIL=? "
				 + " ORDER BY MEMBER_SEQ DESC) ";
		}
		else if(sel.trim().equals("이름")) {
			sql += " WHERE USERNAME LIKE '%'||?||'%' "
				 + " ORDER BY MEMBER_SEQ DESC) ";
		}
		else if(sel.trim().equals("전화번호")) {
			sql += " WHERE PHONENUMBER=? "
				 + " ORDER BY MEMBER_SEQ DESC) ";
		}
		
		sql += " WHERE RNUM>=? AND RNUM<=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<MemberDto> list = new ArrayList<MemberDto>();
		int start, end;
		start = 1 + 10 * mCount;
		end = 10 + 10 * mCount;
		System.out.println("start:"+start+"end:"+end);
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 findMember suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, fText);
			psmt.setInt(2, start);
			psmt.setInt(3, end);
			System.out.println("2/6 findMember suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 findMember suc");
			
			while(rs.next()) {
				int i = 1;
				MemberDto dto = new MemberDto(rs.getInt(i++),
										  rs.getString(i++),
										  rs.getString(i++),
										  rs.getString(i++),
										  rs.getString(i++),
										  rs.getString(i++),
										  rs.getString(i++),
										  rs.getInt(i));
						
				list.add(dto);
			}	
			System.out.println("4/6 findMember suc");
			
		} catch (Exception e) {
			System.out.println("findMember fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);			
		}
		
		return list;
	}

	

	@Override
	public boolean DeleteMember(int seq) {
		
		
		String sql = " DELETE FROM MEMBER "
				   + " WHERE MEMBER_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 DeleteMember suc");
			psmt = conn.prepareStatement(sql);
			
			psmt.setInt(1,seq);
			System.out.println("2/6 DeleteMember suc");
			count = psmt.executeUpdate();
			System.out.println("3/6 DeleteMember suc");
		} catch (Exception e) {
			System.out.println("DeleteMember fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		
		return count>0?true:false;
	}

	@Override
	public MemberDto memberDetail(int seq) {
		String sql = " SELECT EMAIL,PASSWORD,ADDRESS, "
				   + " PHONENUMBER,AUTH,USERNAME "
				   + " FROM MEMBER "
				   + " WHERE MEMBER_SEQ=? ";
		

		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		MemberDto memDto = null;
		try {
			conn = DBConnection.getConnection();
			System.out.println("memberDetail 1/6 suc");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("memberDetail 2/6 suc");
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				memDto = new MemberDto(rs.getString(1),
									rs.getString(2),
									 rs.getString(3),
							     rs.getString(4),
							        rs.getString(6),
							            rs.getInt(5));
			}
			System.out.println("memberDetail 3/6 suc");
		} catch (Exception e) {
			System.out.println("memberDetail fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
				
		return memDto;
	}

	@Override
	public List<Integer> MonthlyTotalPrice(String[] month) {
		
		String sql = " SELECT SUM(ORDER_PRODUCT_PRICE)"
				   + " FROM ORDERLIST"
				   + " WHERE SUBSTR(ORDER_DATE,5,2)=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		List<Integer> priceList = new ArrayList<Integer>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 MonthlyTotalPrice suc");
			for (int i = 0; i < month.length; i++) {
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, month[i]);
				System.out.println("2/6 MonthlyTotalPrice["+i+"] suc");
				rs = psmt.executeQuery();
				if(rs.next()) {
					priceList.add(rs.getInt(1));
					System.out.println("3/6 MonthlyTotalPrice["+i+"] not null suc");
				}
				else {
					priceList.add(0);
					System.out.println("3/6 MonthlyTotalPrice["+i+"] null suc");
				}
			}


		} catch (Exception e) {
			System.out.println("MonthlyTotalPrice fail");
			e.printStackTrace();
		}
		
		finally {
			DBClose.close(psmt, conn, rs);
		}

		return priceList;
	}

	@Override
	public List<Integer> MonthlyTotalCount(String[] month) {
		
		String sql = " SELECT SUM(ORDER_PRODUCT_COUNT)"
				   + " FROM ORDERLIST"
				   + " WHERE SUBSTR(ORDER_DATE,5,2)=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		List<Integer> CountList = new ArrayList<Integer>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 MonthlyTotalCount suc");
			for (int i = 0; i < month.length; i++) {
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, month[i]);
				System.out.println("2/6 MonthlyTotalPrice["+i+"] suc");
				rs = psmt.executeQuery();
				if(rs.next()) {
					CountList.add(rs.getInt(1));
					System.out.println("3/6 MonthlyTotalPrice["+i+"] not null suc");
				}
				else {
					CountList.add(0);
					System.out.println("3/6 MonthlyTotalPrice["+i+"] null suc");
				}
			}
		} catch (Exception e) {
			System.out.println("MonthlyTotalCount fail");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}

		return CountList;
	}
	
	@Override
	public List<OrderListDto> order_list(int oCount) {
		String sql = " SELECT ORDERLIST_SEQ,ORDER_DATE,ORDER_EMAIL,ORDER_NAME,ORDER_ADDRESS,ORDER_PHONENUMBER, "
				   + " ORDER_REQUEST,ORDER_PRODUCT_SEQ,ORDER_PRODUCT_NAME,ORDER_PRODUCT_IMAGE,ORDER_PRODUCT_SIZE,"
				   + " ORDER_PRODUCT_COUNT,ORDER_PRODUCT_PRICE,ORDER_DELIVERYSTATUS "
				   + " FROM "
				   + " (SELECT ROW_NUMBER()OVER(ORDER BY ORDERLIST_SEQ DESC) AS RNUM, "
				   + " ORDERLIST_SEQ,ORDER_DATE,ORDER_EMAIL,ORDER_NAME,ORDER_ADDRESS,ORDER_PHONENUMBER, "
				   + " ORDER_REQUEST,ORDER_PRODUCT_SEQ,ORDER_PRODUCT_NAME,ORDER_PRODUCT_IMAGE,ORDER_PRODUCT_SIZE,"
				   + " ORDER_PRODUCT_COUNT,ORDER_PRODUCT_PRICE,ORDER_DELIVERYSTATUS"
				   + " FROM ORDERLIST "
				   + " ORDER BY ORDERLIST_SEQ DESC) "
				   + " WHERE RNUM >=? AND RNUM<=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<OrderListDto> list = new ArrayList<>();
		int start, end;
		start = 1 + 10 * oCount;
		end = 10 + 10 * oCount;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 order_list suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/6 order_list suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 order_list suc");
			
			while(rs.next()) {
				int i = 1;
				OrderListDto dto = new OrderListDto(rs.getInt(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getInt(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getInt(i++),
													rs.getInt(i++),
													rs.getInt(i++));
				list.add(dto);
			}	
			System.out.println("4/6 getProduct suc");
			
		} catch (Exception e) {
			System.out.println("getProduct fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);			
		}
		
		return list;
	}

	@Override
	public int CountOrder() {
		String sql = " SELECT COUNT(*) " + 
			 		 " FROM ORDERLIST ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int CountOrder = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 CountOrder suc");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 CountOrder suc");
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				CountOrder = rs.getInt(1);
			}
			System.out.println("3/6 CountOrder suc");
			} catch (Exception e) {
				System.out.println("CountOrder fail");
				e.printStackTrace();
			} finally {
				DBClose.close(psmt, conn, rs);		
			}		
		return CountOrder;
	}

	@Override
	public OrderListDto Order_Detail(int seq) {
		String sql = " SELECT ORDERLIST_SEQ,ORDER_DATE,ORDER_EMAIL,ORDER_NAME,ORDER_ADDRESS,ORDER_PHONENUMBER, "
				   + " ORDER_REQUEST,ORDER_PRODUCT_SEQ,ORDER_PRODUCT_NAME,ORDER_PRODUCT_IMAGE,ORDER_PRODUCT_SIZE,"
				   + " ORDER_PRODUCT_COUNT,ORDER_PRODUCT_PRICE,ORDER_DELIVERYSTATUS "
				   + " FROM ORDERLIST "
				   + " WHERE ORDERLIST_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		OrderListDto oDto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 Order_Detail suc");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 Order_Detail suc");
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				System.out.println("Order_Detail 여기들어옴?");
				int i = 1;
						   oDto =  new OrderListDto(rs.getInt(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getInt(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getInt(i++),
													rs.getInt(i++),
													rs.getInt(i++));
				
			System.out.println("Order_Detail 여기까지옴?");		   
			}
			System.out.println("3/6 Order_Detail suc");
		} catch (SQLException e) {
			System.out.println("Order_Detail fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		
		
		return oDto;
	}

	@Override
	public int FindOrderCount(String sel, String fText) {
		String sql = " SELECT COUNT(*) "  
					+" FROM ORDERLIST ";

		if(sel.trim().equals("이메일")) {
			sql += " WHERE ORDER_EMAIL=? ";
		}
		else if(sel.trim().equals("전화번호")) {
			sql += " WHERE ORDER_PHONENUMBER=? ";
		}
		else if(sel.trim().equals("상품명")) {
			sql += " WHERE ORDER_PRODUCT_NAME LIKE '%'||?||'%' ";
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
	
		int FindOrderCount = 0;

	try {
		conn = DBConnection.getConnection();
		System.out.println("1/6 FindOrderCount suc");
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, fText);
		System.out.println("2/6 FindOrderCount suc");
		
		rs = psmt.executeQuery();
		
		if(rs.next()) {
			FindOrderCount = rs.getInt(1);
		}
		System.out.println("3/6 FindOrderCount suc");
		} catch (Exception e) {
			System.out.println("FindOrderCount fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);			
		}		
		return FindOrderCount;
	}

	@Override
	public List<OrderListDto> FindOrderList(String sel, String fText, int oCount) {
		String sql = " SELECT ORDERLIST_SEQ,ORDER_DATE,ORDER_EMAIL,ORDER_NAME,ORDER_ADDRESS,ORDER_PHONENUMBER, "
				   + " ORDER_REQUEST,ORDER_PRODUCT_SEQ,ORDER_PRODUCT_NAME,ORDER_PRODUCT_IMAGE,ORDER_PRODUCT_SIZE,"
				   + " ORDER_PRODUCT_COUNT,ORDER_PRODUCT_PRICE,ORDER_DELIVERYSTATUS "
				   + " FROM "
				   + " (SELECT ROW_NUMBER()OVER(ORDER BY ORDERLIST_SEQ DESC) AS RNUM, "
				   + " ORDERLIST_SEQ,ORDER_DATE,ORDER_EMAIL,ORDER_NAME,ORDER_ADDRESS,ORDER_PHONENUMBER, "
				   + " ORDER_REQUEST,ORDER_PRODUCT_SEQ,ORDER_PRODUCT_NAME,ORDER_PRODUCT_IMAGE,ORDER_PRODUCT_SIZE,"
				   + " ORDER_PRODUCT_COUNT,ORDER_PRODUCT_PRICE,ORDER_DELIVERYSTATUS"
				   + " FROM ORDERLIST ";

		
		if(sel.trim().equals("이메일")) {
			sql += " WHERE ORDER_EMAIL=? "
				 + " ORDER BY ORDERLIST_SEQ DESC) ";
		}
		else if(sel.trim().equals("전화번호")) {
			sql += " WHERE ORDER_PHONENUMBER=? "
				 + " ORDER BY ORDERLIST_SEQ DESC) ";
		}
		else if(sel.trim().equals("상품명")) {
			sql += " WHERE ORDER_PRODUCT_NAME LIKE '%'||?||'%' "
				 + " ORDER BY ORDERLIST_SEQ DESC) ";
		}
		
		sql += " WHERE RNUM>=? AND RNUM<=? ";
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<OrderListDto> list = new ArrayList<>();
		int start, end;
		start = 1 + 10 * oCount;
		end = 10 + 10 * oCount;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 FindOrderList suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, fText);
			psmt.setInt(2, start);
			psmt.setInt(3, end);
			System.out.println("2/6 FindOrderList suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 FindOrderList suc");
			
			while(rs.next()) {
				int i = 1;
				OrderListDto dto = new OrderListDto(rs.getInt(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getInt(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getString(i++),
													rs.getInt(i++),
													rs.getInt(i++),
													rs.getInt(i++));
				list.add(dto);
			}	
			System.out.println("4/6 FindOrderList suc");
			
		} catch (Exception e) {
			System.out.println("FindOrderList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);			
		}
		
		return list;
	}
	
	
	
}
