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
		<xsl:variable name="i18n" select="document('i18n.xml')" />
		<xsl:variable name="requiredlang" select="payment-model/language" as="xs:string"/>
		<xsl:variable name="lang">
			<xsl:choose>
				<xsl:when test="string-length($i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='threed_d_page_tittle']) > 0">
					<xsl:value-of select="payment-model/language" />
				</xsl:when>
				<xsl:otherwise>en</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:template match="/">
		<xsl:variable name="redirect">
			<xsl:value-of select="payment-model/form-redirecturl/value"/>
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
        		
		
		<xsl:variable name="imageloc">
			<xsl:value-of select="payment-model/imagesURL" />
            <xsl:value-of select="$templateVar" />
			<xsl:text>/</xsl:text>
		</xsl:variable>

<html>
<head>
	<title>
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='sagepay_page_title']"/>
	</title>
	<style type="text/css" media="screen">@import url("<xsl:copy-of select="$imageloc"/>vsp3.css");</style>
	<script type="text/javascript" language="JavaScript1.2">
	  <!--
	  //Preload images for this page-->
	  if (document.images) {
		 var proceed_btn = new Image()
		 proceed_btn.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed_img_file']"/>"
		 var proceed_over = new Image()
		 proceed_over.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed_over_img_file']"/>"
		 var submittedimg = new Image()
		 submittedimg.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='submitted_img_file']"/>"
		 }
	</script>	 
						
	<script type="text/javascript" language="JavaScript1.2"><xsl:attribute name="src"><xsl:value-of select="payment-model/imagesURL"/><xsl:text disable-output-escaping="yes">sagepay/buttonscript.js</xsl:text></xsl:attribute></script>

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
                            <img src="{concat(payment-model/imagesURL,'sagepay/sagepay_logo.gif')}" id="sagePayLogo" />
                        </td>
                        <td width="50%" valign="top">
                       	<xsl:if test="string-length(payment-model/vendor/vspvendorname)> 0">
						   <img src="{concat(payment-model/imagesURL,payment-model/vendor/vspvendorname,'/',payment-model/vendor/logo)}" id="vendorLogo"/>																
						</xsl:if>	                            
                        </td>
                    </tr>
                </tbody>
            </table>
			<div class="sectionheader noTopMargin">
               <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='vsp_form_error_header']"/>	
            </div>		   
		</div>
        <div class="greyHzShadeBar">&#160;</div>
				<table border="0" cellpadding="5" cellspacing="0" width="575" align="center">
				<tr>
					<td colspan="2" width="575">
					<br/>														
						<xsl:if test="string-length($redirect)> 0">
						<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='form_msg'] "/>																
						</xsl:if>	
						<xsl:if test="string-length($redirect) = 0">
						<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='form_msg_no_redirection'] "/>																
						</xsl:if>																														
						<br/><br/>															
					</td>
				</tr>		
				<tr>
					<td valign="top" class="bodytextbold" width="100" align="right">
						<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='form_status'] "/>
					</td>
					<td>
						<xsl:value-of select="payment-model/form-response/status"/>
						<br/><br/>
					</td>
				</tr>
				<tr>
					<td valign="top" class="bodytextbold" width="100" align="right">
						<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='form_statusdetail'] "/>
					</td>
					<td>
						<xsl:value-of select="payment-model/form-response/statusdetail"/>		
						<br/><br/>													
					</td>
				</tr>													
				
				<tr>
					<td colspan="2" align="right" bgcolor="#ffffff" width="575">
						<xsl:if test="string-length($redirect)> 0">
						<a onmouseover="activate('proceed')" onmouseout="inactivate('proceed')">
							<xsl:attribute name="href"><xsl:value-of select="payment-model/form-redirecturl/value"/></xsl:attribute>															
							<img name="proceed" align="center">
							<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed_img_file']"/></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed']"/></xsl:attribute>
							<xsl:attribute name="border">0</xsl:attribute>
							</img>
						</a><br /><br />									
						</xsl:if>
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
