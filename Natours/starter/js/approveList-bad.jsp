<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page contentType="text/html;charset=UTF-8" %> 
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="cm" uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html>
  <head>
	<title>我审批过的列表</title>
	<meta http-equiv="X-UA-Compatible" content="IE=8" />
	<link href="<%=request.getContextPath()%>/css/global.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css" />
	
	<link rel="STYLESHEET" type="text/css" href="<%=request.getContextPath()%>/css/knwlg.css" />
    <link type="text/css" rel="stylesheet" href="${basePath }/css/font-awesome.min.css" />
    <link href="<%=request.getContextPath()%>/css/jquery.qtip .min.css" rel="stylesheet" />
    <script src="<%=request.getContextPath()%>/js/jquery-1.7.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/page.js" type="text/javascript" language="javascript"></script>
	<script src="<%=request.getContextPath()%>/js/ContentLoader.js" language="JavaScript"></script>


    <script src="<%=request.getContextPath()%>/js/mloading/mloading.js" type="text/javascript" language="JavaScript"></script> 	
   

	<script  src="<%=request.getContextPath()%>/dhtmlx/dhtmlxcommon.js"></script>
	<script  src="<%=request.getContextPath()%>/dhtmlx/dhtmlxcombo.js"></script>
    

	<script src="<%=request.getContextPath()%>/js/jquery.qtip.min.js"></script>
    
	<link href="<%=request.getContextPath()%>/css/list2.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
    var biztype2 = '<%=request.getAttribute("bizType2") %>';
    function bizTypeCk(){
    	biztype2 = document.getElementById("bizType").value;
    }
    function trunningPage(page){
    	trunPage(document.getElementById('trunning').value);
    }
        
    function trunPage(page){
   		 if(isNaN(page)){
    		return;
    	}
    	
		var bizType = '<%=request.getParameter("bizType")%>';
    	var defType = '<%=request.getParameter("defType")%>';
    	var state = document.getElementById("state").value;
		var bizName = document.getElementById("bizName").value;
		
		var number = "";
        if(document.getElementById("number")){
        	number = document.getElementById("number").value;
        }
		var wfDouble1 = "";
        if(document.getElementById("wfDouble1")){
        	wfDouble1 = document.getElementById("wfDouble1").value;
        }
        var wfDept = "";
        if(document.getElementById("wfDept")){
        	wfDept = document.getElementById("wfDept").value;
        }
        var wfCreater = "";
        if(document.getElementById("wfCreater")){
        	wfCreater = document.getElementById("wfCreater").value;
        }
		var url = "templeMgtAction_ajaxProcessedWFList.action?ad_currentPage="+page+"&time="+new Date().getTime() + "&bizType=" + bizType+"&state="+state+"&bizName="+bizName+"&defType="+defType;
   		url += '&number='+number+'&wfDouble1='+wfDouble1+'&wfDept='+wfDept+'&wfCreater='+wfCreater+ '&biztype2=' + biztype2;
		var cc = new ContentLoader(url, function(){		
			document.getElementById('dataList').innerHTML = req.responseText;
			setTableStyle();
		},"GET",true);
		cc.sendRequest();
    }

	function setTableStyle(){
       	
       	$("#demo1 span[title], #demo1 img[alt]").qtip();
     	$("#demo2 span[title], #demo2 img[alt]").qtip();
     	$("#demo3 span[title], #demo3 img[alt]").qtip();
   	}
   
    function trToDo(bizType,bizGuid,versionId,state,bizInt3){
    	var actionName = "viewWFInstance";
    	var isAttach = '<%=request.getParameter("attach")%>';
 		var attachstr = "";
 		if (isAttach == 1)
 	 		attachstr = "&attach=1"; 		
 		
 		 /* 	if ((bizType >=1101 && bizType<=1117)|| bizType==1119)
 	    		actionName = "viewWFInstance_GW";
 	   	if (bizType==1901||bizType==1401||bizType==1902 || bizType==1204 ||bizType==11114)
 	    		actionName = "viewWFInstance_GW"; */
 	    	
 			var urlStr="<%=request.getContextPath()%>/templeMgtAction_" + actionName + ".action?bizType="+bizType+"&bizGuid="+bizGuid
 				+"&versionId="+versionId+attachstr+"&state="+bizInt3;
 	    	//show_Win(850,500,urlStr,'查看');
 	    	$.get("/background/officeMgt_changeMessState.action?objectId="+bizGuid,
                                    function (result) {
								window.location.href = urlStr;
                                    });
     }
	 
    function queryP(){
		var bizType = '<%=request.getParameter("bizType")%>';
    	var state = document.getElementById("state").value;
		var bizName = document.getElementById("bizName").value;
		var number = "";
        if(document.getElementById("number")){
        	number = document.getElementById("number").value;
        }
		var defType = '<%=request.getParameter("defType")%>';
		var wfDouble1 = "";
        if(document.getElementById("wfDouble1")){
        	wfDouble1 = document.getElementById("wfDouble1").value;
        }
		var wfDept = document.getElementById("wfDept").value;
		var wfCreater = document.getElementById("wfCreater").value;
// 		if(bizType != '-1'){
// 			bizType += "A";
// 		}
		 window.location.href='templeMgtAction_processedWFList.action?bizType='+bizType+'&state='+state+'&bizName='+bizName+'&number='+number+
				'&defType='+defType+'&wfDouble1='+wfDouble1+'&wfDept='+wfDept+'&wfCreater='+wfCreater + '&biztype2=' + biztype2;;
    }
    
    function queryP1(){
    	event = event || window.event;
    	if (event.keyCode == 13) {
    		queryP();
    	}
    	return;
    }
    
    window.onload = function(){
    	if(document.getElementById("wfDouble1")){
    	var wfDouble1 = document.getElementById("wfDouble1");
    	if(wfDouble1.value == 0){
    		wfDouble1.value = "";
    	}
    	}
    	
    	$("#demo1 span[title], #demo1 img[alt]").qtip();
     	$("#demo2 span[title], #demo2 img[alt]").qtip();
     	$("#demo3 span[title], #demo3 img[alt]").qtip();
    };
    
    
    </script>
    <style type="text/css">
    	table td{
    			padding-right: 5px;
    	}
    	.search-title{width: 66px;display: inline-block;height: 30px;line-height: 30px;text-align: right;}
    	.cxbg_text{margin-bottom: 5px;}
    	select.cxbg_text{margin-left: -3px;width: 172px;}
    	.search-model{width: auto;height: 34px;float: left;}
    </style>
    
    
  </head>
  
  <body style="font-size: 14px">
    <div class="zidaoh">
		<cm:navigation funcCode='<%=request.getParameter("funcCode") %>'/>
	</div>
   <div class="bigbox">
    <table border="0" cellspacing="4" cellpadding="0" class="main_content">
 		<tr>
 			<td class="red_right" valign="top">
	 			<div style="height:65px; margin:5px auto 10px auto;">
	 			 	<div class="search-model"><span class="search-title">名称：</span><input type="text" name="bizName" class="cxbg_text" id="bizName" value="${bizName }" onkeydown="if(event.keyCode==13){queryP();}"/></div>
	 			 	<div class="search-model"><span class="search-title">审批状态：</span><c:if test="${bizType !='1201' and bizType !='1115'}">  
                                <select name="state" class="cxbg_text" id="state" onkeydown="if(event.keyCode==13){queryP();}">   
                                   
                                        <option value="-1"  <c:if test="${state =='-1' }"> selected="selected" </c:if> >
                                            --请选择--
                                        </option>
                                        <option value="1" <c:if test="${state == '1' }">selected="selected"</c:if> >
                                           	 未提交
                                        </option>
                                        <option value="2"  <c:if test="${state == '2' }">selected="selected"</c:if> >
                                           	 审批中
                                        </option>
                                        <option value="3" <c:if test="${state == '3' }">selected="selected"</c:if>>
                                            	已通过
                                        </option>
                                        <option value="4" <c:if test="${state == '4' }">selected="selected"</c:if>>
                                            	已退回
                                        </option>
                                 
                                </select>
                            </c:if>
                         </div>
                            <input type="hidden" id="bizType2" value="${bizType2}"/>
	 			 	<div class="search-model"><span class="search-title">业务类别：</span> <select name="state" class="cxbg_text" id="bizType" onclick="bizTypeCk()" onkeydown="if(event.keyCode==13){queryP();}">
							<option value="-1"
								<c:if test="${state =='-1' }"> selected="selected" </c:if>>
								--所有类别--</option>
							<c:forEach var="item" items="${biztypelist}" varStatus="status">
							<option value="${item.codevalue}" <c:if test="${bizType2 == item.codevalue }">selected="selected"</c:if>>${item.cname}</option>
							</c:forEach>
							</select>
                            <c:if test="${bizType =='1201' or bizType =='1115'}">
                            	<select name="state" class="cxbg_text" id="state" onkeydown="if(event.keyCode==13){queryP();}">
                                    <c:if test="${state =='-1' }">
                                        <option value="-1" <c:if test="${state =='-1' }"> selected="selected"</c:if>>
                                            --请选择--
                                        </option>
                                        <option value="1" <c:if test="${state =='1' }"> selected="selected"</c:if>>
                                            	未提交
                                        </option>
                                        <option value="2" <c:if test="${state =='2' }"> selected="selected"</c:if>>
                                            	审批中
                                        </option>
                                        <option value="3" <c:if test="${state =='3' }"> selected="selected"</c:if>>
                                           	 已通过
                                        </option>
                                        <option value="4" <c:if test="${state =='4' }"> selected="selected"</c:if>>
                                            	已退回
                                        </option>
                                        <option value="8" <c:if test="${state =='8' }"> selected="selected"</c:if>>
                                            	已盖章
                                        </option>
                                    </c:if>
                                    
                                </select>
                         </c:if>
                         </div>
        <c:if test="${isCode == 1}">                
                        <div class="search-model"><span class="search-title"> 编号：</span><input type="text" name="number" class="cxbg_text" id="number" value="${wfCode}" onkeydown="if(event.keyCode==13){queryP();}"/></div>
	 	</c:if> 
	 	<c:if test="${isDouble == 1}">
	 	   <div class="search-model"><span class="search-title">金额：</span><input type="text" name="wfDouble1" class="cxbg_text" id="wfDouble1" value="${wfDouble1}" onkeyup="value=value.replace(/[^\d.]/g,'')" onkeydown="if(event.keyCode==13){queryP();}"/></div>
       	  </c:if>   
       	     <div class="search-model"><span class="search-title">部门：</span><input type="text" name="wfDept" class="cxbg_text" id="wfDept" value="${wfDept}" onkeydown="if(event.keyCode==13){queryP();}"/></div>
       	      <div class="search-model"><span class="search-title">提交人：</span><input type="text" name="wfCreater" class="cxbg_text" id="wfCreater" value="${wfCreater}" onkeydown="if(event.keyCode==13){queryP();}"/></div>
	 			 	 <button type="button" onclick="queryP()" class="chaxunbtn" style="margin-left: 66px;float: left;" onkeyup ="queryP1(this)"><i class="icon-search icon-large" style="padding-right:5px;"></i>查询</button>
	 			 	  <c:if test="${batchsWitch == 'true'}">
	   				 	 <input type="button" id="batch"  class="chaxunbtn" value="批量打印"/>
 	    			 </c:if>
	 			 	 <div style="clear: both;"></div>
	 			</div>
	 			<table border="0" cellspacing="0" cellpadding="0" class="biaokua" >
					<tr>
						<td id="dataList"> 
     						<%@include file="ajaxApprovedList.jsp"%>
						</td>
					</tr>
	 			</table>
 			</td>
 		</tr>
     </table>
     </div>
  </body>
</html>
