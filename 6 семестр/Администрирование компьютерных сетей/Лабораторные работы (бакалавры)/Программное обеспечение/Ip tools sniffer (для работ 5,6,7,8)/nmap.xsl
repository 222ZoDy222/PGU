<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="/nmaprun">

<root>
<xsl:for-each select="host">
<host>
	<address><xsl:value-of select="address/@addr"/></address>
	<state><xsl:value-of select="status/@state"/></state>
	<os><xsl:value-of select="os/osmatch/@name"/></os>
	<hostname><xsl:value-of select="hostnames/hostname/@name"/></hostname>
</host>
</xsl:for-each>
</root>

</xsl:template>

</xsl:stylesheet>