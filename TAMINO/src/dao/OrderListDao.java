package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;



import DB.DBClose;
import DB.DBConnection;
import dto.OrderListDto;


public class OrderListDao implements iOrderListDao{

	private static OrderListDao dao = new OrderListDao();
	
	public OrderListDao() {
		
	}
	
	public static OrderListDao getInstance() {
		return dao;
	}

	
	//모든정보 가져오는 list
	@Override
	public List<OrderListDto> getOrderList() {
			String sql = " SELECT ORDERLIST_SEQ, ORDER_DATE, ORDER_EMAIL, ORDER_NAME, "
					+ " ORDER_ADDRESS, ORDER_PHONENUMBER, ORDER_REQUEST "
					+ " ORDER_PRODUCT_SEQ, ORDER_PRODUCT_NAME, ORDER_PRODUCT_IMAGE, ORDER_PRODUCT_SIZE "
					+ " ORDER_PRODUCT_COUNT, ORDER_PRODUCT_PRICE, ORDER_DELIVERYSTATUS "
					+ " FROM ORDERLIST "
					+ " ORDER BY ORDER_DATE DESC";
	
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			List<OrderListDto> list = new ArrayList<OrderListDto>();
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/6 getOrderList suc");
				
				psmt = conn.prepareStatement(sql);
				System.out.println("2/6 getOrderList suc");
				
				rs = psmt.executeQuery();
				System.out.println("3/6 getOrderList suc");
				
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
				System.out.println("4/6 getOrderList suc");
				
			} catch (Exception e) {
				System.out.println("getOrderList fail");
				e.printStackTrace();
			}finally {
				DBClose.close(psmt, conn, rs);
			}
			
			return list;
			}
	
	
	//주문추가
	@Override
	public Boolean addorder(OrderListDto dto) {
			String sql = " INSERT INTO ORDERLIST(ORDERLIST_SEQ, ORDER_DATE, ORDER_EMAIL, ORDER_NAME, " 
										+ " ORDER_ADDRESS, ORDER_PHONENUMBER, ORDER_REQUEST, " 
										+ " ORDER_PRODUCT_SEQ, ORDER_PRODUCT_NAME, ORDER_PRODUCT_IMAGE, ORDER_PRODUCT_SIZE, " 
										+ " ORDER_PRODUCT_COUNT, ORDER_PRODUCT_PRICE, ORDER_DELIVERYSTATUS) "
										+ " VALUES(ORDERLIST_SEQ.NEXTVAL, TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS'),?,?,?,?,?,?,?,?,?,?,?,1) ";
		
			int count = 0;
			
			Connection conn = null;
			PreparedStatement psmt = null;
		
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/6 addorder Success");	
				
				psmt = conn.prepareStatement(sql);
				System.out.println("2/6 addorder Success");
				
				psmt.setString(1, dto.getOrder_email());
				psmt.setString(2, dto.getOrder_name());
				psmt.setString(3, dto.getOrder_address());
				psmt.setString(4, dto.getOrder_phonenumber());
				psmt.setString(5, dto.getOrder_request());
				psmt.setInt(6, dto.getProduct_seq());
				psmt.setString(7, dto.getProduct_name());
				psmt.setString(8, dto.getProduct_image());
				psmt.setString(9, dto.getProduct_size());
				psmt.setInt(10, dto.getProduct_count());
				psmt.setInt(11, dto.getProduct_price());
				
				count = psmt.executeUpdate();
				System.out.println("3/6 addorder Success");
				
							
			} catch (Exception e) {
				System.out.println("addorder Fail");
				e.printStackTrace();
			} finally {
				DBClose.close(psmt, conn, null);			
			}
			return count>0?true:false;
	}

	@Override
	public List<OrderListDto> getResultList(String _today, String order_email){
			String sql = " SELECT ORDERLIST_SEQ, ORDER_DATE, ORDER_EMAIL, ORDER_NAME, " 
					+ " ORDER_ADDRESS, ORDER_PHONENUMBER, ORDER_REQUEST, " 
					+ " ORDER_PRODUCT_SEQ, ORDER_PRODUCT_NAME, ORDER_PRODUCT_IMAGE, ORDER_PRODUCT_SIZE, " 
					+ " ORDER_PRODUCT_COUNT, ORDER_PRODUCT_PRICE, ORDER_DELIVERYSTATUS "
					+ "	FROM ORDERLIST "
					+ "	WHERE ORDER_EMAIL = ? "
					+ " AND ORDER_DATE LIKE ? ";
					
		
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			List<OrderListDto> list = new ArrayList<OrderListDto>();
			
			try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 resultlist Success");	
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 resultlist Success");
			
			
			psmt.setString(1, order_email);
			psmt.setString(2, _today+"%");
			
			System.out.println("3/6 resultlist Success");
			rs = psmt.executeQuery();
			System.out.println("4/6 resultlist Success");
			
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
			
			
			} catch (Exception e) {
			System.out.println("resultlist Fail");
			e.printStackTrace();
			} finally {
			DBClose.close(psmt, conn, null);			
			}
			
			return list;
	}

	@Override
	public boolean insertOrderList(List<OrderListDto> list) {
		String sql = " INSERT INTO ORDERLIST(ORDERLIST_SEQ, ORDER_DATE, ORDER_EMAIL, ORDER_NAME, " 
				+ " ORDER_ADDRESS, ORDER_PHONENUMBER, ORDER_REQUEST, " 
				+ " ORDER_PRODUCT_SEQ, ORDER_PRODUCT_NAME, ORDER_PRODUCT_IMAGE, ORDER_PRODUCT_SIZE, " 
				+ " ORDER_PRODUCT_COUNT, ORDER_PRODUCT_PRICE, ORDER_DELIVERYSTATUS) "
				+ " VALUES(ORDERLIST_SEQ.NEXTVAL, TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS'),?,?,?,?,?,?,?,?,?,?,?,1) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int[] count = new int[list.size()];
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			
			psmt = conn.prepareStatement(sql);
			
			for (int i = 0; i < list.size(); i++) {
				psmt.setString(1, list.get(i).getOrder_email());
				psmt.setString(2, list.get(i).getOrder_name());
				psmt.setString(3, list.get(i).getOrder_address());
				psmt.setString(4, list.get(i).getOrder_phonenumber());
				psmt.setString(5,list.get(i).getOrder_request());
				psmt.setInt(6, list.get(i).getProduct_seq());
				psmt.setString(7, list.get(i).getProduct_name());
				psmt.setString(8, list.get(i).getProduct_image());
				psmt.setString(9, list.get(i).getProduct_size());
				psmt.setInt(10, list.get(i).getProduct_count());
				psmt.setInt(11, list.get(i).getProduct_price());
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
		
		boolean insertcheck = true;
		for (int i = 0; i < count.length; i++) {
			if(count[i] != -2) {
				insertcheck = false;
				break;
			}
		}
		
		return insertcheck;
	}
	
	
	
	
}
