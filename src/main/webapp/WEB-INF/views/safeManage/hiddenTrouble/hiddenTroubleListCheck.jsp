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
					安全管理
				</li>
				<li>
					隐患排查
				</li>
				<li class="active">${targetType}</li>
			</ul><!-- /.breadcrumb -->
		</div>
		<div class="page-content">
			<div class="col-lg-12 col-md-12 col-sm-12 padding-zero search-content">
				<div class="form-inline text-left " role="form">
				 <div class="clearfix">
                        <div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12 padding-zero" >
                            <label class="searchLabel" for="searchName">隐患描述</label>：
                             <input id="searchName" class="input-width text-left"  placeholder="请输入隐患描述" type="text"></input>
                        </div>
                         <div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12 padding-zero">
	                    <label class="searchLabel" for="searchunitIdDiv">单位</label>：
	                     <div class="padding-zero inputWidth  text-left">
	                      <select id="searchunitIdDiv" class="inputWidth text-left padding-zero" ></select>
<!-- 	                    <div id="searchunitIdDiv" class="inputWidth text-left padding-zero"></div> -->
   						</div>
	                </div>
	                    <div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12 padding-zero">
                            <label class="searchLabel" for="searchcheckDate">排查时间</label>：
                              <div class="form-group dateInputOther padding-zero text-left" style="width: 63%">
                             	<div id="searchcheckDate" style="border:none; padding:0px;"></div>
                            </div>
                        </div>
                         <div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12 padding-zero btnSearchBottom"style="text-align:right;" >
                            <button id="btnSearch" class="btn btn-xs btn-primary" >
                                <i class="glyphicon glyphicon-search"></i>
                                查询
                            </button>
                            <button id="btnReset" class="btn btn-xs btn-primary">
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
						<h5 class='table-title header smaller blue' >${targetType}</h5>
						<input class="col-md-12" id="type" name="type"  value="${type}" type="hidden">
						<table id="hiddenTrouble_table" class="table table-striped table-bordered table-hover" style="width:100%;">
							<thead>
								<tr>
									<th style="display:none;">主键</th>
									<th class="center sorting_disabled" style="width:50px;">
        								<label class="pos-rel">
        									<input type="checkbox" class="ace" />
        									<span class="lbl"></span>
        								</label>
        							</th>
	                                <th>序号</th>
	                                <th>隐患描述</th>
	                                <th>排查时间</th>
	                                <th>整改情况</th>
	                                <th>整改时间</th>
	                                <th>填写人</th>
	                                <th>单位</th>
	                                <th>排查人员</th>
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
			var listFormDialog;
			jQuery(function($) {
				seajs.use(['datatables', 'confirm', 'dialog','combobox','combotree','my97datepicker'], function(A){
					var conditions=[];
					
					var type=${type};
					
					//单位
// 					var searchunitId = new A.combotree({
// 						render: "#searchunitIdDiv",
// 						name: 'unitId',
// 						//返回数据待后台返回TODO
// 						datasource: ${unitNameIdTreeList},
// 						width:"110px",
// 						options: {
// 							treeId: 'searchunitId',
// 							data: {
// 								key: {
// 									name: "name"
// 								},
// 								simpleData: {
// 									enable: true,
// 									idKey: "id",
// 									pIdKey: "parentId"
// 								}
// 							}
// 						}
// 					}).render();
					//单位
					 searchunitid = new A.combobox({
						render : "#searchunitIdDiv",
						datasource : ${unitList},
						allowBlank: true,
						options : {
							"disable_search_threshold" : 10
						}
					}).render();
					
					//日期组件
					var searchtimeDatePicker = new A.my97datepicker({
						id: "searchcheckDateId",
						name:"searchcheckDate",
						render:"#searchcheckDate",
						options : {
								isShowWeek : false,
								skin : 'ext',
								maxDate: "",
								minDate: "",
								dateFmt: "yyyy-MM-dd"
						}
					}).render();
					
					//安全检查类别
					var statusCombobox = new A.combobox({
						render: "#searchCategoryDiv",
						datasource:${categoryCombobox},
						//multiple为true时select可以多选
						multiple:false,
						//allowBlank为false表示不允许为空
						allowBlank: true,
						options:{
							"disable_search_threshold":10
						}
					}).render();
					
					
					var exportExcel="";
					
					var hiddenTroubleDatatables = new A.datatables({
						render: '#hiddenTrouble_table',
						options: {
					        "ajax": {
					            "url": format_url("/hiddenTrouble/search"),
					            "contentType": "application/json",
					            "type": "POST",
					            "dataType": "JSON",
					            "data": function (d) {
					              	conditions.push({
			        					field: 'C_TYPE',
			        					fieldType:'LONG',
			        					matchType:'EQ',
			        					value:${type}
			        				});
					            	d.conditions = conditions;
					                return JSON.stringify(d);
					              }
					        },
					        multiple : true,
							ordering: true,
							optWidth: 80,
							columns: [
							          {data:"id", visible:false,orderable:false}, 
							          {orderable: false,"width":"3%", "sClass": "center",render : function(data, type, row, meta) {
						                   var startIndex = meta.settings._iDisplayStart;  
						                   row.start=startIndex + meta.row;
						                   return startIndex + meta.row + 1;  
						               	} },
						               	{data: "troubleName",width: "auto",orderable: true}, 
								        {data: "checkDateString",name:"checkDate",width: "auto",orderable: true},
							          	{data: "editContent",width: "auto",orderable: true}, 
							         	 {data: "editDateString",name:"editDate",width: "auto",orderable: true},
// 							          	{data: "categoryName",name:"category",width: "13%",orderable: true}, 
							         	 {data: "userName",name:"createUserId",width: "auto",orderable: true}, 
							         	 {data: "unitName",name:"unitId",width: "auto",orderable: true},
 							          	{data: "investigator",width: "auto",orderable: true} 
							          ],
							          
							          fnPreDrawCallback: function (oSettings, iStart, iEnd, iMax, iTotal, sPre) {
											 if(exportExcel){
												 exportExcels(format_url("/hiddenTrouble/exportExcel/"+type),JSON.stringify(conditions));
											 }
											 exportExcel="";
										 },
										 
							toolbars: [{
        						label:"新增",
        						icon:"glyphicon glyphicon-plus",
        						className:"btn-success",
        						events:{
            						click:function(event){
                						listFormDialog = new A.dialog({
                    						width:880 ,
                    						height:600 ,
                    						title: "存在隐患及排查情况新增",
                    						url:format_url('/hiddenTrouble/getAddCheck'),
                    						closed: function(){
                    							hiddenTroubleDatatables.draw(false);
                    						}	
                    					}).render()
            						}
        						}
        					}, {
								label:"删除",
								icon:"glyphicon glyphicon-trash",
								className:"btn-danger",
								events:{
									click: function(event){
										var data = hiddenTroubleDatatables.getSelectRowDatas();
										var ids = [];
										var userIds = [];
										if(data.length && data.length>0){
											for(var i =0; i<data.length; i++){
												ids.push(data[i].id);
												userIds.push(data[i].createUserId);
											}
										}
										if(ids.length < 1){
											alert('请选择要删除的数据');
											return;
										}
										var loginUser = ${sysUserId};
										var loginName =${loginName};
										for(var j=0;j<userIds.length;j++){
											if(userIds[j]!=loginUser&&loginName!="super"){
												alert('记录中包含不是当前登陆人的记录不能删除!');
												return;
											}
										}
										var url = format_url('/hiddenTrouble/bulkDelete/');
										A.confirm('您确认删除么？',function(){
											$.ajax({
												url : url,
												contentType : 'application/json',
												dataType : 'JSON',
												type : 'DELETE',
												data : JSON.stringify(ids),
												success: function(result){
													alert('删除成功');
													hiddenTroubleDatatables.draw(false);
												},
												error:function(v,n){
													alert('操作失败');
												}
											});
										});
									}
								}
							}, {
								label:"导出",
								icon: "glyphicon glyphicon-download",
								className: "btn-primary",
								events:{
									click:function(event){
										
										$('#btnSearch').click();
            							exportExcel="exportExcel";
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
									if(data.createUserId!=userId && loginName!='super'){
										btnNode.hide();
									}
								},
								events:{
									click: function(event, nRow, nData){
										var id = nData.id;
										listFormDialog = new A.dialog({
											width:880 ,
											height:600 ,
											title: "存在隐患及排查情况修改",
											url:format_url('/hiddenTrouble/getEditCheck/' + id),
											closed: function(){
												hiddenTroubleDatatables.draw(false);
											}
										}).render();
									}
								}
							}, {
								id:"delete",
								label:"删除",
								icon: "fa fa-trash-o bigger-130",
								className: "red del",
								render: function(btnNode, data){
									var userId = ${sysUserId};
									var loginName =${loginName};
									if(data.createUserId!=userId && loginName!='super'){
										btnNode.hide();
									}
								},
								events:{
									click: function(event, nRow, nData){
										var id = nData.id;
										var url =format_url('/hiddenTrouble/'+ id);
										A.confirm('您确认删除么？',function(){
											$.ajax({
												url : url,
        										contentType : 'application/json',
        										dataType : 'JSON',
        										type : 'DELETE',
        										success: function(result){
        											alert('删除成功');
        											hiddenTroubleDatatables.draw(false);
        										},
        										error:function(v,n){
        											alert('操作失败');
        										}
											});
										});
									}
								}
						},{
							id: "detail",
							label:"查看",
							icon: "fa fa-binoculars bigger-130",
							className: "blue ",
							events:{
								click: function(event, nRow, nData){
									var id = nData.id;
									listFormDialog = new A.dialog({
										width: 880,
										height:600 ,
										title: "存在隐患及排查情况查看",
										url:format_url('/hiddenTrouble/getDetailCheck/' + id),
										closed: function(){
											hiddenTroubleDatatables.draw(false);
										}
									}).render();
								}
							}
						}]
						}
					}).render();
					$('#btnSearch').on('click',function(){
						conditions=[];
// 						if(searchunitId.getValue()!=null
//     							&&searchunitId.getValue()+""!=""){
//     						conditions.push({
//             					field: 'a.C_UNIT_ID',
//             					fieldType:'STRING',
//             					matchType:'EQ',
//             					value:searchunitId.getValue()
//             				});
//     					}
						if($('#searchunitIdDiv').val()){
	    					conditions.push({
	        					field: 'a.C_UNIT_ID',
	        					fieldType:'STRING',
	        					matchType:'EQ',
	        					value:$('#searchunitIdDiv').val()
	        				});
						}
						if($('#searchcheckDateId').val()){
	    					conditions.push({
	        					field: 'a.C_CHECK_DATE',
	        					fieldType:'DATE',
	        					matchType:'EQ',
	        					value:$('#searchcheckDateId').val()+" 00:00:00"
	        				});
						}
				
						if($("#searchName").val()!=""){
							conditions.push({
								field: 'a.C_TROUBLE_NAME',
								fieldType:'STRING',
								matchType:'LIKE',
								value:$("#searchName").val().trim()
							});
						}
				
						
						hiddenTroubleDatatables.draw();
					});
					$('#btnReset').on('click',function(){
// 						searchunitId.setValue();
						$('#searchcheckDateId').val("");
						$("#searchName").val('');
						$("#searchunitIdDiv").val('');
						$("#searchunitIdDiv").trigger("chosen:updated");
					
					});
				});
			});
        </script>
    </body>
</html>