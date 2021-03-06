
<%@page import="com.tls.liferaylms.job.condition.Condition"%>
<%@page import="com.tls.liferaylms.job.condition.ConditionUtil"%>
<%@ include file="/init.jsp"%>

<portlet:actionURL var="newURL" name="newMailJob"> 
	<portlet:param name="activeTab" value="${tab}"/>
</portlet:actionURL>

<liferay-ui:success key="delete-mailjob-ok" message="mailjob.delete-mailjob-ok"/>
<liferay-ui:error key="delete-mailjob-ko" message="mailjob.delete-mailjob-ko"/>
<script type="text/javascript">

$(document).ready(function(){
    $(".aui-tabview-list li").click(function(){
        var isActualTab = $(this).hasClass("current");
        if(isActualTab != true){
        	var processed = document.getElementById("processed");
			var nprocessed = document.getElementById("non-processed");
			
			if(processed.style.display=="none"){
				processed.style.display="block";
				nprocessed.style.display="none";
			}else{
				processed.style.display="none";
				nprocessed.style.display="block";
			}
        }
    });
});

</script>


<liferay-ui:tabs names="processed-plural,non-processed-plural" refresh="false" value="${tab}" />
<aui:button value="groupmailing.new-mail-job" type="button" onClick="${newURL}" />
<%
	PortletURL processedURL = renderResponse.createRenderURL();
	processedURL.setParameter("tab","processed-plural");
%>

<div id="processed" <c:if test="${tab eq 'non-processed-plural'}">style="display:none"</c:if> >
	<liferay-ui:search-container curParam="mailJobPag" emptyResultsMessage="there-are-no-mailjobs" delta="10" iteratorURL="<%=processedURL %>">
		<liferay-ui:search-container-results>
			<%
				List mailjobs = (List)request.getAttribute("mailjobs");
				
				pageContext.setAttribute("results", mailjobs);
				
				pageContext.setAttribute("total", request.getAttribute("count"));
			%>
		</liferay-ui:search-container-results>
		
		<liferay-ui:search-container-row className="com.tls.liferaylms.mail.model.MailJob" keyProperty="idJob" modelVar="mailJob">
			<%
				Condition condition = ConditionUtil.instance(mailJob.getConditionClassName(), mailJob);
				Condition reference = ConditionUtil.instance(mailJob.getDateClassName(), mailJob);
			%>
				
			<portlet:actionURL var="viewURL" name="viewMailJob">
        		<portlet:param name="mailjob" value="<%=String.valueOf(mailJob.getPrimaryKey()) %>" />
			</portlet:actionURL>
			<liferay-ui:search-container-column-text name="condition">
				<%if(condition!=null){ %>
				<c:choose>
					<c:when test="${!mailJob.processed}">
						<a href="<%=viewURL%>"><span class="mailJob"><%= condition.getName(themeDisplay.getLocale()) %> <%= condition.getConditionName(locale) %></span></a>
					</c:when>
					<c:otherwise>
						<span class="mailJob"><%= condition.getName(themeDisplay.getLocale()) %> <%= condition.getConditionName(locale) %></span>
					</c:otherwise>
				</c:choose>
				<%} %>
			</liferay-ui:search-container-column-text>
			<liferay-ui:search-container-column-text name="reference">
				<%if(reference!=null){ %>
				<c:choose>
					<c:when test="${!mailJob.processed}">
						<a href="<%=viewURL%>"><span class="mailJob"><%= reference.getName(themeDisplay.getLocale()) %> <%= reference.getReferenceName(locale) %></span></a>
					</c:when>
					<c:otherwise>
						<span class="mailJob"><%= reference.getName(themeDisplay.getLocale()) %> <%= reference.getReferenceName(locale) %></span>
					</c:otherwise>
				</c:choose>
				<%} %>
			</liferay-ui:search-container-column-text>
			<liferay-ui:search-container-column-text name="days">
				<c:choose>
					<c:when test="${mailJob.dateShift lt 0}">
						${mailJob.dateShift*-1} <liferay-ui:message key="days-before" />
					</c:when>
					<c:otherwise>
						${mailJob.dateShift} <liferay-ui:message key="days-after" />
					</c:otherwise>
				</c:choose>
			</liferay-ui:search-container-column-text>		
			<liferay-ui:search-container-column-text name="release-date">
			<%if(reference!=null){ %>
			<%= reference.getFormatDate() %>
			<%} %>
			</liferay-ui:search-container-column-text>
			<liferay-ui:search-container-column-text name="processed">
				<c:choose>
					<c:when test="${mailJob.processed}">
						<liferay-ui:icon image="checked" alt="checked"></liferay-ui:icon>
					</c:when>
					<c:otherwise>
						<liferay-ui:icon image="unchecked" alt="unchecked"></liferay-ui:icon>
					</c:otherwise>
				</c:choose>
			</liferay-ui:search-container-column-text>			
			
		</liferay-ui:search-container-row>
		<liferay-ui:search-iterator />
	</liferay-ui:search-container>
</div>


<%
	PortletURL nonProcessedURL = renderResponse.createRenderURL();
nonProcessedURL.setParameter("tab","non-processed-plural");
%>

<div id="non-processed" <c:if test="${tab eq 'processed-plural'}">style="display:none"</c:if> >
	<liferay-ui:search-container curParam="mailJobPendinPag" emptyResultsMessage="there-are-no-mailjobs" delta="10" iteratorURL="<%=nonProcessedURL %>">
		<liferay-ui:search-container-results>
			<%
				List mailjobs = (List)request.getAttribute("pendingMailjobs");
				
				pageContext.setAttribute("results", mailjobs);
				
				pageContext.setAttribute("total", request.getAttribute("pendingCount"));
			%>
		</liferay-ui:search-container-results>
		
		<liferay-ui:search-container-row className="com.tls.liferaylms.mail.model.MailJob" keyProperty="idJob" modelVar="mailJob">
			<%
				Condition condition = ConditionUtil.instance(mailJob.getConditionClassName(), mailJob);
				Condition reference = ConditionUtil.instance(mailJob.getDateClassName(), mailJob);
			%>
				
			<portlet:actionURL var="viewURL" name="viewMailJob">
        		<portlet:param name="mailjob" value="<%=String.valueOf(mailJob.getPrimaryKey()) %>" />
			</portlet:actionURL>
			<liferay-ui:search-container-column-text name="condition">
				<%if(condition!=null){ %>
				<c:choose>
					<c:when test="${!mailJob.processed}">
						<a href="<%=viewURL%>"><span class="mailJob"><%= condition.getName(themeDisplay.getLocale()) %> <%= condition.getConditionName(locale) %></span></a>
					</c:when>
					<c:otherwise>
						<span class="mailJob"><%= condition.getName(themeDisplay.getLocale()) %> <%= condition.getConditionName(locale) %></span>
					</c:otherwise>
				</c:choose>
				<%} %>
			</liferay-ui:search-container-column-text>
			<liferay-ui:search-container-column-text name="reference">
					<%if(reference!=null){ %>
				<c:choose>
					<c:when test="${!mailJob.processed}">
						<a href="<%=viewURL%>"><span class="mailJob"><%= reference.getName(themeDisplay.getLocale()) %> <%= reference.getReferenceName(locale) %></span></a>
					</c:when>
					<c:otherwise>
						<span class="mailJob"><%= reference.getName(themeDisplay.getLocale()) %> <%= reference.getReferenceName(locale) %></span>
					</c:otherwise>
				</c:choose>
				<%} %>
			</liferay-ui:search-container-column-text>
			<liferay-ui:search-container-column-text name="days">
				<c:choose>
					<c:when test="${mailJob.dateShift lt 0}">
						${mailJob.dateShift*-1} <liferay-ui:message key="days-before" />
					</c:when>
					<c:otherwise>
						${mailJob.dateShift} <liferay-ui:message key="days-after" />
					</c:otherwise>
				</c:choose>
			</liferay-ui:search-container-column-text>		
			<liferay-ui:search-container-column-text name="release-date">
			<%if(reference!=null){ %>
				<%= reference.getFormatDate() %>
			<%} %>
			</liferay-ui:search-container-column-text>
			<liferay-ui:search-container-column-text name="processed">
				<c:choose>
					<c:when test="${mailJob.processed}">
						<liferay-ui:icon image="checked" alt="checked"></liferay-ui:icon>
					</c:when>
					<c:otherwise>
						<liferay-ui:icon image="unchecked" alt="unchecked"></liferay-ui:icon>
					</c:otherwise>
				</c:choose>
			</liferay-ui:search-container-column-text>
			<liferay-ui:search-container-column-text name="">
				<portlet:actionURL name="deleteMailJob" var="deleteURL">
						<portlet:param name="mailJobId" value="<%=String.valueOf(mailJob.getPrimaryKey()) %>" />
				</portlet:actionURL>
				<liferay-ui:icon-delete url="<%=deleteURL.toString() %>" />
			</liferay-ui:search-container-column-text>			
			
		</liferay-ui:search-container-row>
		<liferay-ui:search-iterator />
	</liferay-ui:search-container>
</div>
