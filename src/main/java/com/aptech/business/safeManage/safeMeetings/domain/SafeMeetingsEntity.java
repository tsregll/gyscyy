package com.aptech.business.safeManage.safeMeetings.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import com.aptech.framework.json.JsonDateDeserializer;
import com.aptech.framework.json.JsonDateSerializer;
import com.aptech.framework.orm.BaseEntity;
import com.aptech.framework.util.DateFormatUtil;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

/**
 * 
 * 安全会议实体类
 *
 * @author 
 * @created 2018-03-29 10:03:15
 * @lastModified 
 * @history
 *
 */
@Alias("SafeMeetingsEntity")
public class SafeMeetingsEntity extends BaseEntity{
		/**
		 * 主键
		 */
    	private Long id;
		/**
		 * 月报名称
		 */
    	private String reportName;
		/**
		 * 时间
		 */
    	private Date time;
		/**
		 * 年号
		 */
    	private String yearNum;
		/**
		 * 附件上传
		 */
    	private String fileAddress;
    	/**
    	 * 导出序号（用于导出excel）
    	 */
    	private int number;
    	/**
    	 * 检查时间字符串格式（用于导出excel）
    	 */
    	private String exportDate;
    	/**
		 * 创建人id
		 */
    	private String createPeopleId;
    	/**
		 * 创建时间
		 */
    	private Date createDate;
    	private String unitId;
    	private String userId;
    	private String unitName;
    	private String userName;
    	
    	
    	
		public String getUnitId() {
			return unitId;
		}
		public void setUnitId(String unitId) {
			this.unitId = unitId;
		}
		public String getUserId() {
			return userId;
		}
		public void setUserId(String userId) {
			this.userId = userId;
		}
		public String getUnitName() {
			return unitName;
		}
		public void setUnitName(String unitName) {
			this.unitName = unitName;
		}
		public String getUserName() {
			return userName;
		}
		public void setUserName(String userName) {
			this.userName = userName;
		}
		public Long getId(){
			return id;
		}
		public void setId(Long id){
			this.id = id;
		}
		public String getReportName(){
			return reportName;
		}
		public void setReportName(String reportName){
			this.reportName = reportName;
		}
		@JsonSerialize(using = JsonDateSerializer.class)
		public Date getTime(){
			return time;
		}
		@JsonDeserialize(using = JsonDateDeserializer.class)
		public void setTime(Date time){
			this.time = time;
		}
		public String getYearNum(){
			return yearNum;
		}
		public void setYearNum(String yearNum){
			this.yearNum = yearNum;
		}
		public String getFileAddress(){
			return fileAddress;
		}
		public void setFileAddress(String fileAddress){
			this.fileAddress = fileAddress;
		}
		public int getNumber() {
			return number;
		}
		public void setNumber(int number) {
			this.number = number;
		}
		public String getExportDate() {
			DateFormatUtil format = DateFormatUtil.getInstance("yyyy-MM-dd");
			if(this.time!=null){
				return this.exportDate = format.format(this.time);
			}else{
				return null;
			}
		}
		public void setExportDate(String exportDate) {
			this.exportDate = exportDate;
		}
		public String getCreatePeopleId() {
			return createPeopleId;
		}
		public void setCreatePeopleId(String createPeopleId) {
			this.createPeopleId = createPeopleId;
		}
		public Date getCreateDate() {
			return createDate;
		}
		public void setCreateDate(Date createDate) {
			this.createDate = createDate;
		}
		
}