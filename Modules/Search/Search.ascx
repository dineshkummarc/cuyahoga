<%@ Register TagPrefix="csc" Namespace="Cuyahoga.ServerControls" Assembly="Cuyahoga.ServerControls" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Search.ascx.cs" Inherits="Cuyahoga.Modules.Search.Search" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<asp:panel id="pnlCriteria" runat="server">
	<asp:textbox id="txtSearchText" runat="server" width="200px"></asp:textbox>
	<asp:button id="btnSearch" runat="server" text="Search"></asp:button>
	<br>
	<br>
</asp:panel><asp:panel id="pnlResults" runat="server" visible="False"><%= base.GetText("DISPLAYING_RESULTS") %>
<asp:label id="lblFrom" runat="server" font-bold="True"></asp:label>-<asp:label id="lblTo" runat="server" font-bold="True"></asp:label>
<%= base.GetText("OF") %> 
<asp:label id="lblTotal" runat="server" font-bold="True"></asp:label>
<%= base.GetText("FOR") %>
<asp:label id="lblQueryText" runat="server" font-bold="True"></asp:label>
(<asp:label id="lblDuration" runat="server"></asp:label> <%= base.GetText("SECONDS") %>) 
<ul class="searchresults">
		<asp:repeater id="rptResults" runat="server">
			<itemtemplate>
				<li>
					<h4>
						<asp:hyperlink id="hplPath" runat="server" navigateurl='<%# DataBinder.Eval(Container.DataItem, "Path") %>'>
							<%# DataBinder.Eval(Container.DataItem, "Title") %>
						</asp:hyperlink></h4>
					<div>
						<%# DataBinder.Eval(Container.DataItem, "Summary") %>
					</div>
					<div class="sub">
						<%# DataBinder.Eval(Container.DataItem, "Path") %>
						- <%# DataBinder.Eval(Container.DataItem, "DateCreated", "{0:g}") %>
					</div>
				</li>
			</itemtemplate>
		</asp:repeater></ul>
<div class="pager">
		<csc:pager id="pgrResults" runat="server" cachedatasource="False" controltopage="rptResults"></csc:pager></div>
</asp:panel>
<asp:panel id="pnlNotFound" runat="server" visible="False" enableviewstate="False">
	<%= base.GetText("NOTFOUND") %>
</asp:panel>