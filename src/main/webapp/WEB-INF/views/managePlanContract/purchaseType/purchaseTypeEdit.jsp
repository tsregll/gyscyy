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
			<form class="form-horizontal" role="form"  style="margin-right:100px;" id="editFormType">
			  <input class="col-md-12" id="id" name="id" type="hidden"  value="${ entity.id }">
			   <input class="col-md-12" id="createUserId" name="createUserId" type="hidden"  value="${ entity.createUserId }">
			   <div class="form-group">
				   
				    <label class="col-md-2 control-label no-padding-right">
					    		<span style="color:red;">*</span>类型名称
				    </label>
				    <div class="col-md-4">
					    <input class="col-md-12" id="name" name="name" type="text" placeholder="" maxlength="64" value="${ entity.name }">
					</div>
					 <label class="col-md-2 control-label no-padding-right">
					    		<span style="color:red;">*</span>创建人
				    </label>
				    <div class="col-md-4">
					    <input class="col-md-12" id="userName" name="userName" type="text" placeholder="" maxlength="64" readonly="readonly" value="${userName }">
				    </div>	
				</div>
			</form>
    		<div style="margin-right:100px;margin-top: 30px;">
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
				seajs.use(['combobox','combotree','my97datepicker','uploaddropzone','wysiwyg'], function(A){
        			var appData = ${entityJson};
					var id = $('#id').val();
					$('#editFormType').validate({
						debug:true,
						rules: {
							id:{maxlength:20},
							name:{maxlength:64,required:true},
							createUserId:{maxlength:64,required:true},
							createDate:{maxlength:64},
							},
						submitHandler: function (form) {
							//添加按钮
							var url = format_url("/purchaseType/"+id);
							//serializeObject()用于Jquery将form转换成用于ajax参数的Javascript Object
							var obj = $("#editFormType").serializeObject();
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
    					$("#editFormType").submit();
    				});
				});
			});
        </script>
    </body>
</html>