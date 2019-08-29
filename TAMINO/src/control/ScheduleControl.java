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

import dao.ScheduleDao;
import dao.iScheduleDao;
import dto.ScheduleDto;
import util.UtilityClass;

@WebServlet("/ScheduleCtrl")
public class ScheduleControl extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String command = req.getParameter("command");
		iScheduleDao dao = ScheduleDao.getInstance();

		if (command.equals("schedule")) {
			
			  System.out.println("스케줄로 가줘라"); 
			  List<ScheduleDto> list = dao.getScheduleList(); req.setAttribute("scheduleList", list);
			  req.getRequestDispatcher("Schedule/Schedule.jsp").forward(req, resp);
			 
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		iScheduleDao dao = ScheduleDao.getInstance();

		String command = req.getParameter("command");
		
	
	}

}
