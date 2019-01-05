<%@ page language="java" contentType="text/html; charset=utf-8"  
    pageEncoding="utf-8"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
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
					<li class="active">
						两票管理
					</li>
					<li class="active">电力线路第一种工作票</li>
					<li class="active">查看</li>
				</ul>
		</div>
		
		<div class="col-md-12" >
		
		<div class="page-content">
		<div class="tabbable" style="margin-top: 20px;">
		 		<ul class="nav nav-tabs" id="myTab">
		 			<li class="active">
			 			<a  data-toggle="tab" href="#workPjxxDetail" aria-expanded="true">
							<i class="green ace-icon fa fa-home bigger-120"></i>
							票据信息
						</a>
		 			</li>
<!-- 		 			<li> -->
<!-- 			 			<a  data-toggle="tab" href="#workCardDetail" aria-expanded="false"> -->
<!-- 							<i class="green ace-icon fa fa-list bigger-120"></i> -->
<!-- 							安全风险控制卡 -->
<!-- 						</a> -->
<!-- 		 			</li> -->
<!-- 		 			<li> -->
<!-- 			 			<a  data-toggle="tab" href="#sqsyDetail" aria-expanded="false"> -->
<!-- 							<i class="green ace-icon fa fa-list bigger-120"></i> -->
<!-- 							申请试运 -->
<!-- 						</a> -->
<!-- 		 			</li> -->
<!-- 		 			<li> -->
<!-- 			 			<a  data-toggle="tab" href="#syhfDetail" aria-expanded="false"> -->
<!-- 							<i class="green ace-icon fa fa-list bigger-120"></i> -->
<!-- 							试运恢复 -->
<!-- 						</a> -->
<!-- 		 			</li> -->
<!-- 		 			<c:if test="${workStatus!=1&&workStatus!=8&&workStatus!=21&&todoTaskEntity.procDefId!=null}"> -->
<!-- 		 			<li> -->
<!-- 			 			<a  data-toggle="tab" href="#splctDetail" aria-expanded="false"> -->
<!-- 							<i class="green ace-icon fa fa-list bigger-120"></i> -->
<!-- 							审批流程图 -->
<!-- 						</a> -->
<!-- 		 			</li> -->
<!-- 		 			<li> -->
<!-- 			 			<a  data-toggle="tab" href="#spteptDetail" aria-expanded="false"> -->
<!-- 							<i class="green ace-icon fa fa-list bigger-120"></i> -->
<!-- 							审批流程步骤 -->
<!-- 						</a> -->
<!-- 		 			</li> -->
<!-- 		 			</c:if> -->
		 		</ul>
		 		<div style="float:right; margin-top:-35px;margin-right:55px;">
					<button id="btnBack" class="btn btn-xs btn-primary">
						<i class="fa fa-reply"></i>
						返回
					</button>
				</div>	
				<div class="tab-content">
				
				<%-- <input id="a" value="${todoTaskEntity.procDefId}" type="text"/>
				<input id="b" value="${todoTaskEntity.procInstId}" type="text"/> --%>
				
					<input id="workTicketId" value="${workTicketId}" type="hidden"/>
					<div id="workPjxxDetail" class="tab-pane fade active in" style="overflow-x:hidden;overflow-y: auto;height: 700px">
			 		</div>
					<!-- 风险卡开始 -->
					<div id="workCardDetail" class="tab-pane fade">
					</div>
					<!-- 风险卡结束 -->
					<div id="sqsyDetail" class="tab-pane fade" style="overflow-x:hidden;overflow-y: auto;height: 650px">
					</div>
					<div id="syhfDetail" class="tab-pane fade">
					</div>
					
					
					<div id="splctDetail" class="tab-pane fade">
						<iframe id ="iframeimage" src="" style="width:100%;height:1100px"; frameborder="0" scrolling="no" ></iframe>
		 			</div>
					<div id="spteptDetail" class="tab-pane fade">
					</div>
					
				</div>
			
			</div><!-- tabbable -->
			</div><!-- page-content -->
        </div><!-- col-md-12 -->
        
        <!-- <div class="col-md-12">
    		<div style="margin-right:100px;margin-top: 20px;"  >
        		<button class="btn btn-xs btn-danger pull-right" data-dismiss="modal" onclick="gotoQx();">
        			<i class="ace-icon fa fa-times"></i>
        			关闭
        		</button>
        	</div>
        </div> -->
		<script type="text/javascript">
			jQuery(function($) {
				seajs.use(['combobox','combotree','my97datepicker'], function(A){
					var  workTicketId=$("#workTicketId").val();
					A.loadPage({
								render: "#workPjxxDetail",
								url: format_url("/workTicketLine/workPjxxDetail/"+workTicketId)
					});
					$('#myTab a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
 						//表单详细
						if($(e.target).attr('href') == "#workPjxxDetail"){
							A.loadPage({
								render: "#workPjxxDetail",
								url: format_url("/workTicketLine/workPjxxDetail/"+workTicketId)
							});
						}
 						//2
						if($(e.target).attr('href') == "#workCardDetail"){
							A.loadPage({
								render: "#workCardDetail",
								url: format_url("/workTicketLine/workCardDetail/"+workTicketId)
							});
						}
 						//3
						if($(e.target).attr('href') == "#sqsyDetail"){
							A.loadPage({
								render: "#sqsyDetail",
								url: format_url("/workLine/sqsyDetail/"+workTicketId)
							});
						}
 						//4
						if($(e.target).attr('href') == "#syhfDetail"){
							A.loadPage({
								render: "#syhfDetail",
								url: format_url("/workLine/syhfDetail/"+workTicketId)
							});
						}
						//流程图
						if($(e.target).attr('href') == "#splctDetail"){
							var url=format_url("/act/diagram-viewer/index.html?processDefinitionId=${todoTaskEntity.procDefId}&processInstanceId=${todoTaskEntity.procInstId}");
							$("#iframeimage").attr("src",url);
						} 
						//流程详细
						if($(e.target).attr('href') == "#spteptDetail"){
							A.loadPage({
								render : spteptDetail,
								url : format_url("/todoTask/processDetail/"+${todoTaskEntity.id_}+"/"+${todoTaskEntity.procInstId})
							});
						} 
 					 });
					
					
					$('#btnBack').on('click',function(){
						var rlId = "${rlId}";
						if(rlId==""){
							A.loadPage({
								render : '#page-container',
								url : format_url("/workTicketLine/index")
							});
						}else {
							A.loadPage({
								render : '#page-container',
								url : format_url("/runLog/info/"+rlId)
							});	
						}
						
					});
				});
			});
			function gotoQx(){
				  window.scrollTo(0,0);
				 $("#page-container").load(format_url('/workTicketLine/index'));
			}
        </script>
    </body>
</html>