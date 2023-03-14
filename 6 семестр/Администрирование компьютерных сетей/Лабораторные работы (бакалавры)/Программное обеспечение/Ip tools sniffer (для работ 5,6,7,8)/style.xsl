<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">



 <xsl:template match="/">

<HTML>
<HEAD>
 <TITLE>Report by IPTools</TITLE>
 <!--<link rel="stylesheet" type="text/css" href="style.css" />-->
 <style type="text/css">
 BODY {
	BACKGROUND-COLOR: #ffffff;	FONT-SIZE: 8pt
  }
  A {	TEXT-DECORATION: none }
  TABLE {	
    border-width:0px;
    border-style:solid;
    WIDTH:100% 
    }
  TD {
    border-width:1px;border-style:solid;
  }  
  A:visited {	COLOR: #0000cf; TEXT-DECORATION: none }
  A:link {	COLOR: #0000cf; TEXT-DECORATION: none }
  A:active {	COLOR: #0000cf; TEXT-DECORATION: underline }
  A:hover {	COLOR: #0000cf; TEXT-DECORATION: underline }
  OL {	COLOR: #333333; FONT-FAMILY: tahoma,helvetica,sans-serif }
  UL {	COLOR: #333333; FONT-FAMILY: tahoma,helvetica,sans-serif }
  P {	COLOR: #333333; FONT-FAMILY: tahoma,helvetica,sans-serif }
  BODY {	COLOR: #333333; FONT-FAMILY: tahoma,helvetica,sans-serif }
  TD {	COLOR: #333333; FONT-FAMILY: tahoma,helvetica,sans-serif }
  TR {	COLOR: #333333; FONT-FAMILY: tahoma,helvetica,sans-serif }
  TH {	COLOR: #333333; FONT-FAMILY: tahoma,helvetica,sans-serif }
  FONT.title {	BACKGROUND-COLOR: white; COLOR: #363636; FONT-FAMILY:                   tahoma,helvetica,verdana,lucida console,utopia; FONT-SIZE: 10pt; FONT-WEIGHT: bold }
  FONT.sub {	BACKGROUND-COLOR: white; COLOR: #000000; FONT-FAMILY:                   tahoma,helvetica,verdana,lucida console,utopia; FONT-SIZE: 10pt }
  FONT.layer {	COLOR: #ff0000; FONT-FAMILY: courrier,sans-serif,arial,helvetica; FONT-SIZE: 8pt; TEXT-ALIGN: left }
  TD.title {	BACKGROUND-COLOR: #A2B5CD; COLOR: #555555; FONT-FAMILY:                   tahoma,helvetica,verdana,lucida console,utopia; FONT-SIZE: 10pt; FONT-WEIGHT: bold; HEIGHT: 20px; TEXT-ALIGN: right }
  TD.sub {	BACKGROUND-COLOR: #DCDCDC; COLOR: #555555; FONT-FAMILY:                   tahoma,helvetica,verdana,lucida console,utopia; FONT-SIZE: 10pt; FONT-WEIGHT: bold; HEIGHT: 18px; TEXT-ALIGN: left }
  TD.content {	BACKGROUND-COLOR: white; COLOR: #000000; FONT-FAMILY:                   tahoma,arial,helvetica,verdana,lucida console,utopia; FONT-SIZE: 8pt; TEXT-ALIGN: left; VERTICAL-ALIGN: middle }
  TD.default {	BACKGROUND-COLOR: WHITE; COLOR: #000000; FONT-FAMILY:                   tahoma,arial,helvetica,verdana,lucida console,utopia; FONT-SIZE: 8pt; }
  TD.border {	BACKGROUND-COLOR: #cccccc; COLOR: black; FONT-FAMILY:                   tahoma,helvetica,verdana,lucida console,utopia; FONT-SIZE: 10pt; HEIGHT: 25px }
  TD.border-HILIGHT {	BACKGROUND-COLOR: #ffffcc; COLOR: black; FONT-FAMILY:                   verdana,arial,helvetica,lucida console,utopia; FONT-SIZE: 10pt; HEIGHT: 25px }
 </style>
 
</HEAD>
<BODY BGCOLOR="#FFFFFF">



 
  <table>
        <tr>
        <xsl:for-each select="//root//*[1]">
        	<xsl:for-each select="./*">
        	<td class="title"><b><xsl:value-of select="name(.)" /></b></td>
        	</xsl:for-each>
        </xsl:for-each>
        </tr>
        
        <xsl:for-each select="//root/*">
        
        <tr>
        		<xsl:for-each select="./*">
    			<td class="default"><xsl:value-of select="."/>&#160;</td>
  			</xsl:for-each>
        
        </tr>
        </xsl:for-each>
        
        <br/><br/><br/>
        
          
  </table>
  

<br/><b>Report created by IPTools</b>
<br/>

</BODY>
</HTML>
  
   </xsl:template>

</xsl:stylesheet>