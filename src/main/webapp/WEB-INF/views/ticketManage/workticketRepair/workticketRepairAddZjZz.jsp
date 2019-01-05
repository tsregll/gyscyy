<%@ page language="java" contentType="text/html; charset=utf-8"  
    pageEncoding="utf-8"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html lang="zh">
    <head>
		<meta charset="UTF-8">
		<%@ include file="/WEB-INF/views/common/meta.jsp" %>
	</head>
	<body>
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
				<ul class="breadcrumb">
					<li>
						<i class="ace-icon fa fa-home home-icon"></i>
						<a href="javascript:void(0);" onclick="firstPage()">首页</a>
					</li>
					<li class="active">业务管理</li>
					<li class="active">待办业务</li>
					<li class="active">待办详细</li>
					<li class="active">终结许可</li>
				</ul>
		</div>
		
		<div class="col-md-12" >
			<div class="page-content">
			<div class="tabbable" style="margin-top: 50px;">
			<div style="float:right; margin-top:-35px;margin-right:55px;">
					<button id="btnBackZjZz" class="btn btn-xs btn-primary">
						<i class="fa fa-reply"></i>
						返回
					</button>
			</div>	
			<form class="form-horizontal" role="form" style="margin-right:100px;" id="addFormZjZz">
			<input type="hidden" id="selectUser" name="selectUser" />
			<input class="col-md-12" id="id" name="id" type="hidden"  maxlength="64" value="${electricId}">
			<input class="col-md-12" id="workPersonId"  type="hidden"  maxlength="64" value="${workPersonId}">
			<h5 class="table-withoutbtn header smaller" style="margin-bottom:0px;">（1）全部工作已结束，设备及安全措施已恢复至开工前状态，工作人员已全部撤离，材料工具已清理完毕。</h5>
							<div class="form-group" style="margin-top: 20px;">
								<label class="col-md-2 control-label no-padding-right">终结时间</label>
								<div class="col-md-4">
											<input class="col-md-12" id="endTime"  type="text" readonly="readonly"  maxlength="128"  value='<fmt:formatDate  pattern="yyyy-MM-dd HH:mm" value="${repairTicketEntity.endTime}" type="date"/>' >
								</div>
							</div>
							<h5 class="table-withoutbtn header smaller" style="margin-bottom:0px;">已汇报值长（值班长）。</h5>
							<div class="form-group" style="margin-top: 20px;">
								<label class="col-md-2 control-label no-padding-right">工作负责人签名</label>
								<div class="col-md-4">
												<input class="col-md-12" id="endPicIdZhu" name="endPicIdZhu" type="hidden"  maxlength="128" value="${repairTicketEntity.endPicId}">
												<input class="col-md-12" id="endPicNameZhu" name="endPicNameZhu" type="text" readonly="readonly" maxlength="128" value="${repairTicketEntity.endPicName}">
								</div>
								<label class="col-md-2 control-label no-padding-right">工作许可人签名</label>
								<div class="col-md-4">
												<input class="col-md-12" id="endAllowIdZhu" name="endAllowIdZhu" type="hidden" placeholder="" maxlength="64" value="${userEntity.id}">
												<input class="col-md-12" id="endAllowNameZhu" name="endAllowNameZhu" type="text" readonly="readonly"  maxlength="64" value="${userEntity.name}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label no-padding-right">值长签名</label>
								<div class="col-md-4">
												<input class="col-md-12" id="endDutyMonitorId" name="endDutyMonitorId" type="hidden" placeholder="" maxlength="64" value="${userEntity.id}">
												<input class="col-md-12" id="endDutyMonitorName" name="endDutyMonitorName" type="text" readonly="readonly"  maxlength="64" value="${userEntity.name}">
								</div>
								<input type="hidden" class="col-md-12" id="endDutyMonitorDate"   name="endDutyMonitorDate" type="text" readonly="readonly"  maxlength="128"  value='<fmt:formatDate  pattern="yyyy-MM-dd HH:mm" value="${repairTicketEntity.endTime}" type="date"/>' >				
							</div>
			
			</form>
			</div>
			</div>
    		<div style="margin-right:100px;">
    			<button id="disagreeZjZz" class="btn btn-xs btn-danger pull-right"  style="margin-right:15px;">
    				<i class="glyphicon glyphicon-remove-circle"></i>
    				驳回
    			</button>
    			<button id="agreeZjZz" class="btn btn-xs btn-success pull-right"  style="margin-right:15px;">
    				<i class="ace-icon fa fa-floppy-o"></i>
    				同意
    			</button>
    		</div>
		</div>
		<script type="text/javascript">
			jQuery(function($) {
				seajs.use(['combobox','combotree','my97datepicker'], function(A){
					var workid='${workIdZjZz}';
					var taskIdZjZz='${taskIdZjZz}';
					var procInstIdZjZz='${procInstIdZjZz}';
					var procDefIdZjZz='${procDefIdZjZz}';
					$('#addFormZjZz').validate({
						debug:true,
						rules:  {
							endDutyMonitorDate:{required:true,maxlength:64}
							},
						submitHandler: function (form) {
							
							//添加按钮
							 url = url;
							//serializeObject()用于Jquery将form转换成用于ajax参数的Javascript Object
							var obj = $("#addFormZjZz").serializeObject();
							$.ajax({
								url : url,
								contentType : 'application/json',
								dataType : 'JSON',
								data : JSON.stringify(obj),
								cache: false,
								type : 'POST',
								success: function(result){
									if(result.result=="success"){
										alert('审批成功');	
										window.scrollTo(0,0);
										$("#page-container").load(format_url('/todoTask/list/1/10'));
									}else{
										alert(result.result);
									}
								},
								error:function(v,n){
									alert('审批失败');
								}
							});
						}
					});
					$("#agreeZjZz").on("click", function(){
						url = format_url("/workticketRepair/agreeZjZz?taskId="+taskIdZjZz+"&procInstId="+procInstIdZjZz);
						$("#addFormZjZz").submit();
    				});
					
					$("#disagreeZjZz").on("click", function(){
						var workPersonId=$("#workPersonId").val();
						url = format_url("/workticketRepair/disagreeZjZz?taskId="+taskIdZjZz+"&procInstId="+procInstIdZjZz+"&workPersonId="+workPersonId);
						workticketDialog = new A.dialog({
							title:"提交确认",
							url:format_url("/repairTicket/sureSubmit"),
							height:450,
							width:500
						}).render();
						
					});
					$('#btnBackZjZz').on('click',function(){
						var formURL="/repairTicket/approve/"+ workid;
						A.loadPage({
							render : '#page-container',
							url : format_url("/todoTask/detail?id=" + taskIdZjZz + "&currentPage="+ 1 
									+ "&pageSize=" + 10+"&procInstId="+procInstIdZjZz+
									"&procDefId="+procDefIdZjZz+"&formURL="+formURL)
						});
					});
				});
			});
				function goBackToSubmitPerson(id,selectUser){//回调函数
					$("#selectUser").val(selectUser);
					$("#addFormZjZz").submit();
				}
        </script>
    </body>
</html>