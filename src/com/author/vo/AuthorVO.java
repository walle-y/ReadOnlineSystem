package com.author.vo;

import java.awt.print.Book;
import java.util.List;

import com.book.vo.BookVO;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties( value={"hibernateLazyInitializer","handler"})
public class AuthorVO {

	private Integer authorId;
	private String authorName;
	private String sex;
	private String authorIntroduce;
	private String authorPicture;
	private List<BookVO> bookList;
		
	public List<BookVO> getBookList() {
		return bookList;
	}
	public void setBookList(List<BookVO> bookList) {
		this.bookList = bookList;
	}
	public Integer getAuthorId() {
		return authorId;
	}
	public void setAuthorId(Integer authorId) {
		this.authorId = authorId;
	}
	public String getAuthorName() {
		return authorName;
	}
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getAuthorIntroduce() {
		return authorIntroduce;
	}
	public void setAuthorIntroduce(String authorIntroduce) {
		this.authorIntroduce = authorIntroduce;
	}
	public String getAuthorPicture() {
		return authorPicture;
	}
	public void setAuthorPicture(String authorPicture) {
		this.authorPicture = authorPicture;
	}
	
	@Override
	public String toString() {
		return "AuthorVO [authorId=" + authorId + ", authorName=" + authorName + ", sex=" + sex + ", authorIntroduce="
				+ authorIntroduce + ", authorPicture=" + authorPicture + "]";
	}
	
	
}
