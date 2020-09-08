package com.book.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.user.vo.UserVO;
@JsonIgnoreProperties( value={"hibernateLazyInitializer","handler"})
public class RevertVO {

	private Integer revertId;
	private Integer evaluationId;
	private Integer userId;
	private String revertContent;
	private Date revertTime;
	private Integer likes;
	private String likeList;
	
	private UserVO userVO;

	public Integer getRevertId() {
		return revertId;
	}

	public void setRevertId(Integer revertId) {
		this.revertId = revertId;
	}

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

	public String getRevertContent() {
		return revertContent;
	}

	public void setRevertContent(String revertContent) {
		this.revertContent = revertContent;
	}

	public Date getRevertTime() {
		return revertTime;
	}

	public void setRevertTime(Date revertTime) {
		this.revertTime = revertTime;
	}

	public Integer getLikes() {
		return likes;
	}

	public void setLikes(Integer likes) {
		this.likes = likes;
	}

	public UserVO getUservo() {
		return userVO;
	}

	public void setUservo(UserVO userVO) {
		this.userVO = userVO;
	}
	
	public String getLikeList() {
		return likeList;
	}

	public void setLikeList(String likeList) {
		this.likeList = likeList;
	}

	@Override
	public String toString() {
		return "RevertVO [revertId=" + revertId + ", evaluationId=" + evaluationId + ", userId=" + userId
				+ ", revertContent=" + revertContent + ", revertTime=" + revertTime + ", likes=" + likes + ", uservo="
				+ userVO + "]";
	}
	
	
}
