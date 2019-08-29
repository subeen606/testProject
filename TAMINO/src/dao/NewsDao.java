package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import DB.DBClose;
import DB.DBConnection;
import dto.NewsDto;



public class NewsDao implements iNewsDao{

	private static NewsDao dao = new NewsDao();
	
	private NewsDao() {
	}
	
	public static NewsDao getInstance() {
		return dao;
	}
	//photo list
	@Override
	public List<NewsDto> getNewsList() {
		
		String sql = " SELECT MENU_NUM, TITLE, CONTENT, NEWS_SEQ, NEWS_DATE, "
						+ " NEWS_READCOUNT, DEL, FILENAME "
						+ " FROM NEWS "
						+ " WHERE MENU_NUM = 0 "
						+ " AND DEL = 0 "
						+ " ORDER BY NEWS_SEQ DESC";
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<NewsDto> list = new ArrayList<NewsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getNewsList suc");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getNewsList suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getNewsList suc");
			
			while(rs.next()) {
				NewsDto dto = new NewsDto(rs.getInt(1),
										rs.getString(2), 
										rs.getString(3), 
										rs.getInt(4), 
										rs.getString(5), 
										rs.getInt(6), 
										rs.getInt(7), 
										rs.getString(8));
				
				list.add(dto);
			}
			System.out.println("4/6 getNewsList suc");
			
		} catch (Exception e) {
			System.out.println("getNewsList fail");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}

	//video list
	@Override
	public List<NewsDto> getvideoList() {
		
		String sql = " SELECT MENU_NUM, TITLE, CONTENT, NEWS_SEQ, NEWS_DATE, "
						+ " NEWS_READCOUNT, DEL, FILENAME "
						+ " FROM NEWS "
						+ " WHERE MENU_NUM = 1 "
						+ " AND DEL = 0 "
						+ " ORDER BY NEWS_SEQ DESC";
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<NewsDto> list = new ArrayList<NewsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getNewsList suc");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getNewsList suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getNewsList suc");
			
			while(rs.next()) {
				
				NewsDto dto = new NewsDto(rs.getInt(1),
										rs.getString(2), 
										rs.getString(3), 
										rs.getInt(4), 
										rs.getString(5), 
										rs.getInt(6), 
										rs.getInt(7), 
										rs.getString(8));
				
				list.add(dto);
			}
			System.out.println("4/6 getNewsList suc");
			
		} catch (Exception e) {
			System.out.println("getNewsList fail");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return list;
	}
	
	
	//photo 게시글 올리기
	@Override
	public boolean upfile(NewsDto dto) {
		String sql = " INSERT INTO NEWS( MENU_NUM, TITLE, CONTENT, NEWS_SEQ, NEWS_DATE, "
					+" NEWS_READCOUNT, DEL, FILENAME) "
	                +" VALUES(0,?,?,NEWS_SEQ.NEXTVAL,SYSDATE,0, "
	                +" 0,?) ";
		
		int count = 0;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
	
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 upfile Success");	
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 upfile Success");
			
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getFilename());
			
			count = psmt.executeUpdate();
			System.out.println("3/6 upfile Success");
						
		} catch (Exception e) {
			System.out.println("upfile Fail");
		} finally {
			DBClose.close(psmt, conn, null);			
		}
				
		return count>0?true:false;
	}
	
	//video 게시글 올리기
	@Override
	public boolean upvideo(NewsDto dto) {
		String sql = " INSERT INTO NEWS( MENU_NUM, TITLE, CONTENT, NEWS_SEQ, NEWS_DATE, "
				+" NEWS_READCOUNT, DEL, FILENAME) "
                +" VALUES(1,?,?,NEWS_SEQ.NEXTVAL,SYSDATE,0, "
                +" 0,?) ";
	
	int count = 0;
	
	Connection conn = null;
	PreparedStatement psmt = null;
	

	
	try {
		conn = DBConnection.getConnection();
		System.out.println("1/6 upfile Success");	
		
		psmt = conn.prepareStatement(sql);
		System.out.println("2/6 upfile Success");
		
		psmt.setString(1, dto.getTitle());
		psmt.setString(2, dto.getContent());
		psmt.setString(3, dto.getFilename());
		
		count = psmt.executeUpdate();
		System.out.println("3/6 upfile Success");
					
	} catch (Exception e) {
		System.out.println("upfile Fail");
	} finally {
		DBClose.close(psmt, conn, null);			
	}
			
	return count>0?true:false;
	}

	//detail가져오기
	@Override
	public NewsDto getNews(int seq) {
		String sql = " SELECT MENU_NUM, TITLE, CONTENT, NEWS_SEQ, NEWS_DATE, "
				+ "NEWS_READCOUNT, DEL, FILENAME "
				+ " FROM NEWS "
				+ " WHERE NEWS_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		NewsDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getnews Success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 getnews Success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getnews Success");
			
			if(rs.next()) {				
				dto = new NewsDto(rs.getInt(1), 
							rs.getString(2), 
							rs.getString(3), 
							rs.getInt(4), 
							rs.getString(5), 
							rs.getInt(6), 
							rs.getInt(7), 
							rs.getString(8));
				System.out.println("4/6 getnews Success");
			}
			
		} catch (Exception e) {
			System.out.println("getnews fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);		
		}
		
		return dto;
	}
	
	
	
	//readcount
	@Override
	public void readcount(int seq) {
		String sql = " UPDATE NEWS SET "
				+ " NEWS_READCOUNT=NEWS_READCOUNT+1 "
				+ " WHERE NEWS_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 readcount Success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 readcount Success");
			
			psmt.executeUpdate();
			System.out.println("3/6 readcount Success");			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);			
		}
		
	}

	//게시글 삭제
	@Override
	public boolean delete(int seq) {
		String sql = "  UPDATE NEWS SET "
				+ " DEL=1 "
				+ " WHERE NEWS_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 delete Success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 delete Success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 delete Success");			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);			
		}
		return count>0?true:false;
	}

	//수정
	@Override
	public boolean update(int seq, String title, String filename, String content) {
		String sql = " UPDATE NEWS SET "
				+ " TITLE=?, CONTENT=?, FILENAME=? "
				+ " WHERE NEWS_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, filename);
			psmt.setInt(4, seq);
			
			System.out.println("3/6 S updatenews");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S updatenewss");
			
		} catch (Exception e) {			
			e.printStackTrace();
		} finally{
			DBClose.close(psmt, conn, null);
			System.out.println("5/6 S updatenews");
		}		
		
		return count>0?true:false;
	}

	//detail 아래 News
	@Override
	public List<NewsDto> getdetailList(int seq) {
		String sql = " SELECT MENU_NUM, TITLE, CONTENT, NEWS_SEQ, NEWS_DATE, "
						+ " NEWS_READCOUNT, DEL, FILENAME "
						+ " FROM NEWS "
						+ " WHERE NEWS_SEQ < ? "
						+ " AND MENU_NUM = 0 "
						+ "	AND DEL = 0 "
						+ " ORDER BY NEWS_SEQ DESC";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<NewsDto> list = new ArrayList<NewsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getNewsList suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
		
		
			System.out.println("2/6 getNewsList suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getNewsList suc");
			
			while(rs.next()) {
				
				NewsDto dto = new NewsDto(rs.getInt(1),
										rs.getString(2), 
										rs.getString(3), 
										rs.getInt(4), 
										rs.getString(5), 
										rs.getInt(6), 
										rs.getInt(7), 
										rs.getString(8));
				
				list.add(dto);
			}
			System.out.println("4/6 getNewsList suc");
			
		} catch (Exception e) {
			System.out.println("getNewsList fail");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return list;
	}

	@Override
	public boolean deletevideo(String seqs[]) {
		String sql = "  UPDATE NEWS SET "
				+ " DEL=1 "
				+ " WHERE NEWS_SEQ=? ";
		
		Connection conn = null;   //위에 랑 연결
		PreparedStatement psmt = null;
	   
	   int count[] = new int[seqs.length];
	   
	   try {
		
		   conn = DBConnection.getConnection();
		   conn.setAutoCommit(false);
		
		psmt = conn.prepareStatement(sql);
		
		for (int i = 0; i < seqs.length; i++) {
			psmt.setString(1, seqs[i]);
			psmt.addBatch(); //새로운값을 넣고 진행하여라
			
		}
		count = psmt.executeBatch(); //한꺼번에 처리해줄때
		
		conn.commit();
		
		
		
	} catch (Exception e) {
		
		e.printStackTrace();
		
		try {
			conn.rollback();
		} catch (Exception e1) {
			
			e1.printStackTrace();
		}
	}finally {
		try {
			conn.setAutoCommit(true);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DBClose.close(psmt, conn, null);	
	}
	   
	   boolean isS = true;
	   
	   for (int i = 0; i < count.length; i++) {
		if (count[i] != -2) {	//-2 == 정상종료  (배열중 하나라도 -2가 나오면 정상종료가 아니다)
			isS = false;
			break;
		}
	}
	   return isS;
	}
	
	
	
}
