package com.readOnlineSystem.handler;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.book.vo.BookVO;
import com.book.vo.ChapterVO;
import com.readOnlineSystem.service.BookService;
import com.readOnlineSystem.service.UserService;
import com.user.vo.UserVO;

@Controller
public class UserHandler {
	@Autowired
	private UserService userService;
	
	@Autowired
	private BookService bookService;
	
	/**
       * ��¼
	 * @throws IOException 
    */
	@RequestMapping(value="/userLogin",method=RequestMethod.GET)
	public String userLogin(HttpServletRequest req,HttpSession session,Map <String,Object> map) throws IOException {	
		ServletContext application = session.getServletContext(); //��ȡapplication
		
		String loginName = req.getParameter("loginName");
		String password = req.getParameter("password");
		String page = req.getParameter("page");
		int bookId = 0;
		int chapterNumber = 0;
		String searchName = "";
		String bookType = "";
						
		UserVO uservo = new UserVO();
		uservo.setLoginName(loginName);
		uservo.setPassword(password);		
		UserVO user = userService.userLogin(uservo); 
		session.setAttribute("user", user);
        map.put("user", user);
		if(user == null) {
			return "redirect:/index.jsp";
		}
		if("readPage".equals(page)) {
			bookId = Integer.parseInt(req.getParameter("bookId"));
			chapterNumber = Integer.parseInt(req.getParameter("chapterNumber"));
			return this.loginByreadPage(bookId, chapterNumber, session, map);
		}else if("list".equals(page)){
			searchName = req.getParameter("searchName");
			bookType = req.getParameter("bookType");
			return this.loginByListPage(searchName, bookType, map);
		}else if("bookDetail".equals(page)) {
			bookId = Integer.parseInt(req.getParameter("bookId"));
			return this.loginByBookDetail(bookId, map);
		}else if("chapter".equals(page)) {
			bookId = Integer.parseInt(req.getParameter("bookId"));
			return this.loginBychapter(bookId, map);
		}
		
		return "redirect:/index.jsp";
	}
	
	/**
     * �޸��û���Ϣ
  */
	@ResponseBody
	@RequestMapping(value="/alterUser",method=RequestMethod.POST)
	public Object alterUser(HttpServletRequest req,HttpSession session,Map <String,Object> map) {	
		Map <String,Object> result = new HashMap<String,Object>();
		int userId =  Integer.parseInt(req.getParameter("userid"));
		UserVO userVo = userService.getUserById(userId);
		String userName = req.getParameter("userName");
		String password = req.getParameter("password");
		String userSex = req.getParameter("userSex");
		String remark = req.getParameter("remark");
		if(userVo != null) {
			userVo.setUserName(userName);
			userVo.setPassword(password);
			userVo.setUserSex(userSex);
			userVo.setRemark(remark);
		}
		int status = 0;
		status = userService.alterUser(userVo);
		if(status == 1) {
			session.removeAttribute("user");
			session.setAttribute("user", userVo);
			result.put("msg","�޸ĳɹ�");
			result.put("user",userVo);
			result.put("user",userVo);
		}else
			result.put("msg","�޸�ʧ��");					
		
		result.put("status",status);		
	   return result;
	}
	
	/**
       * ע��
    */
	@ResponseBody
	@RequestMapping(value="/userRegister",method=RequestMethod.POST)
	public Object userRegister(@ModelAttribute UserVO userVo) {	
		Map <String,Object> result = new HashMap<String,Object>();
		int status = 0;
		userVo.setCreateTime(new Timestamp(System.currentTimeMillis()));
		if("".equals(userVo.getPhoto()) || userVo.getPhoto() == null) {
			userVo.setPhoto("image/2.jpg");
		}
		if("".equals(userVo.getUserName()) || "".equals(userVo.getPassword()) || "".equals(userVo.getLoginName()))
			result.put("msg","ע��ʧ��,��ȷ��ע�������Ƿ�������");
		else {
			  status = userService.userRegister(userVo);
			  if(status == 1) {
					result.put("msg","ע��ɹ�");
			        result.put("user",userVo);
			  }
			  else
					result.put("msg","ע��ʧ��");					
		}
	  return result;
	}
	

	/**
     * ��¼���Ķ�ҳ��
	 * @throws IOException 
  */
	@RequestMapping(value="/loginByreadPage",method=RequestMethod.GET)
	public String loginByreadPage(int bookId,int chapterNumber,HttpSession session,Map <String,Object> map) throws IOException {		
        BookHandler bookhandler = new BookHandler();
			BookVO book = bookService.getBookByID(bookId);
			String bookTypes = book.getTypeIdList();
			bookTypes = this.getTypeByIdlist(bookTypes);
			book.setTypeIdList(bookTypes);
			ChapterVO chapter = bookService.getChapter(bookId,chapterNumber);
			
			List<ChapterVO> chapterList = new ArrayList<ChapterVO>();
			chapterList = bookService.getChapterList(bookId);
			
			String fileUrl = chapter.getContentUrl();
			StringBuffer txt = new StringBuffer();
			ServletContext sc = session.getServletContext();
			String realPath = sc.getRealPath("books");//��Ӧ������books�ļ���
			File file = new File(realPath+fileUrl);
			FileReader fr = new FileReader(file);
			BufferedReader br = new BufferedReader(fr);
			String readLine = null;
			while ((readLine = br.readLine())!=null) {
				txt.append(readLine).append("<br>");
			}
			br.close();
			
			map.put("chapterContent", txt.toString());
			map.put("chapter",chapter);
			map.put("book", book);
			map.put("listSize", chapterList.size());
			return "readPage";
	}
	/**
	 * ��¼listҳ��
	 */
	public String loginByListPage(String bookName,String bookType,Map<String,Object> map) {
		List<BookVO> books = new ArrayList<BookVO>();
        if(!"".equals(bookType.replace(" ", ""))) {		
			String typeId = bookService.getBookTypeId(bookType);
        	List<BookVO> bookList = bookService.getBookByTypeId(typeId);
			BookVO book = new BookVO();
			Iterator<BookVO> it = bookList.iterator();
			while(it.hasNext()) {
				book = it.next();
				if(book != null) {
					String bookTypes = book.getTypeIdList();
					bookTypes = this.getTypeByIdlist(bookTypes);
					book.setTypeIdList(bookTypes);
					books.add(book);
				}	
			}
		}else if(!"".equals(bookName)) {
			
			List<BookVO> bookList = bookService.getBookByName(bookName.replace(" ", ""));
			BookVO book = new BookVO();
			Iterator<BookVO> it = bookList.iterator();
			while(it.hasNext()) {
				book = it.next();
				if(book != null) {
					String bookTypes = book.getTypeIdList();
					bookTypes = this.getTypeByIdlist(bookTypes);
					book.setTypeIdList(bookTypes);
					books.add(book);
				}	
			}
		}
		
		map.put("books",books);
		map.put("searchName",bookName);
		map.put("bookType",bookType);
		return "list";
	}
	
	/**
	 * ��¼��bookDetailҳ��
	 */
	public String loginByBookDetail(Integer bookId,Map<String,Object> map) {		
		BookVO book = bookService.getBookByID(bookId);
		String bookTypes = book.getTypeIdList();
		bookTypes = this.getTypeByIdlist(bookTypes);
		book.setTypeIdList(bookTypes);
		map.put("book",book);
		return "bookDetail";
	}
	
	/**
	 * ��¼��chapterҳ��
	 */
	public String loginBychapter(Integer bookId,Map<String,Object> map) {		
		BookVO book = bookService.getBookByID(bookId);
		String bookTypes = book.getTypeIdList();
		bookTypes = this.getTypeByIdlist(bookTypes);
		book.setTypeIdList(bookTypes);
		List<ChapterVO> chapterList = new ArrayList<ChapterVO>();
		chapterList = bookService.getChapterList(bookId);	
		map.put("chapterList",chapterList);
		map.put("book", book);
		return "chapter";
	}
	
	/**
	 * ���뵽�û�����ҳ��
	 */
	@RequestMapping(value="toUserCenter/{userId}",method=RequestMethod.GET)
	public String toUserCenter(@PathVariable("userId") Integer userId,Map<String,Object> map) {		
		UserVO user = userService.getUserById(userId);
		map.put("user",user);
		return "userCenter";
	}
	
	public String getTypeByIdlist(String bookTypes) {
		StringBuffer types = new StringBuffer();
		String type = "";
		String [] typeList = bookTypes.split("#");
		for(int i = 0; i<typeList.length;i++) {
			type = typeList[i];
			type = bookService.getBookTypeById(Integer.parseInt(type));
			if(i == 0)
			  types.append(type);
			else
			  types.append("#").append(type);
		}
		return types.toString();
	}
	

	/**
	 * ע��logout
	 */
	@RequestMapping(value="/logout",method=RequestMethod.GET)
	public String logout(HttpServletRequest req,HttpSession session,Map <String,Object> map) throws IOException {	
		session.removeAttribute("user");
		return "redirect:/index.jsp";
	}
}
