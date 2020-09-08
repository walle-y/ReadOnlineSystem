package com.book.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties( value={"hibernateLazyInitializer","handler"})
public class BookTypeVO {
  
	private Integer typeId;
	private String typeName;
	
	public Integer getTypeId() {
		return typeId;
	}
	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	@Override
	public String toString() {
		return "BookTypeVO [typeId=" + typeId + ", typeName=" + typeName + "]";
	}
	
	
	
}
