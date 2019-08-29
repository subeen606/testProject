package control;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
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
import org.apache.commons.lang3.StringUtils;

import dao.AdminDao;
import dao.NewsDao;
import dao.iAdminDao;
import dao.iNewsDao;
import dto.ScheduleDto;
import dto.StoreQnADto;
import dto.MemberDto;
import dto.NewsDto;
import dto.OrderListDto;
import dto.ProductDto;
import util.UtilityClass;

@WebServlet("/AdminCtrl")
public class AdminControl extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("do Get");
		String command = req.getParameter("command");
		iAdminDao admindao = AdminDao.getInstance();
		iNewsDao newsdao = NewsDao.getInstance();
		
		
		//////////////////////////////////Main_Page부분///////////////////////////////
		if(command.equals("Main_Page")) {
			//1.스케쥴리스트(3개)
			String Spage = req.getParameter("page");
			String search_category = req.getParameter("search_category");
			String search_txt = req.getParameter("search_txt");
			
			if(search_category == null) {
				search_category = "선택";
			}
			if(search_txt == null) {
				search_txt = "";
			}
			
			int pages = admindao.getSchedulePages(search_category, search_txt);
			System.out.println("AdminSchedule pages:"+pages);
			List<ScheduleDto> schedulelist = new ArrayList<ScheduleDto>();
			if(Spage == null) {
				schedulelist = admindao.getScheduleList(search_category, search_txt, 1);
			}else {
				int page = Integer.parseInt(Spage);
				schedulelist = admindao.getScheduleList(search_category, search_txt, page);
			}
			
			req.setAttribute("scheduleList", schedulelist);
			req.setAttribute("pages", pages);
			//2.마지막뉴스(3걔)

				List<NewsDto> newslist = newsdao.getNewsList();
				
				req.setAttribute("newslist", newslist);
			
			//3.스토어(4걔)
				
			
			List<ProductDto> productlist = new ArrayList<ProductDto>();
			productlist = admindao.getProduct(0);
			req.setAttribute("productlist", productlist);
			req.getRequestDispatcher("Main/Main_Page.jsp").forward(req, resp);
		}
		
		////////////////////////////////////Admin_Main부분/////////////////////////////////
		else if(command.equals("Admin_main")) {
		Calendar cal = Calendar.getInstance();
		String year = cal.get(cal.YEAR)+"";
		String month = (cal.get(cal.MONTH)+1)+"";
		month = UtilityClass.two(month);
		String date = cal.get(cal.DATE)+"";
		date = UtilityClass.two(date);
		String today = year+month+date;
		System.out.println("today:"+today);
		
		List<dto.OrderListDto> TodayOrderList = new ArrayList<>();
		List<StoreQnADto> TodayQnAList = new ArrayList<StoreQnADto>();
		
		TodayOrderList = admindao.TodayOrderList(today);
		TodayQnAList = admindao.TodayQnAList(today);
		System.out.println("Admin_main! TodayOrderList.size():"+TodayOrderList.size()+", TodayQnAList.size():"+TodayQnAList.size());
		req.setAttribute("TodayOrderList", TodayOrderList);
		req.setAttribute("TodayQnAList", TodayQnAList);
		req.getRequestDispatcher("Admin/Admin_Main.jsp").forward(req, resp);
		
		}
		
		////////////////////////////////////Admin_Member부분////////////////////////////////
		else if(command.equals("Member_list")) {
		int page = Integer.parseInt(req.getParameter("page"));
		List<MemberDto> list = new ArrayList<MemberDto>();
		list = admindao.getMember(page);
		int mCount = admindao.CountMember();
		req.setAttribute("list", list);
		req.setAttribute("mCount", mCount);
		req.getRequestDispatcher("Admin/Admin_MemberList.jsp").forward(req, resp);
		}
		else if(command.equals("Member_FindList")) {
		int page = Integer.parseInt(req.getParameter("page"));
		String sel = req.getParameter("sel");
		String fText = req.getParameter("fText");
		System.out.println("Member_FindList sel:"+sel+", fText:"+fText);
		List<MemberDto> list = new ArrayList<MemberDto>();
		list = admindao.findMember(sel, fText, page);
		int mCount = admindao.findCountMember(sel, fText);
		req.setAttribute("list", list);
		req.setAttribute("mCount", mCount);
		req.setAttribute("fText", fText);
		req.setAttribute("sel", sel);
		req.getRequestDispatcher("Admin/Admin_MemberFindList.jsp").forward(req, resp);
		}
		else if(command.equals("Member_Detail")) {
		int seq = Integer.parseInt(req.getParameter("seq"));
		MemberDto memDto = admindao.memberDetail(seq);
		req.setAttribute("memDto", memDto);
		req.getRequestDispatcher("Admin/Admin_MemberDetail.jsp").forward(req, resp);
		}
		
		// 스케줄 관리 부분 /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		else if(command.equals("AdminSchedule")) {
			String Spage = req.getParameter("page");
			String search_category = req.getParameter("search_category");
			String search_txt = req.getParameter("search_txt");
			
			if(search_category == null) {
				search_category = "선택";
			}
			if(search_txt == null) {
				search_txt = "";
			}
			
			int pages = admindao.getSchedulePages(search_category, search_txt);
			System.out.println("pages = " + pages);
			List<ScheduleDto> list = new ArrayList<ScheduleDto>();
			if(Spage == null) {
				list = admindao.getScheduleList(search_category, search_txt, 1);
			}else {
				int page = Integer.parseInt(Spage);
				list = admindao.getScheduleList(search_category, search_txt, page);
			}
			
			req.setAttribute("scheduleList", list);
			req.setAttribute("pages", pages);
			req.getRequestDispatcher("Admin/Admin_ScheduleList.jsp").forward(req, resp);
		
		}else if(command.equals("ScheduleWrite")) {
			resp.sendRedirect("Admin/Admin_ScheduleWrite.jsp");
		
		}else if(command.equals("ScheduleDetail")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			ScheduleDto dto = admindao.ScheduleDetail(seq);
			req.setAttribute("detail", dto);
			req.getRequestDispatcher("Admin/Admin_ScheduleDetail.jsp").forward(req, resp);
		
		}else if(command.equals("backShecduleList")) {
			//List<ScheduleDto> list = admindao.getScheduleList();
			//req.setAttribute("scheduleList", list);
			//req.getRequestDispatcher("Admin/Admin_ScheduleList.jsp").forward(req, resp);
			resp.sendRedirect("/TAMINO/AdminCtrl?command=AdminSchedule");
		}else if(command.equals("ScheduleUpdate")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			ScheduleDto dto = admindao.ScheduleDetail(seq);
			req.setAttribute("detail", dto);
			req.getRequestDispatcher("Admin/Admin_ScheduleUpdate.jsp").forward(req, resp);
		
		}else if(command.equals("ScheduleDelete")) {
			String[] seq = req.getParameterValues("delcheck");
			boolean delcheck = admindao.deleteSchedule(seq);
			if(delcheck) {
				//List<ScheduleDto> list = admindao.getScheduleList();
				//req.setAttribute("scheduleList", list);
				//req.getRequestDispatcher("Admin/Admin_ScheduleList.jsp").forward(req, resp);
				resp.sendRedirect("/TAMINO/AdminCtrl?command=AdminSchedule");
			}
		
		}else if(command.equals("ScheduleSearch")){
			
			String Spage = req.getParameter("page");
			String search_category = req.getParameter("search_category");
			String search_txt = req.getParameter("search_txt");
			
			if(search_category == null) {
				search_category = "선택";
			}
			if(search_txt == null) {
				search_txt = "";
			}
			
			int pages = admindao.getSchedulePages(search_category, search_txt);
			List<ScheduleDto> list = new ArrayList<ScheduleDto>();
			if(Spage == null) {
				list = admindao.getScheduleList(search_category, search_txt, 1);
			}else {
				int page = Integer.parseInt(Spage);
				list = admindao.getScheduleList(search_category, search_txt, page);
			}
			
			req.setAttribute("scheduleList", list);
			req.setAttribute("pages", pages);
			req.getRequestDispatcher("Admin/Admin_ScheduleList.jsp").forward(req, resp);
		
			
		// 상품 관리 부분 /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		}else if(command.equals("ProductList")) {
			int page = Integer.parseInt(req.getParameter("page"));
			List<ProductDto> list = new ArrayList<ProductDto>();
			list = admindao.getProduct(page);
			int pCount = admindao.countProduct();
			req.setAttribute("list", list);
			req.setAttribute("pCount", pCount);
			req.getRequestDispatcher("Admin/Admin_ProductList.jsp").forward(req, resp);
			
		}else if(command.equals("add")) {
			resp.sendRedirect("Admin/Admin_ProductInsert.jsp");
			
		}else if(command.equals("detail")) {
			//System.out.println("GET DETAILE�뱾�뼱�샂");
			int seq = Integer.parseInt(req.getParameter("seq"));
			ProductDto storeDto = admindao.detailProduct(seq);
			System.out.println("detail:"+storeDto.toString());
			req.setAttribute("StoreDto", storeDto);
			req.getRequestDispatcher("Admin/Admin_ProductDetail.jsp").forward(req, resp);
			System.out.println("detail넘어감");
			
		}else if(command.equals("update")) {	
			int seq = Integer.parseInt(req.getParameter("seq"));
			ProductDto storeDto = admindao.detailProduct(seq);
			req.setAttribute("StoreDto", storeDto);
			req.getRequestDispatcher("Admin/Admin_ProductUpdate.jsp").forward(req, resp);
			
		}else if(command.equals("delete")) {
			System.out.println("SEQ紐⑥쓬:"+req.getParameter("seq"));
			String sseq = req.getParameter("seq");
			int count = StringUtils.countMatches(sseq, ",");
			
			String s_seq[] = sseq.split(",");
		
			for (int i = 0; i < s_seq.length; i++) {
				/* System.out.println("s_seq["+i+"] = "+s_seq[i]); */
				admindao.deleteProduct(Integer.parseInt(s_seq[i]));
			}
	
			resp.sendRedirect("AdminCtrl?command=ProductList&page=0");
			
		}else if(command.equals("finding")) {
			String sel = req.getParameter("select");
			String fText = req.getParameter("fText");
			int page = Integer.parseInt(req.getParameter("page"));
			System.out.println("sel:"+sel+", fText:"+fText);
			
			List<ProductDto> list = new ArrayList<ProductDto>();
			list = admindao.findProduct(sel,fText,page);
			int pCount = admindao.findingCount(sel, fText);
			System.out.println("finding pCount:"+pCount);
			req.setAttribute("list", list);
			req.setAttribute("fText", fText);
			req.setAttribute("sel", sel);
			req.setAttribute("pCount", pCount);
			req.getRequestDispatcher("Admin/Admin_ProuctFindList.jsp").forward(req, resp);
		}
		else if(command.equals("Statistics")) {
			String month[] = {"01","02","03","04","05","06","07","08","09","10","11","12"};
			List<Integer> TotalPriceList = new ArrayList<>();
			List<Integer> TotalCountList = new ArrayList<>();
			TotalPriceList = admindao.MonthlyTotalPrice(month);
			TotalCountList = admindao.MonthlyTotalCount(month);
			for (int i = 0; i < TotalPriceList.size(); i++) {
				System.out.println((i+1)+"월 총 금액:"+TotalPriceList.get(i)+", 총 수량:"+TotalCountList.get(i));
			}
			req.setAttribute("TotalPriceList", TotalPriceList);
			req.setAttribute("TotalCountList", TotalCountList);
			req.getRequestDispatcher("./Admin/Admin_Statistics.jsp").forward(req, resp);
		}
		
		// QnA /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		else if(command.equals("QnAList")) {
			System.out.println("qna list 얻어요");
			
			String category = req.getParameter("qna_category");
			String search = req.getParameter("search_category");
			String searchtxt = req.getParameter("search_txt");
			String Spage = req.getParameter("page");
			
			if(category == null) {
				category = "분류선택";
			}
			if(search == null) {
				search = "선택";
			}
			if(searchtxt == null) {
				searchtxt = "";
			}
			
			int pages = admindao.getQnAPageCount(category, search, searchtxt);
			
			List<StoreQnADto> list = new ArrayList<StoreQnADto>();
			
			if(Spage == null) {
				list = admindao.getQnAList(category, search, searchtxt, 1);
			}else {
				int page = Integer.parseInt(Spage);
				list = admindao.getQnAList(category, search, searchtxt, page);
			}
			
			req.setAttribute("qna_category", category);
			req.setAttribute("QnAList", list);
			req.setAttribute("pages", pages);
			req.getRequestDispatcher("Admin/Admin_QnAList.jsp").forward(req, resp);
			
		}else if(command.equals("QnADetail")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			
			StoreQnADto dto = admindao.detailQnA(seq);
			
			String product_name = admindao.detailProduct(dto.getQna_product_seq()).getProductName();
			
			req.setAttribute("qnadetail", dto);
			req.setAttribute("product_name", product_name);
			req.getRequestDispatcher("Admin/Admin_QnADetail.jsp").forward(req, resp);
		
		}else if(command.equals("replyQnA")){
			int parent_seq = Integer.parseInt(req.getParameter("parent_seq"));
			int product_seq = Integer.parseInt(req.getParameter("product_seq"));
			String title = req.getParameter("reply_title");
			String category = req.getParameter("qna_category");
			String content = req.getParameter("reply_content");
			
			System.out.println("parent_seq : " + parent_seq);
			System.out.println("product_seq : " + product_seq);
			
			StoreQnADto dto = new StoreQnADto(product_seq, title, category, content, null, "admin");
			boolean replycheck = admindao.replyQnA(parent_seq, dto);
			if(replycheck) {
				resp.sendRedirect("/TAMINO/AdminCtrl?command=QnAList");
			}
		}else if(command.equals("deleteQnA")) {
			PrintWriter pw = resp.getWriter();
			//System.out.println("deleteQnA");
			String dels = req.getParameter("delslist");
			System.out.println("dels : " + dels);
			
			String[] seq = dels.split(",");
			
			boolean delcheck = admindao.deleteQnA(seq);
			if(delcheck) {
				pw.print("ok");
				//resp.sendRedirect("/TAMINO/AdminCtrl?command=QnAList");
			}else {
				pw.print("no");
			}
			
			pw.flush();
		}
		/////////////////////////OrderList부분////////////////////////////////////////
		else if(command.equals("order_list")) {
			int page = Integer.parseInt(req.getParameter("page"));
			List<OrderListDto> list = new ArrayList<>();
			list = admindao.order_list(page);
			int oCount = admindao.CountOrder();
			req.setAttribute("list", list);
			req.setAttribute("oCount", oCount);
			req.getRequestDispatcher("Admin/Admin_OrderList.jsp").forward(req, resp);
		}
		else if(command.equals("Order_Detail")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			System.out.println("Order_Detail SEQ:"+seq);
			OrderListDto oDto = admindao.Order_Detail(seq);
			req.setAttribute("oDto", oDto);
			req.getRequestDispatcher("Admin/Admin_OrderDetail.jsp").forward(req, resp);
		}
		else if(command.equals("order_findlist")) {
			int page = Integer.parseInt(req.getParameter("page"));
			String sel = req.getParameter("sel");
			String fText = req.getParameter("fText");
			List<OrderListDto> list = new ArrayList<>();
			list = admindao.FindOrderList(sel, fText, page);
			int oCount = admindao.findCountMember(sel, fText);
			req.setAttribute("list", list);
			req.setAttribute("oCount", oCount);
			req.setAttribute("fText", fText);
			req.setAttribute("sel", sel);
			req.getRequestDispatcher("Admin/Admin_OrderFindList.jsp").forward(req, resp);
		}
	/////News부분///////////////////////////////////////////////////////////////////////////
			else if (command.equals("AdminPhoto")) {	//Admin photo list
				List<NewsDto> list = newsdao.getNewsList();
				
				req.setAttribute("newslist", list);
				 
				req.getRequestDispatcher("Admin/Admin_NewsList.jsp").forward(req, resp);
			 
			}else if (command.equals("Adminvideo")) { //Admin video list가져오기
				
				 List<NewsDto> list = newsdao.getvideoList();
				 
				 req.setAttribute("newslist", list);
				 
				 req.getRequestDispatcher("Admin/Admin_VideoList.jsp").forward(req, resp);
				 
			}else if (command.equals("photoupdate")) {  //photo 수정
				
				int _seq = Integer.parseInt(req.getParameter("seq"));
				
				NewsDto dto = newsdao.getNews(_seq);
				
				req.setAttribute("dto", dto);
				
				req.getRequestDispatcher("Admin/Admin_Newsupdate.jsp").forward(req, resp);
				
			}else if (command.equals("photodelete")) {  //photo 삭제
				System.out.println("delete");
				
				int _seq = Integer.parseInt(req.getParameter("seq"));
				
				boolean isS = newsdao.delete(_seq);	//글삭제
				
				if(isS == true){
					resp.sendRedirect("/TAMINO/AdminCtrl?command=AdminPhoto");
				}else{	
					resp.sendRedirect("/TAMINO/AdminCtrl?command=detail&seq="+_seq);
				}
				
			}else if (command.equals("photowrite")) {//글쓰러 가기
				 
				resp.sendRedirect("Admin/Admin_NewsWrite.jsp");
			 
			}else if (command.equals("photodetail")) {	//photo 디테일
				
				int _seq =  Integer.parseInt(req.getParameter("seq"));
				NewsDto dto = newsdao.getNews(_seq);
				NewsDto ndto = newsdao.getNews(_seq + 1);
				
				newsdao.readcount(_seq);//조회수 증가
				 List<NewsDto> list = newsdao.getdetailList(_seq);
				
				 req.setAttribute("dto", dto);
				 
				 req.setAttribute("detaillist", list);
				 //잘가
				 req.getRequestDispatcher("/Admin/Admin_Newsdetail.jsp").forward(req, resp);
				
				}
					
				
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String command = req.getParameter("command");
		iAdminDao admindao = AdminDao.getInstance();
		iNewsDao newsdao = NewsDao.getInstance();
		
		// 스케줄  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		if (command.equals("ScheduleInsert") || command.equals("ScheduleUpdateAF")) {
			System.out.println("업데이트 애프터");
			String fileUpload = req.getServletContext().getRealPath("/poster");
			System.out.println("파일업로드 폴더: " + fileUpload);

			String myDir = fileUpload;

			int yourMaxRequestSize = 100 * 1024 * 1024; // 1MByte
			int yourMaxMemorySize = 100 * 1024; // 1KByte

			String schedule_title = "";
			String schedule_content = "";
			String schedule_year = "";
			String schedule_month = "";
			String schedule_date = "";
			String schedule_hour = "";
			String schedule_minute = "";
			String ticketLink = "";
			String schedule_place = "";
			String schedule_poster = "";
			
			String new_poster = "";
			String old_poster = "";
			int seq = 0;

			boolean isMultipart = ServletFileUpload.isMultipartContent(req);

			if (isMultipart) {

				DiskFileItemFactory factory = new DiskFileItemFactory();

				factory.setSizeThreshold(yourMaxMemorySize);
				factory.setRepository(new File(myDir));

				ServletFileUpload upload = new ServletFileUpload(factory);
				upload.setSizeMax(yourMaxRequestSize);

				List<FileItem> items;
				try {
					items = upload.parseRequest(req);
					Iterator<FileItem> it = items.iterator();
					while (it.hasNext()) {
						FileItem item = it.next();

						if (item.isFormField()) {
							if(item.getFieldName().equals("schedule_title")) {
								schedule_title = item.getString("utf-8");
							}else if(item.getFieldName().equals("schedule_content")) {
								schedule_content = item.getString("utf-8");
							}else if(item.getFieldName().equals("schedule_year")) {
								schedule_year = item.getString("utf-8");
							}else if(item.getFieldName().equals("schedule_month")) {
								schedule_month = UtilityClass.two(item.getString("utf-8"));
							}else if(item.getFieldName().equals("schedule_date")) {
								schedule_date = UtilityClass.two(item.getString("utf-8"));
							}else if(item.getFieldName().equals("schedule_hour")) {
								schedule_hour = UtilityClass.two(item.getString("utf-8"));
							}else if(item.getFieldName().equals("schedule_minute")) {
								schedule_minute = UtilityClass.two(item.getString("utf-8"));
							}else if(item.getFieldName().equals("ticketlink")) {
								ticketLink = item.getString("utf-8");
							}else if(item.getFieldName().equals("schedule_place")) {
								schedule_place = item.getString("utf-8");
							}else if(item.getFieldName().equals("old_poster_file")) {
								old_poster = item.getString("utf-8");
							}else if(item.getFieldName().equals("seq")) {
								seq = Integer.parseInt(item.getString("utf-8"));
								System.out.println("seq = " + seq);
							}
			
						} else {
							if(item.getFieldName().equals("poster_file")){
								schedule_poster = UtilityClass.processUploadFile(item, fileUpload);
							//	System.out.println(filename);
								System.out.println("!fileUpload: " + fileUpload);
							} else if(item.getFieldName().equals("new_poster_file")){
								new_poster = UtilityClass.processUploadFile(item, fileUpload);
								System.out.println("!수정파일: " + fileUpload);
							}
						}
					}
				} catch (FileUploadException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
				}
				
			if (seq == 0) { /* 스케줄 입력 */
						ScheduleDto dto = new ScheduleDto((schedule_year + schedule_month + schedule_date), 
														  (schedule_hour + schedule_minute), 
														   schedule_place, schedule_title, schedule_content, ticketLink, schedule_poster);
					 	
				 	boolean writecheck = admindao.writeSchedule(dto); 
				 	if(writecheck) {
						  System.out.println("입력성공");
						  resp.sendRedirect("AdminCtrl?command=AdminSchedule");
					}
					 	
			} else if (seq != 0) { /* 스케줄 수정 */
					ScheduleDto dto = null;
					if(new_poster.equals("")) {
						dto = new ScheduleDto(seq, (schedule_year + schedule_month + schedule_date), 
													(schedule_hour + schedule_minute), 
													schedule_place,schedule_title, schedule_content, ticketLink, old_poster);
					}else if(!new_poster.equals("")) {
						dto = new ScheduleDto(seq, (schedule_year + schedule_month + schedule_date), 
													(schedule_hour + schedule_minute), 
													schedule_place, schedule_title, schedule_content, ticketLink, new_poster);
						
					}
					boolean updatecheck = admindao.updateSchedule(dto);
					if(updatecheck) {
						System.out.println("업데이트 완료");
						resp.sendRedirect("AdminCtrl?command=AdminSchedule");
					}
				}
			 	
			
			// 상품  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			} else if (command.equals("addProduct")) { /* 상품 추가 */
				System.out.println("addProduct");
				
				String fupload = req.getServletContext().getRealPath("/product");
				System.out.println("product 폴더: " + fupload);
				//String fupload = "d:\\tmp";

				System.out.println("dfd:"+fupload);

				String yourTempDir = fupload;
				int yourMaxRequestSize = 100 * 1024 * 1024;	//	1Mbyte
				int yourMaxMemorySize = 100 * 1024;			// 	1Kbyte
						
				int price = 0;
				int pCount_s = 0;
				int pCount_m = 0;
				int pCount_l = 0;
				int pCount_o = 0;
				String pCode = "";
				String pName = "";
				String content = "";
				String pSize = "";

				List<String> filename = new ArrayList<String>();
				
				boolean isMultipart = ServletFileUpload.isMultipartContent(req);	
				if(isMultipart){	
						DiskFileItemFactory factory = new DiskFileItemFactory();
						factory.setSizeThreshold(yourMaxMemorySize);
						factory.setRepository(new File(yourTempDir));
						
						ServletFileUpload upload = new ServletFileUpload(factory);
						upload.setSizeMax(yourMaxRequestSize);
						
						List<FileItem> items = null;
						try {
							items = upload.parseRequest(req);
							
						} catch (FileUploadException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						Iterator<FileItem> it = items.iterator();
						while(it.hasNext()){
							FileItem item = it.next();
							
							if(item.isFormField()){	
								if(item.getFieldName().equals("price")){
									price = Integer.parseInt((item.getString("utf-8")));	
								}
								else if(item.getFieldName().equals("pCount_s")){
									if(item.getString("utf-8")==null || item.getString("utf-8").equals("")) {
										pCount_s = 0;
									}
									else {
										pCount_s = Integer.parseInt(item.getString("utf-8"));
									}	
								}
								else if(item.getFieldName().equals("pCount_m")){
									if(item.getString("utf-8")==null || item.getString("utf-8").equals("")) {
										pCount_m = 0;
									}
									else {
										pCount_m = Integer.parseInt(item.getString("utf-8"));
									}	
								}
								else if(item.getFieldName().equals("pCount_l")){
									if(item.getString("utf-8")==null || item.getString("utf-8").equals("")) {
										pCount_l = 0;
									}
									else {
										pCount_l = Integer.parseInt(item.getString("utf-8"));
									}	
								}
								else if(item.getFieldName().equals("pCount_o")){
									if(item.getString("utf-8")==null || item.getString("utf-8").equals("")) {
										pCount_o = 0;
									}
									else {
										pCount_o = Integer.parseInt(item.getString("utf-8"));
									}
									 	
								}
								else if(item.getFieldName().equals("pCode")) {
									pCode = item.getString("utf-8");
								}
								else if(item.getFieldName().equals("title")){
									pName = item.getString("utf-8");	
								}
								else if(item.getFieldName().equals("pSize")) {
									pSize = item.getString("utf-8");
								}
								else if(item.getFieldName().equals("content")) {
									content = item.getString("utf-8");
								}
							}
							else{	// fileload(input type="file")
								if(item.getFieldName().equals("fileload1")){
										filename.add(UtilityClass.processUploadFile(item, fupload));
									
								}else if(item.getFieldName().equals("fileload2")) {
										filename.add(UtilityClass.processUploadFile(item, fupload));
									
								}else if(item.getFieldName().equals("fileload3")) {
										filename.add(UtilityClass.processUploadFile(item, fupload));
									
								}else if(item.getFieldName().equals("fileload4")) {
										filename.add(UtilityClass.processUploadFile(item, fupload));
									
								}
							}
						}
					
				}else{
				
				}
				System.out.println("filename:"+filename.toString());
				String finFileName = "";
				for (int i = 0; i < filename.size(); i++) {
					if(filename.get(i).toString().equals("") || filename.get(i) == null) {
						System.out.println("�뿬湲� �뱾�뼱�솕�뒿�땲�떎.");
						finFileName += " ,";
					}
					else {
						finFileName += filename.get(i).toString()+",";
					}
					
				}
				System.out.println("finFileName:"+finFileName);
				ProductDto storeDto = null;
				if(pCode.equals("의류")) {
					storeDto = new ProductDto(pCode, pName, price, content, finFileName, pCount_s, pCount_m, pCount_l, pCount_o, "S-M-L");
				}
				else {
					storeDto = new ProductDto(pCode, pName, price, content, finFileName, 0, 0, 0, pCount_o,"해당없음");
				}
					
				 
				boolean a = admindao.addProduct(storeDto);
				if(a) {
					resp.sendRedirect("AdminCtrl?command=ProductList&page=0");
				}
				
				
			}else if(command.equals("updateProduct")) {
				System.out.println("updateProduct DoPost");
				String fupload = req.getServletContext().getRealPath("/product"); //占쏙옙占시몌옙占쏙옙占싱쇽옙占쏙옙 folder占쏙옙占쏙옙 upload占쏙옙占� 占쏙옙占쏙옙



				System.out.println("占쏙옙占싹억옙占싸듸옙 占쏙옙占쏙옙:"+fupload);

				String yourTempDir = fupload;
				int yourMaxRequestSize = 100 * 1024 * 1024;	//	1Mbyte
				int yourMaxMemorySize = 100 * 1024;			// 	1Kbyte

				
				int seq = 0;		
				int price = 0;
				int pCount_s = 0;
				int pCount_m = 0;
				int pCount_l = 0;
				int pCount_o = 0;
				String pCode = "";
				String pName = "";
				String content = "";
				String pSize = "";


				List<String> filename = new ArrayList<String>();
				
				boolean isMultipart = ServletFileUpload.isMultipartContent(req);	//isMultipartContent占쏙옙 占쏙옙占식쇽옙 占싶억옙占싼댐옙~

				if(isMultipart){	

						DiskFileItemFactory factory = new DiskFileItemFactory();
						factory.setSizeThreshold(yourMaxMemorySize);
						factory.setRepository(new File(yourTempDir));
						
						ServletFileUpload upload = new ServletFileUpload(factory);
						upload.setSizeMax(yourMaxRequestSize);
						

						List<FileItem> items = null;
						try {
							items = upload.parseRequest(req);
							
						} catch (FileUploadException e) {	
							e.printStackTrace();
						}
						Iterator<FileItem> it = items.iterator();
						while(it.hasNext()){
							FileItem item = it.next();
							
							if(item.isFormField()){	
								if(item.getFieldName().equals("price")){
									price = Integer.parseInt((item.getString("utf-8")));	
								}
								else if(item.getFieldName().equals("pCount_s")){
									if(item.getString("utf-8").equals("")) {
										pCount_s = 0;
									}else {
										pCount_s= Integer.parseInt(item.getString("utf-8"));
									}	
								}
								else if(item.getFieldName().equals("pCount_m")){
									if(item.getString("utf-8").equals("")) {
										pCount_m = 0;
									}else {
										pCount_m= Integer.parseInt(item.getString("utf-8"));
									}		
								}
								else if(item.getFieldName().equals("pCount_l")){
									if(item.getString("utf-8").equals("")) {
										pCount_l = 0;
									}else {
										pCount_l= Integer.parseInt(item.getString("utf-8"));
									}		
								}
								else if(item.getFieldName().equals("pCount_o")){
									if(item.getString("utf-8").equals("")) {
										pCount_o = 0;
									}else {
										pCount_o= Integer.parseInt(item.getString("utf-8"));
									}	
								}
								else if(item.getFieldName().equals("pCode")) {
									pCode = item.getString("utf-8");
								}
								else if(item.getFieldName().equals("title")){
									pName = item.getString("utf-8");	
								}
								else if(item.getFieldName().equals("pSize")) {
									pSize = item.getString("utf-8");
								}
								else if(item.getFieldName().equals("content")) {
									content = item.getString("utf-8");
								}
								else if(item.getFieldName().equals("seq")) {
									seq = Integer.parseInt((item.getString("utf-8")));
								}
							}
							else{	
								if(item.getFieldName().equals("fileload1")){	
										filename.add(UtilityClass.processUploadFile(item, fupload));
	
								}else if(item.getFieldName().equals("fileload2")) {
										filename.add(UtilityClass.processUploadFile(item, fupload));
									
								}else if(item.getFieldName().equals("fileload3")) {
										filename.add(UtilityClass.processUploadFile(item, fupload));
									
								}else if(item.getFieldName().equals("fileload4")) {
										filename.add(UtilityClass.processUploadFile(item, fupload));
									
								}
									
								
							}
						}
				}
				else{
					
				}
				
				System.out.println("filename Update:"+filename.toString());
				String finFileName = "";
				for (int i = 0; i < filename.size(); i++) {
					if(filename.get(i).toString().equals("") || filename.get(i) == null) {
						finFileName += " ,";
					}
					else {
						finFileName += filename.get(i).toString()+",";
					}
				}
				String str = admindao.findImg(seq);
				String fFileName = "";
				String fileName_[] = finFileName.split(",");
				String str_[] = str.split(",");
				System.out.println("fileName_:"+fileName_[0]+","+fileName_[1]+","+fileName_[2]+","+fileName_[3]+",");
				System.out.println("str_:"+str_[0]+","+str_[1]+","+str_[2]+","+str_[3]+",");
				for (int i = 0; i < str_.length; i++) {
					if(fileName_[i].equals(" ") || fileName_[i] == null) {
					/* System.out.println(i+"踰덉㎏ if �뱾�뼱�샂"); */
						fFileName += str_[i]+",";
					}
					else {
					/* System.out.println(i+"踰덉㎏ else �뱾�뼱�샂"); */
						fFileName += fileName_[i]+",";
					}
				}
				System.out.println("fFileName:"+fFileName);
				System.out.println("updateProdcut seq:"+seq);
				ProductDto storeDto = null;
				if(pCode.equals("의류")) {
					/*storeDto = new ProductDto(seq,pCode, pName, pCount_s, pCount_m, pCount_l, 0 , price, content, finFileName, "S-M-L");*/
					storeDto = new ProductDto(seq, pCode, pName, price, content, fFileName, pCount_s, pCount_m, pCount_l, pCount_o, "S-M-L");
				}
				else {
					/*storeDto = new ProductDto(seq,pCode, pName, 0, 0, 0, pCount_o, price, content, finFileName, "해당없음");*/
					storeDto = new ProductDto(seq, pCode, pName, price, content, fFileName, pCount_s, pCount_m, pCount_l, pCount_o, "해당없음");
				}
				System.out.println("updateProduct dto:"+storeDto.toString());
				boolean a = admindao.updateProduct(storeDto);
				System.out.println("updateProduct boolean:"+a);
				resp.sendRedirect("AdminCtrl?command=ProductList&page=0");
		
			}
		
//News부분////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
		
			else if (command.equals("writenews")) { //글쓰기
				// 1. tomcat에 배포하는 방법    application=내장객체
				String fupload = req.getRealPath("/upload");
		
				// 2. 지정 폴더에 업로드 하는 방법     연습할땐 이방법 추천 발표할땐 위에껄로 변경
				//String fupload = "C:/Users/youjin/Desktop/JAVA/java/mini/mino/WebContent/upload";
		
		
				System.out.println("파일업로드 폴더:" + fupload);
		
				String yourTempDir = fupload;
		
				int yourMaxRequestSize = 100 * 1024 * 1024; // =1 MByte  전송할때 사이즈
				int yourMaxMemorySize = 100 * 1024;			// =1 KByte	저장할때
		
				// form field에 데이터를 저장할 변수 DB에 넣기!  멀티라 겟파라미터로 못받음
				String title = "";
				String content = "";
		
				//file name
				String filename = "";   
		
				boolean isMultipart = ServletFileUpload.isMultipartContent(req);
		
				if(isMultipart){
					
					// FileItem을 생성
					DiskFileItemFactory factory = new DiskFileItemFactory();
					
					factory.setSizeThreshold(yourMaxMemorySize);
					factory.setRepository(new File(yourTempDir));
					
					ServletFileUpload upload = new ServletFileUpload(factory);
					upload.setSizeMax(yourMaxRequestSize);
					
					
					// list 저장
					List<FileItem> items;
					try {
						items = upload.parseRequest(req);
						Iterator<FileItem> it = items.iterator();
						while(it.hasNext()){
							FileItem item = it.next();
							
							if(item.isFormField()){  // id, title, content
								if(item.getFieldName().equals("title")){
									title = item.getString("utf-8");
								}else if(item.getFieldName().equals("content")){
									content = item.getString("utf-8");
								}
								
							}else{ //fileload
								if(item.getFieldName().equals("fileload")){
									filename = processUploadFile(item, fupload);
									System.out.println("fupload:" + fupload);
									System.out.println("파일이름:" + filename);
								}
							}
						}
						
					} catch (FileUploadException e) {
						e.printStackTrace();
					}
				}else{
					System.out.println("multipart 아님");
				}
				// DB
				String fileadd = fupload +"\\"+ filename;
				boolean isS = newsdao.upfile(new NewsDto(title, content, filename));
				if(isS){
				resp.sendRedirect("/TAMINO/AdminCtrl?command=AdminPhoto");
				}else{
				resp.sendRedirect("/TAMINO/AdminCtrl?command=AdminPhoto");
				}
			
		}else if (command.equals("updateAf")) {	//photo update
			
				String fupload = req.getRealPath("/upload");
		
				System.out.println("파일업로드 폴더:" + fupload);
		
				String yourTempDir = fupload;
		
				int yourMaxRequestSize = 100 * 1024 * 1024; // =1 MByte  전송할때 사이즈
				int yourMaxMemorySize = 100 * 1024;			// =1 KByte	저장할때
		
				String title = "";
				String content = "";
		
				String file1 = "";   
				String file2 = "";   
		
				String sseq = "";
		
				boolean isMultipart = ServletFileUpload.isMultipartContent(req);
		
				if(isMultipart){
					
					// FileItem을 생성
					DiskFileItemFactory factory = new DiskFileItemFactory();
					
					factory.setSizeThreshold(yourMaxMemorySize);
					factory.setRepository(new File(yourTempDir));
					
					ServletFileUpload upload = new ServletFileUpload(factory);
					upload.setSizeMax(yourMaxRequestSize);
					
					
					// list 저장
					List<FileItem> items;
					try {
						items = upload.parseRequest(req);
						Iterator<FileItem> it = items.iterator();
						while(it.hasNext()){
							FileItem item = it.next();
							
							if(item.isFormField()){  // id, title, content
								if(item.getFieldName().equals("title")){
									title = item.getString("utf-8");
								}else if(item.getFieldName().equals("content")){
									content = item.getString("utf-8");
								}else if(item.getFieldName().equals("file1")){
									file1 = item.getString("utf-8");
								}else if(item.getFieldName().equals("seq")){
									sseq = item.getString("utf-8");
								}
								
							}else{ //fileload
								if(item.getFieldName().equals("fileload")){
									file2 = processUploadFile(item, fupload);
									System.out.println("fupload:" + fupload);
								}
							}
						}
					} catch (FileUploadException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
				}else{
					System.out.println("multipart 아님");
				}
				int seq = Integer.parseInt(sseq.trim());
		
				String filename = null;
				if(file2 == ""){
					filename = file1;
				}else{
					filename = file2;
				}
		
				System.out.println("title:"+ title);
				System.out.println("filename:"+ filename);
				System.out.println("content:"+ content);
		
				boolean isS = newsdao.update(seq, title, filename, content);
				if(isS == true){
					resp.sendRedirect("AdminCtrl?command=photodetail&seq="+seq);
				}else{	
					resp.sendRedirect("AdminCtrl?command=photoupdate&seq="+seq);
				}	
			
		//video 글쓰기버튼	 
		}else if (command.equals("addvideo")) {
			resp.sendRedirect("Admin/Admin_videoWrite.jsp");
		}
		//video 글쓰기
		else if (command.equals("writevideo")) {
			// 1. tomcat에 배포하는 방법    application=내장객체
			String fupload = req.getRealPath("/upload");
		
			// 2. 지정 폴더에 업로드 하는 방법     연습할땐 이방법 추천 발표할땐 위에껄로 변경
			//String fupload = "C:/Users/youjin/Desktop/JAVA/java/mini/mino/WebContent/upload";
		
			System.out.println("파일업로드 폴더:" + fupload);
		
			String yourTempDir = fupload;
		
			int yourMaxRequestSize = 100 * 1024 * 1024; // =1 MByte  전송할때 사이즈
			int yourMaxMemorySize = 100 * 1024;			// =1 KByte	저장할때
		
			// form field에 데이터를 저장할 변수 DB에 넣기!  멀티라 겟파라미터로 못받음
			String title = "";
			String content = "";
		
			//file name
			String filename = "";   
		
			boolean isMultipart = ServletFileUpload.isMultipartContent(req);
		
			if(isMultipart){
				
				// FileItem을 생성
				DiskFileItemFactory factory = new DiskFileItemFactory();
				
				factory.setSizeThreshold(yourMaxMemorySize);
				factory.setRepository(new File(yourTempDir));
				
				ServletFileUpload upload = new ServletFileUpload(factory);
				upload.setSizeMax(yourMaxRequestSize);
				
				// list 저장
				List<FileItem> items;
				try {
					items = upload.parseRequest(req);
					Iterator<FileItem> it = items.iterator();
					while(it.hasNext()){
						FileItem item = it.next();
						
						if(item.isFormField()){  // id, title, content
							if(item.getFieldName().equals("title")){
								title = item.getString("utf-8");
							}else if(item.getFieldName().equals("content")){
								content = item.getString("utf-8");
							}
							
						}else{ //fileload
							if(item.getFieldName().equals("fileload")){
								filename = processUploadFile(item, fupload);
								System.out.println("fupload:" + fupload);
								System.out.println("파일이름:" + filename);
							}
						}
					}
					
				} catch (FileUploadException e) {
					e.printStackTrace();
				}
				
			}else{
				System.out.println("multipart 아님");
			}
		
			// DB
			String fileadd = fupload +"\\"+ filename;
			boolean isS = newsdao.upvideo(new NewsDto(title, content, filename));
			if(isS){
			resp.sendRedirect("/TAMINO/AdminCtrl?command=Adminvideo");
			}else{
			resp.sendRedirect("/TAMINO/AdminCtrl?command=Adminvideo");
			}
		}else if (command.equals("videodelete")) { //video 삭제
			
			
			String delArr[] = req.getParameterValues("delck");
			for(int i = 0; i < delArr.length; i++){
				System.out.println(delArr[i]);
			}
			
			 boolean isS = newsdao.deletevideo(delArr);
			 if(isS){
				 resp.sendRedirect("/TAMINO/AdminCtrl?command=Adminvideo");
			 }else{
				 resp.sendRedirect("/TAMINO/AdminCtrl?command=Adminvideo");
			
				 }
			}
		
				
		}
	public String processUploadFile(FileItem fileItem, String dir) throws IOException{
		
		String filename = fileItem.getName();	// 경로 + 파일명이 넘어온다
		long sizeInBytes = fileItem.getSize();	// 파일의 크기
		
		// 파일이 정상
		if(sizeInBytes > 0){// d:\\tmp\\abc.txt or d:/tmp/abc.txt 이런형식으로 넘어온다
			
			int idx = filename.lastIndexOf("\\");  // 뒤의 위치를 얻어옴 abc.txt
			if(idx == -1){  //못찾았을 경우라는 뜻
				idx = filename.lastIndexOf("/");
			}
			
			filename = filename.substring(idx + 1); //a에서 부터 가져온다
			
			File uploadFile = new File(dir, filename); //경로는 여기고 파일명은 이거다!
			try{
			fileItem.write(uploadFile); // 실제 업로드 부분
			}catch(Exception e){}
		}
		return filename; //확인용
		
	}
	
		
		
	
	
}
