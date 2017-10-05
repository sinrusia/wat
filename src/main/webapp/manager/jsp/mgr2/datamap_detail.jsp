<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xssd5/jsp/common/import.jspf" %><%@ include file="/xssd5/jsp/common/session.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	String id = box.get("dam_id");
	
	String mode = "2";
	ICE ice = ICE.getInstance();
	Sqls sqls = ice.sqls();
	
	RecordSet rs = null;
	if(!box.valid("dam_id")){
		SKeys skey = SKeys.getInstance();
		id = skey.getKey("zssd_datamap","dam_id","D",4);
		mode = "1";	
		rs = new RecordSet();
		box.put("dam_id", id);
	}else{
		Result r = sqls.getResult("SSD5.Datamaps.Detail", box);
		rs = r.getRecordSet();
		rs.next();
	}

	
	String checked = rs.getChecked("dam_used");
	if(mode.equals("1")) checked = "checked";

%>

<style>
.dl_table{
	
}
	
.dl_table td.ctt{
		border:1px solid #aaaaaa;
		background-color:#ffffff;
}

.dl_list td{
	padding:2px;
	border-bottom:1px solid #bbbbbb;
}

.dl_list td.sel{
	padding:2px;
	border-bottom:1px solid #bbbbbb;
	background-color:#000000;
	color:#ffffff;
	font-weight:bold;
}

</style>

<form name=frm_1 >	
	<input type=hidden name=mode value="<%= mode %>">
		
	<table class=dl_table>
	<col width=300>
	<col width=700>	
	<tr>
		<td valign=top class=ctt1>
			<table width=100% cellspacing=1 border=0 class=table >
				<col width=70>
				<col>
			<tr >
				<th>ID</th><td><input type=text name=dam_id value="<%= id %>" readonly ></td>
			</tr>
			<tr >
				<th>Name</th><td><input type=text name=dam_name value="<%= rs.get("dam_name") %>" size=30></td>
			</tr>
			<tr >
				<th>Used</th><td><input type=checkbox name=dam_used value="1" <%= checked %>></td>
			</tr>
			<tr >
				<th >Order</th><td><input type=text name=dam_order value="<%= rs.get("dam_order") %>" size=3></td>
			</tr>
			</table>


			<table width=100% cellspacing=1 border=0 class=table  style='margin-top:5px;'>
			<tr >
				<th>Description</th>
			</tr>
			<tr ><td><textarea name=dam_descr rows=5 style='width:99%;' ><%= rs.get("dam_descr") %></textarea></td>
			</tr >
			
			</table>

		</td>
		<td>
			<table width=100% cellspacing=1 border=0 class=table >
			<tr >
				<th>CONFIG</th>
			</tr>
			<tr ><td><textarea name=dam_config rows=35 style='width:99%;' ><%= rs.get("dam_config") %></textarea></td>
			</tr >
			</table>
		</td>
	</tr>
	</table>
</form>

<div style='margin-top:3px;text-align:right;'>
<img src='/xssd5/jsp/mgr2/images/wizard/widget_apply.png'  onclick="doSaveDatamap();" class='link btn'>
<img src='/xssd5/jsp/mgr2/images/wizard/widget_reset.png'  onclick="document.frm_1.reset();" class='link btn'>
</div>


<%@ include file="/xssd5/jsp/common/ui_common.jspf" %>