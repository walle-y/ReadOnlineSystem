package com.test;

import static org.junit.Assert.*;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;

import com.author.vo.AuthorVO;
import com.book.vo.BookVO;
import com.readOnlineSystem.mapper.AuthorMapper;
import com.readOnlineSystem.mapper.BookMapper;
import com.readOnlineSystem.mapper.UserMapper;
import com.user.vo.UserVO;

public class TestMybatis {

	/*@Test
	public void testSqlSessionFactory() throws Exception {
		String resource = "mybatis-config.xml";
		InputStream inputStream = Resources.getResourceAsStream(resource);
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);	    
	    
	    SqlSession session = sqlSessionFactory.openSession();
	    try {
	    	 UserVO user = session.selectOne("com.user.dao.UserDao.getUserVOByuserID", 01);
	    	 System.out.println("------> "+user.toString());
	    } finally {
	    	 session.close();
	    }
	}
	
	@Test
	public void test1() throws Exception {
		String resource = "mybatis-config.xml";
		InputStream inputStream = Resources.getResourceAsStream(resource);
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);	    
	    
	    SqlSession session = sqlSessionFactory.openSession();
	    try {
	    	*//**
	    	 * mapper�ӿڿ���
	    	 * �����󶨣�1.Mapper�ӿ���SQLӳ���ļ��İ�  ӳ���ļ���namesapce��ֵ����ָ��Ϊ�ӿڵ�ȫ����
	    	 *           2.Mapper�ӿڵķ�����SQLӳ���ļ��е�SQL��  SQL����idֵ����ָ���ɽӿڵķ�����
	    	 * *//*
	    	UserMapper userMapper = session.getMapper(UserMapper.class);
	    	UserVO userVO = userMapper.getUserVOByuserID(1); 
	    	 System.out.println("------> "+userVO);	    	
	    }finally {
	    	session.close();
		}
	}
	
	public SqlSessionFactory getSqlSessionFactory() throws IOException {
		String resource = "mybatis-config.xml";
		InputStream inputStream = Resources.getResourceAsStream(resource);
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
	    return sqlSessionFactory;
	}

	@Test
	public void testCRUD() throws IOException {
		SqlSessionFactory sqlSessionFactory = getSqlSessionFactory();
		SqlSession session = sqlSessionFactory.openSession();
		//sqlSessionFactory.openSession(true);�Զ��ύ
		try {	    	
	    	UserMapper userMapper = session.getMapper(UserMapper.class);
	    	BookMapper bookMapper = session.getMapper(BookMapper.class);
	    	AuthorMapper authorMapper = session.getMapper(AuthorMapper.class);
	    	UserVO userVO = new UserVO();
	    	userVO.setLoginName("yzr");
	    	userVO.setUserName("yzr");
	    	userVO.setPassword("123");
	    	userVO.setCreateTime(new Timestamp(System.currentTimeMillis()));
	    	userMapper.addUserVO(userVO);
	    	
	    	UserVO newUser = userMapper.getUserVOByuserIdAndUserName(1, "sa");
	    	System.out.println("�޸�ǰ------> "+newUser);
	    	newUser.setPassword("yw0303");
	    	newUser.setRemark("123");
	    	userMapper.updateUserVO(newUser);
	    	UserVO User = userMapper.getUserVOByuserID(3);
	    	System.out.println("�޸ĺ�------> "+User);	  
	    	
	    	userMapper.deleteUserVOById(3);
	    	Map<String,Object> map = new HashMap<String,Object>();
	    	map.put("userid", 1);
	    	map.put("userName", "sa");
	    	UserVO newUser = userMapper.getUserVOByMap(map);
	    	   
	    	Map<Integer,UserVO> userMap = userMapper.getUserListVOByMap();
	        BookVO book = new BookVO();	        
	        book.setClickConut(2);
	    	List<BookVO> list = bookMapper.getBookBydynamicSQL(book);
	    	BookVO book = new BookVO();
	    	book.setAuthorId(1);
	    	book.setBookName("ƤƤ³��³����֮���ƻ��");
	    	book.setIntroduce("һȺ�������ǰ�һ���ˮ������һ��ƻ�����ϣ����ڵ����ϵ�ˮ���������ˮ�ɷݲ�ͬ����������ƻ����ֻ�������ƻ�����������ƻ��ȴ�����������������������˾ͻ�ӵ���������������Գ�Ϊ���泬�ˡ�");
	    	book.setTypeIdList("2#6");
	    	book.setUploadTime(new Timestamp(System.currentTimeMillis()));
	    	List<BookVO> books = new ArrayList<BookVO>();
	    	books.add(book);
	    	
	    	System.out.println("------- "+bookMapper.getBookVOById(1));
	    	session.commit();
	    }finally {
	    	session.close();
		}
	}
	*/
	
	
	
}
