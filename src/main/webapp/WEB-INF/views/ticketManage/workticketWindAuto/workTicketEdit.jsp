<%@ page language="java" contentType="text/html; charset=utf-8"  
    pageEncoding="utf-8"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html lang="zh">
	<head>
    	<meta charset="UTF-8">
    	<%@ include file="/WEB-INF/views/common/meta.jsp" %> 
    	<style type="text/css">
    		.tab-content-own{
    		border:1px solid #C5D0DC;
    		padding:16px 12px 50px;
    		position:relative;
    		}
    	</style>
    </head>
	<body>
		 <div class="breadcrumbs ace-save-state" id="breadcrumbs">
				<ul class="breadcrumb">
					<li>
						<i class="ace-icon fa fa-home home-icon"></i>
						<a href="javascript:void(0);" onclick="firstPage()">首页</a>
					</li>
						<li class="active">两票管理</li>
					<li class="active">风力自控工作票</li>
					<li class="active">修改</li>
				</ul>
		</div>
		
		<div class="col-md-12" >
		
		<div class="page-content">
		<div class="tabbable" style="margin-top: 20px;">
		 		<ul class="nav nav-tabs">
		 			<li class="active">
			 			<a id="workLiEdit" data-toggle="tab" href="#workitemEdit" aria-expanded="true">
							<i class="green ace-icon fa fa-home bigger-120"></i>
							票据信息
						</a>
		 			</li>
		 			<li>
			 			<a id="workcardLiEdit" data-toggle="tab" href="#workcarditemEdit" aria-expanded="true">
							<i class="green ace-icon fa fa-list bigger-120"></i>
							安全风险控制卡
						</a>
		 			</li>
		 		</ul>
		 		<div style="float:right; margin-top:-35px;margin-right:55px;">
					<button id="btnBack" class="btn btn-xs btn-primary">
						<i class="fa fa-reply"></i>
						返回
					</button>
				</div>	
				<div class="tab-content-own">
				<div id="workitemEdit" class="tab-pane fade active in">
				
		        <form class="form-horizontal" role="form" style="margin-right:100px;" id="workTicketFormEdit">
		        				<input type="hidden" id="id" name="id" value="${workTicketEntity.id}" />
		        				<input type="hidden" id="remarkGuarderNameChuan" name="remarkGuarderId"/>
								<input type="hidden" id="remarkResponsibleNameChuan" name="remarkResponsibleName"/>
								<input type="hidden" id="remarkOtherChuan" name="remarkOther"/>
								<input type="hidden" id="electricId" name="electricId"/>
								
								<input type="hidden" id="oneTotal"/>
								<input type="hidden" id="twoTotal"/>
								<input type="hidden" id="threeTotal"/>
								<div class="form-group">
									<label class="col-md-2 control-label no-padding-right">编码</label>
									<div class="col-md-4">
											<input class="col-md-12" id="code" name="code" type="text" readonly="readonly" placeholder="" maxlength="64" value="${workTicketEntity.code}">
								</div>
								<label class="col-md-2 control-label no-padding-right"><span style="color:red;">*</span>单位名称</label>
								<div class="col-md-4">
										<input  id="unitNameIdEdit"  type="hidden" value="${workTicketEntity.unitNameId}" class="col-md-12">
										<input class="col-md-12" id="unitNameId" type="hidden" readonly="readonly" name="unitNameId" value="${userEntity.unitId}"></input>
										<input class="col-md-12" id="unitName" type="text" readonly="readonly"  value="${userEntity.unitName}"></input>
								</div>
							</div>
								<div class="form-group">
									<label class="col-md-2 control-label no-padding-right"><span style="color:red;">*</span>班组</label>
									<div class="col-md-4">
										<input  id="groupIdEdit"  type="hidden" value="${workTicketEntity.groupId}" class="col-md-12">
										<select class="col-md-12 chosen-select" id="groupId" name="groupId"></select>
								</div>
								<label class="col-md-2 control-label no-padding-right"><span style="color:red;">*</span>工作负责人</label>
								<div class="col-md-4">
										<input class="col-md-12" id="guarderName" type="text" readonly="readonly" name="guarderName"  value="${workTicketEntity.guarderName}"></input>
								</div>
							</div>
							
								<div class="form-group">
									<label class="col-md-2 control-label no-padding-right"><span style="color:red;">*</span>工作班成员</label>
									<div class="col-md-10">
										<textarea id="workClassMember" name="workClassMember" placeholder="" style="height:80px; resize:none;" class="col-md-12" maxlength="128" onblur="gotoFindClassMember();">${workTicketEntity.workClassMember}</textarea>
									</div>
								</div>
								
								<div class="form-group">
								<label class="col-md-2 control-label no-padding-right"><span style="color:red;">*</span>工作班人数（包括工作负责人）</label>
								<div class="col-md-4">
											<input class="col-md-12" id="workClassPeople" name="workClassPeople" type="text" readonly="readonly" maxlength="20" value="${workTicketEntity.workClassPeople}">
								</div>
								</div>
								
								
								<div class="form-group">
									<label class="col-md-2 control-label no-padding-right"><span style="color:red;">*</span>工作内容</label>
									<div class="col-md-10">
										<textarea id="content" name="content" placeholder="" style="height:80px; resize:none;" class="col-md-12" maxlength="128">${workTicketEntity.content}</textarea>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-2 control-label no-padding-right"><span style="color:red;">*</span>工作地点</label>
									<div class="col-md-10">
										<textarea id="address" name="address" placeholder="" style="height:80px; resize:none;" class="col-md-12" maxlength="128">${workTicketEntity.address}</textarea>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-2 control-label no-padding-right"><span style="color:red;">*</span>设备编号</label>
									<div class="col-md-4">
										<div id="equipmentCodeWorkOneDiv">
										</div>								</div>
								<label class="col-md-2 control-label no-padding-right"><span style="color:red;">*</span>设备名称</label>
								<div class="col-md-4">
											<input class="col-md-12" id="equipmentName" readOnly name="equipmentName" type="text" placeholder="" maxlength="64" value="${workTicketEntity.equipmentName}">
								</div>
							</div>
								<div class="form-group">
									<label class="col-md-2 control-label no-padding-right"><span style="color:red;">*</span>计划开始时间</label>
									<div class="col-md-4">
										<div id="plandateStartDiv"></div>
								</div>
								<label class="col-md-2 control-label no-padding-right"><span style="color:red;">*</span>计划终了时间</label>
								<div class="col-md-4">
										<div id="plandateEndDiv"></div>
								</div>
							</div>
 							<div class="form-group">
								<label class="col-md-2 control-label no-padding-right">缺陷单编号</label>
								<div class="col-md-4">
								<div id="flawCodeDiv"></div>
								</div>
							</div> 
				</form>
					<h5 class="table-title header smaller blue">必须采取的安全措施</h5>
    				<div class="widget-main no-padding">
			 			<table id="workSafe-table" class="table table-striped table-bordered table-hover" style="width:100%;">
									<thead>
										<tr>
											<th style="display:none;">主键</th>
			                                <th>序号</th>
			                                <th>退出一下保护、联锁</th>
			                                <th>执行情况</th>
		                                    <th>操作</th>
		                                </tr>
		                            </thead>
		                </table>
					</div>
    				<h5 class="table-title header smaller blue">退出以下控制、检测系统</h5>
    				<div class="widget-main no-padding">
			 			<table id="workSafe-table-Two" class="table table-striped table-bordered table-hover" style="width:100%;">
									<thead>
										<tr>
											<th style="display:none;">主键</th>
			                                <th>序号</th>
			                                <th>退出以下控制、检测系统</th>
			                                <th>执行情况</th>
		                                    <th>操作</th>
		                                </tr>
		                            </thead>
		                </table>
					</div>
                <h5 class="table-title header smaller blue" style="margin-bottom:0px;">备注：</h5>
				<form class="form-horizontal"  style="margin-right:100px;margin-top:70px" id="bzform">
						<div id="workitemBz" class="tab-pane fade active in" style="margin-top: 20px;">	
										<div class="form-group">
											<label class="col-md-2 control-label no-padding-right">指定专责监护人</label>
											<div class="col-md-4">
														<select class="col-md-12 chosen-select" id="remarkGuarderId" name="remarkGuarderId" style="width: 200px;"></select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-md-2 control-label no-padding-right">负责监护(地点及具体工作)</label>
											<div class="col-md-10">
													<textarea id="remarkResponsibleName"    style="height:80px; resize:none;" class="col-md-12" maxlength="128">${WorkTicketWindEntity.remarkResponsibleName}</textarea>
											</div>
										</div>
										<div class="form-group">
											<label class="col-md-2 control-label no-padding-right">其他事项（备注）</label>
											<div class="col-md-10">
													<textarea id="remarkOther"     style="height:80px; resize:none;" class="col-md-12" maxlength="128">${WorkTicketWindEntity.remarkOther}</textarea>
											</div>
										</div>
						</div>
					</form>
                
	 			
		 		<div style="margin-right:100px;margin-top: 20px;">
	        		<button class="btn btn-xs btn-danger pull-right" data-dismiss="modal" onclick="gotoQx();">
	        			<i class="ace-icon fa fa-times"></i>
	        			取消
	        		</button>
	        		<button id="editBtn" class="btn btn-xs btn-success pull-right"  style="margin-right:15px;">
	        			<i class="ace-icon fa fa-floppy-o"></i>
	        			保存
	        		</button>
	        	</div>
				</div>
			<div id="workcarditemEdit" class="tab-pane fade active in">
				<form class="form-horizontal" role="form" style="margin-right:100px;" id="workTicketFormCardEdit">
						<input name="id" type="hidden" value="${workControlCardEntity.id}"/>
						<input name="workticketId" type="hidden" value="${workTicketEntity.id}"/>
								<div class="form-group">
									<label class="col-md-2 control-label no-padding-right">工作负责人</label>
									<div class="col-md-4">
											<input class="col-md-12" id="guarderName" type="text" readonly="readonly"  value="${workTicketEntity.guarderName}"></input>
									</div>
									<label class="col-md-2 control-label no-padding-right">工作票编号</label>
									<div class="col-md-4">
											<input class="col-md-12" id="code"  type="text" readonly="readonly" placeholder="" maxlength="64" value="${workTicketEntity.code}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label no-padding-right">工作内容</label>
									<div class="col-md-10">
										<textarea id="content"  readonly="readonly"  placeholder="" style="height:80px; resize:none;" class="col-md-12" maxlength="128">${workTicketEntity.content}</textarea>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-2 control-label no-padding-right">作业类别</label>
									<div class="col-md-10">
										(1)
										<input name="cardSort" id="cardSort"  type="hidden"></input>
										<c:forEach items="${cardSortList}" var="cardList" varStatus="vs">
										<label class="inline" style="width: 10%">
											${cardList.name}<input id="cardSort${cardList.code}" name="cardSort1" type="checkbox"  value="${cardList.code}"></input>
										</label>
										</c:forEach>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label no-padding-right"></label>
									<div class="col-md-10">
										(2)
										<input name="cardSortTwo" id="cardSortTwo"  type="hidden"></input>
										<c:forEach items="${cardSortListTwo}" var="cardListTwo" varStatus="vs">
										<label class="inline" style="width: 10%">
											${cardListTwo.name}<input id="cardSortTwo${cardListTwo.code}" name="cardSortTwo1" type="checkbox"  value="${cardListTwo.code}"></input>
										</label>
										</c:forEach>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label no-padding-right"></label>
									<div class="col-md-10">
										(3)
										<input name="cardSortThree" id="cardSortThree"  type="hidden"></input>
										<c:forEach items="${cardSortListThree}" var="cardListThree" varStatus="vs">
										<label class="inline" style="width: 10%">
											${cardListThree.name}<input id="cardSortThree${cardListThree.code}" name="cardSortThree1" type="checkbox"  value="${cardListThree.code}"></input>
										</label>
										</c:forEach>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label no-padding-right"></label>
									<div class="col-md-10">
										(4)
										<input name="cardSortFour" id="cardSortFour"  type="hidden"></input>
										<c:forEach items="${cardSortListFour}" var="cardListFour" varStatus="vs">
										<label class="inline" style="width: 10%">
											${cardListFour.name}<input id="cardSortFour${cardListFour.code}" name="cardSortFour1" type="checkbox"  value="${cardListFour.code}"></input>
										</label>
										</c:forEach>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label no-padding-right">补充说明</label>
									<div class="col-md-10">
										<textarea id="cardSortDescription"   name="cardSortDescription" placeholder="" style="height:80px; resize:none;" class="col-md-12" maxlength="128">${workControlCardEntity.cardSortDescription}</textarea>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-2 control-label no-padding-right">工作班成员签名</label>
									<div class="col-md-10">
										<textarea id="workClassMember"  readonly="readonly"  style="height:80px; resize:none;" class="col-md-12" maxlength="128">${workTicketEntity.workClassMember}</textarea>
									</div>
								</div>
    		</form>
				<h5 class="table-title header smaller blue">作业风险分析与主要预控措施</h5>
				    		<div class="widget-main no-padding">
				
	 			<table id="controlCardRisk-table" class="table table-striped table-bordered table-hover" style="width:100%;">
							<thead>
								<tr>
									<th style="display:none;">主键</th>
	                                <th>危险点分析</th>
	                                <th>主要控制措施</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                 </table>
	 		</div>
    		<div style="margin-right:100px;margin-top: 20px;">
    			<button class="btn btn-xs btn-danger pull-right" data-dismiss="modal" onclick="gotoQx();">
    				<i class="ace-icon fa fa-times"></i>
    				取消
    			</button>
    			<button id="saveBtnCardTwo" class="btn btn-xs btn-success pull-right"  style="margin-right:15px;">
    				<i class="ace-icon fa fa-floppy-o"></i>
    				保存
    			</button>
    		</div>
			</div>
			
			
			</div>
			
			
			</div>
			</div>
        </div>
		<script type="text/javascript">
			var controlCardRiskDatatables="";
			var userUnitRels = ${userUnitRels};
			//初始数据备份
			var processUserUnitRels = ${userUnitRels};

			jQuery(function($) {
				seajs.use(['combobox','combotree','my97datepicker','selectbox'], function(A){
					var safeType=${safeType};
					$("#workitemEdit").show();
					$("#workcarditemEdit").hide();
					$("#workcardLiEdit").on('click', function(){
						$("#workcarditemEdit").show();
						$("#workitemEdit").hide();
						controlCardRiskDatatables.draw(true);
					});
					$("#workLiEdit").on('click', function(){
						$("#workcarditemEdit").hide();
						$("#workitemEdit").show();
					});
					var selecttreeDh=new A.selectbox({
						id: 'equipmentWorkOneCode',
						name:'equipmentCode',
						title:'设备台账',
						url:'/equipLedger/selectEquipLedger',
						render:'#equipmentCodeWorkOneDiv',
						width:'1100',//弹出窗体的宽度  可以不写这行
						hight:'780',//弹出窗体的高度  可以不写这行
						callback: function(data){
							if(data&&data[0]){
								selecttreeDh.setValue(data[0].code,data[0].code);
								$("#equipmentName").val(data[0].name);
							};
						}
					}).render();
					selecttreeDh.setValue('${workTicketEntity.equipmentCode}');
					
					
					var qxdcodebox=new A.selectbox({
						id: 'flawCodeIdEdit',
						name:'flawCode',
						title:'缺陷单',
						url:'/workTicketWindAuto/defectList',
						render:'#flawCodeDiv',
						width:'1100',//弹出窗体的宽度  可以不写这行
						hight:'720',//弹出窗体的高度  可以不写这行
						callback: function(data){
							$("#flawCode").val(data.code);
						}
					}).render();
					$("#flawCode").val('${workTicketEntity.flawCode}');//回显示
					
					
					
					
					//combobx组件
                	var groupIdComboboxEdit = new A.combobox({
                		render: "#groupId",
                		//返回数据待后台返回TODO
                		datasource:${groupIdCombobox},
                		multiple:false,
                		allowBlank: true,
                		options:{
                			"disable_search_threshold":10
                		}
                	}).render();
                	groupIdComboboxEdit.setValue($("#groupIdEdit").val());
					
					//日期组件
					var plandateStartDatePickerEdit = new A.my97datepicker({
						id: "plandateStartId",
						name: "plandateStart",
						render: "#plandateStartDiv",
						options : {
								isShowWeek : false,
								skin : 'ext',
								maxDate: "",
								minDate: "",
								dateFmt: "yyyy-MM-dd HH:mm"
						}
					}).render();
					plandateStartDatePickerEdit.setValue('<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${workTicketEntity.plandateStart}" type="both"/>');
					//日期组件
					var plandateEndDatePickerEdit = new A.my97datepicker({
						id: "plandateEndId",
						name: "plandateEnd",
						render: "#plandateEndDiv",
						options : {
								isShowWeek : false,
								skin : 'ext',
								maxDate: "",
								minDate: "#F{$dp.$D(\\'plandateStartId\\')}",
								dateFmt: "yyyy-MM-dd HH:mm"
						}
					}).render();
					plandateEndDatePickerEdit.setValue('<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${workTicketEntity.plandateEnd}" type="both"/>');
					
					
					//指定专责监护人 组件
					var userListBoxCombobox = new A.combobox({
						render: "#remarkGuarderId",
						//返回数据待后台返回TODO
						datasource:${userListBox},
						//multiple为true时select可以多选
						multiple:false,
						//allowBlank为false表示不允许为空
						allowBlank: true,
						options:{
							"disable_search_threshold":10
						}
					}).render();
					userListBoxCombobox.setValue(${WorkTicketWindEntity.remarkGuarderId});
					
					$('#workTicketFormEdit').validate({
						debug:true,
						rules: {
							unitNameId:{required:true,maxlength:64},
							groupId:{required:true,maxlength:20},
							guarderName:{required:true,maxlength:64},
							workClassMember:{required:true,maxlength:128},
							workClassPeople:{required:true,maxlength:20},
							content:{required:true,maxlength:128},
							address:{required:true,maxlength:128},
// 							equipmentCode:{required:true,maxlength:64},
// 							equipmentName:{required:true,maxlength:64},
							plandateStart:{required:true,maxlength:20},
							plandateEnd:{required:true,maxlength:20}
	/* 						,
							flawCode:{required:true,maxlength:64} */
							},
						submitHandler: function (form) {
							var size1 = workSafeOneDatatables.getDatas().length;
							if(size1==0){
								alert("安全措施，未填写完整!");
								return ;
							}
							var size2 = workSafeTwoDatatables.getDatas().length;
							if(size2==0){
								alert("安全措施，未填写完整!");
								return ;
							}
							var checksum=$('input[type=checkbox]:checked').length;
							if(checksum==""){
								alert("安全风险控制卡，未填写完整");
								return;
							}	
							var size = controlCardRiskDatatables.getDatas().length;
							if(size==0){
								alert("安全风险控制卡，未填写完整");
								return ;
							}
							var id = ${workTicketEntity.id};
							//修改按钮
							var url = format_url("/workTicketWindAuto/update/"+id);
							//serializeObject()用于Jquery将form转换成用于ajax参数的Javascript Object
							var obj = $("#workTicketFormEdit").serializeObject();
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
										url : format_url("/workTicketWindAuto/index")
									});
								},
								error:function(v,n){
									alert('操作失败');
								}
							});
						}
					});
					$("#editBtn").on("click", function(){
						//保存的时候把备注的字段赋值
						$("#remarkGuarderNameChuan").val($("#remarkGuarderId").val());
						$("#remarkResponsibleNameChuan").val($("#remarkResponsibleName").val());
						$("#remarkOtherChuan").val($("#remarkOther").val());
						$("#electricId").val(${WorkTicketWindEntity.id});
    					$("#workTicketFormEdit").submit();
    				});
					
					
					$('#btnBack').on('click',function(){
						A.loadPage({
							render : '#page-container',
							url : format_url("/workTicketWindAuto/index")
						});
					});
					
					
//下面是安全措施的列表 1
					var workid='${workTicketEntity.id}';
					var workSafeOneDatatables="";
					var conditionsOne=[];
					workSafeOneDatatables = new A.datatables({
						render: '#workSafe-table',
						options: {
					        "ajax": {
					            "url": format_url("/workSafe/search"),
					            "contentType": "application/json",
					            "type": "POST",
					            "dataType": "JSON",
					            "data": function (d) {
					            	conditionsOne.push({
		            					field: 'C_SAFE_TYPE',
		            					fieldType:'INT',
		            					matchType:'EQ',
		            					value:1
		            				});
					            	conditionsOne.push({
		            					field: 'C_WORKTICKET_ID',
		            					fieldType:'LONG',
		            					matchType:'EQ',
		            					value:'${workTicketEntity.id}'
		            				});
					            	d.conditions = conditionsOne;
					                return JSON.stringify(d);
					              }
					        },
					        multiple : true,
							ordering: true,
							checked: false,
							optWidth: 80,
							aLengthMenu: [5],
							columns: [{data:"id", visible:false,orderable:false}, 
							          {data: "orderSeq",width: "10%",orderable: true},
							          {data: "signerContent",width: "60%",orderable: true},
							          {data: "executeSituation",width: "20%",orderable: true}
							          ],
							fnInfoCallback: function (oSettings, iStart, iEnd, iMax, iTotal, sPre) {
									  $(".dataTables_info").html(sPre);//下脚标
											$("#oneTotal").val(iTotal);
										},
							toolbars: [{
        						label:"新增",
        						icon:"glyphicon glyphicon-plus",
        						className:"btn-success",
        						events:{
            						click:function(event){
            							var oneTotal=Number($("#oneTotal").val())+1;
            							workSafeOneDialog = new A.dialog({
                    						width: 800,
                    						height: 300,
                    						title: "安全措施新增",
                    						url:format_url("/workSafe/getAdd?flag="+1+"&workId="+workid+"&total="+oneTotal ),
                    						closed: function(){
                    							workSafeOneDatatables.draw(false);
                    						}	
                    					}).render();
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
										workSafeOneDialog = new A.dialog({
											width: 800,
											height: 300,
											title: "安全措施编辑",
											url:format_url("/workSafe/getEdit/"+ id+"/"+1),
											closed: function(){
												workSafeOneDatatables.draw(false);
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
										var url =format_url('/workSafe/'+ id);
										A.confirm('您确认删除么？',function(){
											$.ajax({
												url : url,
        										contentType : 'application/json',
        										dataType : 'JSON',
        										type : 'DELETE',
        										success: function(result){
        											alert('删除成功');
        											workSafeOneDatatables.draw(false);
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
//下面是安全措施的列表 2
					
					var workSafeTwoDatatables="";
					var conditionsTwo=[];
					workSafeTwoDatatables = new A.datatables({
						render: '#workSafe-table-Two',
						options: {
					        "ajax": {
					            "url": format_url("/workSafe/search"),
					            "contentType": "application/json",
					            "type": "POST",
					            "dataType": "JSON",
					            "data": function (d) {
					            	conditionsTwo.push({
		            					field: 'C_SAFE_TYPE',
		            					fieldType:'INT',
		            					matchType:'EQ',
		            					value:3
		            				});
					            	conditionsTwo.push({
		            					field: 'C_WORKTICKET_ID',
		            					fieldType:'LONG',
		            					matchType:'EQ',
		            					value:'${workTicketEntity.id}'
		            				});
					            	d.conditions = conditionsTwo;
					                return JSON.stringify(d);
					              }
					        },
					        multiple : true,
							ordering: true,
							checked: false,
							optWidth: 80,
							aLengthMenu: [5],
							columns: [{data:"id", visible:false,orderable:false}, 
							          {data: "orderSeq",width: "10%",orderable: true},
							          {data: "signerContent",width: "60%",orderable: true},
							          {data: "executeSituation",width: "20%",orderable: true}
							          ],
							fnInfoCallback: function (oSettings, iStart, iEnd, iMax, iTotal, sPre) {
									  $(".dataTables_info").html(sPre);//下脚标
											$("#oneTotal").val(iTotal);
										},
							toolbars: [{
        						label:"新增",
        						icon:"glyphicon glyphicon-plus",
        						className:"btn-success",
        						events:{
            						click:function(event){
            							var oneTotal=Number($("#oneTotal").val())+1;
            							workSafeOneDialog = new A.dialog({
                    						width: 800,
                    						height: 300,
                    						title: "安全措施新增",
                    						url:format_url("/workSafe/getAdd?flag="+3+"&workId="+workid+"&total="+oneTotal ),
                    						closed: function(){
                    							workSafeTwoDatatables.draw(false);
                    						}	
                    					}).render();
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
										workSafeOneDialog = new A.dialog({
											width: 800,
											height: 300,
											title: "安全措施编辑",
											url:format_url("/workSafe/getEdit/"+ id+"/"+3),
											closed: function(){
												workSafeTwoDatatables.draw(false);
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
										var url =format_url('/workSafe/'+ id);
										A.confirm('您确认删除么？',function(){
											$.ajax({
												url : url,
        										contentType : 'application/json',
        										dataType : 'JSON',
        										type : 'DELETE',
        										success: function(result){
        											alert('删除成功');
        											workSafeTwoDatatables.draw(false);
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
					 //第二个tab
					 $('#workTicketFormCardEdit').validate({
							debug:true,
							rules:  {},
							submitHandler: function (form) {
								var size1 = workSafeOneDatatables.getDatas().length;
								if(size1==0){
									alert("安全措施，未填写完整!");
									return ;
								}
								var size2 = workSafeTwoDatatables.getDatas().length;
								if(size2==0){
									alert("安全措施，未填写完整!");
									return ;
								}
								var checksum=$('input[type=checkbox]:checked').length;
								if(checksum==""){
									alert("安全风险控制卡，未填写完整");
									return;
								}	
								var size = controlCardRiskDatatables.getDatas().length;
								if(size==0){
									alert("安全风险控制卡，未填写完整");
									return ;
								}
								//添加按钮
								var cardId='${workControlCardEntity.id}';
								var url = format_url("/workControlCard/"+cardId);
								//serializeObject()用于Jquery将form转换成用于ajax参数的Javascript Object
								var obj = $("#workTicketFormCardEdit").serializeObject();
								$.ajax({
									url : url,
									contentType : 'application/json',
									dataType : 'JSON',
									data : JSON.stringify(obj),
									cache: false,
									type : 'POST',
									success: function(result){
										alert('修改成功');
										A.loadPage({
											render : '#page-container',
											url : format_url("/workTicketWindAuto/index")
										});
									},
									error:function(v,n){
										alert('添加失败');
									}
								});
							}
						});
						$("#saveBtnCardTwo").on("click", function(){
							var chk_value =[]; 
							$("input[name='cardSort1']:checked").each(function(){
								chk_value.push($(this).val());
							});
							$("#cardSort").val(chk_value);
							
							var chk_valueTwo =[]; 
							$("input[name='cardSortTwo1']:checked").each(function(){
								chk_valueTwo.push($(this).val());
							});
							$("#cardSortTwo").val(chk_valueTwo);
							
							var chk_valueThree =[]; 
							$("input[name='cardSortThree1']:checked").each(function(){
								chk_valueThree.push($(this).val());
							});
							$("#cardSortThree").val(chk_valueThree);
							
							var chk_valueFour =[]; 
							$("input[name='cardSortFour1']:checked").each(function(){
								chk_valueFour.push($(this).val());
							});
							$("#cardSortFour").val(chk_valueFour);
							
							$("#workTicketFormCardEdit").submit();
	    				});
						
						
						
						var conditionsCard=[];
						 controlCardRiskDatatables = new A.datatables({
							render: '#controlCardRisk-table',
							options: {
						        "ajax": {
						            "url": format_url("/controlCardRisk/search"),
						            "contentType": "application/json",
						            "type": "POST",
						            "dataType": "JSON",
						            "data": function (d) {
						            	conditionsCard.push({
			            					field: 'C_CONTROL_ID',
			            					fieldType:'LONG',
			            					matchType:'EQ',
			            					value:'${workControlCardEntity.id}'
			            				});
						            	d.conditions = conditionsCard;
						                return JSON.stringify(d);
						              }
						        },
						        checked: false,
						        multiple : true,
								ordering: true,
								optWidth: 120,
								aLengthMenu: [5],
								columns: [{data:"id", visible:false,orderable:false}, 
								          {data: "dangerPoint",width: "auto",orderable: true},
								          {data: "mainControl",width: "auto",orderable: true}
								          ],
								toolbars: [{
	        						label:"新增",
	        						icon:"glyphicon glyphicon-plus",
	        						className:"btn-success",
	        						events:{
	            						click:function(event){
	            							var cardId='${workControlCardEntity.id}';
	            							workSafeTwoDialog = new A.dialog({
	                    						width: 800,
	                    						height: 350,
	                    						title: "工作票控制卡风险与措施增加",
	                    						url:format_url('/controlCardRisk/getAdd?cardId='+cardId),
	                    						closed: function(){
	                    							controlCardRiskDatatables.draw(false);
	                    						}	
	                    					}).render();
	            						}
	        						}
	        					}
								],
								btns: [{
									id: "edit",
									label:"修改",
									icon: "fa fa-pencil-square-o bigger-130",
									className: "green edit",
									events:{
										click: function(event, nRow, nData){
											var id = nData.id;
											workSafeTwoDialog = new A.dialog({
												width: 800,
												height: 350,
												title: "工作票控制卡风险与措施编辑",
												url:format_url('/controlCardRisk/getEdit/' + id),
												closed: function(){
													controlCardRiskDatatables.draw(false);
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
											var url =format_url('/controlCardRisk/'+ id);
											A.confirm('您确认删除么？',function(){
												$.ajax({
													url : url,
	        										contentType : 'application/json',
	        										dataType : 'JSON',
	        										type : 'DELETE',
	        										success: function(result){
	        											alert('删除成功');
	        											controlCardRiskDatatables.draw(false);
	        										},
	        										error:function(v,n){
	        											alert('操作失败');
	        										}
												});
											});
										}
									}
							}
								]
							}
						}).render();
						 
						//控制回显多选框开始
						var onecheck='${workControlCardEntity.cardSort}';
						var  oneCheck =onecheck.split(",");
						$("input[name='cardSort1']").each(function(){
							if(contains(oneCheck,$(this).val())){
								 $("#cardSort"+$(this).val()).attr("checked",'true');
							}
						});
						var onecheckTwo='${workControlCardEntity.cardSortTwo}';
						var  oneCheckTwo =onecheckTwo.split(",");
						$("input[name='cardSortTwo1']").each(function(){
							if(contains(oneCheckTwo,$(this).val())){
								 $("#cardSortTwo"+$(this).val()).attr("checked",'true');
							}
						});
						
						var onecheckThree='${workControlCardEntity.cardSortThree}';
						var  oneCheckThree =onecheckThree.split(",");
						$("input[name='cardSortThree1']").each(function(){
							if(contains(oneCheckThree,$(this).val())){
								 $("#cardSortThree"+$(this).val()).attr("checked",'true');
							}
						});
						
						var onecheckFour='${workControlCardEntity.cardSortFour}';
						var  oneCheckFour =onecheckFour.split(",");
						$("input[name='cardSortFour1']").each(function(){
							if(contains(oneCheckFour,$(this).val())){
								 $("#cardSortFour"+$(this).val()).attr("checked",'true');
							}
						});
					   //控制回显多选框结束
				});
			});
			
			
			function gotoQx(){
				 $("#page-container").load(format_url('/workTicketWindAuto/index'));
			}
			function gotoFindClassMember(){
				var classMember=$("#workClassMember").val();
				var count=0;
				var date = classMember.split(",");
				for(var i=0;i<date.length;i++){
					if(date[i]!=""){
						count=count+1;
					}
				}
				count=count+1;
				$("#workClassPeople").val(count);
			}
			//判断值是否在数组里的方法zzq
			function contains(arr, obj) {
				  var i = arr.length;
				  while (i--) {
				    if (arr[i] === obj) {
				      return true;
				    }
				  }
				  return false;
			}
        </script> 
    </body> 
</html>