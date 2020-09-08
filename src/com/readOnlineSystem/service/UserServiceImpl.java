package com.readOnlineSystem.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.readOnlineSystem.mapper.UserMapper;
import com.user.vo.UserVO;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserMapper userMapper;
	
	@Override
	public UserVO userLogin(UserVO uservo) {
		UserVO user = userMapper.getUserByUser(uservo);
		return user;
	}

	@Override
	public int userRegister(UserVO user) {		
		return userMapper.addUserVO(user);
	}

	@Override
	public UserVO getUserById(Integer userId) {
		return userMapper.getUserVOByuserID(userId);
	}

	@Override
	public int alterUser(UserVO userVo) {	
		return userMapper.updateUserVO(userVo);
	}
 
	
}
