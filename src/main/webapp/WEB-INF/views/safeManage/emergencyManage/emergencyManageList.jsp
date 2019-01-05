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
				<li class="active">安全管理</li>
				<li class="active">应急管理</li>
			</ul><!-- /.breadcrumb -->
		</div>
		<div class="page-content">
			<div class="col-lg-12 col-md-12 col-sm-12 search-content  padding-zero">
				<div class="form-inline text-left" role="form">
				<div class="clearfix">
	                <div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12 padding-zero">
	                    <label class="searchLabel" for="searchcode">单位</label>：
	                    <div class="padding-zero inputWidth  text-left">
                             <select id="searchunitIdDiv" class="" ></select>
                        </div>
<!-- 	                    <div id="searchunitIdDiv" class="inputWidth text-left padding-zero"></div> -->
	                </div>
	                <div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12 padding-zero">
	                 <label class="searchLabel" for="searchScrapSource">类别</label>：：
	                    <div class="padding-zero inputWidth  text-left" style="margin-left: -12px">
	                        <select id="searchType" class="" name="searchType"></select>
	                    </div>
	                </div>
	                <div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12 padding-zero"style="margin-left: -12px">
	                    <label class="searchLabel" for="searchcode">年号</label>：
	                     <div class="padding-zero inputWidth  text-left">
	                        <div id="yearNumDiv"></div>
	                    </div>
	                </div>
<!-- 	                <div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12 padding-zero"style="margin-left: 12px"> -->
<!-- 	                 <label class="searchLabel" for="searchScrapSource">相关资料</label>： -->
<!-- 	                    <input id="searchInformation" class="form-group  inputWidth padding-zero  text-left" placeholder="请填写相关资料名称" type="text"> -->
<!-- 	                </div> -->
	                   <div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12 padding-zero btnSearchBottom" style="text-align:right; ">
                            <button id="btnSearch" class="btn btn-xs btn-primary">
                                <i class="glyphicon glyphicon-search"></i>
                           		     查询
                            </button>
                            <button id="btnReset" class="btn btn-xs btn-primary" >
                                <i class="glyphicon glyphicon-repeat"></i>
                             	   重置
                            </button>
                       	</div>
	            </div>
<!--                    <div class="clearfix" > -->
<!-- 						<div class="form-group col-lg-12 col-md-12 col-sm-6 col-xs-12 padding-zero btnSearchBottom" style="text-align:right; "> -->
<!--                             <button id="btnSearch" class="btn btn-xs btn-primary"> -->
<!--                                 <i class="glyphicon glyphicon-search"></i> -->
<!--                            		     查询 -->
<!--                             </button> -->
<!--                             <button id="btnReset" class="btn btn-xs btn-primary" > -->
<!--                                 <i class="glyphicon glyphicon-repeat"></i> -->
<!--                              	   重置 -->
<!--                             </button> -->
<!--                        	</div> -->
<!-- 				   </div> -->
                </div>
            </div>			
			<div class="row">
				<div class="col-xs-12">
					<!-- div.dataTables_borderWrap -->
					<div class="widget-main no-padding">
						<h5 class='table-title header smaller blue' >应急管理</h5>
						<table id="emergencyManage_table" class="table table-striped table-bordered table-hover" style="width:100%;">
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
	                                <th>单位</th>
	                                <th>填写人</th>
	                                <th>类别</th>
<!-- 	                                <th>相关资料</th> -->
<!-- 	                                <th>隐患排查名称</th> -->
	                                <th>年号</th>
	                                <th>时间</th>
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
			var exportExcel = "";
			jQuery(function($) {
				seajs.use(['datatables', 'confirm', 'dialog','combobox','combotree','my97datepicker'], function(A){
					var conditions=[];
					//部门控件下拉树
// 					var searchunitId = new A.combotree({
// 					render: "#searchunitIdDiv",
// 					name: 'unitId',
// 					//返回数据待后台返回TODO
// 					datasource: ${unitNameIdTreeList},
// 					width:"110px",
// 					options: {
// 						treeId: 'searchunitId',
// 						data: {
// 							key: {
// 								name: "name"
// 							},
// 							simpleData: {
// 								enable: true,
// 								idKey: "id",
// 								pIdKey: "parentId"
// 							}
// 						}
// 					}
// 				}).render();
						//单位
			   var searchunitid = new A.combobox({
						render : "#searchunitIdDiv",
						datasource : ${unitList},
						allowBlank: true,
						options : {
							"disable_search_threshold" : 10
						}
					}).render();
					var type = new A.combobox({
						render : "#searchType",
						datasource : ${emergencyType},
						allowBlank: true,
						options : {
							"disable_search_threshold" : 10
						}
					}).render();
					//日期组件
					var yearNumPicker = new A.my97datepicker({
						id: "yearNumId",
						name:"yearNum",
						render:"#yearNumDiv",
						options : {
								isShowWeek : false,
								skin : 'ext',
								maxDate: "",
								minDate: "",
								dateFmt: "yyyy"
						}
					}).render();
					var emergencyManageDatatables = new A.datatables({
						render: '#emergencyManage_table',
						options: {
					        "ajax": {
					            "url": format_url("/emergencyManage/search"),
					            "contentType": "application/json",
					            "type": "POST",
					            "dataType": "JSON",
					            "data": function (d) {
					            	d.conditions = conditions;
					            	dd=d;
					                return JSON.stringify(d);
					              }
					        },
					        multiple : true,
							ordering: true,
							optWidth: 80,
							columns: [{data:"id", visible:false,orderable:false}, 
							          {orderable: false,"width":"3%", "sClass": "center",render : function(data, type, row, meta) {
						                   var startIndex = meta.settings._iDisplayStart;  
						                   row.start=startIndex + meta.row;
						                   return startIndex + meta.row + 1;  
						               	}},
							          {data: "unitName",name:"unitId",width: "auto",orderable: true}, 
							          {data: "userName",name:"userName",width: "auto",orderable: true}, 
							          {data: "typeName",name:"type",width: "auto",orderable: true}, 
// 							          {data: "information",width: "auto",orderable: true}, 
// 							          {data: "name",width: "auto",orderable: true}, 
							          {data: "yearNumString",name:"yearNum",width: "auto",orderable: true}, 
							          {data: "time",width: "auto",orderable: true}],
							          fnPreDrawCallback: function (oSettings, iStart, iEnd, iMax, iTotal, sPre) {
											 if(exportExcel){
												 exportExcels(format_url("/emergencyManage/exportExcel"),JSON.stringify(dd));
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
                    						width:800 ,
                    						height:450 ,
                    						title: "应急管理增加",
                    						url:format_url('/emergencyManage/getAdd'),
                    						closed: function(){
                    							emergencyManageDatatables.draw(false);
                    						}	
                    					}).render()
//             							A.loadPage({
// 											render : '#page-container',
// 											url : format_url('/emergencyManage/getAdd')
// 										});
            						}
        						}
        					}, {
								label:"删除",
								icon:"glyphicon glyphicon-trash",
								className:"btn-danger",
								events:{
									click: function(event){
										var data = emergencyManageDatatables.getSelectRowDatas();
										var ids = [];
										var userIds = [];
										if(data.length && data.length>0){
											for(var i =0; i<data.length; i++){
												ids.push(data[i].id);
												userIds.push(data[i].userId);
											}
										}
										if(ids.length < 1){
											alert('请选择要删除的数据');
											return;
										}
										var loginUser = '${sysUserEntity.id}';
										var loginName = '${sysUserEntity.loginName}'
										for(var j=0;j<userIds.length;j++){
											if(userIds[j]!=loginUser&&loginName!="super"){
												alert('记录中包含不是当前登陆人的记录不能删除!');
												return;
											}
										}
										var url = format_url('/emergencyManage/allDelete/');
										A.confirm('您确认删除么？',function(){
											$.ajax({
												url : url,
												contentType : 'application/json',
												dataType : 'JSON',
												type : 'DELETE',
												data : JSON.stringify(ids),
												success: function(result){
													alert('删除成功');
													emergencyManageDatatables.draw(false);
												},
												error:function(v,n){
													alert('操作失败');
												}
											});
										});
									}
								}
							},{  
        						id:"dc",
        						label:"导出",
        						icon:"glyphicon glyphicon-download",
        						className:"btn-primary",
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
									var userId = ${sysUserEntity.id}
									var loginName = '${sysUserEntity.loginName}'
										if(data.userId!=userId&&loginName!="super"){
											btnNode.hide();
										}
								},
								events:{
									click: function(event, nRow, nData){
										var id = nData.id;
										listFormDialog = new A.dialog({
											width:800 ,
											height:450 ,
											title: "应急管理修改",
											url:format_url('/emergencyManage/getEdit/' + id),
											closed: function(){
												emergencyManageDatatables.draw(false);
											}
										}).render();
// 										A.loadPage({
// 											render : '#page-container',
// 											url : format_url("/emergencyManage/getEdit/"+id)
// 										});
									}
								}
							}, {
								id:"delete",
								label:"删除",
								icon: "fa fa-trash-o bigger-130",
								className: "red del",
								render: function(btnNode, data){
									var userId = ${sysUserEntity.id}
									var loginName = '${sysUserEntity.loginName}'
										if(data.userId!=userId&&loginName!="super"){
											btnNode.hide();
										}
								},
								events:{
									click: function(event, nRow, nData){
										var id = nData.id;
										var url =format_url('/emergencyManage/deleteOne/'+ id);
										A.confirm('您确认删除么？',function(){
											$.ajax({
												url : url,
        										contentType : 'application/json',
        										dataType : 'JSON',
        										type : 'DELETE',
        										success: function(result){
        											alert('删除成功');
        											emergencyManageDatatables.draw(false);
        										},
        										error:function(v,n){
        											alert('操作失败');
        										}
											});
										});
									}
								}
						},
						{
							id: "detail",
							label:"查看",
							icon: "fa fa-binoculars bigger-130",
							className: "blue ",
							events:{
								click: function(event, nRow, nData){
									var id = nData.id;
									listFormDialog = new A.dialog({
										width:800 ,
										height:450 ,
										title: "应急管理查看",
										url:format_url('/emergencyManage/getDetail/' + id),
										closed: function(){
											emergencyManageDatatables.draw(false);
										}
									}).render();
// 									A.loadPage({
// 										render : '#page-container',
// 										url : format_url("/emergencyManage/getDetail/"+ id)
// 									});
								}
							}
						}]
						}
					}).render();
					$('#btnSearch').on('click',function(){
						conditions=[];
// 						if(searchunitId.getValue()!=null
//     							&&searchunitId.getValue()!=""){
//     						conditions.push({
//             					field: 't.C_UNIT_ID',
//             					fieldType:'STRING',
//             					matchType:'EQ',
//             					value:searchunitId.getValue()
//             				});
//     					}
// 						if($("#searchInformation").val()!=""){
// 	    					conditions.push({
// 	        					field: 't.C_INFORMATION',
// 	        					fieldType:'STRING',
// 	        					matchType:'LIKE',
// 	        					value:$('#searchInformation').val()
// 	        				});
//     					}
						if($('#searchunitIdDiv').val()){
	    					conditions.push({
	        					field: 't.C_UNIT_ID',
	        					fieldType:'STRING',
	        					matchType:'EQ',
	        					value:$('#searchunitIdDiv').val()
	        				});
						}
						if($("#yearNumId").val()!=""){
	    					conditions.push({
	        					field: 't.C_YEAR_NUM',
	        					fieldType:'STRING',
	        					matchType:'EQ',
	        					value:$('#yearNumId').val()+"-01-01"
	        				});
    					}
						if($("#searchType").val()!=""){
	    					conditions.push({
	        					field: 't.C_TYPE',
	        					fieldType:'STRING',
	        					matchType:'EQ',
	        					value:$('#searchType').val()
	        				});
    					}
						
						emergencyManageDatatables.draw();
					});
					$('#btnReset').on('click',function(){
// 						searchunitId.setValue();
// 						$("#searchInformation").val("");
						$("#yearNumId").val("");
						$("#searchType").val("");
						$("#searchType").trigger("chosen:updated");
						$("#searchunitIdDiv").val('');
						$("#searchunitIdDiv").trigger("chosen:updated");
					});
				});
			});
        </script>
    </body>
</html>