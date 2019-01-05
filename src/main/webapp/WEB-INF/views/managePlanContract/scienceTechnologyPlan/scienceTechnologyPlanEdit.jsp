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
				<li>
					计划管理
				</li>
				<li class="active">技术质量类计划</li>
				<li class="active">年度科技计划</li>
				<li class="active">修改</li>
			</ul>
		</div>
		<div class="page-content" style="margin-left:30px;margin-right:30px;">
		<div style="float:right;margin-right:50px;">
			<button id="btnBack"class="btn btn-xs btn-primary  pull-right"data-dismiss="modal" style="    margin-top: 14px;">
       			<i class="fa fa-reply"></i>
       			返回
       		</button>
		</div>
	<h5 class='table-title-withoutbtn header smaller blue' style='margin-bottom:0px;' >基础信息</h5>
		<div class="col-md-12" style="margin-top: 30px">
			<form class="form-horizontal" role="form"  style="margin-right:13%;" id="editForm">
			<input id="id" name="id" type="hidden" value="${entity.id}">
		       <div class="form-group">
				    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>上传人
				    </label>
				    <div class="col-md-4">
<!-- 						<input class="col-md-12" id="userId" name="userId" type="text" placeholder="" maxlength="20" value=""> -->
						<select id="userIdDiv" class="col-md-12 chosen-select" name="userId" data-placeholder="请选择上传人"></select>	
                    </div>
                    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>单位名称
					</label>
					<div class="col-md-4">
					<div id="unitIdDiv"></div>
                	</div>
               </div>
		       <div class="form-group">
				    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>计划名称
				    </label>
				    <div class="col-md-4">
						<input class="col-md-12" id="planName" name="planName" type="text" placeholder="" maxlength="20" value="${entity.planName }">
                    </div>
                    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>计划分类
				    </label>
				    <div class="col-md-4">
<!-- 						<input class="col-md-12" id="planType" name="PlanType" type="text" placeholder="" maxlength="20" value=""> -->
						<select id="planTypeDiv" class="col-md-12 chosen-select" name="planType" data-placeholder="请选择计划分类"></select>	
                    </div>
               </div>
		       <div class="form-group">
					<label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>内容描述
					</label>
					<div class="col-md-4">
	                   <input class="col-md-12" id="description" name="description" type="text" placeholder="" maxlength="128" value="${entity.description }">
                	</div>
				    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>计划完成时间
				    </label>
				    <div class="col-md-4">
						<input class="col-md-12" id="PlanCompleteTime" name="planCompleteTime" type="text" placeholder="" maxlength="20" value="${entity.planCompleteTime }">
                    </div>
               </div>
		       <div class="form-group">
					<label class="col-md-2 control-label no-padding-right">
						备注
					</label>
					<div class="col-md-10">
<!-- 	                   <input class="col-md-12" id="remark" name="remark" type="text" placeholder="" maxlength="200" value=""> -->
	                   <textarea placeholder="请输入备注" name="remarks" class="col-md-12" style="height:90px; resize:none;">${entity.description }</textarea>
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
    		<div style="margin-right:100px;">
    			<button id="editBtn" class="btn btn-xs btn-success pull-right"  style="margin-right:15px;">
    				<i class="ace-icon fa fa-floppy-o"></i>
    				保存
    			</button>
    		</div>
		</div>
		</div>
		<script type="text/javascript">
			jQuery(function($) {
				seajs.use(['combobox','combotree','my97datepicker','uploaddropzone'], function(A){
					//附件上传
					var uploaddropzone =new A.uploaddropzone({
						render : "#divfile",
						fileId:${entity.fileId},
						autoProcessQueue:true,//是否自动上传
						addRemoveLinks : true,//显示删除按钮
					}).render();
					//部门控件下拉树
					var unitId = new A.combotree({
					render: "#unitIdDiv",
					name: 'unitId',
					//返回数据待后台返回TODO
					datasource: ${unitNameIdTreeList},
					width:"210px",
					options: {
						treeId: 'searchunitId',
						data: {
							key: {
								name: "name"
							},
							simpleData: {
								enable: true,
								idKey: "id",
								pIdKey: "parentId"
							}
						},
					}
				}).render();
					unitId.setValue(${entity.unitId});
					//combobox组件
					var userIdCombobox = new A.combobox({
							render: "#userIdDiv",
							datasource:${searchuser},
							options:{
								"disable_search_threshold":10
							}
						}).render();
					userIdCombobox.setValue(${entity.userId});
					//计划分类
					var planTypeCombobox = new A.combobox({
							render: "#planTypeDiv",
							datasource:${planTypeCombobox},
							options:{
								"disable_search_threshold":10
							}
						}).render();
					planTypeCombobox.setValue(${entity.planType});

        			var appData = ${entityJson};
					var id = $('#id').val();
					$('#editForm').validate({
						debug:true,
						rules: {
							userId:{required:true,maxlength:20},
							unitId:{required:true,maxlength:20},
							planName:{required:true,maxlength:20},
							description:{required:true,maxlength:128},
							planType:{required:true,maxlength:20},
							planCompleteTime:{required:true,maxlength:20},
							},
						submitHandler: function (form) {
							//添加按钮
							var url = format_url("/scienceTechnologyPlan/update/"+id);
							//serializeObject()用于Jquery将form转换成用于ajax参数的Javascript Object
							var obj = $("#editForm").serializeObject();
							//附件上传
							obj.fileId=JSON.stringify(uploaddropzone.getValue());
							$.ajax({
								url : url,
								contentType : 'application/json',
								dataType : 'JSON',
								data : JSON.stringify(obj),
								cache: false,
								type : 'POST',
								success: function(result){
									alert('操作成功');
									A.loadPage({
										render : '#page-container',
										url : format_url("/scienceTechnologyPlan/list")
									});
								},
								error:function(v,n){
									alert('操作失败');
								}
							});
						}
					});
					$("#editBtn").on("click", function(){
    					$("#editForm").submit();
    				});
					$("#btnBack").on("click", function(){
						A.loadPage({
							render : '#page-container',
							url : format_url("/scienceTechnologyPlan/list")
						});
    				});
				});
			});
        </script>
    </body>
</html>