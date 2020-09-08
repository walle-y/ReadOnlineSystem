package com.readOnlineSystem.handler;

import java.awt.print.Book;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.author.vo.AuthorVO;
import com.book.vo.BookCaseVO;
import com.book.vo.BookTypeVO;
import com.book.vo.BookVO;
import com.book.vo.ChapterVO;
import com.book.vo.EvaluationVO;
import com.book.vo.RevertVO;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonObjectFormatVisitor;
import com.readOnlineSystem.service.BookService;
import com.readOnlineSystem.service.UserService;
import com.user.vo.UserVO;

@Controller
public class BookHandler {
   
	@Autowired
	private BookService bookService;
	@Autowired
	private UserService userService;
	/**
       * 通过作者ID获取图书
    */
	@RequestMapping("/getBookByAuthorId/{authorId}/{authorName}")
	public String getBookByAuthorId(@PathVariable("authorId") int authorId,@PathVariable("authorName") String authorName,Map<String,Object> map) {
		List<BookVO> books = new ArrayList<BookVO>();
		List<BookVO> bookList = bookService.getBookByAuthorId(authorId);
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
		map.put("books",books);
		map.put("authorName",authorName);
		return "list";
	}
	
	/**
     * 通过图书名称获取图书
  */
	@RequestMapping(value=("/bookforName"),method=RequestMethod.GET)
	public String getBookByName(@RequestParam("bookName")String bookName,Map<String,Object> map) {
		String name = bookName.replace(" ", "");
		List<BookVO> books = new ArrayList<BookVO>();
		List<BookVO> bookList = bookService.getBookByName(name);
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
		map.put("books",books);
		map.put("searchName",bookName);
		return "list";
	}
	
	/**
     * 获取图书类型
  */
	@ResponseBody
	@RequestMapping(value=("/getBookType"),method=RequestMethod.POST)
	public Object getBookType(HttpServletRequest request) {
		Map result = new HashMap<String,Object>();		
		List<BookTypeVO> typeList = new ArrayList<BookTypeVO>();
		typeList = bookService.getBookType();
		result.put("typeList",typeList);
		return result; 
	}
	
	/**
     * 获取作者
  */
	@ResponseBody
	@RequestMapping(value=("/getAuthor"),method=RequestMethod.POST)
	public Object getAuthor(HttpServletRequest request) {
		Map result = new HashMap<String,Object>();		
		List<AuthorVO> authorList = new ArrayList<AuthorVO>();
		authorList = bookService.getAuthor();
		result.put("authorList",authorList);
		return result; 
	}
	
	/**
     * 通过图书类型获取图书
  */
	@RequestMapping(value=("/getBookByType/{bookType}"),method=RequestMethod.GET)
	public String getBookByType(@PathVariable("bookType") String bookType,Map<String,Object> map) {
		List<BookVO> books = new ArrayList<BookVO>();
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
		map.put("books",books);
		map.put("bookType",bookType);
		return "list";
	}
	
	/**
     * 通过图书类型获取图书列表（针对首页类型推荐）
  */
	@ResponseBody
	@RequestMapping(value=("/getBookByNumber"),method=RequestMethod.POST)
	public Object getBookByNumber(HttpServletRequest request) {
		Map result = new HashMap<String,Object>();
		int bodyNumber = Integer.parseInt(request.getParameter("bodyNumber"));
		List<BookVO> books = new ArrayList<BookVO>();
		List<BookVO> bookList = bookService.getBookByNumber(bodyNumber);
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
		result.put("books",books);
		return result; 
	}
	
	/**
     * 通过图书获取相似图书（智能推荐功能）
  */
	@ResponseBody
	@RequestMapping(value=("/getLikenessBook"),method=RequestMethod.POST)
	public Object getLikenessBook(HttpServletRequest request) {
		Map result = new HashMap<String,Object>();
		int bookId = Integer.parseInt(request.getParameter("bookId"));
		BookVO book = bookService.getBookByID(bookId);
		List<BookVO> books = new ArrayList<BookVO>();
		List<BookVO> bookList = bookService.getBookByAuthour(book.getAuthorId());
		BookVO book1 = new BookVO();
		Iterator<BookVO> it = null; 
		if(bookList.size() <= 1) {
			int num = 0;
			String [] bookTypes = book.getTypeIdList().split("#");
			for(int i = 0 ; i<bookTypes.length;i++) {
				String typeId = bookTypes[i];
				bookList = bookService.getBookByTypeId(typeId);
				it = bookList.iterator();				
				while(it.hasNext()) {				
					book1 = it.next();
					if(num == 4) {
						break;
					}
					if(book1 != null && book1.getBookId() != book.getBookId()) {
						String types = book1.getTypeIdList();
						types = this.getTypeByIdlist(types);
						book1.setTypeIdList(types);
						books.add(book1);
						num++;
					}	
				}
			}
			
		}else {
			it = bookList.iterator();
			while(it.hasNext()) {
				book1 = it.next();
				if(book1 != null) {
					String types = book1.getTypeIdList();
					types = this.getTypeByIdlist(types);
					book1.setTypeIdList(types);
					books.add(book1);
				}	
			}
			if(bookList.size() < 4) {
				int num = bookList.size();
				String [] bookTypes = book.getTypeIdList().split("#");
				for(int i = 0 ; i<bookTypes.length;i++) {
					String typeId = bookTypes[i];
					bookList = bookService.getBookByTypeId(typeId);
					it = bookList.iterator();				
					while(it.hasNext()) {				
						book1 = it.next();
						if(num == 4) {
							break;
						}
						if(book1 != null && book1.getBookId() != book.getBookId() && book1.getAuthorId() != book.getAuthorId()) {
							String types = book1.getTypeIdList();
							types = this.getTypeByIdlist(types);
							book1.setTypeIdList(types);
							books.add(book1);
							num++;
						}	
					}
				}
				
			
			}
		}		
		result.put("books",books);
		return result; 
	}
	
	/**
     * 通过图书ID获取图书
  */
	@RequestMapping(value=("/getBook/{bookId}"),method=RequestMethod.GET)
	public String getBookById(@PathVariable("bookId") Integer bookId,Map<String,Object> map) {
		BookVO book = bookService.getBookByID(bookId);
		String bookTypes = book.getTypeIdList();
		bookTypes = this.getTypeByIdlist(bookTypes);
		book.setTypeIdList(bookTypes);
		map.put("book",book);
		return "bookDetail";
	}
	
	/**
     * 通过类型ID获取类型名称
  */
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
     * 通过图书ID获取图书章节
  */
	@RequestMapping(value=("/getChapter/{bookId}"),method=RequestMethod.GET)
	public String getChapter(@PathVariable("bookId") Integer bookId,Map<String,Object> map) {
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
     * 通过图书ID和章节数获取章节文本
	 * @throws IOException 
  */
	@RequestMapping(value=("/getchapterContent/{bookId}/{chapterNumber}"),method=RequestMethod.GET)
	public String getchapterContent(@PathVariable("bookId") Integer bookId,@PathVariable("chapterNumber") Integer chapterNumber,Map<String,Object> map,HttpSession session) throws IOException {
		BookVO book = bookService.getBookByID(bookId);
		String bookTypes = book.getTypeIdList();
		bookTypes = this.getTypeByIdlist(bookTypes);
		book.setTypeIdList(bookTypes);
		ChapterVO chapter = bookService.getChapter(bookId,chapterNumber);
		
		List<ChapterVO> chapterList = new ArrayList<ChapterVO>();
		chapterList = bookService.getChapterList(bookId);
		StringBuffer txt = new StringBuffer();
		if(chapter == null) {
			map.put("chapterContent", null);
		}else {
			String fileUrl = chapter.getContentUrl();		
			ServletContext sc = session.getServletContext();
			String realPath = sc.getRealPath("books");//对应创建的books文件夹
			File file = new File(realPath+fileUrl);
			FileReader fr = new FileReader(file);
			BufferedReader br = new BufferedReader(fr);
			String readLine = null;
			while ((readLine = br.readLine())!=null) {
				txt.append(readLine).append("<br>");
			}
			br.close();
			map.put("chapterContent", txt.toString());
		}						
		map.put("chapter",chapter);
		map.put("book", book);
		map.put("listSize", chapterList.size());
		return "readPage";
	}
	
	/**
     * 通过图书ID获取图书章节评论
  */
	@ResponseBody
	@RequestMapping(value=("/getEveluation"),method=RequestMethod.POST)
	public Object getEveluation(HttpServletRequest request) {
		Map result = new HashMap<String,Object>();
		int bookId = Integer.parseInt(request.getParameter("bookId"));
		int chapterNumber = Integer.parseInt(request.getParameter("chapterNumber"));
		List<EvaluationVO> evaluationList = new ArrayList<EvaluationVO>();
		evaluationList = bookService.evaluationList(bookId,chapterNumber);	
		result.put("evaluationList", evaluationList);
		return result; 
	}
	
	/**
     * 增加章节评论
  */
	@ResponseBody
	@RequestMapping(value=("/addEvaluation"),method=RequestMethod.POST)
	public Object addEvaluation(HttpServletRequest request) {
		Map result = new HashMap<String,Object>();
		int bookId = Integer.parseInt(request.getParameter("bookId"));
		int chapterNumber = Integer.parseInt(request.getParameter("chapterNumber"));
		int userId = Integer.parseInt(request.getParameter("userId"));
		String evaluationContent = request.getParameter("evaluationContent");
		EvaluationVO evaluation = new EvaluationVO();
		evaluation.setBookId(bookId);
		evaluation.setChapterNumber(chapterNumber);
		evaluation.setUserId(userId);
		evaluation.setEvaluationContent(evaluationContent);
		evaluation.setLikes(0);
		evaluation.setEvaluationTime(new Date(System.currentTimeMillis()));
		int status = 0;
		status = bookService.addEvaluation(evaluation);
		result.put("status", status);
		return result; 
	}
	
	/**
     * 增加章节回复
  */
	@ResponseBody
	@RequestMapping(value=("/addRevert"),method=RequestMethod.POST)
	public Object addRevert(HttpServletRequest request) {
		Map result = new HashMap<String,Object>();
		int evaluationId = Integer.parseInt(request.getParameter("evaluationId"));
		int userId = Integer.parseInt(request.getParameter("userId"));
		String revertContent = request.getParameter("revertContent");
		RevertVO revert = new RevertVO();
		revert.setUserId(userId);
		revert.setEvaluationId(evaluationId);
		revert.setRevertContent(revertContent);
		revert.setRevertTime(new Date(System.currentTimeMillis()));
		revert.setLikes(0);
		int status = 0;
		status = bookService.addRevert(revert);
		result.put("status", status);
		return result; 
	}
	
	/**
     * 通过用户ID获取书柜
  */
	@ResponseBody
	@RequestMapping(value=("/getBookBox"),method=RequestMethod.POST)
	public Object getBookBox(HttpServletRequest request) {
		Map result = new HashMap<String,Object>();
		List<BookCaseVO> bookList = new ArrayList<BookCaseVO>();		
		int userId = Integer.parseInt(request.getParameter("userId"));		
		bookList = bookService.getBookBox(userId);
		result.put("bookList", bookList);
		result.put("userId", userId);
		return result; 
	}
	
	/**
     * 将图书除移出书柜
  */
	@ResponseBody
	@RequestMapping(value=("/removeBookInBox"),method=RequestMethod.POST)
	public Object removeBookInBox(HttpServletRequest request) {
		Map result = new HashMap<String,Object>();		
		int userId = Integer.parseInt(request.getParameter("userId"));
		int bookId = Integer.parseInt(request.getParameter("bookId"));
        int status = bookService.removeBookInBox(userId,bookId);
        if(status == 1)
           result.put("msg", "图书除移成功！");
        else
        	result.put("msg", "图书除移失败！");
        
		return result; 
	}
	/**
     * 将图书除加入书柜
  */
	@ResponseBody
	@RequestMapping(value=("/addtoBookCase"),method=RequestMethod.POST)
	public Object addtoBookCase(HttpServletRequest request) {
		Map result = new HashMap<String,Object>();		
		int userId = Integer.parseInt(request.getParameter("userId"));
		int bookId = Integer.parseInt(request.getParameter("bookId"));
        int status = bookService.addBookInBox(userId,bookId);
        if(status == 1)
           result.put("msg", "图书收藏成功！");
        else
        	result.put("msg", "图书失败！");       
		return result; 
	}
	
	/**
     * 章节评论点赞
  */
	@ResponseBody
	@RequestMapping(value=("/addEvaluationLikes"),method=RequestMethod.POST)
	public Object addEvaluationLikes(HttpServletRequest request) {
		Map result = new HashMap<String,Object>();
		int evaluationId = Integer.parseInt(request.getParameter("evaluationId"));
		int userId = Integer.parseInt(request.getParameter("userId"));
		EvaluationVO evaluation = bookService.getEvaluationById(evaluationId);
		String likeList = evaluation.getLikeList();
		int likes = evaluation.getLikes();
		int status = 0;
		if(likeList == null || "".equals(likeList)) {	
			evaluation.setLikes(likes+1);
			evaluation.setLikeList(String.valueOf(userId));
			status = bookService.modEvaluation(evaluation);
		}else {
			StringBuffer sb = new StringBuffer("");
			String list[] = likeList.split("#");
			for(int i = 0;i<list.length;i++) {
				String id = list[i];
				if(id.equals(String.valueOf(userId))) {
					status = 2;
				}else if(i != list.length-1) {
					sb.append(id).append("#");
				}else {
					sb.append(id).append("#").append(String.valueOf(userId));
				}				
			}
			if(status == 2)
				evaluation.setLikes(likes-1);
			else
				evaluation.setLikes(likes+1);
			evaluation.setLikeList(sb.toString());
			int sta = bookService.modEvaluation(evaluation);
			if(sta == 1 && status == 2) 
				status = 2;	
			else
				status = 1;
		}
				
		result.put("status", status);
		return result; 
	}
	
	
	/**
     * 章节评论回复点赞
  */
	@ResponseBody
	@RequestMapping(value=("/addRevertLikes"),method=RequestMethod.POST)
	public Object addRevertLikes(HttpServletRequest request) {
		Map result = new HashMap<String,Object>();
		int revertId = Integer.parseInt(request.getParameter("revertId"));
		int userId = Integer.parseInt(request.getParameter("userId"));
		RevertVO revert = bookService.getRevertById(revertId);
		String likeList = revert.getLikeList();
		int likes = revert.getLikes();
		int status = 0;
		if(likeList == null || "".equals(likeList)) {	
			revert.setLikes(likes+1);
			revert.setLikeList(String.valueOf(userId));
			status = bookService.modRevert(revert);
		}else {
			StringBuffer sb = new StringBuffer("");
			String list[] = likeList.split("#");
			for(int i = 0;i<list.length;i++) {
				String id = list[i];
				if(id.equals(String.valueOf(userId))) {
					status = 2;
				}else if(i != list.length-1) {
					sb.append(id).append("#");
				}else {
					sb.append(id).append("#").append(String.valueOf(userId));
				}				
			}
			if(status == 2)
				revert.setLikes(likes-1);
			else
				revert.setLikes(likes+1);
			revert.setLikeList(sb.toString());
			int sta = bookService.modRevert(revert);
			if(sta == 1 && status == 2) 
				status = 2;	
			else
				status = 1;
		}
				
		result.put("status", status);
		return result; 
	}
	
	@RequestMapping(value="/download/{bookId}",method=RequestMethod.GET) //匹配的是href中的download请求
    public ResponseEntity<byte[]> download(HttpServletRequest request,@PathVariable("bookId") Integer bookId,
            Model model,HttpSession session) throws IOException{
        BookVO book = bookService.getBookByID(bookId);
        book.setDownloadAmount(book.getDownloadAmount()+1);
        String filename = book.getBookName()+".txt";  	
    	ServletContext sc = session.getServletContext();
		String downloadFilePath = sc.getRealPath("books");//对应创建的books文件夹
        File file = new File(downloadFilePath+File.separator+filename);//新建一个文件                     
        HttpHeaders headers = new HttpHeaders();//http头信息       
        String downloadFileName = new String(filename.getBytes("UTF-8"),"iso-8859-1");//设置编码       
        headers.setContentDispositionFormData("attachment", downloadFileName);       
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        bookService.modBook(book);
        //MediaType:互联网媒介类型  contentType：具体请求中的媒体类型信息        
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers,HttpStatus.CREATED);
        
    }
}
