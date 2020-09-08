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
	
	public List<BookVO> getBookBydynamicSQL(BookVO book);//ͨ����̬SQL��ѯBookVO���� ��book����ֻ�����������ѯ������

    public void updateBookBydynamicSQL(BookVO book);//ͨ����̬SQL�޸�BookVO���� 
    
    public List<BookVO> getBookByChoose(BookVO book);//ͨ��<choose>��ǩѡ��������ѯ
    
    public List<BookVO> getBookByBookIds(@Param("BookIds")List<Integer>BookIds);//ͨ�����ID��ȡ���ͼ�����
    
    public List<BookVO> getBookByName(@Param("name")String name);
   //��������
    public Integer batchAdd(@Param("books")List<BookVO> books);//�������
    public Integer batchDelete(@Param("BookIds")List<Integer>BookIds);//����ɾ��

	public String getBookTypeById(Integer id);//��ȡͼ������

	public List<ChapterVO> getChapterList(@Param("bookId")Integer bookId);

	public ChapterVO getChapter(@Param("bookId")Integer bookId, @Param("chapterNumber")Integer chapterNumber);

	public List<EvaluationVO> evaluationList(@Param("bookId")Integer bookId, @Param("chapterNumber")Integer chapterNumber);//��ȡ�½������б�
    
	public List<RevertVO> getRevertListById(@Param("evaluationId")Integer evaluationId);

	public List<BookVO> getBookByType(@Param("bookType")String bookType);//ͨ��ͼ�����ͻ�ȡͼ���б�

	public int getBookTypeId(@Param("typeName")String typeName);//ͨ����������ȡ����ID

	public int addEvaluation(EvaluationVO evaluation); //����½�����

	public List<BookCaseVO> getBookBox(@Param("userId")Integer userId);//ͨ���û�ID��ȡͼ�����

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
