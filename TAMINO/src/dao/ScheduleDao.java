package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DB.DBConnection;
import dto.ScheduleDto;

public class ScheduleDao implements iScheduleDao{
	
	private static ScheduleDao dao = new ScheduleDao();
	
	private ScheduleDao() {
		DBConnection.initConnection();
	}
	
	public static ScheduleDao getInstance() {
		return dao;
	}

	@Override
	public List<ScheduleDto> getScheduleList() {
		String sql = " SELECT SCHEDULE_SEQ, SCHEDULE_DATE, SCHEDULE_TIME, "
					+ " SCHEDULE_PLACE, SCHEDULE_TITLE, SCHEDULE_CONTENT, TICKETLINK, SCHEDULE_POSTER "
					+ " FROM SCHEDULE "
					+ " ORDER BY SCHEDULE_DATE ASC, SCHEDULE_TIME ASC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ScheduleDto> list = new ArrayList<ScheduleDto>();
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
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
		}
		
		return list;
	}

	/*
	@Override
	public boolean writeSchedule(ScheduleDto dto) {
		String sql = " INSERT INTO SCHEDULE "
					+ " VALUES(SCHEDULE_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?) ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		System.out.println("writeSchedule"+dto.toString());
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
		}
		
		return count>0?true:false;
	}
	*/
	
	
	
}
