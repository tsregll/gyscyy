package com.aptech.business.run.workRecord.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aptech.business.component.dictionary.ProcessMarkEnum;
import com.aptech.business.component.dictionary.ProtectResultEnum;
import com.aptech.business.component.dictionary.ProtectStatusEnum;
import com.aptech.business.equip.equipLedger.domain.EquipLedgerEntity;
import com.aptech.business.equip.equipLedger.service.EquipLedgerService;
import com.aptech.business.orgaApp.domain.OrgaAppEntity;
import com.aptech.business.orgaApp.service.OrgaAppService;
import com.aptech.business.run.protect.domain.ProtectEntity;
import com.aptech.business.run.workPlan.domain.WorkPlanEntity;
import com.aptech.business.run.workPlan.service.WorkPlanService;
import com.aptech.business.run.workRecord.domain.WorkRecordEntity;
import com.aptech.business.run.workRecord.service.WorkRecordService;
import com.aptech.common.system.dictionary.util.DictionaryUtil;
import com.aptech.common.system.dictionary.web.SysDictionaryVO;
import com.aptech.common.system.unit.domain.SysUnitEntity;
import com.aptech.common.system.unit.service.SysUnitService;
import com.aptech.common.system.user.domain.SysUserEntity;
import com.aptech.common.system.user.service.SysUserService;
import com.aptech.common.template.listForm.service.ListFormService;
import com.aptech.common.template.listForm.vo.AppListFormVO;
import com.aptech.common.web.ComboboxVO;
import com.aptech.common.web.base.BaseController;
import com.aptech.common.web.base.ResultListObj;
import com.aptech.common.workflow.definition.domain.DefinitionEntity;
import com.aptech.common.workflow.definition.service.DefinitionService;
import com.aptech.common.workflow.modelEditor.domain.BranchMarkEnum;
import com.aptech.common.workflow.modelEditor.domain.CandidateMarkEnum;
import com.aptech.common.workflow.modelEditor.service.NodeConfigService;
import com.aptech.common.workflow.processNodeAuth.domain.ProcessNodeAuthEntity;
import com.aptech.common.workflow.processNodeAuth.service.ProcessNodeAuthService;
import com.aptech.common.workflow.todoTask.domain.ExamMarkEnum;
import com.aptech.common.workflow.todoTask.domain.ExamResultEnum;
import com.aptech.common.workflow.todoTask.domain.TodoTaskEntity;
import com.aptech.common.workflow.todoTask.service.TodoTaskService;
import com.aptech.framework.context.RequestContext;
import com.aptech.framework.orm.DataStatusEnum;
import com.aptech.framework.orm.IBaseEntityOperation;
import com.aptech.framework.orm.OrmUtil;
import com.aptech.framework.orm.Page;
import com.aptech.framework.orm.Sort;
import com.aptech.framework.orm.search.Condition;
import com.aptech.framework.orm.search.FieldTypeEnum;
import com.aptech.framework.orm.search.MatchTypeEnum;
import com.aptech.framework.util.JsonUtil;
import com.aptech.framework.web.base.PageUtil;
import com.aptech.framework.web.base.ResultObj;

/**
 * 
 * 定期工作记录配置控制器
 *
 * @author 
 * @created 2017-06-01 15:08:52
 * @lastModified 
 * @history
 *
 */
@Controller
@RequestMapping("/workRecord")
public class WorkRecordController extends BaseController<WorkRecordEntity> {
	
	@Autowired
	private WorkRecordService workRecordService;
	@Autowired
    private ListFormService listFormService;
	@Autowired
    private SysUnitService sysUnitService;
	@Autowired
    private SysUserService sysUserService;
	@Autowired
    private WorkPlanService workPlanService;
	@Autowired
    private OrgaAppService orgaAppService;
	@Autowired
    private DefinitionService definitionService;
	@Autowired
    private NodeConfigService nodeConfigService;
	@Autowired
    private TodoTaskService todoTaskService;
    @Autowired
    private ProcessNodeAuthService processNodeAuthService;
    @Autowired
    private EquipLedgerService equipLedgerService;
	@Override
	public IBaseEntityOperation<WorkRecordEntity> getService() {
		return workRecordService;
	}
	
	/**
	 *	list页面跳转
	 * @Title: 
	 * @Description:
	 * @param 
	 * @return
	 */
	@RequestMapping("/index")
	public ModelAndView list(HttpServletRequest request, Map<String, Object> params) {
		Map<String, Object> model = new HashMap<String, Object>();
        List<SysUnitEntity> treeNodeList = sysUnitService.getUnitTreeNodeList();
		//TODO下拉树具体内容根据具体业务定制
		model.put("workRecordTreeList", JsonUtil.toJson(treeNodeList));
		ComboboxVO comboWorkRecordVO = new ComboboxVO();
		//TODO下拉框具体内容根据具体业务定制
		List<Condition> conditions = new ArrayList<Condition>();
		SysUserEntity userEntity= RequestContext.get().getUser();
		conditions.add(new Condition("a.C_STATUS", FieldTypeEnum.STRING, MatchTypeEnum.EQ, String.valueOf(DataStatusEnum.NORMAL.ordinal())));
		conditions.add(new Condition("a.C_UNIT_ID", FieldTypeEnum.LONG, MatchTypeEnum.EQ,userEntity.getUnitId()));
		List<SysUserEntity> allUsers = sysUserService.findByCondition(
				conditions, null);
        for(SysUserEntity sysUserEntity : allUsers){
            comboWorkRecordVO.addOption(sysUserEntity.getId().toString(), sysUserEntity.getName());
        }
		model.put("workRecordCombobox", JsonUtil.toJson(comboWorkRecordVO.getOptions()));
		return this.createModelAndView("run/workRecord/workRecordList", model);
	}
	
	/**
	 * list数据查询
	 * 
	 * @Title: 
	 * @Description:
	 * @param 
	 * @return
	 */
	@RequestMapping(value = "/seach/{appId}", method = RequestMethod.POST)
	public @ResponseBody ResultListObj commonList(HttpServletRequest request,
			@RequestBody Map<String, Object> params ,@PathVariable Long appId) {
		AppListFormVO appListFormVO = listFormService.getAppListFormVOById(appId);
		Page<Map<String, Object>> page = PageUtil.getPage(params);
		List<Condition> conditions = new ArrayList<Condition>();
		if (params.get("conditions") != null) {
			conditions = OrmUtil.changeMapToCondition(params);
			if(!RequestContext.get().isDeveloperMode()){
				SysUserEntity sysUserEntity = (SysUserEntity)RequestContext.get().getUser();
				for(Condition condition: conditions){
					if(condition.getValue().toString().contains("${")){
						String flag = condition.getValue().toString();
						if(flag.equals("${currentUnitId}")){
							condition.setValue(sysUserEntity.getUnitId());
						}else if(flag.equals("${currentUserId}")){
							condition.setValue(sysUserEntity.getId());
						}else if(flag.equals("${currentRoleId}")){
							condition.setValue(sysUserEntity.getRoleIds());
						}
					}
				}
			}else{
				for(Condition condition: conditions){
					if(condition.getValue().toString().contains("${")){
						String flag = condition.getValue().toString();
						if(flag.equals("${currentUnitId}")){
							condition.setValue(0);
						}else if(flag.equals("${currentUserId}")){
							condition.setValue(0);
						}else if(flag.equals("${currentRoleId}")){
							condition.setValue(0);
						}
					}
				}
			}
		}
		List<Sort> orders = OrmUtil.changeMapToOrders(params);
		if (page != null) {
			page.setOrders(orders);
		}
		List<Map<String, Object>> entities = listFormService.findListByCondition(appListFormVO, conditions, page);
		ResultListObj resultObj = new ResultListObj();
		resultObj.setDraw((Integer) params.get("draw"));
		if (entities != null) {
			resultObj.setData(entities);
			if (page != null) {
				resultObj.setRecordsTotal(page.getTotal());
			} else {
				resultObj.setRecordsTotal((long) entities.size());
			}
		}
		return resultObj;
	}
	
	/**
	 *	跳转到添加页面
	 */
	@RequestMapping("/getAdd")
	public ModelAndView getAddPage(HttpServletRequest request){
		Map<String, Object> model = new HashMap<String, Object>();
	//	List<WorkRecordEntity> treeNodeList = null; 
		//TODO下拉树具体内容根据具体业务定制
        List<SysUnitEntity> treeNodeList = sysUnitService.getUnitTreeNodeList();

		model.put("workRecordTreeList", JsonUtil.toJson(treeNodeList));
		ComboboxVO comboWorkRecordVO = new ComboboxVO();
		//TODO下拉框具体内容根据具体业务定制
		List<Condition> conditions = new ArrayList<Condition>();
		SysUserEntity userEntity= RequestContext.get().getUser();
		conditions.add(new Condition("a.C_STATUS", FieldTypeEnum.STRING, MatchTypeEnum.EQ, String.valueOf(DataStatusEnum.NORMAL.ordinal())));
		conditions.add(new Condition("a.C_UNIT_ID", FieldTypeEnum.LONG, MatchTypeEnum.EQ,userEntity.getUnitId()));
		List<SysUserEntity> allUsers = sysUserService.findByCondition(
				conditions, null);
        for(SysUserEntity sysUserEntity : allUsers){
            comboWorkRecordVO.addOption(sysUserEntity.getId().toString(), sysUserEntity.getName());
        }
		model.put("workRecordCombobox", JsonUtil.toJson(comboWorkRecordVO.getOptions()));
		ComboboxVO comboWorkRecordVO1 = new ComboboxVO();
        //TODO下拉框具体内容根据具体业务定制
        List<WorkPlanEntity> allworkPlanEntity = workPlanService.findAll();
        for(WorkPlanEntity workPlanEntity : allworkPlanEntity){
            comboWorkRecordVO1.addOption(workPlanEntity.getId().toString(), workPlanEntity.getCode());
        }
        model.put("workplanCombobox", JsonUtil.toJson(comboWorkRecordVO1.getOptions()));
        ComboboxVO comboRunLogVO2 = new ComboboxVO();
        List<OrgaAppEntity> allOrgaAppEntity = orgaAppService.findAll();
        for(OrgaAppEntity orgaAppEntity : allOrgaAppEntity){
            comboRunLogVO2.addOption(orgaAppEntity.getId().toString(), orgaAppEntity.getName());
        }
        model.put("orgAppCombobox", JsonUtil.toJson(comboRunLogVO2.getOptions()));
		 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	        String dateStr = format.format(new Date());
	        model.put("giveDate", dateStr);		
	        model.put("userEntity", userEntity);
		return this.createModelAndView("run/workRecord/workRecordAdd", model);
	}
	
	/**
	 *	跳转到修改页面
	 */
	@RequestMapping("/getEdit/{id}")
	public ModelAndView getEditPage(HttpServletRequest request, @PathVariable Long id){
		Map<String, Object> model = new HashMap<String, Object>();
		// 返回前台数据项
		WorkRecordEntity workRecordEntity = (WorkRecordEntity)workRecordService.findById(id);
		EquipLedgerEntity equipLedgerEntity=equipLedgerService.findById(new Long(workRecordEntity.getDeviceId()));
		if(equipLedgerEntity!=null){
		      workRecordEntity.setEquipName(equipLedgerEntity.getName());

		}
		if(!"".equals(workRecordEntity.getPlanId())&&workRecordEntity.getPlanId()!=null){
		    WorkPlanEntity workPlanEntitytemp=workPlanService.findById(new Long(workRecordEntity.getPlanId()));
	        if(workPlanEntitytemp!=null){
	              workRecordEntity.setPlanCode(workPlanEntitytemp.getCode());

	        } 
		}
		
		model.put("dataMap", workRecordEntity);
		model.put("dataMapJson", JsonUtil.toJson(workRecordEntity));
		
        List<SysUnitEntity> treeNodeList = sysUnitService.getUnitTreeNodeList();
		//TODO下拉树具体内容根据具体业务定制
		model.put("workRecordTreeList", JsonUtil.toJson(treeNodeList));
		ComboboxVO comboWorkRecordVO = new ComboboxVO();
		//TODO下拉框具体内容根据具体业务定制
		List<Condition> conditions = new ArrayList<Condition>();
		SysUserEntity userEntity= RequestContext.get().getUser();
		conditions.add(new Condition("a.C_STATUS", FieldTypeEnum.STRING, MatchTypeEnum.EQ, String.valueOf(DataStatusEnum.NORMAL.ordinal())));
		conditions.add(new Condition("a.C_UNIT_ID", FieldTypeEnum.LONG, MatchTypeEnum.EQ,userEntity.getUnitId()));
		List<SysUserEntity> allUsers = sysUserService.findByCondition(
				conditions, null);
        for(SysUserEntity sysUserEntity : allUsers){
            comboWorkRecordVO.addOption(sysUserEntity.getId().toString(), sysUserEntity.getName());
        }
		model.put("workRecordCombobox", JsonUtil.toJson(comboWorkRecordVO.getOptions()));
		ComboboxVO comboWorkRecordVO1 = new ComboboxVO();
        //TODO下拉框具体内容根据具体业务定制
        List<WorkPlanEntity> allworkPlanEntity = workPlanService.findAll();
        for(WorkPlanEntity workPlanEntity : allworkPlanEntity){
            comboWorkRecordVO1.addOption(workPlanEntity.getId().toString(), workPlanEntity.getCode());
        }
        model.put("workplanCombobox", JsonUtil.toJson(comboWorkRecordVO1.getOptions()));
        ComboboxVO comboRunLogVO2 = new ComboboxVO();
        List<OrgaAppEntity> allOrgaAppEntity = orgaAppService.findAll();
        for(OrgaAppEntity orgaAppEntity : allOrgaAppEntity){
            comboRunLogVO2.addOption(orgaAppEntity.getId().toString(), orgaAppEntity.getName());
        }
        model.put("orgAppCombobox", JsonUtil.toJson(comboRunLogVO2.getOptions()));
		
		return this.createModelAndView("run/workRecord/workRecordEdit", model);
	}
	/**
	* @Title: detailList
	* @Description: 工作记录详细列表
	* @author sunliang
	* @date 2017年6月28日下午2:17:03
	* @param request
	* @param params
	* @return
	* @throws
	*/
	@RequestMapping("/detailList/{id}")
    public ModelAndView detailList(HttpServletRequest request, Map<String, Object> params, @PathVariable Long id) {
        Map<String, Object> model = new HashMap<String, Object>();
        List<SysUnitEntity> treeNodeList = sysUnitService.getUnitTreeNodeList();
        //TODO下拉树具体内容根据具体业务定制
        model.put("workRecordTreeList", JsonUtil.toJson(treeNodeList));
        ComboboxVO comboWorkRecordVO = new ComboboxVO();
        //TODO下拉框具体内容根据具体业务定制
        List<SysUserEntity> allUsers = sysUserService.findAll();
        for(SysUserEntity sysUserEntity : allUsers){
            comboWorkRecordVO.addOption(sysUserEntity.getId().toString(), sysUserEntity.getName());
        }
        model.put("workRecordCombobox", JsonUtil.toJson(comboWorkRecordVO.getOptions()));
        model.put("planId", id);
        return this.createModelAndView("run/workRecord/workRecordDetailList", model);
    }
	@RequestMapping(value = "/update/")
    public @ResponseBody
    ResultObj update(@RequestBody WorkRecordEntity t, HttpServletRequest request) throws Exception{
        ResultObj resultObj = new ResultObj();
        workRecordService.updateEntity(t);
        return resultObj;
    }
	/**
	* @Title: confirmDelayStates
	* @Description: 跳转到选择延期状态页
	* @author sunliang
	* @date 2017年6月29日下午4:09:38
	* @param request
	* @param id
	* @return
	* @throws
	*/
	@RequestMapping("/confirmDelayStates/{id}")
    public ModelAndView confirmDelayStates(HttpServletRequest request, @PathVariable Long id){
        Map<String, Object> model = new HashMap<String, Object>();
        //TODO下拉树具体内容根据具体业务定制
        ComboboxVO comboProtectVO = new ComboboxVO();
        //TODO下拉框具体内容根据具体业务定制
        Map<String, SysDictionaryVO> codeDateTypeMap  =  DictionaryUtil.getDictionaries("DELAY_STATES");
        
        for(String key :  codeDateTypeMap.keySet()){
            SysDictionaryVO sysDictionaryVO = codeDateTypeMap.get(key);
            comboProtectVO.addOption(sysDictionaryVO.getCode(), sysDictionaryVO.getName());
        }
        model.put("delayStatesCombobox", JsonUtil.toJson(comboProtectVO.getOptions()));   
        model.put("id", id);
        return this.createModelAndView("run/workRecord/confirmDelayStates", model);
	}
	 /**
	* @Title: sureSubmitPerson
	* @Description: 跳转到人员选择
	* @author sunliang
	* @date 2017年6月29日下午4:09:24
	* @param request
	* @return
	* @throws
	*/
	@RequestMapping("/sureSubmitPerson/{id}")
	    public ModelAndView sureSubmitPerson(HttpServletRequest request, @PathVariable Long id) {
	        String delayStates=request.getParameter("delayStates");
	        Map<String, Object> model = new HashMap<String, Object>();
	        List<Condition> conditions=new ArrayList<Condition>();
	        conditions.add(new Condition("C_DEFINITION_KEY", FieldTypeEnum.STRING, MatchTypeEnum.EQ,ProcessMarkEnum.WORKRECORD_PROCESS_KEY.getName()));
	        List<DefinitionEntity> defList=definitionService.findByCondition(conditions, null);
	        String modelId="";
	        if(!defList.isEmpty()){
	            modelId=defList.get(0).getModelId();
	        }
	        //审批页面点击签发按钮的时候，把下一步的人查询出来
	        SysUserEntity userEntity = RequestContext.get().getUser();
	        List<SysUserEntity> userList=null;
	        if("1".equals(delayStates)){
	             userList= nodeConfigService.getFirstNodeTransactor(modelId,"1",userEntity);
	        }else {
	             userList= nodeConfigService.getFirstNodeTransactor(modelId,"2",userEntity);	            
	        }
	        request.setAttribute("userList", userList);
	        model.put("id", id);
	        model.put("delayStates", delayStates);	        
	        return this.createModelAndView("run/workRecord/sureSubmitPerson", model);
	    }
	/**
     *  提交审批
     */
    @RequestMapping("/toCheck/{wrId}")
    public @ResponseBody ResultObj toCheck(HttpServletRequest request, @PathVariable Long wrId,@RequestBody Map<String, Object> params){
        ResultObj resultObj = new ResultObj();
        workRecordService.tocheck(wrId,params);
        return resultObj;
    }
    @RequestMapping("/submitPerson/{id}")
    public ModelAndView submitPerson(HttpServletRequest request, @PathVariable Long id) {
        String delayStates=request.getParameter("delayStates");
        Map<String, Object> model = new HashMap<String, Object>();
        List<Condition> conditions=new ArrayList<Condition>();
        conditions.add(new Condition("C_DEFINITION_KEY", FieldTypeEnum.STRING, MatchTypeEnum.EQ,ProcessMarkEnum.WORKRECORD_PROCESS_KEY.getName()));
        List<DefinitionEntity> defList=definitionService.findByCondition(conditions, null);
        String modelId="";
        if(!defList.isEmpty()){
            modelId=defList.get(0).getModelId();
        }
        //审批页面点击签发按钮的时候，把下一步的人查询出来
        SysUserEntity userEntity = RequestContext.get().getUser();
        List<SysUserEntity> userList=null;
        if("1".equals(delayStates)){
             userList= nodeConfigService.getFirstNodeTransactor(modelId,"1",userEntity);
        }else {
             userList= nodeConfigService.getFirstNodeTransactor(modelId,"2",userEntity);                
        }
        request.setAttribute("userList", userList);
        model.put("id", id);
        model.put("delayStates", delayStates);          
        return this.createModelAndView("run/workRecord/submitPerson", model);
    }
    /**
    * @Title: againSubmit
    * @Description: 再提交
    * @author sunliang
    * @date 2017年8月16日下午4:48:11
    * @param t
    * @return
    * @throws
    */
    @RequestMapping("/againSubmit/{id}")
    public @ResponseBody ResultObj againSubmit(@RequestBody WorkRecordEntity t){
        ResultObj resultObj = new ResultObj();
        try {             
            Map<String, Object> variables=new HashMap<String, Object>();
            variables.put("status", ProtectStatusEnum.ZZCHECK.getCode());
            variables.put(CandidateMarkEnum.NEXT_HANDLERS.getName(),t.getUserList());
            variables.put(BranchMarkEnum.BRANCH_KEY.getName(),ExamResultEnum.AGREE.getId());
            variables.put(ExamMarkEnum.RESULT.getCode(),ExamResultEnum.AGREE.getName());
            variables.put(ExamMarkEnum.COMMENT.getCode(), "");           
            return workRecordService.check(t,variables);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultObj;
    }
    /**
     *  跳转到审批页面
     */
    @RequestMapping("/approve/{id}/{type}")
    public ModelAndView approve(HttpServletRequest request, @PathVariable Long id, @PathVariable String type){
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("type", type);
        // 返回前台数据项
        WorkRecordEntity workRecordEntity = (WorkRecordEntity)workRecordService.findById(id);
        SysUnitEntity sysUnitEntity=sysUnitService.findById((long)workRecordEntity.getUnitId());
        workRecordEntity.setUnitName(sysUnitEntity.getName());
        model.put("dataMap", workRecordEntity);
        model.put("dataMapJson", JsonUtil.toJson(workRecordEntity));
        
        //TODO下拉树具体内容根据具体业务定制
        List<SysUnitEntity> treeNodeList = sysUnitService.getUnitTreeNodeList();

        model.put("workRecordTreeList", JsonUtil.toJson(treeNodeList));
        ComboboxVO comboWorkPlanVO = new ComboboxVO();
        //TODO下拉框具体内容根据具体业务定制
        List<SysUserEntity> allUsers = sysUserService.findAll();
        for(SysUserEntity sysUserEntity : allUsers){
            comboWorkPlanVO.addOption(sysUserEntity.getId().toString(), sysUserEntity.getName());
        }
        model.put("workRecordCombobox", JsonUtil.toJson(comboWorkPlanVO.getOptions()));
        ComboboxVO comboWorkRecordVO1 = new ComboboxVO();
        //TODO下拉框具体内容根据具体业务定制
        List<WorkPlanEntity> allworkPlanEntity = workPlanService.findAll();
        for(WorkPlanEntity workPlanEntity : allworkPlanEntity){
            comboWorkRecordVO1.addOption(workPlanEntity.getId().toString(), workPlanEntity.getCode());
        }
        model.put("workplanCombobox", JsonUtil.toJson(comboWorkRecordVO1.getOptions()));
        ComboboxVO comboRunLogVO2 = new ComboboxVO();
        List<OrgaAppEntity> allOrgaAppEntity = orgaAppService.findAll();
        for(OrgaAppEntity orgaAppEntity : allOrgaAppEntity){
            comboRunLogVO2.addOption(orgaAppEntity.getId().toString(), orgaAppEntity.getName());
        }
        model.put("orgAppCombobox", JsonUtil.toJson(comboRunLogVO2.getOptions()));
        //查询各个人的按钮权限 开始
        SysUserEntity userEntity= RequestContext.get().getUser();
        List<Condition> conditionsLc=new ArrayList<Condition>();
        conditionsLc.add(new Condition("sys_user.C_LOGIN_NAME", FieldTypeEnum.STRING, MatchTypeEnum.EQ, userEntity.getLoginName()));
        conditionsLc.add(new Condition("procInst.BUSINESS_KEY_", FieldTypeEnum.STRING, MatchTypeEnum.EQ, id));
        conditionsLc.add(new Condition("task.end_time_ IS NULL"));
        List<TodoTaskEntity> list =  todoTaskService.findByCondition(conditionsLc, null);
        TodoTaskEntity todoTaskEntity=null;
        if(!list.isEmpty()){
            todoTaskEntity=list.get(0);
            List<ProcessNodeAuthEntity> nodeList=processNodeAuthService.getAuthorityList(todoTaskEntity.getTaskDefKey());
            System.out.println(nodeList.size());
            model.put("nodeList", nodeList);
        }
//查询各个人的按钮权限 结束
        return this.createModelAndView("run/workRecord/workRecordCheck", model);
    }
    /**
    * @Title: submitPersonAgree
    * @Description: 查询审批人
    * @author sunliang
    * @date 2017年6月30日下午2:32:15
    * @param request
    * @param taskId
    * @return
    * @throws
    */
    @RequestMapping("/submitPersonAgree/{taskId}")
    public ModelAndView submitPersonAgree(HttpServletRequest request,@PathVariable String taskId) {
        //审批页面点击签发按钮的时候，把下一步的人查询出来
        Map<String, Object> model = new HashMap<String, Object>();
        List<SysUserEntity> userList=nodeConfigService.getNextNodeTransactor(taskId,ProtectResultEnum.AGREE.getId().toString());
        String delayStates= request.getParameter("delayStates");
        model.put("userList", userList);
        model.put("delayStates", delayStates);
        return this.createModelAndView("run/protect/sureSubmitPerson", model);
    }
    /**
    * @Title: zzPass
    * @Description: 值长审批通过
    * @author sunliang
    * @date 2017年6月30日下午2:33:50
    * @param t
    * @return
    * @throws
    */
    @RequestMapping("/zzPass/{id}")
    public @ResponseBody
    ResultObj zzPass(@RequestBody WorkRecordEntity t) {
        Map<String, Object> params=new HashMap<String, Object>();
        params.put("status", ProtectStatusEnum.YXZGCHECK.getCode());
        params.put(CandidateMarkEnum.NEXT_HANDLERS.getName(),t.getUserList());
        params.put(BranchMarkEnum.BRANCH_KEY.getName(), ProtectResultEnum.AGREE.getId());
        params.put(ExamMarkEnum.COMMENT.getCode(), ProtectResultEnum.AGREE.getName());
        params.put(ExamMarkEnum.RESULT.getCode(), "");
        return workRecordService.check(t,params);
    }
    
    /**
    * @Title: zzNoPass
    * @Description: 值长审批不通过
    * @author sunliang
    * @date 2017年6月30日下午2:49:32
    * @param t
    * @return
    * @throws
    */
    @RequestMapping("/zzNoPass/{id}")
    public @ResponseBody ResultObj zzNoPass(@RequestBody WorkRecordEntity t){
        Map<String, Object> params=new HashMap<String, Object>();
        params.put("status", ProtectStatusEnum.ZZREJECT.getCode());
        SysUserEntity fzrEntity=sysUserService.findById(new Long(t.getDutyPersonId()));
        params.put(CandidateMarkEnum.NEXT_HANDLERS.getName(),fzrEntity.getLoginName());
        params.put(BranchMarkEnum.BRANCH_KEY.getName(), ProtectResultEnum.BACK_END.getId());
        params.put(ExamMarkEnum.COMMENT.getCode(), ProtectResultEnum.BACK_END.getName());
        params.put(ExamMarkEnum.RESULT.getCode(), "");
        return  workRecordService.check(t, params);
    }
    /**
    * @Title: zgNoPass
    * @Description: 专工审批不通过
    * @author sunliang
    * @date 2017年6月30日下午2:51:17
    * @param t
    * @return
    * @throws
    */
    @RequestMapping("/zgNoPass/{id}")
    public @ResponseBody ResultObj zgNoPass(@RequestBody WorkRecordEntity t){
        Map<String, Object> params=new HashMap<String, Object>();
        params.put("status", ProtectStatusEnum.YXZGREJECT.getCode());
        SysUserEntity fzrEntity=sysUserService.findById(new Long(t.getDutyPersonId()));
        params.put(CandidateMarkEnum.NEXT_HANDLERS.getName(),fzrEntity.getLoginName());
        params.put(BranchMarkEnum.BRANCH_KEY.getName(), ProtectResultEnum.BACK_END.getId());
        params.put(ExamMarkEnum.COMMENT.getCode(), ProtectResultEnum.BACK_END.getName());
        params.put(ExamMarkEnum.RESULT.getCode(), "");
        return  workRecordService.check(t, params);
    }

    /**
    * @Title: zgPass
    * @Description: 专工审批通过
    * @author sunliang
    * @date 2017年6月30日下午2:51:39
    * @param t
    * @return
    * @throws
    */
    @RequestMapping("/zgPass/{id}")
    public @ResponseBody ResultObj zgPass(@RequestBody WorkRecordEntity t){
        Map<String, Object> params=new HashMap<String, Object>();
        params.put("status", ProtectStatusEnum.FINISH.getCode());
        params.put(CandidateMarkEnum.NEXT_HANDLERS.getName(),t.getUserList());
        params.put(BranchMarkEnum.BRANCH_KEY.getName(), ProtectResultEnum.AGREE.getId());
        params.put(ExamMarkEnum.COMMENT.getCode(), ProtectResultEnum.AGREE.getName());
        params.put(ExamMarkEnum.RESULT.getCode(), "");
        return  workRecordService.check(t, params);
    }
    /**
    * @Title: zgyqNoPass
    * @Description: 专工审批延期不通过
    * @author sunliang
    * @date 2017年6月30日下午2:51:54
    * @param t
    * @return
    * @throws
    */
    @RequestMapping("/zgyqNoPass/{id}")
    public @ResponseBody ResultObj zgyqNoPass(@RequestBody WorkRecordEntity t){
        Map<String, Object> params=new HashMap<String, Object>();
        params.put("status", ProtectStatusEnum.YQREJECT.getCode());
        SysUserEntity fzrEntity=sysUserService.findById(new Long(t.getDutyPersonId()));
        params.put(CandidateMarkEnum.NEXT_HANDLERS.getName(),fzrEntity.getLoginName());
        params.put(BranchMarkEnum.BRANCH_KEY.getName(), ProtectResultEnum.BACK_END.getId());
        params.put(ExamMarkEnum.COMMENT.getCode(), ProtectResultEnum.BACK_END.getName());
        params.put(ExamMarkEnum.RESULT.getCode(), "");
        return  workRecordService.check(t, params);
    }

    /**
    * @Title: zgyqPass
    * @Description: 专工审批延期通过
    * @author sunliang
    * @date 2017年6月30日下午2:52:11
    * @param t
    * @return
    * @throws
    */
    @RequestMapping("/zgyqPass/{id}")
    public @ResponseBody ResultObj zgyqPass(@RequestBody WorkRecordEntity t){
        Map<String, Object> params=new HashMap<String, Object>();
        params.put("status", ProtectStatusEnum.YQPASS.getCode());
        SysUserEntity fzrEntity=sysUserService.findById(new Long(t.getDutyPersonId()));
        params.put(CandidateMarkEnum.NEXT_HANDLERS.getName(),fzrEntity.getLoginName());
        params.put(BranchMarkEnum.BRANCH_KEY.getName(), ProtectResultEnum.AGREE.getId());
        params.put(ExamMarkEnum.COMMENT.getCode(), ProtectResultEnum.AGREE.getName());
        params.put(ExamMarkEnum.RESULT.getCode(), "");
        return  workRecordService.check(t, params);
    }
    /**
    * @Title: cancel
    * @Description: 流程取消
    * @author sunliang
    * @date 2017年8月15日下午3:02:39
    * @param request
    * @param t
    * @return
    * @throws
    */
    @RequestMapping("/cancel/{id}")
    public @ResponseBody ResultObj cancel(HttpServletRequest request,@RequestBody WorkRecordEntity t){
        ResultObj resultObj = new ResultObj();
        try {
            String selectUser=request.getParameter("selectUser");
            Map<String, Object> taskVariables=new HashMap<String, Object>();
            taskVariables.put("status", ProtectStatusEnum.CANCEL.getCode());            
            taskVariables.put(CandidateMarkEnum.NEXT_HANDLERS.getName(),selectUser);
            taskVariables.put(BranchMarkEnum.BRANCH_KEY.getName(),ExamResultEnum.BACK.getId());
            taskVariables.put(ExamMarkEnum.RESULT.getCode(), "");
            taskVariables.put(ExamMarkEnum.COMMENT.getCode(), ProtectResultEnum.BACK_END.getName());
            workRecordService.check(t,taskVariables);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultObj;
    }
    /**
    * @Title: getDetail
    * @Description: 跳转到详细页
    * @author sunliang
    * @date 2017年7月3日上午9:16:50
    * @param request
    * @param id
    * @return
    * @throws
    */
    @RequestMapping("/getDetail/{id}")
    public ModelAndView getDetail(HttpServletRequest request, @PathVariable Long id){
        Map<String, Object> model = new HashMap<String, Object>();
        // 返回前台数据项
        WorkRecordEntity workRecordEntity = (WorkRecordEntity)workRecordService.findById(id);
        SysUnitEntity sysUnitEntity=sysUnitService.findById((long)workRecordEntity.getUnitId());
        workRecordEntity.setUnitName(sysUnitEntity.getName());
        model.put("dataMap", workRecordEntity);
        model.put("dataMapJson", JsonUtil.toJson(workRecordEntity));
        
        List<SysUnitEntity> treeNodeList = sysUnitService.getUnitTreeNodeList();
        //TODO下拉树具体内容根据具体业务定制
        model.put("workRecordTreeList", JsonUtil.toJson(treeNodeList));
        ComboboxVO comboWorkRecordVO = new ComboboxVO();
        //TODO下拉框具体内容根据具体业务定制
        List<SysUserEntity> allUsers = sysUserService.findAll();
        for(SysUserEntity sysUserEntity : allUsers){
            comboWorkRecordVO.addOption(sysUserEntity.getId().toString(), sysUserEntity.getName());
        }
        model.put("workRecordCombobox", JsonUtil.toJson(comboWorkRecordVO.getOptions()));
        ComboboxVO comboWorkRecordVO1 = new ComboboxVO();
        //TODO下拉框具体内容根据具体业务定制
        List<WorkPlanEntity> allworkPlanEntity = workPlanService.findAll();
        for(WorkPlanEntity workPlanEntity : allworkPlanEntity){
            comboWorkRecordVO1.addOption(workPlanEntity.getId().toString(), workPlanEntity.getCode());
        }
        model.put("workplanCombobox", JsonUtil.toJson(comboWorkRecordVO1.getOptions()));
        ComboboxVO comboRunLogVO2 = new ComboboxVO();
        List<OrgaAppEntity> allOrgaAppEntity = orgaAppService.findAll();
        for(OrgaAppEntity orgaAppEntity : allOrgaAppEntity){
            comboRunLogVO2.addOption(orgaAppEntity.getId().toString(), orgaAppEntity.getName());
        }
        model.put("orgAppCombobox", JsonUtil.toJson(comboRunLogVO2.getOptions()));
        model.put("wrId", id);

        return this.createModelAndView("run/workRecord/workRecordDetail", model);
    }
    /**
    * @Title: batchDelete
    * @Description: 批量删除
    * @author sunliang
    * @date 2017年8月3日下午3:20:26
    * @param ids
    * @return
    * @throws Exception
    * @throws
    */
    @RequestMapping(value = "/batchDelete")
    public @ResponseBody ResultObj batchDelete(@RequestBody List<Integer> ids)throws Exception {
        ResultObj resultObj = new ResultObj();
        for (Integer id : ids) {
            long longId = (long) id;
            WorkRecordEntity t = workRecordService.findById(longId);
            if (t != null) {                
                workRecordService.delete(longId);              
            }
        }
        return resultObj;
    }
}