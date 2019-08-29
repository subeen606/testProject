package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.RequestWrapper;

import org.apache.catalina.Session;

import dao.MemberDao;
import dao.StoreDao;
import dao.iMemberDao;
import dao.iStoreDao;
import dto.MemberDto;
import dto.MyOrderListDto;
import dto.OrderListDto;
import dto.ProductDto;
import dto.StoreQnADto;

@WebServlet("/StoreCtrl")
public class StoreControl extends HttpServlet{
	List<OrderListDto> list = new ArrayList<OrderListDto>();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String command = req.getParameter("command");
		iStoreDao dao = StoreDao.getInstance();
		iMemberDao memdao = MemberDao.getInstance();
		System.out.println("doGet");
		
		if(command.equals("StoreMain")) {
			resp.sendRedirect("Store/Store_Index.jsp");
			
		}else if(command.equals("QnAList")) {
			List<StoreQnADto> list = new ArrayList<StoreQnADto>();
			int product_seq = Integer.parseInt(req.getParameter("product_seq"));
			String product_name = dao.detailProduct(product_seq).getProductName();
			String Spage = req.getParameter("page");
			System.out.println("qna product seq : " + product_seq);
			int pages = dao.getQnAPageCount(product_seq);
			//req.setAttribute("page", pages);
			
			if(Spage == null) {
				list = dao.getQnAList(product_seq, 1);
			}else {
				
				int currpage = Integer.parseInt(Spage);
				list = dao.getQnAList(product_seq, currpage);
			}
			
			//list = dao.getQnAList(product_seq, pages);
			req.setAttribute("pages", pages);
			req.setAttribute("QnAList", list);
			req.setAttribute("product_seq", product_seq);
			req.setAttribute("product_name", product_name);
			req.getRequestDispatcher("Store/Store_QnA.jsp").forward(req, resp);
			
		}else if(command.equals("QnAInsert")) {
			
			System.out.println("QnA작성");
			
			String qna_title = req.getParameter("qna_title");
			String qna_category = req.getParameter("qna_category");
			String qna_content = req.getParameter("qna_content");
			String qna_email = req.getParameter("qna_email");
			int product_seq = Integer.parseInt(req.getParameter("product_seq"));
			
			boolean writecheck = dao.writeQnA(new StoreQnADto(product_seq, qna_title, qna_category, qna_content, null, qna_email));
			if(writecheck) {
				
			}else {
				System.out.println("QnA 작성 실패");
			}
			
		}else if(command.equals("QnADetail")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			StoreQnADto dto = dao.deatilQnA(seq);
			
			int p_seq = dto.getQna_product_seq();
			ProductDto pdto = dao.detailProduct(p_seq);
			String product_name = pdto.getProductName();
			
			req.setAttribute("QnADetail", dto);
			req.setAttribute("product_name", product_name);
			req.getRequestDispatcher("Store/Store_QnADetail.jsp").forward(req, resp);
			
		}else if(command.equals("deleteQnA")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			int pseq = Integer.parseInt(req.getParameter("product_seq"));
			boolean delcheck = dao.deleteQnA(seq);
			if(delcheck) {
				//resp.sendRedirect("/TAMINO/StoreCtrl?command=QnAList&product_seq=" + pseq);
			}
					
			
		}else if(command.equals("updateQnA")) {
			int seq = Integer.parseInt(req.getParameter("qna_seq"));
			int pseq = Integer.parseInt(req.getParameter("product_seq"));
			String title = req.getParameter("qna_title");
			String category = req.getParameter("qna_category");
			String content = req.getParameter("qna_content");
			
			StoreQnADto dto = new StoreQnADto(seq, pseq, title, category, content, null, null, 0, 0, 0, 0, 0);
			System.out.println("updateQnA dto : " + dto.toString());
			boolean updatecheck = dao.updateQnA(dto);
			if(updatecheck) {
				System.out.println("업데이트 성공");
				//resp.sendRedirect("/TAMINO/StoreCtrl?command=QnAList&product_seq=" + pseq);
			}else {
				System.out.println("업데이트 실패");
			}
			
		}else if(command.equals("myReply")) {
			
			PrintWriter pw = resp.getWriter();
			System.out.println("답변을읽자");
			
			String currId = req.getParameter("myId");
			System.out.println("현재아이디: " + currId);
			int parent_seq = Integer.parseInt(req.getParameter("parent_seq"));
			
			StoreQnADto dto = dao.deatilQnA(parent_seq);
			System.out.println("문의글 작성자: " + dto.getQna_email());
			if(currId.equals(dto.getQna_email())) {
				pw.println("ok");
			}else if(!currId.equals(dto.getQna_email())){
				pw.println("no");
			}
			
			pw.flush();
		}
		
		else if(command.equals("ProductList")) {
			String category = req.getParameter("category");
			System.out.println(category);
			String spage = req.getParameter("page");
			System.out.println(spage);
			
			if(category.equals("all")) {
				int pagecount = dao.getPageCount(category);
				System.out.println("컨트롤러:"+pagecount);
				List<ProductDto> list = new ArrayList<ProductDto>();
				if(spage == null) {
					list = dao.getProductList(category, 1);
				}else {
					int page = Integer.parseInt(spage);
					list = dao.getProductList(category, page);
					System.out.println(list.toString());
				}
				req.setAttribute("page", pagecount);
				req.setAttribute("list", list);
				req.getRequestDispatcher("Store/Store_List.jsp").forward(req, resp);
				
			}else if(category.equals("clothing")) {
				category = "의류";
				int pagecount = dao.getPageCount(category);
				System.out.println("컨트롤러:"+pagecount);
				
				List<ProductDto> list = new ArrayList<ProductDto>();
				
				if(spage == null) {
					list = dao.getProductList(category, 1);
				}else {
					int page = Integer.parseInt(spage);
					list = dao.getProductList(category, page);
					System.out.println(list.toString());
				}
				req.setAttribute("page", pagecount);
				req.setAttribute("list", list);
				req.getRequestDispatcher("Store/Store_ClothingList.jsp").forward(req, resp);
				
			}else if(category.equals("accsesory")) {
				category = "악세사리";
				int pagecount = dao.getPageCount(category);
				System.out.println("컨트롤러:"+pagecount);
				
				List<ProductDto> list = new ArrayList<ProductDto>();
				
				if(spage == null) {
					list = dao.getProductList(category, 1);
				}else {
					int page = Integer.parseInt(spage);
					list = dao.getProductList(category, page);
					System.out.println(list.toString());
				}
				req.setAttribute("page", pagecount);
				req.setAttribute("list", list);
				req.getRequestDispatcher("Store/Store_AccesoryList.jsp").forward(req, resp);
				
			}else if(category.equals("vinyl")) {
				category = "앨범";
				int pagecount = dao.getPageCount(category);
				System.out.println("컨트롤러:"+pagecount);
				
				List<ProductDto> list = new ArrayList<ProductDto>();
				
				if(spage == null) {
					list = dao.getProductList(category, 1);
				}else {
					int page = Integer.parseInt(spage);
					list = dao.getProductList(category, page);
					System.out.println(list.toString());
				}
				req.setAttribute("page", pagecount);
				req.setAttribute("list", list);
				req.getRequestDispatcher("Store/Store_VinylList.jsp").forward(req, resp);
				
			}else if(category.equals("etc")) {
				category = "기타";
				
				int pagecount = dao.getPageCount(category);
				System.out.println("컨트롤러:"+pagecount);
				
				List<ProductDto> list = new ArrayList<ProductDto>();
				
				if(spage == null) {
					list = dao.getProductList(category, 1);
				}else {
					int page = Integer.parseInt(spage);
					list = dao.getProductList(category, page);
					System.out.println(list.toString());
				}
				req.setAttribute("page", pagecount);
				req.setAttribute("list", list);
				req.getRequestDispatcher("Store/Store_EtcList.jsp").forward(req, resp);
			}
			System.out.println(category);
			
		}else if(command.equals("ProductDetail")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			System.out.println("디테일로가자");
		
			ProductDto dto = dao.detailProduct(seq);
			System.out.println("디테일 컨트롤러 : " + dto.toString());
			
			String fileName[] = dto.getProductImage().split(",");
			System.out.println("컨트롤러: " + Arrays.toString(fileName));
			req.setAttribute("detail", dto);
			req.getRequestDispatcher("Store/Store_Detail.jsp").forward(req, resp);
	
		}else if(command.equals("goCart")) {
			
			HttpSession session = req.getSession();
			
			MemberDto logindto = (MemberDto)session.getAttribute("login");
			String email = logindto.getEmail();
			if(logindto != null) {
				resp.sendRedirect("Store/Store_Cart.jsp");
			}
			
			/*
			if(session.getAttribute(email) == null) {
				session.setMaxInactiveInterval(24 * 60 * 60 * 1000);
				session.setAttribute(logindto.getEmail(), list);
				req.getRequestDispatcher("Store/Store_Cart.jsp").forward(req, resp);
			}else {
				resp.sendRedirect("Store/Store_Cart.jsp");
			}	
			*/

		}else if(command.equals("findCart")) {
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=utf-8");

			PrintWriter pw = resp.getWriter();
			
			System.out.println("왔다");
			int findex = Integer.parseInt(req.getParameter("findIndex"));
			
			System.out.println("findIndex : " + findex);
			
			
			HttpSession session = req.getSession();
			MemberDto logindto = (MemberDto)session.getAttribute("login");
			List<OrderListDto> list = (List<OrderListDto>)session.getAttribute(logindto.getEmail());
			
			System.out.println("cartupdate 컨트롤러에서 : " + findex);
			
			OrderListDto updatedto = list.get(findex);
			
			System.out.println("업데이트 할 dto = "+updatedto.toString());
			
			String json = "";
				   json += "{\"pname\":\"" + updatedto.getProduct_name() + "\",";
				   json += "\"pimage\":\"" + updatedto.getProduct_image() + "\",";
				   json += "\"psize\":\"" + updatedto.getProduct_size() + "\",";
				   json += "\"pcount\":" + updatedto.getProduct_count() + "}";
				 
			System.out.println(json);
			
			pw.println(json);
			pw.flush();
			
		}else if(command.equals("allOrder")) {
			HttpSession session = req.getSession();
			MemberDto logindto = (MemberDto)session.getAttribute("login");
			List<OrderListDto> orderlist = (List<OrderListDto>)session.getAttribute(logindto.getEmail());
			for (int i = 0; i < orderlist.size(); i++) {
				System.out.println("주문할 내역 : " + orderlist.get(i).toString());
			}
			resp.sendRedirect("Store/Store_Order.jsp"); 
		}
		
		
		
		
		else if(command.equals("MyOrderList")){  //마이페이지 주문내역	
			HttpSession session = req.getSession();
			MemberDto logindto = (MemberDto)session.getAttribute("login");
			String email = logindto.getEmail();
			
			List<MyOrderListDto> orderlist = dao.getMyOrder(email);
			req.setAttribute("orderlist", orderlist);
			req.getRequestDispatcher("Store/Store_Myorderlist.jsp").forward(req, resp);
		}
		
		else if(command.equals("login")) {
			System.out.println("로그인");
			resp.sendRedirect("Login/Login.jsp");
				
		}else if(command.equals("loginAF")) {
			String id = req.getParameter("id");
			String pw = req.getParameter("pw");
			
			MemberDto dto = memdao.login(id, pw);
			HttpSession session = req.getSession();
			session.setMaxInactiveInterval(3000);
			session.setAttribute("login", dto);
			/* req.getRequestDispatcher("Store/Store_QnAWrite.jsp").forward(req, resp); */
			resp.sendRedirect("/TAMINO/StoreCtrl?command=StoreMain");
		
		}else if(command.equals("logout")) {
			HttpSession session = req.getSession();
			session.removeAttribute("login");
			resp.sendRedirect("/TAMINO/StoreCtrl?command=StoreMain");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String command = req.getParameter("command");
		iStoreDao dao = StoreDao.getInstance();
		System.out.println("doPost");
		
		if(command.equals("addCart")) {
			HttpSession session = req.getSession();
			if(session.getAttribute("login") == null) {
				resp.sendRedirect("/TAMINO/StoreCtrl?command=login");
			}
			System.out.println("장바구니 도착");
			
			int product_seq = Integer.parseInt(req.getParameter("product_seq"));
			
			String product_code = req.getParameter("product_code");
			String product_name = req.getParameter("product_name");
			String product_size = req.getParameter("product_size");
			String product_image = req.getParameter("product_image");
			int product_count = Integer.parseInt(req.getParameter("product_count"));
			int product_price = Integer.parseInt(req.getParameter("product_price"));
			
			if(!product_code.equals("의류")) {
				product_size = "해당없음";
			}
			System.out.println(product_size);
			
			
			MemberDto logindto = (MemberDto)session.getAttribute("login");
			String email = logindto.getEmail();
			
			
			list.add(new OrderListDto(email, product_seq, product_name, product_image, product_size, product_count, product_price));
			session.setMaxInactiveInterval(24 * 60 * 60 * 1000);
			/* session.setAttribute("cartlist", list); */
			session.setAttribute(logindto.getEmail(), list);
			
		}else if(command.equals("updateCart")) {
			System.out.println("장바구니수정");
			
			int updateindex = Integer.parseUnsignedInt(req.getParameter("updateindex"));
			System.out.println("수정할인덱스: " + updateindex);
			
			String update_size = req.getParameter("update_size");
			int update_count = Integer.parseInt(req.getParameter("update_count"));
			
			HttpSession session = req.getSession();
			MemberDto logindto = (MemberDto)session.getAttribute("login");
			List<OrderListDto> list = (List<OrderListDto>)session.getAttribute(logindto.getEmail());
			OrderListDto updateDto = list.get(updateindex);
			System.out.println("수정 전 dto : "+updateDto.toString());
			if(updateDto.getProduct_size().equals("해당없음")) {
				updateDto.setProduct_size("해당없음");
			}else {
				updateDto.setProduct_size(update_size);
			}
			
			updateDto.setProduct_count(update_count);
			
			System.out.println("수정 후 dto : "+updateDto.toString());
			
			//resp.sendRedirect("/TAMINO/StoreCtrl?command=goCart");
			
		}else if(command.equals("deleteCart")) {
			HttpSession session = req.getSession();
			MemberDto logindto = (MemberDto)session.getAttribute("login");
			List<OrderListDto> list = (List<OrderListDto>)session.getAttribute(logindto.getEmail());
			System.out.println(list.toString());
			
			System.out.println("장바구니 삭제");
			String dels[] = req.getParameter("delslist").split(",");
			
			for (int i = 0; i < dels.length; i++) {
				System.out.println("dels array: " + dels[i]);
			}
			
			
			List<OrderListDto> delList = new ArrayList<OrderListDto>();
			for (int i = 0; i < dels.length; i++) {
				delList.add(list.get(Integer.parseInt(dels[i])));
			}
			
			for (int i = 0; i < delList.size(); i++) {
				list.remove(delList.get(i));
			}
			resp.sendRedirect("/TAMINO/StoreCtrl?command=goCart");
			
		}
	}
	
	

}
