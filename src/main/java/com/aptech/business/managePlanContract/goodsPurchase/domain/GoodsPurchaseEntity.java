package com.aptech.business.managePlanContract.goodsPurchase.domain;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.type.Alias;

import com.aptech.business.component.dictionary.GoodsPurchaseStatusEnum;
import com.aptech.business.component.dictionary.YearPurchaseStatusEnum;
import com.aptech.business.component.dictionary.ifEndStatusEnum;
import com.aptech.business.managePlanContract.goodsRelation.domain.GoodsRelationEntity;
import com.aptech.business.overhaul.overhaulWorkTask.domain.OverhaulWorkTaskEntity;
import com.aptech.common.system.dictionary.util.DictionaryUtil;
import com.aptech.common.system.dictionary.web.SysDictionaryVO;
import com.aptech.framework.json.JsonDateTimeDeserializer;
import com.aptech.framework.json.JsonDateTimeSerializer;
import com.aptech.framework.orm.BaseEntity;
import com.aptech.framework.util.DateFormatUtil;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

/**
 * 
 * 物资采购实体类
 *
 * @author 
 * @created 2018-04-17 15:00:02
 * @lastModified 
 * @history
 *
 */
@Alias("GoodsPurchaseEntity")
public class GoodsPurchaseEntity extends BaseEntity{
		/**
		 * 主键
		 */
    	private Long id;
    	/**
    	 * 计划编号
    	 */
    	private String code;
		/**
		 * 名称
		 */
    	private String name;
		/**
		 * 创建人
		 */
    	private String createUserId;
		/**
		 * 创建时间
		 */
    	private Date createDate;
		/**
		 * 设备类别
		 */
    	private String type;
		/**
		 * 物资采购计划类别
		 */
    	private String planType;
		/**
		 * 型号规格
		 */
    	private String specification;
		/**
		 * 数量
		 */
    	private String amount;
		/**
		 * 预计单价
		 */
    	private String budgePrice;
		/**
		 * 预计总价
		 */
    	private String totalPrice;
		/**
		 * 预计采购时间
		 */
    	private Date buyTime;
		/**
		 * 所需项目名称
		 */
    	private String projectName;
		/**
		 * 备注
		 */
    	private String remark;
		/**
		 * 年度采购Id
		 */
    	private Long yearPurchaseId;
    	
    	private String buyTimeString;
    	
    	//计划关联
      	private List<GoodsRelationEntity> goodsList;
      	
      	private String userName;
      	private String status;
      	
	    /**
	     * 审批按钮的标示
	     */
	    private String  spFlag;
	    
	    //（审批意见）
	    private String approveIdea;
	    
	    //计数单位
	    private  String unit;
	    
	    private String dutyUnit;//处室
	    
	    private String dutyName;
	    
	    private String companyUnit;//风场单位
	    
	    private String companyName;
      	
	    private String ifEndStatus;
	    
    	private String taskId;
    	
    	/**
    	 * 选择use
    	 */
    	private String userList;
    	
    	private String procInstId;
	    
    	//单位id
    	private String unitId;
    	
    	
    	
	    public String getUnitId() {
			return unitId;
		}

		public void setUnitId(String unitId) {
			this.unitId = unitId;
		}

		public String getCode() {
			return code;
		}

		public void setCode(String code) {
			this.code = code;
		}

		public String getDutyUnit() {
			return dutyUnit;
		}

		public void setDutyUnit(String dutyUnit) {
			this.dutyUnit = dutyUnit;
		}

		public String getDutyName() {
			return dutyName;
		}

		public void setDutyName(String dutyName) {
			this.dutyName = dutyName;
		}

		public String getCompanyUnit() {
			return companyUnit;
		}

		public void setCompanyUnit(String companyUnit) {
			this.companyUnit = companyUnit;
		}

		public String getCompanyName() {
			return companyName;
		}

		public void setCompanyName(String companyName) {
			this.companyName = companyName;
		}

		public String getUnit() {
			return unit;
		}

		public void setUnit(String unit) {
			this.unit = unit;
		}

		/**
		 * 状态名字
		 */
		public String getStatusName() {
			for (GoodsPurchaseStatusEnum workStatusEnum : GoodsPurchaseStatusEnum.values()) {
				if (workStatusEnum.getCode().equals(this.status.toString())) {
					return workStatusEnum.getName();
				}
			}
			return null;
		}
		
    	public String getSpFlag() {
			return spFlag;
		}

		public void setSpFlag(String spFlag) {
			this.spFlag = spFlag;
		}

		public String getApproveIdea() {
			return approveIdea;
		}

		public void setApproveIdea(String approveIdea) {
			this.approveIdea = approveIdea;
		}

		public String getStatus() {
			return status;
		}

		public void setStatus(String status) {
			this.status = status;
		}

		public String getUserName() {
			return userName;
		}

		public void setUserName(String userName) {
			this.userName = userName;
		}

		public List<GoodsRelationEntity> getGoodsList() {
			return goodsList;
		}

		public void setGoodsList(List<GoodsRelationEntity> goodsList) {
			this.goodsList = goodsList;
		}

		public String getTypeName() {
			Map<String, SysDictionaryVO> typeMap  =  DictionaryUtil.getDictionaries("EQUIPTYPE");
			Map<String,String> typeEnumMap = new HashMap<String, String>();
			for(String key : typeMap.keySet()){
				SysDictionaryVO sysDictionaryVO = typeMap.get(key);
				typeEnumMap.put(sysDictionaryVO.getCode(), sysDictionaryVO.getName());
			}
			return typeEnumMap.get(this.type);
		}
    	
    	public String getPlanTypeName() {
    		Map<String, SysDictionaryVO> typeMap  =  DictionaryUtil.getDictionaries("GOODS_PLAN_TYPE");
    		Map<String,String> typeEnumMap = new HashMap<String, String>();
    		for(String key : typeMap.keySet()){
    			SysDictionaryVO sysDictionaryVO = typeMap.get(key);
    			typeEnumMap.put(sysDictionaryVO.getCode(), sysDictionaryVO.getName());
    		}
    		return typeEnumMap.get(this.planType);
    	}
    	

		public String getBuyTimeString() {
			if (buyTimeString !=null && buyTimeString !="") {
				return buyTimeString;
			}
			DateFormatUtil df= DateFormatUtil.getInstance("yyyy-MM");
			if (this.buyTime==null) {
				return buyTimeString;
			}
			return df.format(this.buyTime);
		}


		public void setBuyTimeString(String buyTimeString) {
			this.buyTimeString = buyTimeString;
		}



		public Long getId(){
			return id;
		}
		public void setId(Long id){
			this.id = id;
		}
		public String getName(){
			return name;
		}
		public void setName(String name){
			this.name = name;
		}
		public String getCreateUserId(){
			return createUserId;
		}
		public void setCreateUserId(String createUserId){
			this.createUserId = createUserId;
		}
	    @JsonSerialize(using = JsonDateTimeSerializer.class)
		public Date getCreateDate(){
			return createDate;
		}
	    @JsonDeserialize(using = JsonDateTimeDeserializer.class)
		public void setCreateDate(Date createDate){
			this.createDate = createDate;
		}
		public String getType(){
			return type;
		}
		public void setType(String type){
			this.type = type;
		}
		public String getPlanType(){
			return planType;
		}
		public void setPlanType(String planType){
			this.planType = planType;
		}
		public String getSpecification(){
			return specification;
		}
		public void setSpecification(String specification){
			this.specification = specification;
		}
		public String getAmount(){
			return amount;
		}
		public void setAmount(String amount){
			this.amount = amount;
		}
		public String getBudgePrice(){
			return budgePrice;
		}
		public void setBudgePrice(String budgePrice){
			this.budgePrice = budgePrice;
		}
		public String getTotalPrice(){
			return totalPrice;
		}
		public void setTotalPrice(String totalPrice){
			this.totalPrice = totalPrice;
		}
	    @JsonSerialize(using = JsonDateTimeSerializer.class)
		public Date getBuyTime(){
			return buyTime;
		}
	    @JsonDeserialize(using = JsonDateTimeDeserializer.class)
		public void setBuyTime(Date buyTime){
			this.buyTime = buyTime;
		}
		public String getProjectName(){
			return projectName;
		}
		public void setProjectName(String projectName){
			this.projectName = projectName;
		}
		public String getRemark(){
			return remark;
		}
		public void setRemark(String remark){
			this.remark = remark;
		}
		public Long getYearPurchaseId(){
			return yearPurchaseId;
		}
		public void setYearPurchaseId(Long yearPurchaseId){
			this.yearPurchaseId = yearPurchaseId;
		}
		
		//转换计数个数
		public String getUnitName(){
			if(!StringUtils.isEmpty(this.unit)){
				Map<String, SysDictionaryVO> unitMap  =  DictionaryUtil.getDictionaries("DIGIT");
				Map<String,String> unitEnumMap = new HashMap<String, String>();
				for(String key : unitMap.keySet()){
					SysDictionaryVO sysDictionaryVO = unitMap.get(key);
					unitEnumMap.put(sysDictionaryVO.getCode(), sysDictionaryVO.getName());
				}
				return unitEnumMap.get(this.unit);
			}
			return null;
		}

		public String getIfEndStatus() {
			return ifEndStatus;
		}

		public void setIfEndStatus(String ifEndStatus) {
			this.ifEndStatus = ifEndStatus;
		}
		/**
		 * 是否关闭名称
		 */
		public String getIfEndStatusName() {
			for (ifEndStatusEnum ifEndStatusEnum : ifEndStatusEnum.values()) {
				if (ifEndStatusEnum.getCode().equals(this.ifEndStatus.toString())) {
					return ifEndStatusEnum.getName();
				}
			}
			return null;
		}

		public String getTaskId() {
			return taskId;
		}

		public void setTaskId(String taskId) {
			this.taskId = taskId;
		}

		public String getUserList() {
			return userList;
		}

		public void setUserList(String userList) {
			this.userList = userList;
		}

		public String getProcInstId() {
			return procInstId;
		}

		public void setProcInstId(String procInstId) {
			this.procInstId = procInstId;
		}
		
}