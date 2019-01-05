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
				    <input class="col-md-12" id="id" name="id" type="hidden" placeholder="" maxlength="20" value="${ entity.id }">
			   <div class="form-group">
			    <label class="col-md-2 control-label no-padding-right">
					<span style="color:red;">*</span>填写人
				    </label>
				    <div class="col-md-4">
				       <input  class="col-md-12" id="createUserId" name="createUserId" placeholder=""  type="hidden" maxlength="64" readonly="readonly" value="${entity.createUserId }">
				         <input  class="col-md-12" id="userName" name="userName" placeholder=""  type="text" maxlength="64" readonly="readonly" value="${userName }">
                    </div>
				   <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>单位
					</label>
					<div class="col-md-4">
										<select id="unitId" name="unitId" ></select>
								</div>
				</div>
			   <div class="form-group">
				    <label class="col-md-2 control-label no-padding-right">
					     <span style="color:red;">*</span>年号
				    </label>
				    <div class="col-md-4">
					    <div id="yearNumDiv"></div>
					</div>
					 <label class="col-md-2 control-label no-padding-right">
					    <span style="color:red;">*</span>时间
				    </label>
				    <div class="col-md-4">
					    <div id="businessDateDiv"></div>
				    </div>
				</div>
			   <div class="form-group">
				   
				  
                    <label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>名称
				    </label>
				    <div class="col-md-4">
						<input class="col-md-12" id="name" name="name" type="text" placeholder="" maxlength="64" value="${entity.name }">
                    </div>
					<label class="col-md-2 control-label no-padding-right">
						<span style="color:red;">*</span>类别
					</label>
					<div class="col-md-4">
	                 <select class="col-md-12 chosen-select" id="category" name="category"></select>
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
				seajs.use(['combobox','combotree','my97datepicker','uploaddropzone'], function(A){
        			var appData = ${entityJson};
        			
        			//附件上传
					var uploaddropzone =new A.uploaddropzone({
						render : "#divfile",
						fileId:${entity.fileId},
						autoProcessQueue:true,//是否自动上传
						addRemoveLinks : true,//显示删除按钮
					}).render();
        			
					//日期组件
					var yearNumDatePicker = new A.my97datepicker({
						id: "yearNumId",
						name: "yearNum",
						render: "#yearNumDiv",
						options : {
								isShowWeek : false,
								skin : 'ext',
								maxDate: "",
								minDate: "",
								dateFmt: "yyyy"
						}
					}).render();
					yearNumDatePicker.setValue(appData.yearNumString);
					//日期组件
					var businessDateDatePicker = new A.my97datepicker({
						id: "businessDateId",
						name: "businessDate",
						render: "#businessDateDiv",
						options : {
								isShowWeek : false,
								skin : 'ext',
								maxDate: "",
								minDate: "",
								dateFmt: "yyyy-MM-dd"
						}
					}).render();
					businessDateDatePicker.setValue(appData.businessDateString);
					//单位
					 searchunitid = new A.combobox({
						render : "#unitId",
						datasource : ${unitList},
						allowBlank: true,
						options : {
							"disable_search_threshold" : 10
						}
					}).render();
					 searchunitid.setValue(${entity.unitId});
					//combobx组件
					var categoryCombobox = new A.combobox({
						render: "#category",
						//返回数据待后台返回TODO
						datasource:${categoryCombobox},
						//multiple为true时select可以多选
						multiple:false,
						//allowBlank为false表示不允许为空
						allowBlank: true,
						options:{
							"disable_search_threshold":10
						}
					}).render();
					categoryCombobox.setValue(appData.category);
					
					var id = $('#id').val();
					$('#editForm').validate({
						debug:true,
						rules: {
							id:{      maxlength:20},
							name:{required:true,      maxlength:64},
							category:{required:true,      maxlength:64},
							yearNum:{ required:true ,     maxlength:64},
							businessDate:{required:true,      maxlength:64}
							},
						submitHandler: function (form) {
							//添加按钮
							var url = format_url("/threeBusiness/saveBusinessPage/"+id);
							//serializeObject()用于Jquery将form转换成用于ajax参数的Javascript Object
							var obj = $("#editForm").serializeObject();
							
							obj.yearNum = $('#yearNumId').val()+"-01-01 00:00:00";
							obj.businessDate = $('#businessDateId').val()+" 00:00:00";
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
									listFormDialog.close();
								},
								error:function(v,n){
									alert('操作失败');
								}
							});
						}
					});
					$("#editBtn").on("click", function(){
						
						var yearNumStr = yearNumDatePicker.getValue();
						var checkDateStr = businessDateDatePicker.getValue().split("-")[0];
						if(yearNumStr!=checkDateStr){
							alert("年号和时间不符");
							return;
						}
    					$("#editForm").submit();
    				});
				});
			});
        </script>
    </body>
</html>