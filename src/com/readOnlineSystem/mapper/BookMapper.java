package com.readOnlineSystem.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.author.vo.AuthorVO;
import com.book.vo.BookCaseVO;
import com.book.vo.BookTypeVO;
import com.book.vo.BookVO;
import com.book.vo.ChapterVO;
import com.book.vo.EvaluationVO;
import com.book.vo.RevertVO;

public interface BookMapper {

	public BookVO getBookVOById(Integer bookId);
	
	public List<BookVO> getBookByAuthorId(@Param("authorId")Integer authorId);
	
	public List<BookVO> getBookBydynamicSQL(BookVO book);//通过动态SQL查询BookVO对象 ，book对象只是用来保存查询条件的

    public void updateBookBydynamicSQL(BookVO book);//通过动态SQL修改BookVO对象 
    
    public List<BookVO> getBookByChoose(BookVO book);//通过<choose>标签选择条件查询
    
    public List<BookVO> getBookByBookIds(@Param("BookIds")List<Integer>BookIds);//通过多个ID获取多个图书对象
    
    public List<BookVO> getBookByName(@Param("name")String name);
   //批量操作
    public Integer batchAdd(@Param("books")List<BookVO> books);//批量添加
    public Integer batchDelete(@Param("BookIds")List<Integer>BookIds);//批量删除

	public String getBookTypeById(Integer id);//获取图书类型

	public List<ChapterVO> getChapterList(@Param("bookId")Integer bookId);

	public ChapterVO getChapter(@Param("bookId")Integer bookId, @Param("chapterNumber")Integer chapterNumber);

	public List<EvaluationVO> evaluationList(@Param("bookId")Integer bookId, @Param("chapterNumber")Integer chapterNumber);//获取章节评论列表
    
	public List<RevertVO> getRevertListById(@Param("evaluationId")Integer evaluationId);

	public List<BookVO> getBookByType(@Param("bookType")String bookType);//通过图书类型获取图书列表

	public int getBookTypeId(@Param("typeName")String typeName);//通过类型名获取类型ID

	public int addEvaluation(EvaluationVO evaluation); //添加章节评论

	public List<BookCaseVO> getBookBox(@Param("userId")Integer userId);//通过用户ID获取图书书柜

	public int removeBookInBox(@Param("userId")int userId,@Param("bookId") int bookId);

	public int addBookInBox(@Param("userId")int userId,@Param("bookId") int bookId);

	public int addRevert(RevertVO revert);

	public List<BookVO> getBookByNumber(@Param("bodyNumber")int bodyNumber);

	public EvaluationVO getEvaluationById(@Param("evaluationId")int evaluationId);

	public int modEvaluation(EvaluationVO evaluation);

	public RevertVO getRevertById(@Param("revertId")int revertId);

	public int modRevert(RevertVO revert);

	public List<BookVO> getBookByAuthour(@Param("authorId")Integer authorId);

	public List<BookTypeVO> getBookType();

	public List<AuthorVO> getAuthor();
}
