package com.readOnlineSystem.service;

import java.util.List;

import com.author.vo.AuthorVO;
import com.book.vo.BookCaseVO;
import com.book.vo.BookTypeVO;
import com.book.vo.BookVO;
import com.book.vo.ChapterVO;
import com.book.vo.EvaluationVO;
import com.book.vo.RevertVO;

public interface BookService {

	public List<BookVO> getBookByAuthorId(int authorId);
	
	public List<BookVO> getBookByName(String name);
	
	public BookVO getBookByID(Integer bookId);

	public String getBookTypeById(int id);

	public List<ChapterVO> getChapterList(Integer bookId);

	public ChapterVO getChapter(Integer bookId, Integer chapterNumber);

	public List<EvaluationVO> evaluationList(int bookId, int chapterNumber);

	public List<BookVO> getBookByTypeId(String typeId);

	public String getBookTypeId(String typeId);

	public int addEvaluation(EvaluationVO evaluation);

	public List<BookCaseVO> getBookBox(int userId);

	public int removeBookInBox(int userId, int bookId);

	public int addBookInBox(int userId, int bookId);

	public int addRevert(RevertVO revert);

	public List<BookVO> getBookByNumber(int bodyNumber);

	public EvaluationVO getEvaluationById(int evaluationId);

	public int modEvaluation(EvaluationVO evaluation);

	public RevertVO getRevertById(int revertId);

	public int modRevert(RevertVO revert);

	public List<BookVO> getBookByAuthour(Integer authorId);

	public void modBook(BookVO book);

	public List<BookTypeVO> getBookType();

	public List<AuthorVO> getAuthor();

	
}
