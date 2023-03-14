<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="//root">
<xsl:text>&#xA;</xsl:text>
<root>
<xsl:text>&#xA;</xsl:text>	
<xsl:for-each select="//node">
<node>
<xsl:text>&#xA;</xsl:text>        
    			<IP><xsl:value-of select="IP"/></IP><xsl:text>&#xA;</xsl:text>
    			<Hostname><xsl:value-of select="Sys_Name"/></Hostname><xsl:text>&#xA;</xsl:text>
    			<SN><xsl:value-of select="Product_ID"/></SN><xsl:text>&#xA;</xsl:text>
    			<Model><xsl:value-of select="Product_Name"/></Model><xsl:text>&#xA;</xsl:text>
    			<Vendor><xsl:value-of select="Product_Vendor"/></Vendor><xsl:text>&#xA;</xsl:text>
    			<Version><xsl:value-of select="Product_Version"/></Version><xsl:text>&#xA;</xsl:text>
    			<OS><xsl:value-of select="OS_Name"/></OS><xsl:text>&#xA;</xsl:text>
    			<ServicePack><xsl:value-of select="OS_Version"/></ServicePack><xsl:text>&#xA;</xsl:text>
    			<Description><xsl:value-of select="OS_Description"/></Description><xsl:text>&#xA;</xsl:text>

</node>
<xsl:text>&#xA;</xsl:text>
</xsl:for-each>
</root>
</xsl:template>

</xsl:stylesheet>