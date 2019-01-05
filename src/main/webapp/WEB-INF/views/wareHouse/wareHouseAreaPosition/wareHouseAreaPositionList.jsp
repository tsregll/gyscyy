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
					<a href="#">首页</a>
				</li>
				<li>仓库管理</li>
				<li class="active">货区/货位管理</li>
				<li class="active">货位配置</li>
			</ul><!-- /.breadcrumb -->
		</div>
		<div class="page-content">
			<div class="col-lg-12 col-md-12 col-sm-12 search-content  padding-zero">
				<div class="form-inline" role="form">
		           <div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12 padding-zero">
						<label class="" for="form-field-1">货位编码：</label>
		                <input id="searchcode" class="input-width text-left" placeholder="请输入货位编码" type="text" >
                   </div>
		           <div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12 padding-zero">
						<label class="" for="form-field-1">货位名称：</label>
		                <input id="searchname" class="input-width text-left" placeholder="请输入货位名称" type="text" >
                   </div>
                   <div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12 padding-zero"></div>
                   <div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12 padding-zero btnSearchBottom" style="text-align:right; ">
						<button id="btnSearch" class="btn btn-xs btn-primary">
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
			<div class="row">
				<div class="col-xs-12">
					<!-- div.dataTables_borderWrap -->
					<div class="widget-main no-padding">
						<h5 class='table-title header smaller blue' >货位</h5>
						<table id="wareHouseAreaPosition_table" class="table table-striped table-bordered table-hover" style="width:100%;">
							<thead>
								<tr>
									<th style="display:none;">主键</th>
									<th class="center sorting_disabled" style="width:50px;">
        								<label class="pos-rel">
        									<input type="checkbox" class="ace" />
        									<span class="lbl"></span>
        								</label>
        							</th>
	                                <th>货位编码</th>
	                                <th>货位名称</th>
	                                <th>所属货区</th>
	                                <th>备注</th>
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
					var wareAreaId=${wareAreaId};
					var conditions=[];
					var wareAreaId=${wareAreaId};
					var wareHouseAreaPositionDatatables = new A.datatables({
						render: '#wareHouseAreaPosition_table',
						options: {
					        "ajax": {
					            "url": format_url("/wareHouseAreaPosition/data/list/"+wareAreaId),
					            "contentType": "application/json",
					            "type": "POST",
					            "dataType": "JSON",
					            "data": function (d) {
					            	d.conditions = conditions;
					                return JSON.stringify(d);
					              }
					        },
					        multiple : true,
							ordering: true,
							optWidth: 80,
							columns: [
							          {data:"id", visible:false,orderable:false},
							          {data: "code",width: "20%",orderable: true},
							          {data: "name",width: "20%",orderable: true}, 
							          {data: "goodAreaIdName",width: "20%",orderable: true},
							          {data: "remark",width: "30%",orderable: true}
							          ],
							toolbars: [{
        						label:"新增",
        						icon:"glyphicon glyphicon-plus",
        						className:"btn-success",
        						events:{
            						click:function(event){
                						listFormDialog = new A.dialog({
                    						width:850 ,
                    						height:471 ,
                    						title: "货位增加",
                    						url:format_url('/wareHouseAreaPosition/getAdd/'+wareAreaId),
                    						closed: function(){
                    							wareHouseAreaPositionDatatables.draw(false);
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
										var data = wareHouseAreaPositionDatatables.getSelectRowDatas();
										var ids = [];
										if(data.length && data.length>0){
											for(var i =0; i<data.length; i++){
												ids.push(data[i].id);
											}
										}
										if(ids.length < 1){
											alert('请选择要删除的数据');
											return;
										}
										var url = format_url('/wareHouseAreaPosition/deleteMulti/'+ids);
										A.confirm('您确认删除么？',function(){
											$.ajax({
												url : url,
												contentType : 'application/json',
												dataType : 'JSON',
												type : 'DELETE',
												data : JSON.stringify(ids),
												success: function(result){
													if(result.result=="success"){
														alert('删除成功');
														wareHouseAreaPositionDatatables.draw(false);
													}
													if(result.result=="exception"){
														alert('删除失败！该货位在入库中被引用！');
														return;
													}
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
								label:"返回",
								icon:"fa fa-reply",
								className:"btn-primary",
								events:{
									click: function(event){
										 $("#page-container").load(format_url('/wareHouseArea/index'));
									}
								}
							}],
							btns: [{
								id: "edit",
								label:"修改",
								icon: "fa fa-pencil-square-o bigger-130",
								className: "green edit",
								events:{
									click: function(event, nRow, nData){
										var id = nData.id;
										listFormDialog = new A.dialog({
											width:850 ,
											height:471 ,
											title: "货位编辑",
											url:format_url('/wareHouseAreaPosition/getEdit/' + id),
											closed: function(){
												wareHouseAreaPositionDatatables.draw(false);
											}
										}).render();
									}
								}
							}, {
								id:"delete",
								label:"删除",
								icon: "fa fa-trash-o bigger-130",
								className: "red del",
								events:{
									click: function(event, nRow, nData){
										var id = nData.id;
										var url =format_url('/wareHouseAreaPosition/deleteSingle/'+ id);
										A.confirm('您确认删除么？',function(){
											$.ajax({
												url : url,
        										contentType : 'application/json',
        										dataType : 'JSON',
        										type : 'DELETE',
        										success: function(result){
        											if(result.result=="success"){
	        											alert('删除成功');
	        											wareHouseAreaPositionDatatables.draw(false);
        											}
        											if(result.result=="exception"){
	        											alert('删除失败!该货位在入库管理中被引用！');
	        											return;
        											}
        										},
        										error:function(v,n){
        											alert('操作失败');
        										}
											});
										});
									}
								}
						}]
						}
					}).render();
					$('#btnSearch').on('click',function(){
						conditions=[];
						if($('#searchcode').val()){
        					conditions.push({
        						field: 'p.C_CODE',
        						fieldType:'STRING',
        						matchType:'LIKE',
        						value:$('#searchcode').val()
        					});
						}

						if($('#searchname').val()){
        					conditions.push({
        						field: 'p.C_NAME',
        						fieldType:'STRING',
        						matchType:'LIKE',
        						value:$('#searchname').val()
        					});
						}

						wareHouseAreaPositionDatatables.draw();
					});
					$('#btnReset').on('click',function(){
						$('#searchcode').val('')
						$('#searchname').val('')
					});
					
					$('#return').on('click',function(){
						 $("#page-container").load(format_url('/wareHouseArea/index'));
					});
				});
			});
        </script>
    </body>
</html>