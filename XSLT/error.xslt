<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet version="2.0" 
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fn="http://www.w3.org/2005/02/xpath-functions"
  xmlns:xdt="http://www.w3.org/2005/02/xpath-datatypes"
  xmlns:date="http://exslt.org/dates-and-times"
  exclude-result-prefixes="xsl fn xs xdt date">

<xsl:output method="xhtml" encoding="ISO-8859-1" indent="yes" omit-xml-declaration="yes" media-type="text/html" 
 doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

		<!-- define the languages document for use -->
		<xsl:template match="/error">
        <xsl:variable name="i18n" select="document('i18n.xml')"/>
        <xsl:variable name="requiredlang">
            <xsl:value-of select="language"/>
        </xsl:variable>
        <xsl:variable name="testresult">
            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='sagepay_page_title']"/>
        </xsl:variable>
        <xsl:variable name="lang">
            <xsl:choose>
                <xsl:when test="string-length($testresult) > 0">
                    <xsl:value-of select="language"/>
                </xsl:when>
                <xsl:otherwise>en</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="template">
            <xsl:value-of select="vendor/vendortemplate"/>
        </xsl:variable>
        
        <xsl:variable name="templateVar">
            <xsl:choose>
                <xsl:when test="string-length($template) > 0">
                    <xsl:value-of select="$template"/>
                </xsl:when>
                <xsl:otherwise>Default</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
		<xsl:variable name="imageloc" select="concat(payment-model/imagesURL,payment-model/vendor/vendortemplate,'/')" as="xs:string"/>		

<html>
<head>
	<title>
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='sagepay_page_title']"/>
	</title>
	<style type="text/css" media="screen">

	 @import url("<xsl:copy-of select="$imageloc"/>vsp3.css");

	</style>
</head>
<body>
	<div id="pageWrapper">
		<xsl:attribute name="title"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='sagepay_page_title']"/></xsl:attribute>
		 <div id="headerTop"/>
		 <div id="header">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td width="50%" valign="top">
                            <img src="{concat(imagesURL,'sagepay/sagepay_logo.gif')}" id="sagePayLogo" />
                        </td>
                        <td width="50%" valign="top">
                        <xsl:if test="string-length(vendor/vspvendorname)> 0">
						   <img src="{concat(imagesURL,vendor/vspvendorname,'/',vendor/logo)}" id="vendorLogo"/>																
						</xsl:if>	
                            
                        </td>
                    </tr>
                </tbody>
            </table>
			<div class="sectionheader noTopMargin">
               <xsl:value-of select="httpstatus"/>	
            </div>		   
		</div>
        <div class="greyHzShadeBar">&#160;</div>
				<table border="1" cellpadding="5" cellspacing="0" width="575" align="center">
				<tr>
					<td valign="top" colspn="2" height="10px" class="bodytextbold">
							<xsl:text> </xsl:text>
						</td>
					</tr>
					<tr>
						<td valign="top" class="bodytextbold"  width="200">
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='http_status_code'] "/> 
						</td>
						<td valign="top" class="bodytextbold">
							<xsl:text> </xsl:text><xsl:value-of select="httpstatuscode"/>
						</td>
					</tr>
					<tr>
						<td valign="top" class="bodytextbold"  width="200">
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='httpstatus_msg'] "/>
						</td>
						<td valign="top" class="bodysmalltext">
							<xsl:text> </xsl:text><xsl:value-of select="httpstatus-message"/>
						</td>
					</tr>
					<tr>
						<td valign="top" class="bodytextbold"  width="200">
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='errorcode']"/> :
						</td>
						<td valign="top" class="bodytextbold">
							<xsl:text> </xsl:text><xsl:value-of select="errorcode"/>
						</td>
					</tr>
					<tr>
						<td valign="top" class="bodytextbold"  width="200">
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='errordescription']"/> :
						</td>
						<td class="bodysmalltext">
							<xsl:text> </xsl:text><xsl:value-of select="errordescription"/>
						</td>
					</tr>
				</table>
				<div>
					<table width="653" cellpadding="0" cellspacing="0" border="0">
					  <tr><td height="20px"></td></tr>
					  <tr>
						 <td width="653" align="center" class="copyright">Copyright Sage Pay 2010 </td>
					  </tr>								
					</table>
				</div>	
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
