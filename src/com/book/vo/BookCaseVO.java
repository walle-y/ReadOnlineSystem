package com.book.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties( value={"hibernateLazyInitializer","handler"})
public class BookCaseVO {

	private Integer userId;
	private Integer bookId;
	private Integer chapterNumber;
	
	private BookVO book;

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getBookId() {
		return bookId;
	}

	public void setBookId(Integer bookId) {
		this.bookId = bookId;
	}

	public Integer getChapterNumber() {
		return chapterNumber;
	}

	public void setChapterNumber(Integer chapterNumber) {
		this.chapterNumber = chapterNumber;
	}

	public BookVO getBook() {
		return book;
	}

	public void setBook(BookVO book) {
		this.book = book;
	}

	@Override
	public String toString() {
		return "BookCaseVO [userId=" + userId + ", bookId=" + bookId + ", chapterNumber=" + chapterNumber + ", book="
				+ book + "]";
	}
	
	
}
