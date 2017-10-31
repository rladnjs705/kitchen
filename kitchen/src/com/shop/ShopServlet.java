package com.shop;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/shop/*")
public class ShopServlet extends MyServlet{
	private static final long serialVersionUID = 1L;
	
	
	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {	
		req.setCharacterEncoding("utf-8");
		
		String uri=req.getRequestURI();
		
		HttpSession session=req.getSession();
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"shop";
		File f=new File(pathname);
		
		if(! f.exists()) {
			f.mkdirs();
		}
		
		if(uri.indexOf("list.do")!=-1) {
		}else if(uri.indexOf("created.do")!=-1) {
			//글쓰기 폼
			createdForm(req, resp);
		}else if(uri.indexOf("created_ok.do")!=-1) {
			//글 저장
			createdSubmit(req, resp, pathname);
		}else if(uri.indexOf("shopmenu.do")!=-1) {
			//글 보기
			shopmenu(req, resp);
		}else if(uri.indexOf("update.do")!=-1) {
			//글 수정 폼
			updateForm(req, resp);
		}else if(uri.indexOf("update_ok.do")!=-1) {
			//글 수정 완료
			updateSubmit(req, resp);
		}else if(uri.indexOf("delete.do")!=-1) {
			//글 삭제
			delete(req, resp);
		}
	}
	private void createdForm(HttpServletRequest req, HttpServletResponse resp)throws ServletException , IOException{
		req.setAttribute("mode", "created");
		
		forward(req, resp, "/WEB-INF/views/shop/created.jsp");
	}
	
	private void createdSubmit(HttpServletRequest req, HttpServletResponse resp, String pathname) throws ServletException, IOException {
		ShopDAO dao =new ShopDAO();
		String cp =req.getContextPath();
		ShopDTO dto =new ShopDTO();
		
		String encType="utf-8";
		int maxSize=5*1024*1024;
		
		MultipartRequest mreq=new MultipartRequest(req, pathname, maxSize, encType, new DefaultFileRenamePolicy());
		
		dto.setShopName(mreq.getParameter("shopName"));
		dto.setContent(mreq.getParameter("content"));
		dto.setShopZip1(mreq.getParameter("shopZip1"));
		dto.setShopZip2(mreq.getParameter("shopZip2"));
		dto.setShopAddr1(mreq.getParameter("shopAddr1"));
		dto.setShopAddr2(mreq.getParameter("shopAddr2"));
		dto.setShopTel1(mreq.getParameter("shopTel1"));
		dto.setShopTel2(mreq.getParameter("shopTel2"));
		dto.setShopStart(mreq.getParameter("shopStart"));
		dto.setShopEnd(mreq.getParameter("shopEnd"));
		dto.setShopPrice(Integer.parseInt(mreq.getParameter("shopPrice")));
		dto.setShopTime(Integer.parseInt(mreq.getParameter("shopTime")));
		dto.setLatitude(Integer.parseInt(mreq.getParameter("latitude")));
		dto.setLongitude(Integer.parseInt(mreq.getParameter("longitude")));
		
		if(mreq.getFile("upload")!=null) {
			dto.setSaveFilename(mreq.getFilesystemName("upload"));
			dto.setOriginalFilename(mreq.getOriginalFileName("upload"));
		}
		
		dao.insertShop(dto);
		resp.sendRedirect(cp+"/shop/shopmenu.do");
		
	}
	
	private void shopmenu(HttpServletRequest req, HttpServletResponse resp)throws ServletException , IOException{
		MyUtil util = new MyUtil();
		ShopDAO dao = new ShopDAO();
		
		String page = req.getParameter("page");
		
		int currentPage = 1;
		if(page!=null) {
			currentPage = Integer.parseInt(page);
		}
		int dataCount = dao.dataCount();
		
		int numPerPage = 10;
		int totalPage = util.pageCount(numPerPage, dataCount);
		
		if(currentPage>totalPage)
			currentPage = totalPage;
		
		int rows=10;
		int start = (currentPage-1)*rows+1;
		int end = currentPage*rows;
		
		List<ShopDTO> list = new ArrayList<>();
		
		list = dao.listShop(start, end);
		
		for(ShopDTO dto: list) {
			System.out.println(dto.getContent());
		}
		
		int listNum, n=0;
		Iterator<ShopDTO>it=list.iterator();
		while(it.hasNext()) {
			ShopDTO dto=it.next();
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			n++;
		}
		String cp = req.getContextPath();
		String listUrl = cp+"/shop/shopmenu.do";
		String articleUrl = cp+"/menu/article.do?page="+currentPage;
		String query = "";
		
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

		forward(req, resp, "/WEB-INF/views/shop/shopmenu.jsp");
	}
	
	private void updateForm(HttpServletRequest req, HttpServletResponse resp)throws ServletException , IOException{
		
	}
	
	private void updateSubmit(HttpServletRequest req, HttpServletResponse resp)throws ServletException , IOException{
		
	}
	
	private void delete(HttpServletRequest req, HttpServletResponse resp)throws ServletException , IOException{
		
	}
}
