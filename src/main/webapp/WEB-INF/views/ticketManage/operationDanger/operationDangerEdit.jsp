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
			<form class="form-horizontal" role="form"  style="margin-right:100px;" id="editDangerForm">
		       <div class="form-group">
					<label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>危险因素
					</label>
					<div class="col-md-4">
	                   <input class="col-md-12" id="careCard" name="careCard" type="text" placeholder="" maxlength="128" value="${t.careCard}">
                	</div>
				    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>控制措施
				    </label>
				    <div class="col-md-4">
						<input class="col-md-12" id="startPicId" name="startPicId" type="text" placeholder="" maxlength="128" value="${t.startPicId}">
                    </div>
               </div>
            </form>
    		<div style="margin-right:100px;">
    			<button class="btn btn-xs btn-danger pull-right" data-dismiss="modal">
    				<i class="ace-icon fa fa-times"></i>
    				取消
    			</button>
    			<button id="editDangerBtn" class="btn btn-xs btn-success pull-right"  style="margin-right:15px;">
    				<i class="ace-icon fa fa-floppy-o"></i>
    				保存
    			</button>
    		</div>
		</div>
		<script type="text/javascript">
			jQuery(function($) {
				seajs.use(['combobox','combotree','my97datepicker'], function(A){
					$('#editDangerForm').validate({
						debug:true,
						rules:  {
							careCard : {required : true,maxlength : 64},
							startPicId : {required : true,maxlength : 64},
						},
						submitHandler: function (form) {
							//修改按钮
							var url = format_url("/operationDanger/"+${t.id});
							var obj = $("#editDangerForm").serializeObject();
							obj.operationId=$("#id").val();
							obj.id=${t.id}
							$.ajax({
								url : url,
								contentType : 'application/json',
								dataType : 'JSON',
								data : JSON.stringify(obj),
								cache: false,
								type : 'POST',
								success: function(result){
									if(result.result=="success"){
										alert('修改成功');
										listFormDialog.close();
									}else{
										alert(result.errorMsg);
									}
								},
								error:function(v,n){
									alert('修改失败');
								}
							});
						}
					});
					$("#editDangerBtn").on("click", function(){
						$("#editDangerForm").submit();
    				});
    				
				});
			});
        </script>
    </body>
</html>