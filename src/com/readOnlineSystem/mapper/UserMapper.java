package com.readOnlineSystem.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.MapKey;
import org.apache.ibatis.annotations.Param;

import com.user.vo.UserVO;

public interface UserMapper {

	//ͨ��userID��ȡuserVO����	
	public UserVO getUserVOByuserID (Integer userid) ;
	
	//�޸�һ��userVO����
	public int updateUserVO(UserVO user);
	
	//���һ��userVO����
	public int addUserVO(UserVO user);
	
	//ɾ��һ��userVO����
	public void deleteUserVOById(Integer id);
	
	//ͨ��userID���û�������ѯ ��ȡuserVO����	 �������ʱ����@Param("")ע��
	public UserVO getUserVOByuserIdAndUserName (@Param("userid")Integer userid, @Param("userName")String userName);
	
	//ͨ��Map��ȡuserVO����	
	public UserVO getUserVOByMap (Map<String ,Object> map) ;
	
	//��ȡ������¼����
	public List<UserVO> getUserList();
	
	//��ȡ������¼����װ��Map����
	@MapKey("userid") //ָ�����ö����ĳ��������ΪMap��Key
	public Map<Integer , UserVO> getUserListVOByMap();
	
	public UserVO getUserByUser(@Param("user")UserVO uservo) ;

	public int alterUser(@Param("user")UserVO userVo);
	
}
