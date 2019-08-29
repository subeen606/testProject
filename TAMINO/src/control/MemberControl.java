package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;
import dao.OrderListDao;
import dao.iMemberDao;
import dao.iOrderListDao;
import dto.MemberDto;
import dto.MyOrderListDto;

@WebServlet("/MemberCtrl")
public class MemberControl extends HttpServlet{
	
	iMemberDao memdao = MemberDao.getInstance();
	//iOrderListDao orderdao = OrderListDao.getInstance();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String command = req.getParameter("command");
		
		if(command.equals("login")) {
			System.out.println("로그인");
			resp.sendRedirect("Member/Member_Login.jsp");
				
		}else if(command.equals("logout")) {
			System.out.println("logout 들어옴");
			HttpSession session = req.getSession();
			session.removeAttribute("login");
			
			
			resp.sendRedirect("/TAMINO/AdminCtrl?command=Main_Page");
			
		}else if(command.equals("Account_emailCheck")) {
			String email = req.getParameter("email");
			System.out.println("Account_emailCheck email:"+ email);
			boolean a = memdao.emailCheck(email);
			resp.getWriter().print(a);
		}else if(command.equals("myInfo")) {
			String email = req.getParameter("email").trim();
			MemberDto memDto =  memdao.findMember(email);
			req.setAttribute("memDto", memDto);
			req.getRequestDispatcher("Member/Member_UpdateInfo.jsp").forward(req, resp);

		}
		
		else if(command.equals("GoMyPage")) {
			resp.sendRedirect("Member/Member_Index.jsp");
		}
		
		else if(command.equals("MyOrderList")){  //마이페이지 주문내역	
			HttpSession session = req.getSession();
			MemberDto logindto = (MemberDto)session.getAttribute("login");
			String email = logindto.getEmail();
			
			List<MyOrderListDto> orderlist = memdao.getMyOrder(email);
			req.setAttribute("orderlist", orderlist);
			req.getRequestDispatcher("Member/Member_Myorderlist.jsp").forward(req, resp);
		}
		
		else if(command.equals("Find_Email")) {
			System.out.println("Find_Email 들어옴");
			PrintWriter out = resp.getWriter();
			String name = req.getParameter("name");
			String phone = req.getParameter("phone");
			/* System.out.println("name="+name+", phone="+phone); */
			String email = memdao.findEmail(name, phone);
			System.out.println("email:"+email);
			out.println(email);
			out.flush();
			out.close();
		}
		
		else if(command.equals("Find_Password")) {
			System.out.println("Find_Password 들어옴");
			PrintWriter out = resp.getWriter();
			String email = req.getParameter("email");
			String phone = req.getParameter("phone");
			MemberDto memDto = memdao.findPwd(email, phone);
			
			if(memDto != null) {
				String updatePw = "";
				String pwd[] = {"0","1","2","3","4","5","6","7","8","9",
								"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};
				for (int i = 0; i < 8; i++) {
					 updatePw += pwd[(int)(Math.random()*34+1)]; 
				}
				 memdao.updateInfo(new MemberDto(memDto.getMember_seq(), memDto.getEmail(), updatePw, memDto.getAddress(), memDto.getPhoneNumber(), memDto.getUserName(), memDto.getMember_date(), memDto.getAuth()) );
				/* System.out.println("비밀번호 변경 성공"); */
				 util.Mailng.naverMailSend(email, "Tamino officail site 임시 비밀번호 입니다.", "귀하의 임시 비밀번호:"+updatePw+"\n 비밀번호 변경 후 사용해주세요.");
			}
			
			else if(memDto == null) {
				out.print(false);
				out.flush();
			}
			
			out.close();
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=utf-8");
		String command = req.getParameter("command");
		
		if(command.equals("login")) {
			System.out.println("로그인");
			resp.sendRedirect("Member/Member_Login.jsp");
				
		}else if(command.equals("Member_Login")) {

			String email = req.getParameter("email");
			String pwd = req.getParameter("password");
			PrintWriter out = resp.getWriter();
			MemberDao dao = MemberDao.getInstance();
			MemberDto mdto = dao.login(email, pwd);
			
			if(mdto != null) {
				if(mdto.getAuth()==3) {
					out.println("<script>alert('관리자 로그인입니다.'); location.href='/TAMINO/AdminCtrl?command=Admin_main'; </script>");
				}
				else {
				// 로그인 세션 생성
				HttpSession session = req.getSession();
				session.setAttribute("login", mdto);
				session.setMaxInactiveInterval(60 * 60 * 24 * 31);
				out.println("<script>alert('"+mdto.getUserName()+"님 환영합니다.'); location.href='/TAMINO/AdminCtrl?command=Main_Page'; </script>");
				out.flush();
				}
			
			}else {
				out.println("<script>alert('아이디,비밀번호를 확인해주세요'); location.href='/TAMINO/Member/Member_Login.jsp';</script>");
				out.flush();
			}

			out.close();
			
	 } else if (command.equals("Member_Account")) {
		 	System.out.println("Member_Account 들어옴");
		 	
		 	PrintWriter out = resp.getWriter();
		 	
			String email = req.getParameter("email");
			String pwd = req.getParameter("password");
			String name = req.getParameter("name");
			String phone1 = req.getParameter("phone1");
			String phone2 = req.getParameter("phone2");
			String phone3 = req.getParameter("phone3");
			String address1 = req.getParameter("address1");
			String address2 = req.getParameter("address2");
			String address3 = req.getParameter("address3");
			String address4 = req.getParameter("address4");

			String address = address1 + "-" + address2 + "-" + address3 + "-" + address4 ;

			String phonenumber = phone1 + "-" + phone2 + "-" + phone3;
			
			System.out.println("이름:"+name+", 주소:"+address);

			boolean check;
			check = memdao.addMember(new MemberDto(email, pwd, address, phonenumber, name, 0));
			
			if(check) {
				out.println("<script>alert('가입에 성공하였습니다.'); location.href='Member/Member_Login.jsp'; </script>");
				out.flush();
			}
			else {
				out.println("<script>alert('가입에 실패하였습니다.'); location.href='Member/Member_Login.jsp'; </script>");
				out.flush();
			}

			out.close();

		}else if(command.equals("updateInfo")) {
			PrintWriter out = resp.getWriter();
			
			String name = req.getParameter("name");
			String pwd = req.getParameter("password");
			String phoneNum = req.getParameter("phonenumber1")+"-"+req.getParameter("phonenumber2")+"-"+req.getParameter("phonenumber3");
			String address = req.getParameter("address1")+"-"+req.getParameter("address2")+"-"+req.getParameter("address3")+"-"+req.getParameter("address4");
			MemberDto dto = new MemberDto(pwd, address, phoneNum, name);
			System.out.println("updateInfo:"+dto.toString());
			boolean  a = memdao.updateInfo(dto);
			
			if(a) {
				out.println("<script>alert('회원정보가 수정되었습니다.'); </script>");
				out.flush();
			}else {
				out.println("<script>alert('회원정보를 수정하지 못했습니다.'); </script>");
				out.flush();
			}
			//req.setAttribute("boolean", a);
			//req.getRequestDispatcher("./Member/MyUpdateAf_inMain.jsp").forward(req, resp);
			out.close();
		}
	 
		
		
		/*
		else if(command.equals("loginAF")) {
			String id = req.getParameter("id");
			String pw = req.getParameter("pw");
			
			MemberDto dto = memdao.login(id, pw);
			HttpSession session = req.getSession();
			session.setMaxInactiveInterval(3000);
			session.setAttribute("login", dto);
			
			resp.sendRedirect("/TAMINO/StoreCtrl?command=StoreMain");
		
		}else if(command.equals("logout")) {
			HttpSession session = req.getSession();
			session.removeAttribute("login");
			resp.sendRedirect("/TAMINO/StoreCtrl?command=StoreMain");
		}else if(command.equals("Member_Account")) {
			
		}
		*/
	}
	
	
}
