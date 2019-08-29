package dto;

import java.io.Serializable;

public class NewsDto implements Serializable{

	private int menu_num;
	private String title;
	private String content;
	private int news_seq;
	private String news_date;
	private int news_readcount;
	private int del;
	private String filename;
	
	public NewsDto() {
		
	}

	public NewsDto(int menu_num, String title, String content, int news_seq, String news_date, int news_readcount,
			int del, String filename) {
		super();
		this.menu_num = menu_num;
		this.title = title;
		this.content = content;
		this.news_seq = news_seq;
		this.news_date = news_date;
		this.news_readcount = news_readcount;
		this.del = del;
		this.filename = filename;
	}



	public NewsDto(String title, String content, String filename) {
		super();
		this.title = title;
		this.content = content;
		this.filename = filename;
	}


	public int getMenu_num() {
		return menu_num;
	}


	public void setMenu_num(int menu_num) {
		this.menu_num = menu_num;
	}


	public String getTitle() {
		return title;
	}



	public void setTitle(String title) {
		this.title = title;
	}



	public String getContent() {
		return content;
	}



	public void setContent(String content) {
		this.content = content;
	}



	public int getNews_seq() {
		return news_seq;
	}



	public void setNews_seq(int news_seq) {
		this.news_seq = news_seq;
	}



	public String getNews_date() {
		return news_date;
	}



	public void setNews_date(String news_date) {
		this.news_date = news_date;
	}



	public int getNews_readcount() {
		return news_readcount;
	}



	public void setNews_readcount(int news_readcount) {
		this.news_readcount = news_readcount;
	}



	public int getDel() {
		return del;
	}



	public void setDel(int del) {
		this.del = del;
	}



	public String getFilename() {
		return filename;
	}



	public void setFilename(String filename) {
		this.filename = filename;
	}



	@Override
	public String toString() {
		return "NewsDto [menu_num=" + menu_num + ", title=" + title + ", content=" + content + ", news_seq=" + news_seq
				+ ", news_date=" + news_date + ", news_readcount=" + news_readcount + ", del=" + del + ", filename="
				+ filename + "]";
	}




	
	
	
}
