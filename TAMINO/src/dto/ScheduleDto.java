package dto;

import java.io.Serializable;

public class ScheduleDto implements Serializable{
	
	private int seq;
	private String schedule_date;
	private String schedule_time;
	private String schedule_place;
	private String schedule_title;
	private String schedule_content;
	private String ticketLink;
	private String schedule_poster;
	
	public ScheduleDto() {
	}
	
	public ScheduleDto(int seq, String schedule_date, String schedule_time, String schedule_place,
			String schedule_title, String schedule_content, String ticketLink, String schedule_poster) {
		super();
		this.seq = seq;
		this.schedule_date = schedule_date;
		this.schedule_time = schedule_time;
		this.schedule_place = schedule_place;
		this.schedule_title = schedule_title;
		this.schedule_content = schedule_content;
		this.ticketLink = ticketLink;
		this.schedule_poster = schedule_poster;
	}
	
	public ScheduleDto(String schedule_date, String schedule_time, String schedule_place,
			String schedule_title, String schedule_content, String ticketLink, String schedule_poster) {
		super();
		this.schedule_date = schedule_date;
		this.schedule_time = schedule_time;
		this.schedule_place = schedule_place;
		this.schedule_title = schedule_title;
		this.schedule_content = schedule_content;
		this.ticketLink = ticketLink;
		this.schedule_poster = schedule_poster;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getSchedule_date() {
		return schedule_date;
	}

	public void setSchedule_date(String schedule_date) {
		this.schedule_date = schedule_date;
	}

	public String getSchedule_time() {
		return schedule_time;
	}

	public void setSchedule_time(String schedule_time) {
		this.schedule_time = schedule_time;
	}

	public String getSchedule_place() {
		return schedule_place;
	}

	public void setSchedule_place(String schedule_place) {
		this.schedule_place = schedule_place;
	}

	public String getSchedule_title() {
		return schedule_title;
	}

	public void setSchedule_title(String schedule_title) {
		this.schedule_title = schedule_title;
	}

	public String getSchedule_content() {
		return schedule_content;
	}

	public void setSchedule_content(String schedule_content) {
		this.schedule_content = schedule_content;
	}

	public String getTicketLink() {
		return ticketLink;
	}

	public void setTicketLink(String ticketLink) {
		this.ticketLink = ticketLink;
	}

	public String getSchedule_poster() {
		return schedule_poster;
	}

	public void setSchedule_poster(String schedule_poster) {
		this.schedule_poster = schedule_poster;
	}

	@Override
	public String toString() {
		return "ScheduleDto [seq=" + seq + ", schedule_date=" + schedule_date + ", schedule_time=" + schedule_time
				+ ", schedule_place=" + schedule_place + ", schedule_title=" + schedule_title + ", schedule_content="
				+ schedule_content + ", ticketLink=" + ticketLink + ", schedule_poster=" + schedule_poster + "]";
	}

	
}
