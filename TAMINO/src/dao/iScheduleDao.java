package dao;

import java.util.List;

import dto.ScheduleDto;

public interface iScheduleDao {
	
	public List<ScheduleDto> getScheduleList();
	
	//public boolean writeSchedule(ScheduleDto dto);
	
}
