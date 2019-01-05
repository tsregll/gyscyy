<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tag/Purview.tld" prefix="p"%> 
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
					招标采购
				</li>
				<li class="active">定标请示函</li>
			</ul><!-- /.breadcrumb -->
		</div>
	
		<div class="page-content">
			<div class="col-lg-12 col-md-12 col-sm-12 search-content  padding-zero">
				<div class="form-inline text-left" role="form">
				<div class="clearfix">
					<div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12 padding-zero">
                       <label class="searchLabel">所属部门</label>：
                       <div class="padding-zero inputWidth  text-left">
                          <select id="unitId" class="" ></select>
                       </div>
                    </div>
                    <div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12 padding-zero">
	                   <label class="searchLabel " for="form-field-1">采购事项</label>：
	                    <input id="nameId" class="inputWidth text-left" placeholder="请输入采购事项" type="text" >
	                </div>
					<div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12 padding-zero">
                       <label class="searchLabel">立项单位</label>：
                       <div class="padding-zero inputWidth  text-left">
                          <select id="departmentId" class="" ></select>
                       </div>
                    </div>
                 </div>
                 <div class="clearfix" >
	                <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12  padding-zero">
	                    <label class="searchLabel " for="form-field-1">请示批复时间</label>：
	                    <div class="form-group dateInputOther padding-zero text-left">
	                        <div id="replyTimeStartDiv" style="border:none; padding:0px;"></div>
	                    </div>
	                    <div class="toLabel" for="searchStartTimeRightDiv" >~</div>
	                    <div class="form-group dateInputOther padding-zero text-left">
	                        <div id="replyTimeEndDiv" style="border:none; padding:0px;"></div>
	                    </div>
	                </div>
					<div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12 padding-zero btnSearchBottom" style="text-align:right; ">
                          <button id="btnSearchAccident" class="btn btn-xs btn-primary">
                              <i class="glyphicon glyphicon-search"></i>
                         		     查询
                          </button>
                          <button id="btnResetAccident" class="btn btn-xs btn-primary" >
                              <i class="glyphicon glyphicon-repeat"></i>
                           	   重置
                          </button>
                     </div>
		   		</div>
                </div>
            </div>			
			<div class="row">
				<div class="col-xs-12">
					<!-- div.dataTables_borderWrap -->
					<div class="widget-main no-padding">
						<h5 class='table-title header smaller blue' >定标请示函</h5>
						<table id="dealStandard_table" class="table table-striped table-bordered table-hover" style="width:100%;">
							<thead>
								<tr>
									<th style="display:none;">主键</th>
	                                <th>序号</th>
	                                <th>所属部门</th>
	                                <th>采购事项</th>
	                                <th>立项单位</th>
	                                <th>请示批复时间</th>
	                                <th>备注</th>
<!-- 	                                <th>审核状态</th> -->
                                    <th>操作</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
		<!-- inline scripts related to this page -->
		<script type="text/javascript">
			var exportExcelAccident="";
			var listFormDialog;
			jQuery(function($) {
				seajs.use(['datatables', 'confirm','combobox','my97datepicker'], function(A){
					var conditions=[];
					var itemType = ${itemType};
					var answerht = ${answerht};
					//所属部门
					var unitIdCombobox = new A.combobox({
						render: "#unitId",
						datasource:${unitIdList},
						//multiple为true时select可以多选
						multiple:false,
						//allowBlank为false表示不允许为空
						allowBlank: true,
						options:{
							"disable_search_threshold":10
						}
					}).render();
					
					//立项单位
					var departmentIdCombobox = new A.combobox({
						render: "#departmentId",
						datasource:${departmentIdList},
						//multiple为true时select可以多选
						multiple:false,
						//allowBlank为false表示不允许为空
						allowBlank: true,
						options:{
							"disable_search_threshold":10
						}
					}).render();
					
					//请示批复开始时间
					var updateDateStartDiv = new A.my97datepicker({
						id: 'replyTimeStartDivId',
						name:'replyTime',
						render:'#replyTimeStartDiv',
						options : {
								isShowWeek : false,
								skin : 'ext',
								maxDate: "#F{$dp.$D(\\'replyTimeEndDivId\\')}",
								minDate: "",
								dateFmt: "yyyy-MM-dd"
						}
					}).render();
					
					//请示批复结束时间
					var updateDateEndDiv = new A.my97datepicker({
						id: 'replyTimeEndDivId',
						name:'replyTime',
						render:'#replyTimeEndDiv',
						options : {
								isShowWeek : false,
								skin : 'ext',
								maxDate: "",
								minDate: "#F{$dp.$D(\\'replyTimeStartDivId\\')}",
								dateFmt: "yyyy-MM-dd"
						}
					}).render();
					var dealStandardDatatables = new A.datatables({
						render: '#dealStandard_table',
						options: {
					        "ajax": {
					            "url": format_url("/dealStandard/search"),
					            "contentType": "application/json",
					            "type": "POST",
					            "dataType": "JSON",
					            "data": function (d) {
					            	conditions.push({
				     					field: 'st.C_STATUS',
				     					fieldType:'STRING',
				     					matchType:'EQ',
				     					value:1
				     				});
					            	d.conditions = conditions;
					                return JSON.stringify(d);
					              }
					        },
					        multiple : true,
							ordering: true,
							checked: false,
							optWidth: 80,
							columns: [{data:"id", visible:false,orderable:false},
							          {orderable: false,"width":"3%", "sClass": "center",render : function(data, type, row, meta) {
						                   var startIndex = meta.settings._iDisplayStart;  
						                   row.start=startIndex + meta.row;
						                   return startIndex + meta.row + 1;  
						               	} },
							          {data: "unitName",name:"unitId",width: "auto",orderable: true}, 
							          {data: "name",width: "auto",orderable: true}, 
							          {data: "departmentName",name:"departmentId",width: "auto",orderable: true}, 
							          {data: "replyTimeStr",name:"replyTime",width: "auto",orderable: true},  
							          {data: "remark",width: "auto",orderable: true}
							          ],
							          fnPreDrawCallback: function (oSettings, iStart, iEnd, iMax, iTotal, sPre) {
											 if(exportExcelAccident){
												 exportExcels(format_url("/dealStandard/exportExcel"),JSON.stringify(conditions));
											 }
											 exportExcelAccident="";
										 },
							toolbars: [{
        						label:"新增",
        						icon:"glyphicon glyphicon-plus",
        						className:"btn-success",
        						events:{
            						click:function(event){
            							if(answerht=="1"){
            								A.loadPage({
    											render : '#page-container',
    											url : format_url('/dealStandard/getAdd')
    										});
            							}else{
            								 alert("只有计划经营处负责人可以新增！");
            			                      return;
            							}
            							
            						}
        						}
        					},{
        						label:"批量导入",
        						icon:"glyphicon glyphicon-upload",
        						className:"btn-primary",
        						events:{
            						click:function(event){
            							if(answerht=="1"){
            								workSafeOneDialog = new A.dialog({
                        						width: 800,
                        						height: 300,
                        						title: "批量导入",
                        						url:format_url("/dealStandard/getBatchAdd"),
                        						closed: function(){
                        						}	
                        					}).render();
            							}else{
            								 alert("只有计划经营处负责人可以批量导入！");
            			                      return;
            							}
            							
            						}
        						}
        					}, {
								label:"历史",
								icon:"glyphicon glyphicon-time",
								className:"btn-danger",
								events:{
									click: function(event){
										if(answerht=="1"){
											A.loadPage({
												render : '#page-container',
												url : format_url('/cancelHistory/getHistoryList/'+itemType)
											});
            							}else{
            								 alert("只有计划经营处负责人可以查看历史！");
            			                      return;
            							}
            							
									}
								}
							},{  
        						id:"dc",
        						label:"导出",
        						icon:"glyphicon glyphicon-download",
        						className:"btn-primary",
        						events:{
        							click:function(event){
            							$('#btnSearchAccident').click();
            							exportExcelAccident="exportExcelAccident";
            						}
        						}
        					},{  
        						id:"dc",
        						label:"模板下载",
        						icon:"glyphicon glyphicon-download",
        						className:"btn-primary",
        						events:{
        							click:function(event){
    								 	exportExcels(format_url("/dealStandard/exportExcelModel"));
            						}
        						}
        					}],
							btns: [{
								id: "edit",
								label:"修改",
								icon: "fa fa-pencil-square-o bigger-130",
								className: "green edit",
								render: function(btnNode, data){
									var userId = ${sysUserId};
									var loginName =${loginName};
									if(data.createId!=userId && loginName!='super'){
										btnNode.hide();
									}
								},
								events:{
									click: function(event, nRow, nData){
										var id = nData.id;
										A.loadPage({
											render : '#page-container',
											url : format_url('/dealStandard/getEdit/' + id)
										});
									}
								}
							}
// 							, {
// 								id:"delete",
// 								label:"删除",
// 								icon: "fa fa-trash-o bigger-130",
// 								className: "red del",
// 								events:{
// 									click: function(event, nRow, nData){
// 										var id = nData.id;
// 										var url =format_url('/produceReply/deleteOne/'+ id);
// 										A.confirm('您确认删除么？',function(){
// 											$.ajax({
// 												url : url,
//         										contentType : 'application/json',
//         										dataType : 'JSON',
//         										type : 'DELETE',
//         										success: function(result){
//         											alert('删除成功');
//         											produceReplyDatatables.draw(false);
//         										},
//         										error:function(v,n){
//         											alert('操作失败');
//         										}
// 											});
// 										});
// 									}
// 								}
// 						} 
// 							,{
// 							id:"submit",
// 						 	label: "提交审核",
// 							icon: "fa fa-check-square-o bigger-130",
// 							className: "edit",
// 							render: function(btnNode, data){
// 								var loginUserId = '${sysUserEntity.id}'
// 								console.log(data);
// 								console.log(data.status);
// 								if(data.status!="0"){
// 									btnNode.hide();
// 								}
// 								if(data.uploadPerson!=loginUserId){
// 									btnNode.hide();
// 								}
// 							},
// 							events:{
// 								click: function(event, nRow, nData){
// 									debugger;
// 									var id = nData.id;
// 												workticketDialog = new A.dialog({
// 													title:"选择单位负责人",
// 													url:format_url("/accidentMeasuresPlan/sureSubmit?id="+ id),
// 													height:500,
// 													width:600,
// 												}).render();
// 								}
// 							}
// 						} 
					,{
							id: "detail",
							label:"查看",
							icon: "fa fa-binoculars bigger-130",
							className: "blue ",
							events:{
								click: function(event, nRow, nData){
									var id = nData.id;
									A.loadPage({
										render : '#page-container',
										url : format_url("/dealStandard/getDetail/"+ id)
									});
								}
							}
						},{
							id: "history",
							label:"撤回",
							icon: "fa fa-history bigger-130",
							className: "red ",
							render: function(btnNode, data){
								var userId = ${sysUserId};
								var loginName =${loginName};
								if(data.createId!=userId && loginName!='super'){
									btnNode.hide();
								}
							},
							events:{
								click: function(event, nRow, nData){
									var id = nData.id;
									
            						listFormDialog = new A.dialog({
                						width: '750',
                						height: '350',
                						title: "撤回",
                						url:format_url("/cancelHistory/addHistoryMessage/"+ id+"/"+itemType),
                						closed: function(){
                							dealStandardDatatables.draw(false);
                						}	
                					}).render()
									
								}
							}
						}]
						}
					}).render();
					$('#btnSearchAccident').on('click',function(){
						conditions=[];
						//所属部门
						if($("#unitId").val()){
	    					conditions.push({
	    						field: 'st.C_UNIT_ID',
	    						fieldType:'STRING',
	    						matchType:'EQ',
	    						value:$("#unitId").val()
	    					});
    					}
						//采购事项
						if($("#nameId").val()){
	    					conditions.push({
	    						field: 'st.C_NAME',
	    						fieldType:'STRING',
	    						matchType:'LIKE',
	    						value:$("#nameId").val()
	    					});
    					}
						//立项单位
						if($("#departmentId").val()){
	    					conditions.push({
	    						field: 'st.C_DEPARTMENT_ID',
	    						fieldType:'STRING',
	    						matchType:'EQ',
	    						value:$("#departmentId").val()
	    					});
    					}
						//请示批复开始时间
						if($("#updateDateStartDivId").val()){
	    					conditions.push({
	    						field: 'st.C_REPLY_TIME',
	    						fieldType:'DATE',
	    						matchType:'GE',
	    						value:$("#replyTimeStartDivId").val()+" 00:00:00"
	    					});
    					}
						//请示批复结束时间
    					if($("#updateDateEndDivId").val()){
	    					conditions.push({
	    						field: 'st.C_REPLY_TIME',
	    						fieldType:'DATE',
	    						matchType:'LE',
	    						value:$("#replyTimeEndDivId").val()+" 23:59:59"
	    					});
    					}
    					dealStandardDatatables.draw();
					});
					//重置条件并查询
					$('#btnResetAccident').on('click',function(){
						$("#unitId").val("");
						$("#unitId").trigger("chosen:updated");
						$("#nameId").val("");
						$("#departmentId").val("");
						$("#departmentId").trigger("chosen:updated");
						$("#replyTimeStartDivId").val("");
						$("#replyTimeStartDiv").val("");
						$("#replyTimeEndDivId").val("");
						$("#replyTimeEndDiv").val("");
						conditions=[];
						dealStandardDatatables.draw();
					});
				});
			});
        </script>
    </body>
</html>