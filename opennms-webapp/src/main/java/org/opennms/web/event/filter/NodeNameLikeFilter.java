/*******************************************************************************
 * This file is part of OpenNMS(R).
 *
 * Copyright (C) 2002-2014 The OpenNMS Group, Inc.
 * OpenNMS(R) is Copyright (C) 1999-2014 The OpenNMS Group, Inc.
 *
 * OpenNMS(R) is a registered trademark of The OpenNMS Group, Inc.
 *
 * OpenNMS(R) is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published
 * by the Free Software Foundation, either version 3 of the License,
 * or (at your option) any later version.
 *
 * OpenNMS(R) is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with OpenNMS(R).  If not, see:
 *      http://www.gnu.org/licenses/
 *
 * For more information contact:
 *     OpenNMS(R) Licensing <license@opennms.org>
 *     http://www.opennms.org/
 *     http://www.opennms.com/
 *******************************************************************************/

package org.opennms.web.event.filter;

import org.opennms.web.filter.SubstringFilter;

/**
 * Encapsulates all node filtering functionality.
 *
 * @author ranger
 * @version $Id: $
 * @since 1.8.1
 */
public class NodeNameLikeFilter extends SubstringFilter {
    /** Constant <code>TYPE="nodenamelike"</code> */
    public static final String TYPE = "nodenamelike";

    /**
     * <p>Constructor for NodeNameLikeFilter.</p>
     *
     * @param substring a {@link java.lang.String} object.
     */
    public NodeNameLikeFilter(String substring) {
        super(TYPE, "NODE.NODELABEL", "node.label", substring);
    }

    /** {@inheritDoc} */
    @Override
    public String getSQLTemplate() {
        return (" EVENTID IN (SELECT EVENTID FROM EVENTS JOIN NODE ON EVENTS.NODEID=NODE.NODEID WHERE NODE.NODELABEL ILIKE %s) ");
    }

    /**
     * <p>getTextDescription</p>
     *
     * @return a {@link java.lang.String} object.
     */
    @Override
    public String getTextDescription() {
        return ("node name containing \"" + getSubstring() + "\"");
    }

    /**
     * <p>toString</p>
     *
     * @return a {@link java.lang.String} object.
     */
    @Override
    public String toString() {
        return ("<WebEventRepository.NodeNameContainingFilter: " + getDescription() + ">");
    }

    /**
     * <p>getSubstring</p>
     *
     * @return a {@link java.lang.String} object.
     */
    public String getSubstring() {
        return getValue();
    }

    /** {@inheritDoc} */
    @Override
    public boolean equals(Object obj) {
        if (obj == null) return false;
        if (!(obj instanceof NodeNameLikeFilter)) return false;
        return (this.toString().equals(obj.toString()));
    }
}
