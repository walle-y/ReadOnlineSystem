package com.book.vo;
import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.user.vo.UserVO;
@JsonIgnoreProperties( value={"hibernateLazyInitializer","handler"})
public class EvaluationVO{

	private Integer evaluationId;
	private Integer userId;
	private Integer bookId;
	private Integer chapterNumber;	
	private Date evaluationTime;
	private String evaluationContent;
	private Integer likes;
	private String likeList;
	
	private UserVO userVO;
	private List<RevertVO> revertList;
	public Integer getEvaluationId() {
		return evaluationId;
	}
	public void setEvaluationId(Integer evaluationId) {
		this.evaluationId = evaluationId;
	}
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
	public Date getEvaluationTime() {
		return evaluationTime;
	}
	public void setEvaluationTime(Date evaluationTime) {
		this.evaluationTime = evaluationTime;
	}
	public String getEvaluationContent() {
		return evaluationContent;
	}
	public void setEvaluationContent(String evaluationContent) {
		this.evaluationContent = evaluationContent;
	}
	public Integer getLikes() {
		return likes;
	}
	public void setLikes(Integer likes) {
		this.likes = likes;
	}
	public UserVO getUserVO() {
		return userVO;
	}
	public void setUserVO(UserVO userVO) {
		this.userVO = userVO;
	}
	public List<RevertVO> getRevertList() {
		return revertList;
	}
	public void setRevertList(List<RevertVO> revertList) {
		this.revertList = revertList;
	}
	public String getLikeList() {
		return likeList;
	}
	public void setLikeList(String likeList) {
		this.likeList = likeList;
	}
	@Override
	public String toString() {
		return "EvaluationVO [evaluationId=" + evaluationId + ", userId=" + userId + ", bookId=" + bookId
				+ ", chapterNumber=" + chapterNumber + ", evaluationTime=" + evaluationTime + ", evaluationContent="
				+ evaluationContent + ", likes=" + likes + ", userVO=" + userVO + ", revertList=" + revertList + "]";
	}
	
	
	
	
	
}
