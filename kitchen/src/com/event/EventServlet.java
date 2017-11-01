package com.event;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.MyUtil;

@WebServlet("/event/*")
public class EventServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}
	
	private void forward(HttpServletRequest req, HttpServletResponse resp, String path) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher(path);
		rd.forward(req, resp);
	}
	
	private void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		// cp부터 끝까지 주소
		String uri=req.getRequestURI();
		
		// uri에 따른 작업 구분
		if(uri.indexOf("list.do")!=-1) {
			// 게시물 리스트
			list(req, resp);
		} else if(uri.indexOf("created.do")!=-1) {
			// 글쓰기 폼
			createdForm(req, resp);
		} else if(uri.indexOf("created_ok.do")!=-1) {
			// 게시물 저장
			createdSubmit(req, resp);
		} else if(uri.indexOf("article.do")!=-1) {
			// 게시물 보기
			article(req, resp);
		} else if(uri.indexOf("update.do")!=-1) {
			// 수정 폼
			updateForm(req, resp);
		} else if(uri.indexOf("update_ok.do")!=-1) {
			// 수정 완료
			updateSubmit(req, resp);
		} else if(uri.indexOf("delete.do")!=-1) {
			// 게시물 삭제
			delete(req, resp);
		}
	}
	
	private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EventDAO dao=new EventDAO();
		MyUtil util=new MyUtil();
		String cp=req.getContextPath();
		
		String page=req.getParameter("page");
		int current_page=1;
		if(page!=null)
			current_page=Integer.parseInt(page);
		
		String searchKey=req.getParameter("searchKey");
		String searchValue=req.getParameter("searchValue");
		if(searchKey==null) {
			searchKey="eventSubject";
			searchValue="";
		}
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue=URLDecoder.decode(searchValue, "utf-8");
		}
		String state=req.getParameter("state");
		if(state==null)
			state="y";
		
		// 전체 데이터 개수 구하기
		int dataCount;
		if(searchValue.length()!=0)
			dataCount= dao.dataCount(searchKey, searchValue, state);
		else
			dataCount= dao.dataCount(state);
		
		int rows = 10;
		int total_page=util.pageCount(rows, dataCount);
		
		if(current_page>total_page)
			current_page=total_page;
		
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		
		List<EventDTO> list;
		if(searchValue.length()!=0)
			list= dao.listEvent(start, end, searchKey, searchValue, state);
		else
			list= dao.listEvent(start, end, state);
		
		// 리스트 글번호 만들기
		int listNum, n=0;
		Iterator<EventDTO> it=list.iterator();
		while (it.hasNext()) {
			EventDTO dto=it.next();
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			n++;
		}
		
		String query= "state="+state;
		if(searchValue!=null && searchValue.length()!=0) {
			searchValue = URLEncoder.encode(searchValue, "utf-8");
			query+="&searchKey=" +searchKey + "&searchValue=" +searchValue;
		}
		
		// 페이징처리
		String listUrl = cp+"/event/list.do";
		String articleUrl = cp+"/event/article.do?page=" + current_page;
		if(query.length()!=0) {
			listUrl+="?"+query;
			articleUrl=articleUrl + "&" + query;
		}
		
		String paging = util.paging(current_page, total_page, listUrl);
		
		// list.jsp 파일에 데이터를 넘겨준다.
		req.setAttribute("list", list);
		req.setAttribute("state", state);
		req.setAttribute("paging", paging);
		req.setAttribute("page", current_page);
		req.setAttribute("total_page", total_page);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("articleUrl", articleUrl);
		
		forward(req, resp, "/WEB-INF/views/event/list.jsp");
	}
	
	private void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("mode", "created");
		
		forward(req, resp, "/WEB-INF/views/event/created.jsp");
	}
	
	private void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EventDAO dao=new EventDAO();
		String cp=req.getContextPath();
		
		EventDTO dto=new EventDTO();
		
		dto.setUserId("admin");// 세션값 넣어주기
		dto.setEventSubject(req.getParameter("eventSubject"));
		dto.setEventContent(req.getParameter("eventContent"));
		dto.setEventEnd(req.getParameter("eventEnd"));
		
		dao.insertEvent(dto);
		
		resp.sendRedirect(cp+"/event/list.do");
	}
	
	private void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EventDAO dao=new EventDAO();
		String cp=req.getContextPath();
		
		int eventNum=Integer.parseInt(req.getParameter("eventNum"));
		String page=req.getParameter("page");
		
		String searchKey=req.getParameter("searchKey");
		String searchValue=req.getParameter("searchValue");
		if(searchKey==null) {
			searchKey="eventSubject";
			searchValue="";
		}
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue=URLDecoder.decode(searchValue, "utf-8");
		}
		
		// 조회수 증가
		dao.updateHitcount(eventNum);
		
		// 게시물 가져오기
		EventDTO dto=dao.readEvent(eventNum);
		if(dto==null) { // 게시물이 없으면
			resp.sendRedirect(cp+"/event/list.do?page="+page);
			return;
		}
		
		// 스타일로 처리하는 경우 : style="white-space:pre;"
		dto.setEventContent(dto.getEventContent().replaceAll("\n", "<br>"));
		
		// 이전글 / 다음글
		EventDTO preReadDto = dao.preReadEvent(eventNum, searchKey, searchValue);
		EventDTO nextReadDto = dao.nextReadEvent(eventNum, searchKey, searchValue);
		
		String query = "page="+page;
		if(! searchValue.equals("")) {
			query += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}
		
		req.setAttribute("dto", dto);
		req.setAttribute("page", page);
		req.setAttribute("query", query);
		req.setAttribute("preReadDto", preReadDto);
		req.setAttribute("nextReadDto", nextReadDto);
		
		forward(req, resp, "/WEB-INF/views/event/article.jsp");
	}
	
	private void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EventDAO dao=new EventDAO();
		String cp=req.getContextPath();
		
		int eventNum=Integer.parseInt(req.getParameter("eventNum"));
		String page=req.getParameter("page");
		
		EventDTO dto=dao.readEvent(eventNum);
		if(dto==null) {
			resp.sendRedirect(cp+"/event/list.do?page="+page);
			return;
		}
		
		req.setAttribute("mode", "update");
		req.setAttribute("dto", dto);
		req.setAttribute("page", page);
		
		forward(req, resp, "/WEB-INF/views/event/created.jsp");
	}
	
	private void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EventDAO dao=new EventDAO();
		String cp=req.getContextPath();
		
		EventDTO dto=new EventDTO();
		String page=req.getParameter("page");
		
		dto.setEventNum(Integer.parseInt(req.getParameter("eventNum")));
		dto.setUserId(req.getParameter("userId"));
		dto.setEventSubject(req.getParameter("eventSubject"));
		dto.setEventContent(req.getParameter("eventContent"));
		dto.setEventEnd(req.getParameter("eventEnd"));
		
		dao.updateEvent(dto);
		
		resp.sendRedirect(cp+"/event/list.do?page="+page);
	}
	
	private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EventDAO dao=new EventDAO();
		String cp=req.getContextPath();
		
		int eventNum=Integer.parseInt(req.getParameter("eventNum"));
		String page=req.getParameter("page");
		dao.deleteEvent(eventNum);
		
		resp.sendRedirect(cp+"/event/list.do?page="+page);
	}
}
