package com.book.vo;

import java.sql.Date;

import com.author.vo.AuthorVO;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties( value={"hibernateLazyInitializer","handler"})
public class BookVO {
 
	private Integer bookId;
	private String bookName;
	private Integer authorId;
	private String introduce;
	private Integer starEvaluation;
	private Integer clickConut;//
	private String typeIdList;//
	private Date uploadTime;//
	private Integer downloadAmount;//
	private Integer likes;//
	private String bookPicture;
	
	private AuthorVO authorVO;//
		
	
	public AuthorVO getAuthorVO() {
		return authorVO;
	}
	public void setAuthorVO(AuthorVO authorVO) {
		this.authorVO = authorVO;
	}
	public Integer getBookId() {
		return bookId;
	}
	public void setBookId(Integer bookId) {
		this.bookId = bookId;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public Integer getAuthorId() {
		return authorId;
	}
	public void setAuthorId(Integer authorId) {
		this.authorId = authorId;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public Integer getStarEvaluation() {
		return starEvaluation;
	}
	public void setStarEvaluation(Integer starEvaluation) {
		this.starEvaluation = starEvaluation;
	}
	public Integer getClickConut() {
		return clickConut;
	}
	public void setClickConut(Integer clickConut) {
		this.clickConut = clickConut;
	}

	public String getTypeIdList() {
		return typeIdList;
	}
	public void setTypeIdList(String typeIdList) {
		this.typeIdList = typeIdList;
	}
	public Date getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}	
	public Integer getDownloadAmount() {
		return downloadAmount;
	}
	public void setDownloadAmount(Integer downloadAmount) {
		this.downloadAmount = downloadAmount;
	}
	public Integer getLikes() {
		return likes;
	}
	public void setLikes(Integer likes) {
		this.likes = likes;
	}
	
	public String getBookPicture() {
		return bookPicture;
	}
	public void setBookPicture(String bookPicture) {
		this.bookPicture = bookPicture;
	}
	@Override
	public String toString() {
		return "BookVO [bookId=" + bookId + ", bookName=" + bookName + ", authorId=" + authorId + ", introduce="
				+ introduce + ", starEvaluation=" + starEvaluation + ", clickConut=" + clickConut + ", typeIdList="
				+ typeIdList + ", uploadTime=" + uploadTime + ", downloadAmount=" + downloadAmount + ", likes=" + likes
				+ ", bookPicture=" + bookPicture + ", authorVO=" + authorVO + "]";
	}
	
	
}
