package dao;

import java.util.List;

import dto.NewsDto;

public interface iNewsDao {

	
	
	public List<NewsDto> getNewsList();	//photo list
	
	public List<NewsDto> getvideoList();	//video list
	
	public boolean upfile(NewsDto dto);	//photo 게시물 올리기
	
	public boolean upvideo(NewsDto dto);	//photo 게시물 올리기
	
	public NewsDto getNews(int seq);	//디테일 정보 가져오기
	
	public List<NewsDto> getdetailList(int seq);	//디테일 list
	
	public void readcount(int seq);	//조회수
	
	public boolean delete(int seq);	//photo게시글 삭제
	
	public boolean deletevideo(String seqs[]);//video 게시글 삭제
	
	public boolean update(int seq,String title,String filename,String content);	//게시글 수정
	
	
	
}
