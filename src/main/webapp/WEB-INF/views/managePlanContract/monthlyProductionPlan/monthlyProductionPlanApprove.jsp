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
		     <input id="id" name="id" value="${entity.id }" type="hidden">
			  <div class="form-group" style="margin-top: 30px">
				    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>单位名称
				    </label>
				    <div class="col-md-4">
						<input class="col-md-12" id="unitId" name="unitId" type="text" readonly="readonly" placeholder="" maxlength="20" value="${sysUnitEntity.name }">
<!-- 						<div id="unitIdDiv"></div> -->
                    </div>
                    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>上传人
					</label>
					<div class="col-md-4">
	                   <input class="col-md-12" id="userId" name="userId" type="text" readonly="readonly" placeholder="" maxlength="20" value="${sysUserEntity.name }">
<!-- 	                   <select class="col-md-12 chosen-select" id="userId" name="userId"></select> -->
                	</div>
               </div>
		       <div class="form-group">
					<label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>物资名称
					</label>
					<div class="col-md-4">
	                   <input class="col-md-12" id="materialName" name="materialName" readonly="readonly" type="text" placeholder="" maxlength="20" value="${entity.materialName }">
                	</div>
				    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>物资规格
				    </label>
				    <div class="col-md-4">
						<input class="col-md-12" id="materialType" name="materialType" readonly="readonly" type="text" placeholder="" maxlength="20" value="${entity.materialType }">
                    </div>
               </div>
		       <div class="form-group">
					<label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>费用预算(万元)
					</label>
					<div class="col-md-4">
	                   <input class="col-md-12" id="charge" name="charge" readonly="readonly" onkeyup="value=value.replace(/[\D]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[\D]/g,''))" type="text" placeholder="" maxlength="20" value="${entity.charge }">
                	</div>
				    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>型号
				    </label>
				    <div class="col-md-4">
						<input class="col-md-12" id="version" name="version" readonly="readonly" type="text" placeholder="" maxlength="20" value="${entity.version }">
                    </div>
               </div>
		       <div class="form-group">
					<label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>数量
					</label>
					<div class="col-md-4">
	                   <input class="col-md-12" id="count" name="count" readonly="readonly" type="text" placeholder="" maxlength="20" value="${entity.count }">
                	</div>
				    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>功能要求
				    </label>
				    <div class="col-md-4">
						<input class="col-md-12" id="fuctionRequirement" name="fuctionRequirement" readonly="readonly" type="text" placeholder="" maxlength="20" value="${entity.fuctionRequirement }">
                    </div>
               </div>
		       <div class="form-group">
				    <label class="col-md-2 control-label no-padding-right">
						备注
				    </label>
				    <div class="col-md-10">
						<textarea placeholder="请输入备注" name="remark" class="col-md-12" readonly="readonly" style="height:90px; resize:none;">${entity.remark }</textarea>
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
					$('#addForm').validate({
						debug:true,
						rules:  {
							},
						submitHandler: function (form) {
							//添加按钮
							var url = format_url("/monthlyProductionPlan");
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
										url : format_url("/monthlyProductionPlan/list")
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
    						url:format_url("/monthlyProductionPlan/getAddSCJSC?id="+id+"&taskId="+taskId ),
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
    						url:format_url("/monthlyProductionPlan/getAddJHJYC?id="+id+"&taskId="+taskId ),
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
    						url:format_url("/monthlyProductionPlan/getAddDWLDTL?id="+id+"&taskId="+taskId ),
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
    						url:format_url("/monthlyProductionPlan/getAddJHJYCXW?id="+id+"&taskId="+taskId ),
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
    						url:format_url("/monthlyProductionPlan/sureSubmit?id="+ id),
    						closed: function(){
    						}	
    					}).render();
					});
					//作废
					$('#zfBtn').on('click',function(){
						var obj = $("#addForm").serializeObject();
						obj.id=${entity.id};
						$.ajax({
							url : format_url("/monthlyProductionPlan/disAgreeZf?taskId="+taskId+"&procInstId="+procInstId+"&selectUser="+""),
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
							url : format_url("/monthlyProductionPlan/list")
						});
					});
				});
			});
			function goBackToSubmitPerson(id,selectUser){//回调函数
				var taskId=$("#taskId").val();
				var procInstId=$("#procInstId").val();
				var url =format_url("/monthlyProductionPlan/againSubmit?workId="+id+"&selectUser="+selectUser+"&taskId="+taskId+"&procInstId="+procInstId);
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