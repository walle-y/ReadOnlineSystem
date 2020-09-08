package com.readOnlineSystem.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.author.vo.AuthorVO;
import com.book.vo.BookCaseVO;
import com.book.vo.BookTypeVO;
import com.book.vo.BookVO;
import com.book.vo.ChapterVO;
import com.book.vo.EvaluationVO;
import com.book.vo.RevertVO;
import com.readOnlineSystem.mapper.BookMapper;

@Service
public class BookServiceImpl implements BookService{

	@Autowired
	private BookMapper bookMapper;
	
	@Override
	public List<BookVO> getBookByAuthorId(int authorId) {
		List<BookVO> books = bookMapper.getBookByAuthorId(authorId);
		return books;
	}

	@Override
	public List<BookVO> getBookByName(String bookName) {
		StringBuffer name = new StringBuffer("'%");
		name.append(bookName).append("%'");
		List<BookVO> books = bookMapper.getBookByName(name.toString());
		return books;
	}

	@Override
	public BookVO getBookByID(Integer bookId) {
		BookVO book = bookMapper.getBookVOById(bookId);
		return book;
	}

	@Override
	public String getBookTypeById(int id) {
		return bookMapper.getBookTypeById(id);
	}

	@Override
	public List<ChapterVO> getChapterList(Integer bookId) {
		return bookMapper.getChapterList(bookId);
	}

	@Override
	public ChapterVO getChapter(Integer bookId, Integer chapterNumber) {
		return bookMapper.getChapter(bookId,chapterNumber);
	}

	@Override
	public List<EvaluationVO> evaluationList(int bookId, int chapterNumber) {
		return bookMapper.evaluationList(bookId,chapterNumber);
	}

	@Override
	public List<BookVO> getBookByTypeId(String typeId) {
		StringBuffer type = new StringBuffer("'%");
		type.append(typeId).append("%'");
		return bookMapper.getBookByType(type.toString());
	}

	@Override
	public String getBookTypeId(String typeName) {
		String typeId = Integer.toString(bookMapper.getBookTypeId(typeName));
		return typeId;
	}

	@Override
	public int addEvaluation(EvaluationVO evaluation) {
		return bookMapper.addEvaluation(evaluation);
	}

	@Override
	public List<BookCaseVO> getBookBox(int userId) {
		return bookMapper.getBookBox(userId);
	}

	@Override
	public int removeBookInBox(int userId, int bookId) {
		return bookMapper.removeBookInBox(userId,bookId);
	}

	@Override
	public int addBookInBox(int userId, int bookId) {
		return bookMapper.addBookInBox(userId,bookId);
	}

	@Override
	public int addRevert(RevertVO revert) {
		return bookMapper.addRevert(revert);
	}

	@Override
	public List<BookVO> getBookByNumber(int bodyNumber) {
		return bookMapper.getBookByNumber(bodyNumber);
	}

	@Override
	public EvaluationVO getEvaluationById(int evaluationId) {
		return bookMapper.getEvaluationById(evaluationId);
	}

	@Override
	public int modEvaluation(EvaluationVO evaluation) {
		return bookMapper.modEvaluation(evaluation);
	}

	@Override
	public RevertVO getRevertById(int revertId) {
		return bookMapper.getRevertById(revertId);
	}

	@Override
	public int modRevert(RevertVO revert) {
		return bookMapper.modRevert(revert);
	}

	@Override
	public List<BookVO> getBookByAuthour(Integer authorId) {
		return bookMapper.getBookByAuthour(authorId);
	}

	@Override
	public void modBook(BookVO book) {
	   bookMapper.updateBookBydynamicSQL(book);		
	}

	@Override
	public List<BookTypeVO> getBookType() {
		return bookMapper.getBookType();
	}

	@Override
	public List<AuthorVO> getAuthor() {
		return bookMapper.getAuthor();
	}

}
