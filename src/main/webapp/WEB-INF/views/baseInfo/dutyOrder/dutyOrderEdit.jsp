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
			<form class="form-horizontal" role="form"  style="margin-right:100px;" id="editForm">
			     <input class="col-md-12" id="id" name="id" type="hidden" value="${ entity.id }">
			   <div class="form-group">
				    <label class="col-md-2 control-label no-padding-right">
					    名称
				    </label>
				    <div class="col-md-4">
					    <input class="col-md-12" id="name" name="name" type="text" placeholder="" maxlength="64" value="${ entity.name }">
				    </div>	
				    <label class="col-md-2 control-label no-padding-right">
					    编码
				    </label>
				    <div class="col-md-4">
					    <input class="col-md-12" id="code" name="code" type="text" placeholder="" maxlength="64" value="${ entity.code }">
					</div>
				</div>
			   <div class="form-group">
				    <label class="col-md-2 control-label no-padding-right">
					    组织机构
				    </label>
				    <div class="col-md-4">
					    <input class="col-md-12" id="organization" name="organization" type="text" placeholder="" maxlength="20" value="${ entity.organization }">
				    </div>	
				    <label class="col-md-2 control-label no-padding-right">
					    组长
				    </label>
				    <div class="col-md-4">
					    <input class="col-md-12" id="teamLeader" name="teamLeader" type="text" placeholder="" maxlength="64" value="${ entity.teamLeader }">
					</div>
				</div>
			   <div class="form-group">
				    <label class="col-md-2 control-label no-padding-right">
					    组员
				    </label>
				    <div class="col-md-4">
					    <input class="col-md-12" id="teamMember" name="teamMember" type="text" placeholder="" maxlength="64" value="${ entity.teamMember }">
				    </div>	
				    <label class="col-md-2 control-label no-padding-right">
					    备注
				    </label>
				    <div class="col-md-4">
					    <input class="col-md-12" id="remark" name="remark" type="text" placeholder="" maxlength="255" value="${ entity.remark }">
					</div>
				</div>
			   <div class="form-group">
				    <label class="col-md-2 control-label no-padding-right">
					    删除标记
				    </label>
				    <div class="col-md-4">
					    <input class="col-md-12" id="deleteFlag" name="deleteFlag" type="text" placeholder="" maxlength="3" value="${ entity.deleteFlag }">
				    </div>	
               </div>
			</form>
    		<div style="margin-right:100px;">
        		<button class="btn btn-xs btn-danger pull-right" data-dismiss="modal">
        			<i class="ace-icon fa fa-times"></i>
        			取消
        		</button>
        		<button id="editBtn" class="btn btn-xs btn-success pull-right"  style="margin-right:15px;">
        			<i class="ace-icon fa fa-floppy-o"></i>
        			保存
        		</button>
        	</div>
        </div>
		<script type="text/javascript">
			jQuery(function($) {
				seajs.use(['combobox','combotree','my97datepicker'], function(A){
        			var appData = ${entityJson};
					var id = $('#id').val();
					$('#editForm').validate({
						debug:true,
						rules: {id:{      maxlength:20},name:{      maxlength:64},code:{      maxlength:64},organization:{      maxlength:20},teamLeader:{      maxlength:64},teamMember:{      maxlength:64},remark:{      maxlength:255},deleteFlag:{      maxlength:3},},
						submitHandler: function (form) {
							//添加按钮
							var url = format_url("/dutyOrder/"+id);
							//serializeObject()用于Jquery将form转换成用于ajax参数的Javascript Object
							var obj = $("#editForm").serializeObject();
							$.ajax({
								url : url,
								contentType : 'application/json',
								dataType : 'JSON',
								data : JSON.stringify(obj),
								cache: false,
								type : 'POST',
								success: function(result){
									alert('操作成功');
									listFormDialog.close();
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
				});
			});
        </script>
    </body>
</html>