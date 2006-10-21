<%--

//
// This file is part of the OpenNMS(R) Application.
//
// OpenNMS(R) is Copyright (C) 2002-2003 The OpenNMS Group, Inc.  All rights reserved.
// OpenNMS(R) is a derivative work, containing both original code, included code and modified
// code that was published under the GNU General Public License. Copyrights for modified 
// and included code are below.
//
// OpenNMS(R) is a registered trademark of The OpenNMS Group, Inc.
//
// Copyright (C) 1999-2001 Oculan Corp.  All rights reserved.
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
//
// For more information contact:
//      OpenNMS Licensing       <license@opennms.org>
//      http://www.opennms.org/
//      http://www.opennms.com/
//

--%>

<%-- 
  This page is included by other JSPs to create a box containing an
  abbreviated list of outages.
  
  It expects that a <base> tag has been set in the including page
  that directs all URLs to be relative to the servlet context.
--%>

<%@page language="java"
	contentType="text/html"
	session="true"
	import="org.opennms.web.outage.*,
		java.util.*
	"
%>

<%! 
    OutageModel model = new OutageModel();
%>

<%
    //required parameter node
    String nodeIdString = request.getParameter("node");
    
    if( nodeIdString == null ) {
        throw new org.opennms.web.MissingParameterException("node", new String[] {"node", "intf", "service"}); 
    }

    //required parameter intf
    String ipAddr = request.getParameter("intf");

    if( ipAddr == null ) {
        throw new org.opennms.web.MissingParameterException("intf", new String[] {"node", "intf", "service"}); 
    }

    //required parameter node
    String serviceIdString = request.getParameter("service");
    
    if( serviceIdString == null ) {
        throw new org.opennms.web.MissingParameterException("service", new String[] {"node", "intf", "service"}); 
    }
    
    int nodeId = Integer.parseInt(nodeIdString);
    int serviceId = Integer.parseInt(serviceIdString);    
        
    //determine yesterday's respresentationr
    Calendar cal = new GregorianCalendar();
    cal.add( Calendar.DATE, -1 );
    Date yesterday = cal.getTime();

    //gets all current outages and outages that have been resolved within the
    //the last 24 hours
    Outage[] outages = this.model.getOutagesForService(nodeId, ipAddr, serviceId, yesterday);
%>

<h3>Recent Outages</h3>

<table>

<% if(outages.length == 0) { %>
  <td class="standardheader" colspan="3">There have been no outages on this service in the last 24 hours.</td>
<% } else { %>
  <tr>
    <th>Lost</td>
    <th>Regained</td>
    <th>Outage ID</td>
  </tr>
  <%  for(int i=0; i < outages.length; i++) { %>
     <tr class="<%=(outages[i].getRegainedServiceTime() == null) ? "Critical" : "Normal"%>">
      <td class="divider"><%=org.opennms.netmgt.EventConstants.formatToUIString(outages[i].getLostServiceTime())%></td>
      <td  class="divider bright"><%=(outages[i].getRegainedServiceTime() == null) ? "DOWN" : org.opennms.netmgt.EventConstants.formatToUIString(outages[i].getRegainedServiceTime())%></td>
      <td class="divider"><a href="outage/detail.jsp?id=<%=outages[i].getId()%>"><%=outages[i].getId()%></a></td>
    </tr>
  <% } %>
<% } %>

</table>
