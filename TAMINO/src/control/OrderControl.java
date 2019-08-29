package control;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AdminDao;
import dao.OrderListDao;
import dao.iAdminDao;
import dao.iOrderListDao;
import dto.MemberDto;
import dto.OrderListDto;
import dto.ProductDto;

import oracle.net.aso.i;

@WebServlet("/ordercontrol")
public class OrderControl extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		
		String command = req.getParameter("command");
		iOrderListDao dao = OrderListDao.getInstance();
		
		
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 req.setCharacterEncoding("UTF-8");

		
		String command = req.getParameter("command");
		iOrderListDao dao = OrderListDao.getInstance();
		
		if (command.equals("addorder")) {
			
			// 세션 받기
			HttpSession session = req.getSession();
			MemberDto logindto = (MemberDto)session.getAttribute("login");
			List<OrderListDto> orderlist = (List<OrderListDto>)session.getAttribute(logindto.getEmail());
			
			
			String sessionName = "";
			Enumeration em = session.getAttributeNames();
			while(em.hasMoreElements()) {
				sessionName = em.nextElement().toString();
				System.out.println("세션 명: " + sessionName);
				if(!sessionName.equals("login")){
					session.removeAttribute(sessionName); 
				}	
			}
			
			String order_email = req.getParameter("order_email");
			String order_name = req.getParameter("order_name");
			//주소
			String order_address1 = req.getParameter("order_address1");
			String order_address2 = req.getParameter("order_address2");
			String order_address3 = req.getParameter("order_address3");
			String order_address4 = req.getParameter("order_address4");
			
			String order_address = order_address1 + "-" + order_address2 + "-" + order_address3 + "-" + order_address4;
			//전화번호
			String order_phonenumber1 = req.getParameter("order_phonenumber1");
			String order_phonenumber2 = req.getParameter("order_phonenumber2");
			String order_phonenumber3 = req.getParameter("order_phonenumber3");
			
			String order_phonenumber = order_phonenumber1 + "-" + order_phonenumber2 + "-" + order_phonenumber3;
			
			String order_request1 = req.getParameter("order_request1");
			
			String order_request2 = req.getParameter("order_request2");
			
			String order_request = null;
			
			if(order_request1.equals("")) {
				order_request = order_request2;
			}
			
			//재고수
			iAdminDao adao = AdminDao.getInstance();

			OrderListDto dto = null;
			int listsize = Integer.parseInt(req.getParameter("listsize"));
			
			
			List<OrderListDto> insertOrder = new ArrayList<OrderListDto>();
			for (int i = 0; i < orderlist.size(); i++) {
				int product_seq = orderlist.get(i).getProduct_seq();
				String product_name = orderlist.get(i).getProduct_name();
				String product_image = orderlist.get(i).getProduct_image();
				String product_size = orderlist.get(i).getProduct_size();
				int product_count = orderlist.get(i).getProduct_count();
				int product_price = orderlist.get(i).getProduct_price();
				
				dto = new OrderListDto(order_email,order_name,order_address,order_phonenumber,order_request,
						product_seq,product_name,product_image,product_size,product_count,product_price);
				insertOrder.add(dto);
				
				//재고수
				System.out.println("controll"+product_seq);
				System.out.println("controll"+product_size);
				
				int num = adao.searchnum(product_seq, product_size);
				System.out.println("controll"+num);
				boolean a = adao.updatecount(product_seq, product_size, product_count, num);
			}
			
			dao.insertOrderList(insertOrder);
			
			
			
			
			orderlist.clear();
			
			
			req.setAttribute("order_email", order_email);
			req.getRequestDispatcher("ordercontrol?command=resultlist").forward(req, resp);
			/*
			for (int i = 0; i < listsize; i++) {
				
				int product_seq = Integer.parseInt(req.getParameter("product_seq"+i));
				String product_name = req.getParameter("product_name"+i);
				String product_image = req.getParameter("product_image"+i);
				String product_size = req.getParameter("product_size"+i);
				int product_count = Integer.parseInt(req.getParameter("product_count"+i));
				int product_price = Integer.parseInt(req.getParameter("product_price"+i));
				
				dto = new OrderListDto(order_email,order_name,order_address,order_phonenumber,order_request,
						product_seq,product_name,product_image,product_size,product_count,product_price);
				
				dao.addorder(dto);
				//재고수
				System.out.println("controll"+product_seq);
				System.out.println("controll"+product_size);
				
				int num = adao.searchnum(product_seq, product_size);
				System.out.println("controll"+num);
				boolean a = adao.updatecount(product_seq, product_size, product_count, num);
			}
		
			req.setAttribute("order_email", order_email);
			req.getRequestDispatcher("ordercontrol?command=resultlist").forward(req, resp);
			 */
				
		}else if (command.equals("resultlist")) {
			
			Calendar calendar = Calendar.getInstance();
            java.util.Date date = calendar.getTime();
            //String _today = (new SimpleDateFormat("yyyyMMddHHmm").format(date));
            String _today = (new SimpleDateFormat("yyyyMMddHHmmss").format(date));
			String order_email = req.getParameter("order_email");
			
			List<OrderListDto> orderlist = dao.getResultList(_today, order_email);
			
			System.out.println(_today);
			System.out.println(order_email);
			
			req.setAttribute("_today", _today);
			req.setAttribute("orderlist", orderlist);
			req.getRequestDispatcher("/Store/Store_OrderResult.jsp").forward(req, resp);
		}
		
	}



}
