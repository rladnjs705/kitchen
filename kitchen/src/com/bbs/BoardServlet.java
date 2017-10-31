package com.bbs;

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
import com.notice.NoticeDAO;
import com.notice.NoticeDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.FileManager;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/bbs/*")
public class BoardServlet extends MyServlet{
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
		} else if(uri.indexOf("delete.do")!=-1) {
			delete(req, resp, pathname);
		} else if(uri.indexOf("update.do")!=-1) {
			update(req, resp);
		} else if(uri.indexOf("update_ok.do")!=-1) {
			updateSubmit(req, resp, pathname);
		} else if(uri.indexOf("download.do")!=-1) {
			download(req, resp, pathname);
		} else if(uri.indexOf("reply.do")!=-1) {
			reply(req, resp);
		} else if(uri.indexOf("reply_ok.do")!=-1) {
			replySubmit(req, resp, pathname);
		} else if(uri.indexOf("article.do")!=-1) {
			article(req, resp);
		}
	}
	
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String page = req.getParameter("page");
		int num = Integer.parseInt(req.getParameter("num"));
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = dao.readBoard(num);
		dao.updateHitCount(num);
		
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		
		if(searchKey==null) {
			searchKey = "작성자";
			searchValue = "";
		}
		
		BoardDTO predto = dao.preReadBoard(dto.getGroupNum(), dto.getOrderNo(), searchKey, searchValue);
		BoardDTO nextdto = dao.nextReadBoard(dto.getGroupNum(), dto.getOrderNo(), searchKey, searchValue);
		
		String msgP = "";
		String msgN = "";
		if(predto==null)
			msgP = "이전글이 존재하지 않습니다.";
		if(nextdto==null)
			msgN = "다음글이 존재하지 않습니다.";
		
		req.setAttribute("msgP", msgP);
		req.setAttribute("msgN", msgN);
		req.setAttribute("preDto", predto);
		req.setAttribute("nextDto", nextdto);
		req.setAttribute("dto", dto);
		req.setAttribute("page", page);
		forward(req, resp, "/WEB-INF/views/bbs/article.jsp");
	}
	
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		MyUtil util = new MyUtil();
		BoardDAO dao = new BoardDAO();
		
		String page = req.getParameter("page");
		
		int currentPage = 1;
		if(page!=null) {
			currentPage = Integer.parseInt(page);
		}
		
		String searchKey = req.getParameter("searchKey");
		String searchValue = "";
		//searchValue = URLEncoder.encode(searchValue, "UTF-8");
		if(searchKey==null) {
			searchKey = "userName";
			searchValue = "";
		}
		
		int dataCount = dao.dataCount();
		if(searchValue.length()!=0)
			dataCount = dao.dataCount(searchKey, searchValue);
		
		int numPerPage = 10;
		int totalPage = util.pageCount(numPerPage, dataCount);
		
		if(currentPage>totalPage)
			currentPage = totalPage;
		
		if(req.getMethod().equalsIgnoreCase("get")) {
			searchValue = URLDecoder.decode(searchValue,"UTF-8");
		}
		
		int rows=10;
		int start = (currentPage-1)*rows+1;
		int end = currentPage*rows;
		
		List<BoardDTO> list = new ArrayList<>();
		list = dao.listBoard(start, end);
		if(searchValue.length()!=0)
			list = dao.listBoard(start, end, searchKey, searchValue);
		
		for(BoardDTO dto :list) {
			System.out.println(dto.getContent());
		}
		// 리스트 글번호 만들기
		int listNum, n=0;
		Iterator<BoardDTO>it=list.iterator();
		while(it.hasNext()) {
			BoardDTO dto=it.next();
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp = req.getContextPath();
		String listUrl = cp+"/bbs/list.do";
		String articleUrl = cp+"/bbs/article.do?page="+currentPage;
		String query = "";
		
		if(searchValue.length()!=0) {
			query = "searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "UTF-8");
		}
		
		if(query.length()!=0) {
			listUrl+="?"+query;
			articleUrl+="&"+query;
		}
		
		String paging = util.paging(currentPage, totalPage, listUrl);
		
		req.setAttribute("page", currentPage);
		req.setAttribute("query", query);
		req.setAttribute("articleUrl", articleUrl);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("list", list);
		req.setAttribute("paging", paging);
		
		forward(req, resp, "/WEB-INF/views/bbs/list.jsp");
	}
	
	protected void created(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String page = req.getParameter("page");
		//로그인확인
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info==null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}
		
		req.setAttribute("mode", "created");
		req.setAttribute("page", page);
		forward(req, resp, "/WEB-INF/views/bbs/created.jsp");
	}
	
	protected void createdSubmit(HttpServletRequest req, HttpServletResponse resp,String pathname) throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = new BoardDTO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String mode = req.getParameter("mode");
		
		String encType = "utf-8";
		int maxFilesize = 20*1024*1024;
		MultipartRequest mreq = null;
		mreq = new MultipartRequest(req,pathname,maxFilesize,encType,new DefaultFileRenamePolicy());
		
		dto.setUserId(info.getUserId());
		dto.setSubject(mreq.getParameter("subject"));
		dto.setContent(mreq.getParameter("content"));
		dto.setQuestionType(mreq.getParameter("questionType"));
		dto.setPwd(Integer.parseInt(mreq.getParameter("pwd")));
		
		if(mreq.getFile("upload")!=null) {
			dto.setSaveFileName(mreq.getFilesystemName("upload"));
			dto.setOriginalFileName(mreq.getOriginalFileName("upload"));
		}
		
		dto.setTel(mreq.getParameter("tel1")+mreq.getParameter("tel2")+mreq.getParameter("tel3"));
		dao.insertInquiry(dto, mode);
		
		String cp = req.getContextPath();
		resp.sendRedirect(cp+"/bbs/list.do");
	}
	
	protected void delete(HttpServletRequest req, HttpServletResponse resp, String pathname) throws ServletException, IOException {
			
	}
	
	protected void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String page = req.getParameter("page");
		int num = Integer.parseInt(req.getParameter("num"));
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = dao.readBoard(num);
		
		if(dto==null) {
			forward(req, resp, "/WEB-INF/views/bbs/list.jsp");
			return;
		}
		
		String tel1="", tel2="", tel3="";
		
		if(dto.getTel().length()==11) {
			tel1 = dto.getTel().substring(0, 3);
			tel2 = dto.getTel().substring(3,7);
			tel3 = dto.getTel().substring(7,11);
		} else if(dto.getTel().length()==10) {
			tel1 = dto.getTel().substring(0, 3);
			tel2 = dto.getTel().substring(3,6);
			tel3 = dto.getTel().substring(6,10);
		}
		
		req.setAttribute("dto", dto);
		req.setAttribute("tel1", tel1);
		req.setAttribute("tel2", tel2);
		req.setAttribute("tel3", tel3);
		req.setAttribute("mode", "update");
		
		forward(req, resp, "/WEB-INF/views/bbs/created.jsp");
	}
	
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp, String pathname) throws ServletException, IOException {
		
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

	protected void reply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("mode", "reply");
	}
	
	protected void replySubmit(HttpServletRequest req, HttpServletResponse resp, String pathname) throws ServletException, IOException {
		
	}
	
}
