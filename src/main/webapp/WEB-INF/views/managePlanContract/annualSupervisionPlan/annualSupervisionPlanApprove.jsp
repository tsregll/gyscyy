<%@ page language="java" contentType="text/html; charset=utf-8"  
    pageEncoding="utf-8"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html lang="zh">
    <head>
		<meta charset="UTF-8">
		<%@ include file="/WEB-INF/views/common/meta.jsp" %>
		<style>
			.page-content .tabbable{height:960px}
			.page-content .tab-content{height:100%}
		</style>
	</head>
	<body>
		<div class="page-content" style="height: 40%">
		<div class="col-md-12"  >
			<form class="form-horizontal" role="form"  style="margin-right:100px;" id="addForm">
		      <input id="id" name="id" type="hidden" value="${entity.id }">
			   <div class="form-group">
				    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>项目名称
				    </label>
				    <div class="col-md-4">
						<input class="col-md-12" id="subject" name="subject" readonly="readonly" type="text" placeholder="" maxlength="20" value="${entity.subject }">
                    </div>
                    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>责任单位
					</label>
					<div class="col-md-4">
						<input class="col-md-12" id="unitId" name="unitId" readonly="readonly" type="text" placeholder="" maxlength="20" value="${sysUnitEntity.name }">
                    </div>
               </div>
		       <div class="form-group">
				    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>目的及方案
				    </label>
				    <div class="col-md-4">
						<input class="col-md-12" id="purposePlan" readonly="readonly" name="purposePlan" type="text" placeholder="" maxlength="20" value="${entity.purposePlan }">
                    </div>
                    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>计划完成时间
					</label>
					<div class="col-md-4">
	                   <input class="col-md-12" id="planDate"  type="text" readonly="readonly" placeholder="" maxlength="20" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${entity.planDate}"  type="both"/>">
<!-- 	                   <div id="planDateDiv"></div> -->
                	</div>
               </div>
		       <div class="form-group">
					 <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>上传人
				    </label>
				    <div class="col-md-4">
						<input class="col-md-12" id="userId" readonly="readonly" name="userId" type="text" placeholder="" maxlength="20" value="${sysUserEntity.name }">
                    </div>
				    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>监督专业
				    </label>
				    <div class="col-md-4">
<!-- 				    <select class="col-md-12 chosen-select" id="supervisionMajor" name="supervisionMajor"></select> -->
						<input class="col-md-12" id="supervisionMajor" readonly="readonly" name="supervisionMajor" type="text" placeholder="" maxlength="20" value="${entity.supervisionMajorName }">
                    </div>
               </div>
		       <div class="form-group">
					<label class="col-md-2 control-label no-padding-right">
						备注
					</label>
					<div class="col-md-10">
	                    <textarea placeholder="请输入备注" name="remark" readonly="readonly" class="col-md-12" style="height:90px; resize:none;">${entity.remark }</textarea>
                	</div>
				   
               </div>
		       <div class="form-group">
               <label class="col-md-2 control-label no-padding-right">
						附件
				    </label>
				    		<div class="col-md-10" id="divfile">
               </div>
               </div>
               </form>
		</div>
		</div>
		   <div style="margin-right:100px;margin-top: 20px;">
					    <c:forEach items="${nodeList}" var="nodeList" varStatus="vs">
					    <c:if test="${nodeList.authFactorCode=='ztjBtn' && type=='dealing'}">
						<button id="ztjBtn" class="btn btn-xs btn-success pull-right"  style="margin-right:15px;margin-top:20px;">
		    				<i class="ace-icon fa fa-floppy-o"></i>
		    				再提交
		    			</button>
		    			</c:if>
		    			<c:if test="${nodeList.authFactorCode=='zfBtn' && type=='dealing' }">
						<button id="zfBtn" class="btn btn-xs btn-danger pull-right"  style="margin-right:15px;margin-top:20px;">
		    				<i class="ace-icon fa fa-floppy-o"></i>
		    				作废
		    			</button>
		    			</c:if>
		    			
	    				<c:if test="${nodeList.authFactorCode=='technicalBtn' && type=='dealing'}">
						<button id="technicalBtn" class="btn btn-xs btn-success pull-right"  style="margin-right:15px;margin-top:20px;">
		    				<i class="ace-icon fa fa-floppy-o"></i>
		    				生产技术处审核
		    			</button>
		    			</c:if>
	    				<c:if test="${nodeList.authFactorCode=='planBtn' && type=='dealing'}">
		    			<button id="planBtn" class="btn btn-xs btn-success pull-right"  style="margin-right:15px;margin-top:20px;">
		    				<i class="ace-icon fa fa-floppy-o"></i>
		    				计划经营处审核
		    			</button>
		    			</c:if>
	    				<c:if test="${nodeList.authFactorCode=='manageBtn' && type=='dealing'}">
						<button id="manageBtn" class="btn btn-xs btn-success pull-right"  style="margin-right:15px;margin-top:20px;">
		    				<i class="ace-icon fa fa-floppy-o"></i>
		    				单位领导讨论
		    			</button>
		    			</c:if>
	    				<c:if test="${nodeList.authFactorCode=='excuteBtn' && type=='dealing'}">
		    			<button id="excuteBtn" class="btn btn-xs btn-success pull-right"  style="margin-right:15px;margin-top:20px;">
		    				<i class="ace-icon fa fa-floppy-o"></i>
		    				计划经营处下文执行
		    			</button>
		    			</c:if>
		    			</c:forEach>
	        	</div>
		<script type="text/javascript">
		 var taskId=$("#taskId").val();
		 var procInstId=$("#procInstId").val();
		 var procDefId=$("#procDefId").val();
		 var id='${entity.id}'; 
		 var scienceTechnologyPlanDatatables;
			jQuery(function($) {
				seajs.use(['combobox','combotree','my97datepicker','uploaddropzone'], function(A){
					//附件上传
					var uploaddropzone =new A.uploaddropzone({
						render : "#divfile",
						fileId:${entity.fileId},
						autoProcessQueue:true,//是否自动上传
						addRemoveLinks : false,//显示删除按钮
						chargeUp:true
					}).render();
					$('#addForm').validate({
						debug:true,
						rules:  {
							},
						submitHandler: function (form) {
							//添加按钮
							var url = format_url("/annualSupervisionPlan");
							//serializeObject()用于Jquery将form转换成用于ajax参数的Javascript Object
							var obj = $("#addForm").serializeObject();
							$.ajax({
								url : url,
								contentType : 'application/json',
								dataType : 'JSON',
								data : JSON.stringify(obj),
								cache: false,
								type : 'POST',
								success: function(result){
									alert('添加成功');
									window.scrollTo(0,0);
									A.loadPage({
										render : '#page-container',
										url : format_url("/annualSupervisionPlan/list")
									});
								},
								error:function(v,n){
									alert('添加失败');
								}
							});
						}
					});
					var id=${entity.id};
					//生产技术处审核
					$('#technicalBtn').on('click',function(){
						workSafeOneDialog = new A.dialog({
    						width: 1000,
    						height: 400,
    						title: "生产技术处审核",
    						url:format_url("/annualSupervisionPlan/getAddSCJSC?id="+id+"&taskId="+taskId ),
    						closed: function(){
    						}	
    					}).render();
					});
					//计划经营处审核
					$('#planBtn').on('click',function(){
						workSafeOneDialog = new A.dialog({
    						width: 1000,
    						height: 400,
    						title: "计划经营处审核",
    						url:format_url("/annualSupervisionPlan/getAddJHJYC?id="+id+"&taskId="+taskId ),
    						closed: function(){
    						}	
    					}).render();
					});
					//单位领导讨论
					$('#manageBtn').on('click',function(){
						workSafeOneDialog = new A.dialog({
    						width: 1000,
    						height: 400,
    						title: "单位领导审核",
    						url:format_url("/annualSupervisionPlan/getAddDWLDTL?id="+id+"&taskId="+taskId ),
    						closed: function(){
    						}	
    					}).render();
					});
					//计划经营处下文执行
					$('#excuteBtn').on('click',function(){
						workSafeOneDialog = new A.dialog({
    						width: 1000,
    						height: 400,
    						title: "计划经营处下文执行",
    						url:format_url("/annualSupervisionPlan/getAddJHJYCXW?id="+id+"&taskId="+taskId ),
    						closed: function(){
    						}	
    					}).render();
					});
					//再提交
					$('#ztjBtn').on('click',function(){
						var id='${entity.id}';
						workSafeOneDialog = new A.dialog({
    						width: 500,
    						height: 450,
    						title: "选择生产技术处人员",
    						url:format_url("/annualSupervisionPlan/sureSubmit?id="+ id),
    						closed: function(){
    						}	
    					}).render();
					});
					//作废
					$('#zfBtn').on('click',function(){
						var obj = $("#addForm").serializeObject();
						obj.id=${entity.id};
						$.ajax({
							url : format_url("/annualSupervisionPlan/disAgreeZf?taskId="+taskId+"&procInstId="+procInstId+"&selectUser="+""),
							contentType : 'application/json',
							dataType : 'JSON',
							data : JSON.stringify(obj),
							cache: false,
							type : 'POST',
							success: function(result){
								if(result.result=="success"){
									alert('作废成功');	
									window.scrollTo(0,0);
									$("#page-container").load(format_url('/todoTask/list/1/10'));
								}else{
									alert(result.result);
								}
							},
							error:function(v,n){
								alert('作废失败');
							}
						});
					});
					$("#btnBack").on('click',function(){
						A.loadPage({
							render : '#page-container',
							url : format_url("/annualSupervisionPlan/list")
						});
					});
				});
			});
			function goBackToSubmitPerson(id,selectUser){//回调函数
				var taskId=$("#taskId").val();
				var procInstId=$("#procInstId").val();
				var url =format_url("/annualSupervisionPlan/againSubmit?workId="+id+"&selectUser="+selectUser+"&taskId="+taskId+"&procInstId="+procInstId);
				$.ajax({
					contentType: "application/json",
					dataType:"JSON",
					url : url,
					success: function(result){
						if(result.result=="success"){
							alert('操作成功');
							window.scrollTo(0,0);
							$("#page-container").load(format_url('/todoTask/list/1/10'));
						}else{
							alert(result.errorMsg);
						}
					},
					error:function(v,n){
						alert('操作失败');
					}
				});
				
			}
        </script>
    </body>
</html>