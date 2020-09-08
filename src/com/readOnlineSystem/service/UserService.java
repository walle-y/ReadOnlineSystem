package com.readOnlineSystem.service;

import com.user.vo.UserVO;

public interface UserService {

	public UserVO userLogin(UserVO user);
	
	public int userRegister(UserVO user);

	public UserVO getUserById(Integer userId);

	public int alterUser(UserVO userVo);
}
