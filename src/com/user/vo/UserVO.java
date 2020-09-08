package com.user.vo;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties( value={"hibernateLazyInitializer","handler"})
@Alias("UserVO")//给指定类取别名
public class UserVO {

	private Integer userid ; 
	private String userName ;
	private String loginName;
	private String password ; 
	private String userSex ; 
	private String userLevel ; 
	private String remark ;//用户签名
	private Integer uploadNumber ;
	private Timestamp  createTime ;
	private String photo;
		
    public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public UserVO() {
    	
    }
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserSex() {
		return userSex;
	}
	public void setUserSex(String userSex) {
		this.userSex = userSex;
	}
	public String getUserLevel() {
		return userLevel;
	}
	public void setUserLevel(String userLevel) {
		this.userLevel = userLevel;
	}
	public String getRemark() {
		return  remark;
	}
	public void setRemark(String Remark) {
		this. remark = Remark;
	}
	
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	
	public Integer getUploadNumber() {
		return uploadNumber;
	}
	public void setUploadNumber(Integer uploadNumber) {
		this.uploadNumber = uploadNumber;
	}
	@Override
	public String toString() {
		return "UserVO [userid=" + userid + ", userName=" + userName + ", loginName=" + loginName + ", password="
				+ password + ", userSex=" + userSex + ", userLevel=" + userLevel + ", remark=" + remark
				+ ", uploadNumber=" + uploadNumber + ", createTime=" + createTime + ", photo=" + photo + "]";
	}
	
	
}
