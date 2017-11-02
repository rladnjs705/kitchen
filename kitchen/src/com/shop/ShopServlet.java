package com.shop;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.FileManager;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/shop/*")
public class ShopServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();

		String pathname = "C:\\web\\work\\kitchen\\kitchen\\WebContent\\resource\\images";
		File f = new File(pathname);

		if (!f.exists()) {
			f.mkdirs();
		}

		if (uri.indexOf("list.do") != -1) {
		} else if (uri.indexOf("created.do") != -1) {
			// 글쓰기 폼
			createdForm(req, resp);
		} else if (uri.indexOf("created_ok.do") != -1) {
			// 글 저장
			createdSubmit(req, resp, pathname);
		} else if (uri.indexOf("shopmenu.do") != -1) {
			// 글 보기
			shopmenu(req, resp);
		} else if (uri.indexOf("update.do") != -1) {
			// 글 수정 폼
			updateForm(req, resp);
		} else if (uri.indexOf("update_ok.do") != -1) {
			// 글 수정 완료
			updateSubmit(req, resp, pathname);
		} else if (uri.indexOf("deleteList.do") != -1) {
			// 글 삭제
			deleteList(req, resp);
		}
	}

	private void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("mode", "created");

		forward(req, resp, "/WEB-INF/views/shop/created.jsp");
	}

	private void createdSubmit(HttpServletRequest req, HttpServletResponse resp, String pathname)
			throws ServletException, IOException {
		ShopDAO dao = new ShopDAO();
		String cp = req.getContextPath();
		ShopDTO dto = new ShopDTO();

		String encType = "utf-8";
		int maxSize = 5 * 1024 * 1024;

		MultipartRequest mreq = new MultipartRequest(req, pathname, maxSize, encType, new DefaultFileRenamePolicy());

		dto.setShopName(mreq.getParameter("shopName"));
		dto.setContent(mreq.getParameter("content"));
		dto.setShopZip1(mreq.getParameter("shopZip1"));
		dto.setShopAddr1(mreq.getParameter("shopAddr1"));
		dto.setShopAddr2(mreq.getParameter("shopAddr2"));
		dto.setShopTel1(mreq.getParameter("shopTel1"));
		dto.setShopTel2(mreq.getParameter("shopTel2"));
		dto.setShopStart(mreq.getParameter("shopStart"));
		dto.setShopEnd(mreq.getParameter("shopEnd"));
		dto.setShopPrice(Integer.parseInt(mreq.getParameter("shopPrice")));
		dto.setShopTime(Integer.parseInt(mreq.getParameter("shopTime")));
		dto.setLatitude(mreq.getParameter("latitude"));
		dto.setLongitude(mreq.getParameter("longitude"));
		dto.setCategoryname(mreq.getParameter("categoryName"));

		if (mreq.getFile("upload") != null) {
			String saveFilename = mreq.getFilesystemName("upload");

			dto.setSaveFilename(saveFilename);
		}

		dao.insertShop(dto);
		resp.sendRedirect(cp + "/shop/shopmenu.do");

	}

	private void shopmenu(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MyUtil util = new MyUtil();
		ShopDAO dao = new ShopDAO();

		String page = req.getParameter("page");

		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}
		String state = req.getParameter("state");
		if (state != null && req.getMethod().equalsIgnoreCase("get")) {
			state = URLDecoder.decode(state, "utf-8");
		}

		if (state == null || state.length() == 0)
			state = "한식";

		int dataCount = dao.dataCount(state);
		int numPerPage = 10;
		int totalPage = util.pageCount(numPerPage, dataCount);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int rows = 10;
		int start = (currentPage - 1) * rows + 1;
		int end = currentPage * rows;

		List<ShopDTO> list = new ArrayList<>();

		list = dao.listShop(start, end, state);

		int listNum, n = 0;
		Iterator<ShopDTO> it = list.iterator();
		while (it.hasNext()) {
			ShopDTO dto = it.next();
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}
		String cp = req.getContextPath();
		String listUrl = cp + "/shop/shopmenu.do";
		String articleUrl = cp + "/menu/article.do?page=" + currentPage;
		String query = "state=" + URLEncoder.encode(state, "utf-8");

		if (query.length() != 0) {
			listUrl += "?" + query;
			articleUrl += "&" + query;
		}

		String paging = util.paging(currentPage, totalPage, listUrl);

		req.setAttribute("page", currentPage);
		req.setAttribute("query", query);
		req.setAttribute("state", state);
		req.setAttribute("articleUrl", articleUrl);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("list", list);
		req.setAttribute("paging", paging);

		forward(req, resp, "/WEB-INF/views/shop/shopmenu.jsp");
	}

	private void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ShopDAO dao = new ShopDAO();
		String cp = req.getContextPath();
		
		
		
		int shopNum = Integer.parseInt(req.getParameter("shopNum"));
		String page = req.getParameter("page");

		ShopDTO dto = dao.readShop(shopNum);
		String state = req.getParameter("state");
		if (dto == null) {
			resp.sendRedirect(cp + "/shop/shopmenu.do?shopNum=" + shopNum + "&state=" + state + "&page=" + page);
			return;
		}

		req.setAttribute("mode", "update");
		req.setAttribute("dto", dto);
		req.setAttribute("page", page);
		req.setAttribute("state", state);
		req.setAttribute("shopNum", shopNum);

		forward(req, resp, "/WEB-INF/views/shop/created.jsp");
	}

	private void updateSubmit(HttpServletRequest req, HttpServletResponse resp, String pathname)
			throws ServletException, IOException {
		ShopDAO dao = new ShopDAO();
		ShopDTO dto = new ShopDTO();

		String encType = "utf-8";
		int maxFilesize = 20 * 1024 * 1024;
		MultipartRequest mreq = null;
		mreq = new MultipartRequest(req, pathname, maxFilesize, encType, new DefaultFileRenamePolicy());

		dto.setShopNum(Integer.parseInt(mreq.getParameter("shopNum")));
		dto.setCategoryname(mreq.getParameter("categoryName"));
		dto.setShopName(mreq.getParameter("shopName"));
		dto.setContent(mreq.getParameter("content"));
		dto.setSaveFilename(mreq.getParameter("saveFilename"));
		dto.setShopZip1(mreq.getParameter("shopZip1"));
		dto.setShopAddr1(mreq.getParameter("shopAddr1"));
		dto.setShopAddr2(mreq.getParameter("shopAddr2"));
		dto.setShopTel1(mreq.getParameter("shopTel1"));
		dto.setShopTel2(mreq.getParameter("shopTel2"));
		dto.setShopPrice(Integer.parseInt(mreq.getParameter("shopPrice")));
		dto.setShopTime(Integer.parseInt(mreq.getParameter("shopTime")));
		dto.setShopStart(mreq.getParameter("shopStart"));
		dto.setShopEnd(mreq.getParameter("shopEnd"));
		dto.setLatitude(mreq.getParameter("latitude"));
		dto.setLongitude(mreq.getParameter("longitude"));

		if (mreq.getFile("upload") != null) {
			if (dto.getSaveFilename().length() != 0) {
				// 기존 파일 지우기
				FileManager.doFiledelete(pathname, dto.getSaveFilename());
			}
			dto.setSaveFilename(mreq.getFilesystemName("upload"));

		}

		dao.updateShop(dto);

		String cp = req.getContextPath();

		resp.sendRedirect(cp + "/shop/shopmenu.do");
	}

	private void deleteList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String[] shopNum = req.getParameterValues("checkbox");
		
		ShopDAO dao = new ShopDAO();
		String cp = req.getContextPath();
		dao.deleteShop(shopNum);
		resp.sendRedirect(cp + "/shop/shopmenu.do");
	}
}
