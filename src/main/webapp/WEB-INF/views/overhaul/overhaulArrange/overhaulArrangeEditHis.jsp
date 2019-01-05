<%@ page language="java" contentType="text/html; charset=utf-8"  
    pageEncoding="utf-8"%>  
<!DOCTYPE html>
<html lang="zh">
    <head>
		<meta charset="UTF-8">
		<%@ include file="/WEB-INF/views/common/meta.jsp" %>
	</head>
	<body>
		<div class="col-md-12" >
			<form class="form-horizontal" role="form"  style="margin-right:100px;" id="overhaulArrangeForm">
			   <input id="overhaulLogId" name="overhaulLogId" type="hidden"/>
		       <div class="form-group">
					<label class="col-md-2 control-label no-padding-right">
						负责人历史
					</label>
					<div class="col-md-4">
						 <input type="text" id="dutyPersonName"  name="dutyPersonName" value="${overhaulArrangeEntity.dutyPersonName}" readonly="readonly" style="width: 200px;"/>
						 <input type="hidden" id="dutyPersonId"  name="dutyPersonId" value="${overhaulArrangeEntity.dutyPersonId}" />
                	</div>
					<label class="col-md-2 control-label no-padding-right">
						完成状态
					</label>
					<div class="col-md-4">
						 <select id="finishStatus"  name="finishStatus"></select>
                	</div>
               </div>
               <div class="form-group">
					<label class="col-md-2 control-label no-padding-right">
					请假人员
					</label>
					<div class="col-md-4">
						  <input type="text" id="askPersonName"  name="askPersonName" value="${overhaulArrangeEntity.askPersonName}" readonly="readonly" style="width: 200px;"/>
						 <input type="hidden" id="askPersonId"  name="askPersonId" value="${overhaulArrangeEntity.askPersonId}" />
                	</div>
               </div>
		       <div class="form-group">
				    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>工作地点
				    </label>
				    <div class="col-md-10">
						 <textarea id="workPlace" class="col-md-12" style="height:100px; resize:none;" name="workPlace" type="text" placeholder="请输入工作地点" maxlength="512" value="">${overhaulArrangeEntity.workPlace}</textarea>
                    </div>
               </div>
		       <div class="form-group">
				    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>工作项目
				    </label>
				    <div class="col-md-10">
						 <textarea id="workProject" class="col-md-12" style="height:100px; resize:none;" name="workProject" type="text" placeholder="请输入工作项目" maxlength="512" value="">${overhaulArrangeEntity.workProject}</textarea>
                    </div>
               </div>
               <div class="form-group">
					<label class="col-md-2 control-label no-padding-right"  style="text-align:right;">
						请假人员及事由
                    </label>
					<div class="col-md-10">
                   		 <textarea id="other" class="col-md-12" style="height:100px; resize:none;" name="other" type="text" placeholder="请输入请假人员及事由" maxlength="128" value=""></textarea>
                    </div>
	           </div>
		       <div class="form-group">
				    <label class="col-md-2 control-label no-padding-right">
						备注
				    </label>
				    <div class="col-md-10">
						 <textarea id="remark" class="col-md-12" style="height:100px; resize:none;" name="remark" type="text" placeholder="请输入备注" maxlength="512" value="">${overhaulArrangeEntity.remark}</textarea>
                    </div>
               </div>
            </form>
    		<div style="margin-right:100px;">
    			<button class="btn btn-xs btn-danger pull-right" data-dismiss="modal">
    				<i class="ace-icon fa fa-times"></i>
    				取消
    			</button>
    			<button id="overhaulArrangeSaveBtn" class="btn btn-xs btn-success pull-right"  style="margin-right:15px;" type="button">
    				<i class="ace-icon fa fa-floppy-o"></i>
    				保存
    			</button>
    		</div>
		</div>
		<script type="text/javascript">
			jQuery(function($) {
				seajs.use(['combobox','combotree','selectbox','my97datepicker'], function(A){
					//检修负责人
// 					dutyUsersId = new A.combobox({
// 						render : "#dutyPersonId",
// 						datasource : ${dutyUsers},
// 						allowBlank: true,
// 						options : {
// 							"disable_search_threshold" : 10
// 						}
// 					}).render();
// 					dutyUsersId.setValue(${overhaulArrangeEntity.dutyPersonId});
					//完成状态
					overhaulArrangeCombobox = new A.combobox({
						render: "#finishStatus",
						datasource:${overhaulArrangeFinishStatus},
						//multiple为true时select可以多选
						//allowBlank为false表示不允许为空
						allowBlank: true,
						options:{
							"disable_search_threshold":10
						}
					}).render();
					overhaulArrangeCombobox.setValue('${overhaulArrangeEntity.finishStatus}');
					$('#overhaulArrangeForm').validate({
						debug:true,
						rules:  {
// 							dutyPersonId:{required:true},	
							finishStatus:{required:true},	
							workPlace:{required:true,maxlength:512},	
							workProject:{required:true,maxlength:512},	
						},
						submitHandler: function (form) {
							if(overhaulLogId){
								$("#overhaulLogId").val(${overhaulArrangeEntity.overhaulLogId});
							}
							//添加按钮
							var id = ${overhaulArrangeEntity.id};
							var status = ${overhaulArrangeEntity.status};
// 							var url = format_url("/overhaulArrange/edit/"+id);
							var url = format_url("/overhaulArrange/editHis/"+id);
							//serializeObject()用于Jquery将form转换成用于ajax参数的Javascript Object
							var obj = $("#overhaulArrangeForm").serializeObject();
							$.ajax({
								url : url,
								contentType : 'application/json',
								dataType : 'JSON',
								data : JSON.stringify(obj),
								cache: false,
								type : 'POST',
								success: function(result){
									alert('修改成功');
									overhaulArrangeDatatables.draw();
									listFormDialog.close();
								},
								error:function(v,n){
									alert('修改失败');
								}
							});
						}
					});
					$("#overhaulArrangeSaveBtn").on("click", function(){
						$("#overhaulArrangeForm").submit();
    				});
				});
			});
        </script>
    </body>
</html>