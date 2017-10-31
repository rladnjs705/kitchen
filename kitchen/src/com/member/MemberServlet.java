package com.member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.util.MyServlet;


@WebServlet("/member/*")
public class MemberServlet extends MyServlet{
	private static final long serialVersionUID = 1L;
	
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String uri = req.getRequestURI();
		
		if(uri.indexOf("login.do")!=-1) {
			//로그인화면으로
			login(req, resp);
		} else if(uri.indexOf("login_ok.do")!=-1){
			//DB에 저장된 자료와 비교, 로그인완료
			loginSubmit(req, resp);
		} else if(uri.indexOf("logout.do")!=-1) {
			//로그아웃
			logout(req, resp);
		}else if(uri.indexOf("userIdCheck.do")!=-1) {
			userIdCheck(req, resp);
		}else if(uri.indexOf("memberCreated.do")!=-1) {
			memberCreated(req, resp);
		} else if(uri.indexOf("memberCreatedSubmit.do")!=-1) {
			memberCreatedSubmit(req, resp);
		} else if(uri.indexOf("mypage.do")!=-1) {
			mypage(req,resp);
		}
	}
	private void memberCreated(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("mode", "created");
		forward(req, resp, "/WEB-INF/views/member/member.jsp");
	}
	
	private void memberCreatedSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = new MemberDTO();
		dto.setUserId(req.getParameter("userId"));
		dto.setUserPwd(req.getParameter("userPwd"));
		dto.setUserName(req.getParameter("userName"));
		dto.setBirth(req.getParameter("birth"));
		//이메일 합치기
		String email = null;
		email=req.getParameter("email1");
		email+="@";
		email+=req.getParameter("email2");
		dto.setEmail(email);
		String tel=req.getParameter("tel1");
		tel+="-";
		tel+=req.getParameter("tel2");
		tel+="-";
		tel+=req.getParameter("tel3");
		dto.setTel(tel);
		dto.setZip(req.getParameter("zip"));
		dto.setAddr_1(req.getParameter("addr_1"));
		dto.setAddr_2(req.getParameter("addr_2"));
		int check=dao.insertMember(dto);
		if(check!=0) {
			req.setAttribute("userId", dto.getUserId());
			forward(req, resp, "/WEB-INF/views/member/succeed.jsp");
		}else {
			forward(req, resp, "/WEB-INF/views/member/fail.jsp");
		}
	}
	

	protected void forward(HttpServletRequest req, HttpServletResponse resp, String path) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher(path);
		rd.forward(req, resp);
	}
	
	private void userIdCheck(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberDAO dao=new MemberDAO();
		String userId=req.getParameter("userId");
		int check=dao.checkUserId(userId);
		req.setAttribute("mode", "created");
		req.setAttribute("userIdCheck", check);
		req.setAttribute("userId", userId);
		forward(req, resp, "/WEB-INF/views/member/member.jsp");
	}
	
	private void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		forward(req, resp, "/WEB-INF/views/member/login.jsp");
	}
	
	
	private void loginSubmit (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		// 로그인 처리
		req.setCharacterEncoding("utf-8");
		HttpSession session = req.getSession();
		
		MemberDAO dao = new MemberDAO();
		String id = req.getParameter("userId");
		String pwd = req.getParameter("userPwd");
		
		MemberDTO dto = dao.readMember(id);
		if(dto==null || !dto.getUserPwd().equals(pwd)) {	
			req.setAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}
		
		//세션에 로그인정보 저장하기
		SessionInfo info = new SessionInfo();
		info.setUserId(dto.getUserId());
		info.setUserName(dto.getUserName());
		info.setRoll(dto.getEnabled());
		String cp = req.getContextPath();
		session.setAttribute("member", info);
		resp.sendRedirect(cp);
	}
	
	private void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		
		session.invalidate();
		
		String cp = req.getContextPath();
		resp.sendRedirect(cp);
	}
	private void mypage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		req.setCharacterEncoding("utf-8");
		HttpSession session = req.getSession();
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		req.setAttribute("userId", info.getUserId());
		req.setAttribute("userName", info.getUserName());
		forward(req, resp, "/WEB-INF/views/member/mypage.jsp");
	}
	
	
}
