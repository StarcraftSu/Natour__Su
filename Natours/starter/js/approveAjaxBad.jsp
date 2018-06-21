<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="cm" uri="/WEB-INF/tld/common.tld"%>
<%@ page language="java" import="conf.hbm.WfInstance" %>
<%@ page language="java" import="conf.hbm.WfCurrOperater" %>
<%@ page language="java" import="com.ccidit.features.templeMgt.action.WfListWrapper" %>

<%@ page language="java" import="java.lang.reflect.Method" %>
<%@ page language="java" import="java.lang.reflect.Method" %>
<%@ page language="java" import="java.lang.Class"%>
<%@ page language="java" import="com.ccidit.core.util.StringUtils"%>
<script type="text/javascript" src="/fineServer/ReportServer?op=emb&resource=finereport.js"></script> 
<%@ page contentType="text/html;charset=UTF-8" %> 
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" type="text/css" href="/fineServer/ReportServer?op=emb&resource=finereport.css"/>    
 <script>
    $(function() {
    	
     

      // ajax 获取内容
      $("#demo4 a[rel]").each(function() {
        $(this).qtip({
          content: {
            text: "加载中...",
            ajax: {
              url: $(this).attr("rel")
            }
          }
        });
      });

      
    });
    
    
    //
     $("#batch").live("click",function(){
			var str=[];
			$('.biaokua2 input[name="moDel"]:checked').each(function(){
				str.push($(this).val().split(","));	
			}); 
			var defType ='<%=request.getParameter("defType")%>';
			var data = convertToJson(str);
 			var jsonString = JSON.stringify(data);
			//console.log(data);
			//定义帆软的路径http://oa.ccidgroup.com/fineServer/ReportServer
			$.post("/budgetMgtAction_batchPrinting.action?defType="+defType+"&dav="+jsonString, function(data) {
			 var list=eval(data.list);
			 console.log(data.list);  
		 	for(var i=0; i<list.length; i++){
	  			id=list[i].id;
		  		console.log(list[i].name);
		  		 para={  
					id:list[i].id  
					}; 
		  		
			    var config = {      
			                     //url : "http://oa.ccidgroup.com/fineServer/ReportServer?reportlet=CW_HaiNanJKDPrint111.cpt", 
			                   	url : "/fineServer/ReportServer?reportlet="+list[i].name,     
			                    isPopUp : false,    
			                    data :para 
			            };       
    			console.log(config);
    		 	FR.doURLPDFPrint(config);
	  			}
			});
	
		}); 
			
	 function convertToJson(arr){
   		var data=[];
    	arr.forEach(function(val){
    		var info = new Info(val[0],val[1],val[2],val[3],val[4]);
    		data.push(info);
    	});
    	return data;
    }
    
     function Info(biztype,bizguid,state,versionid,depid){
    	this.biztype = biztype;
    	this.bizguid = bizguid;
    	this.state = state;
    	this.versionid = versionid;
    	this.depid = depid;
    }
    
  </script>
  
 
  
<table  border="0" cellspacing="0" cellpadding="0" class="biaokua2" style="margin-top: 1px;">
 <input type="hidden" id="userID" name="userID" value="${userID}"/>
	<tr>
		 <c:if test="${batchsWitch == 'true'}">
		  <th width="5%" style="  background:url(<%=request.getContextPath()%>/images/xiaoxian.gif) no-repeat right center; ">选择</th>
		  </c:if>
		<th width="5%" style="  background:url(<%=request.getContextPath()%>/images/xiaoxian.gif) no-repeat right center; ">序号</th>
		<s:iterator id="wrapper" value="wrapperList" status="sta" >
			<th <s:if test='#sta.index<wrapperList.size()-1'>style=" background:url(<%=request.getContextPath()%>/images/xiaoxian.gif) no-repeat right center;" </s:if>> <s:property value="title"/>  </th>
		</s:iterator>
    </tr>
    <%
    	List<WfInstance> wiList = (List<WfInstance>)request.getAttribute("wiList");
    	for(int i=0;i<wiList.size();i++){
    		
    		WfInstance wi = wiList.get(i);
    %>
	   <tr  style="cursor:pointer" >
	   	 <c:if test="${batchsWitch == 'true'}">
	     <td><input type="checkbox" name="moDel" value="<%=wi.getBizType()%>,'<%=wi.getBizGuid()%>',<%=wi.getState()%>,<%=wi.getFormVersionId()%>,<%=wi.getDeptId()%>"/></td>
	   </c:if>  
	      <td ><%=i+1 %></td>
	      		<%
		    	List<WfListWrapper> wfList = (List<WfListWrapper>)request.getAttribute("wrapperList");
			    	for(int j=0;j<wfList.size();j++){
			    		
			    		WfListWrapper wf = wfList.get(j);
			    		String column = wf.getValue();
			    		Class clazz = wi.getClass(); 
		        		Method method = clazz.getDeclaredMethod(column);
		        		String value = String.valueOf( method.invoke(wi)); 
			    %>
			     <a href="javascript:void(0);">  <td   onclick="trToDo('<%=wi.getBizType()%>','<%=wi.getBizGuid()%>','<%= wi.getFormVersionId()%>','<%=wi.getTempNodeId()%>','<%=wi.getState()%>')" ></a>
			   
			   
			   
			   
			    <%
			    	if(column!= null && (column.equals("getBizDouble1") ||column.equals("getBizDouble2") ||column.equals("getBizDouble3") ||column.equals("getBizDouble4"))) {
			    		Double d = (Double)method.invoke(wi);
			    		
			    		String bizDouble = StringUtils.formatDouble(d);
			    %>		
			    	<span style="">	<%=bizDouble %></span>
			    	
			    <%
			    	}	
			    	else if(column!= null && (column.equals("getBizCode"))) {
			    		String d = (String)method.invoke(wi);
			    		String Code = "null".equals(d)?"":d;
			    		
			    %>		
			    	<span style="">	<%=Code %></span>
			    				
			    	<% 	
			    	}
			    
			      	//出理当前审批人显示联系方式
			      	else if(column!= null && column.equals("getCurrOperaterList")) {
	
	   				List<WfCurrOperater> currOperaterList = (List<WfCurrOperater>) method.invoke(wi);
	
	   				//为空显示空格
			      	if (currOperaterList == null|| currOperaterList.size() == 0) {
			    		  %> &nbsp; <%
	 				}else {
	 					for (int k = 0; k < currOperaterList.size(); k++) {
	 						
	 						WfCurrOperater wcp = currOperaterList.get(k);
	 						if (currOperaterList.size() == 1) {
	 							//只有一个直接显示
	 						%>
								<p id="demo1">
									<span title="<%=wi.getShowdetail()%>"><%=wcp.getCurOperationName()%></span>
								</p> 
							<%
	 						}
							//多于一个显示。。。
	 						if (currOperaterList.size() == 2) { %>
	 						
	
								<p id="demo1">
									<span title="<%=wi.getShowdetail()%>"><%=wcp.getCurOperationName()%></span>
								</p> 
								
								<%
	 						}
	 						
	 						
	 						%>
	 						 <%
	 						if (currOperaterList.size() > 2) {
	 						if(k==0){
	 						
	 						 %>
	 						<p id="demo1">
									<span title="<%=wi.getShowdetail()%>"><%=wcp.getCurOperationName()%>...</span>
								</p> 
	 						
	 						
	 						<%
	 						}
	 						}
	 					}
	 				}

 			}
	      	else  	if(column!= null && column.equals("getPreOperaterName")) {%>
	      	<p id="demo2"><span title="<%=wi.getShowdetail2() %>"><%=wi.getPreOperaterName()!=null?wi.getPreOperaterName():" " %> </span></p>
	      	
	      	<% 
	      	}else if(column!= null && column.equals("getCreateUserName")){%>
	      		<p id="demo3"><span title="<%=wi.getShowdetail3() %>"><%=wi.getCreateUserName()!=null?wi.getCreateUserName():" "%></span></p>
	      	<% 	
	      	}else if(column!= null && column.equals("getStateName")){ 
	      		String color = "green";
	      		int state = wi.getState();
	      		if(state==3){
	      			color = "blue";
	      		}
	      		if(state==4 || state==11){
	      			color = "red";
	      		}
	      		if(state==1||state==2||state==14||state==15){
	      			color = "black";
	      		}
	      		
	      		%>
	      		<font style="color: <%=color %>; font-size: 12px;"><%=wi.getStateName() %></font>
	      		
	      		<% 
	      	}else if((column!=null && column.equals("getBizTypeName")) && (wi.getBizType().intValue()==16016 || wi.getBizType().intValue()==6016)){ 
	      		%>
	      		<img alt="<%=wi.getBizTypeName() %>" src="/images/">
	      		<% 
	      	}else if((column!=null && column.equals("getBizTypeName")) && (wi.getBizType().intValue()==16015 || wi.getBizType().intValue()==6015)){ 
	      		%>
	      		能力建设项目
	      		<% 
	      	}else if((column!=null && column.equals("getBizTypeName")) && (wi.getBizType().intValue()==16012 || wi.getBizType().intValue()==6012)){ 
	      		%>
	      		政府项目
	      		<% 
	      	}else{
	      	%>
		      
		      	
		      	
		      	<%=value!=null?value:""%>
		      		
		      	<% }
 					%> </td>
		      <%
		      	}
		      %>
	    </tr>
    
   		<%
        	}
        %>
    </table>
    
<script>
$(function() {
    // 从链接的title提取提示
	 $("#demo1 span[title], #demo1 img[alt]").qtip();
     $("#demo2 span[title], #demo2 img[alt]").qtip();
     $("#demo3 span[title], #demo3 img[alt]").qtip();
});
</script>
<%@include file="pageToolBar.jsp"%>