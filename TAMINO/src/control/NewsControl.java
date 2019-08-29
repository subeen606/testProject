package control;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dao.NewsDao;
import dao.iNewsDao;
import dto.NewsDto;






@WebServlet("/newscontrol")
public class NewsControl extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("NewsCtrl get 들어옴");
		
		String command = req.getParameter("command");
		iNewsDao dao = NewsDao.getInstance();
		
		if (command.equals("list")) {	//photo list
				System.out.println("NewsCtrl list 들어옴");
				List<NewsDto> list = dao.getNewsList();
				
				req.setAttribute("newslist", list);
				 
				req.getRequestDispatcher("News/Newslist.jsp").forward(req, resp);
			 
		 }else if (command.equals("detail")) {	//photo 디테일
			
				int _seq =  Integer.parseInt(req.getParameter("seq"));
				NewsDto dto = dao.getNews(_seq);
				
				
				 dao.readcount(_seq);//조회수 증가
				 List<NewsDto> list = dao.getdetailList(_seq);
				 List<NewsDto> flist = dao.getNewsList();
				
				 req.setAttribute("dto", dto);
				 req.setAttribute("detaillist", list);
				 req.setAttribute("fdetaillist", flist);
				 //잘가
				 req.getRequestDispatcher("/News/Newsdetail.jsp").forward(req, resp);
				
				
		}else if (command.equals("videolist")) { //video list가져오기
			
			 List<NewsDto> list = dao.getvideoList();
			 
			 req.setAttribute("newslist", list);
			 
			 req.getRequestDispatcher("News/Newsvideo.jsp").forward(req, resp);
			 
		}
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String command = req.getParameter("command");
		iNewsDao dao = NewsDao.getInstance();
		
	}
}
		