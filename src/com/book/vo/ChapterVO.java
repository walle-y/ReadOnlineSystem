package com.book.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties( value={"hibernateLazyInitializer","handler"})
public class ChapterVO {

	private Integer bookId;
	private Integer chapterNumber;
	private String chapterName;
	private String contentUrl;
	private Integer clickConut;//点击数
	private Integer likes;//点赞数
	
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
	public String getChapterName() {
		return chapterName;
	}
	public void setChapterName(String chapterName) {
		this.chapterName = chapterName;
	}
	public String getContentUrl() {
		return contentUrl;
	}
	public void setContentUrl(String contentUrl) {
		this.contentUrl = contentUrl;
	}
	public Integer getClickConut() {
		return clickConut;
	}
	public void setClickConut(Integer clickConut) {
		this.clickConut = clickConut;
	}
	public Integer getLikes() {
		return likes;
	}
	public void setLikes(Integer likes) {
		this.likes = likes;
	}
	
	@Override
	public String toString() {
		return "ChapterVO [ bookId=" + bookId + ", chapterNumber=" + chapterNumber
				+ ", chapterName=" + chapterName + ", contentUrl=" + contentUrl + ", clickConut=" + clickConut
				+ ", likes=" + likes + "]";
	}
	
	
}
