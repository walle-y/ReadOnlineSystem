package com.readOnlineSystem.mapper;

import com.author.vo.AuthorVO;
import com.book.vo.BookVO;

public interface AuthorMapper {

	public AuthorVO getAuthorVOById(Integer authorId);
	
	public AuthorVO getAuthorVO(Integer authorId);
}
