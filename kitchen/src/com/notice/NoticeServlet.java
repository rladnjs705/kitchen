package com.notice;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.FileManager;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/notice/*")
public class NoticeServlet extends MyServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String uri = req.getRequestURI();

		HttpSession session = req.getSession();
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"fbbs";
		File f = new File(pathname);
		if(! f.exists()) {	//폴더가 없으면 폴더 만들기 
			f.mkdirs();
		}
		
		if(uri.indexOf("list.do")!=-1) {
			list(req, resp);
		} else if(uri.indexOf("created.do")!=-1) {
			created(req, resp);
		} else if(uri.indexOf("created_ok.do")!=-1) {
			createdSubmit(req, resp, pathname);
		} else if(uri.indexOf("article.do")!=-1) {
			article(req, resp);
		} else if(uri.indexOf("delete.do")!=-1) {
			delete(req,resp,pathname);
		} else if(uri.indexOf("update.do")!=-1) {
			update(req, resp);
		} else if(uri.indexOf("update_ok.do")!=-1) {
			updateSubmit(req, resp,pathname);
		} else if(uri.indexOf("download.do")!=-1) {
			download(req, resp, pathname);
		}
	}
	
	private void delete(HttpServletRequest req, HttpServletResponse resp, String pathname) throws ServletException, IOException {
		NoticeDAO dao = new NoticeDAO();
		NoticeDTO dto = new NoticeDTO();
		int num = Integer.parseInt(req.getParameter("num"));
		String cp = req.getContextPath();
		dao.deleteNotice(num);
		
		if(dto!=null&&dto.getSaveFileName()!=null&&dto.getSaveFileName().length()!=0) {
			FileManager.doFiledelete(pathname, dto.getSaveFileName());
		}

		resp.sendRedirect(cp+"/notice/list.do");
	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//로그인했는지 안했는지 확인
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		//관리자계정일 경우에만 공지리스트에서 글올리기 버튼을 보여준다.
		if(info==null||!info.getUserId().equals("admin")) {
			req.setAttribute("roll", "guest");
		}
		
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		
		if(searchKey==null) {
			searchKey = "subject";
			searchValue = "";
		}
	
		if(req.getMethod().equalsIgnoreCase("get")) {
			searchValue = URLDecoder.decode(searchValue,"UTF-8");
		}
		
		MyUtil util = new MyUtil();
		NoticeDAO dao = new NoticeDAO();
		
		int dataCount = dao.dataCount();
		if(searchValue.length()!=0)
			dataCount = dao.dataCount(searchKey, searchValue);
		
		int dataPerPage = 10;
		
		String page = req.getParameter("page");
		int current_page=1;
		
		if(page!=null)
			current_page = Integer.parseInt(page);
		
		int total_page = util.pageCount(dataPerPage, dataCount);
		
		if(total_page<current_page)
			current_page=total_page;
		
		int rows=10;
		int start = (current_page-1)*rows+1;
		int end = current_page*rows;
		
		List<NoticeDTO> list = new ArrayList<>();
		if(searchValue.length()==0)
			list = dao.list(start, end);
		else
			list = dao.list(start, end, searchKey, searchValue);
		
		List<NoticeDTO> listNotice = new ArrayList<>();
		listNotice = dao.listNotice();
		
		// 리스트 글번호 만들기
		int listNum, n=0;
		Iterator<NoticeDTO>it=list.iterator();
		while(it.hasNext()) {
			NoticeDTO dto=it.next();
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp = req.getContextPath();
		String list_url = cp+"/notice/list.do";
		String article_url = cp+"/notice/article.do?page="+current_page;
		String query = "";
		
		if(searchValue.length()!=0) {
			query = "searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "UTF-8");
		}
		
		if(query.length()!=0) {
			list_url+="?"+query;
			article_url+="&"+query;
		}
		String paging = util.paging(current_page, total_page, list_url);
		
		req.setAttribute("paging", paging);
		req.setAttribute("page", current_page);
		req.setAttribute("totalPage", total_page);
		req.setAttribute("list", list);
		req.setAttribute("listNotice", listNotice);
		req.setAttribute("listUrl", list_url);
		req.setAttribute("articleUrl", article_url);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("query", query);
		
		forward(req, resp, "/WEB-INF/views/notice/list.jsp");
	}
	
	protected void created(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String page = req.getParameter("page");
		
		//로그인 하지 않았을 경우 로그인페이지로 이동.
		if(info==null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}

		req.setAttribute("page", page);
		req.setAttribute("mode", "created");
		forward(req, resp, "/WEB-INF/views/notice/created.jsp");
	}
	
	protected void createdSubmit(HttpServletRequest req, HttpServletResponse resp, String pathname) throws ServletException, IOException {
		NoticeDAO dao = new NoticeDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		//String pwd = req.getParameter("pwd");
		//System.out.println(session.getAttribute("userPwd"));
		//if(!session.getAttribute(pwd).equals(pwd))
		String encType = "utf-8";
		int maxFilesize = 20*1024*1024;
		MultipartRequest mreq = null;
		mreq = new MultipartRequest(req,pathname,maxFilesize,encType,new DefaultFileRenamePolicy());
		
		NoticeDTO dto = new NoticeDTO();
		dto.setUserId(info.getUserId());
		dto.setSubject(mreq.getParameter("subject"));
		dto.setContent(mreq.getParameter("content"));
		//dto.setIpAddr(req.getRemoteAddr());	//ip주소는 파라미터가 아니므로 그냥 req써도 된다.
		
		String isNotice = mreq.getParameter("isNotice");
		
		if(isNotice!=null&&isNotice.trim().equals("on"))
			dto.setNotice(1);
		else
			dto.setNotice(0);

		if(mreq.getFile("upload")!=null) {
			dto.setSaveFileName(mreq.getFilesystemName("upload"));
			dto.setOriginalFileName(mreq.getOriginalFileName("upload"));
		}
		dao.insertNotice(dto);
		
		String cp = req.getContextPath();
		
		resp.sendRedirect(cp+"/notice/list.do");
	}		
	
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		//관리자계정일 경우에만 공지리스트에서 수정/삭제 버튼을 보여준다.
		if(info==null||!info.getUserId().equals("admin")) {
			req.setAttribute("roll", "guest");
		}
		
		String page = req.getParameter("page");
		int num = Integer.parseInt(req.getParameter("num"));
		
		NoticeDAO dao = new NoticeDAO();
		NoticeDTO dto = new NoticeDTO();
		dto = dao.readNotice(num);
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		dao.updateHit(num);
		
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		
		if(searchKey==null) {
			searchKey = "subject";
			searchValue = "";
		}
		
		searchValue = URLDecoder.decode(searchValue, "utf-8");
		
		NoticeDTO predto = dao.preRead(num, searchKey, searchValue);
		NoticeDTO nextdto = dao.nextRead(num, searchKey, searchValue);
		
		String msgP = "";
		String msgN = "";
		if(predto==null)
			msgP="이전글이 존재하지 않습니다.";
		if(nextdto==null)
			msgN= "다음글이 존재하지 않습니다.";
		
		String query = "";
		if(searchValue.length()!=0) {
			query = "&searchKey="+searchKey+"&searchValue="+searchValue;
		}
		req.setAttribute("dto", dto);
		req.setAttribute("predto", predto);
		req.setAttribute("nextdto", nextdto);
		req.setAttribute("page", page);
		req.setAttribute("msgN", msgN);
		req.setAttribute("msgP", msgP);
		req.setAttribute("query", query);
		
		forward(req, resp, "/WEB-INF/views/notice/article.jsp");
	}
	
	protected void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String page = req.getParameter("page");
		int num = Integer.parseInt(req.getParameter("num"));
		
		NoticeDAO dao = new NoticeDAO();
		NoticeDTO dto = dao.readNotice(num);
		
		req.setAttribute("dto", dto);
		req.setAttribute("num", num);
		req.setAttribute("page", page);
		req.setAttribute("mode", "update");
		forward(req, resp, "/WEB-INF/views/notice/created.jsp");
	}
	
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp,String pathname) throws ServletException, IOException {
		String d = req.getParameter("deleteFile");
		System.out.println(d);
		NoticeDAO dao = new NoticeDAO();
		NoticeDTO dto = new NoticeDTO();
		
		String encType = "utf-8";
		int maxFilesize = 20*1024*1024;
		MultipartRequest mreq = null;
		mreq = new MultipartRequest(req,pathname,maxFilesize,encType,new DefaultFileRenamePolicy());
		
		int num = Integer.parseInt(mreq.getParameter("num"));
		dto.setNum(num);
		String isNotice = mreq.getParameter("isNotice");
		if(isNotice!=null&&isNotice.trim().equals("on"))
			dto.setNotice(1);
		else
			dto.setNotice(0);
		
		dto.setSubject(mreq.getParameter("subject"));
		dto.setContent(mreq.getParameter("content"));
		
		dto.setSaveFileName(mreq.getParameter("saveFileName"));
		dto.setOriginalFileName(mreq.getParameter("originalFileName"));
		
		if(mreq.getFile("upload")!=null) {
			if(dto.getSaveFileName()==null||dto.getSaveFileName().length()!=0) {
				//기존에 있던 파일 지우기
				FileManager.doFiledelete(pathname, dto.getSaveFileName());
			}
			dto.setSaveFileName(mreq.getFilesystemName("upload"));
			dto.setOriginalFileName(mreq.getOriginalFileName("upload"));
		}
		
		dao.updateNotice(dto);
		
		String cp = req.getContextPath();
		resp.sendRedirect(cp+"/notice/list.do");
		
	}
	
	private void download(HttpServletRequest req, HttpServletResponse resp, String pathname) throws ServletException, IOException {
		NoticeDAO dao = new NoticeDAO();

		int num = Integer.parseInt(req.getParameter("num"));
		NoticeDTO dto = dao.readNotice(num);
		
		boolean b = false;
		if(dto!=null) {
			b = FileManager.doFiledownload(dto.getSaveFileName(), dto.getOriginalFileName(), pathname, resp);
		}
		
		//다운받을 수 없으면 alert창 띄워주고 다시 목록으로 돌아가게끔한다.
		if(!b) {
			resp.setContentType("text/html;charset = utf-8");
			PrintWriter out = resp.getWriter();
			String s = "<script>alert('파일을 다운로드할 수 없습니다.');";
			s+="history.back();</script>";
			out.println(s);
			
		}
	}

}
