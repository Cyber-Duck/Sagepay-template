<?xml version="1.0" encoding="ISO-8859-1"?> 
<xsl:stylesheet version="2.0" 
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fn="http://www.w3.org/2005/02/xpath-functions"
  xmlns:xdt="http://www.w3.org/2005/02/xpath-datatypes"
  exclude-result-prefixes="xsl fn xs xdt">

<xsl:output method="xhtml" encoding="ISO-8859-1" indent="yes" omit-xml-declaration="yes" media-type="text/html" 
 doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
 
	<xsl:template match="/">

		<!-- select the languages to use default is english-->
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
		<xsl:variable name="imageloc" select="concat(payment-model/imagesURL,payment-model/vendor/vendortemplate,'/')" as="xs:string"/>
		
<html>
<head>
	<title>
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='sagepay_page_title']"/>
	</title>
				<style type="text/css" media="screen">
				@import url("<xsl:copy-of select="$imageloc"/>vsp3.css");
				</style>
				<meta http-equiv="refresh" content="2"/>			
				<script type="text/javascript" language="JavaScript1.2" src="{concat(payment-model/imagesURL,'sagepay/xp_progress.js')}" />
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
                            <img src="{concat(payment-model/imagesURL,payment-model/vendor/vspvendorname,'/',payment-model/vendor/logo)}" id="vendorLogo"/>
                        </td>
                    </tr>
                </tbody>
            </table>
		</div>
        <div class="greyHzShadeBar">&#160;</div>
			<div class="bodytextbold noTopMargin">
               	
            </div>		
			<table border="0" width="100%">	
			<tr><td height="20px" align="center"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='please_wait_while_authorsiation']"/></td></tr>
						
 				<tr>
					<td align="center">
						<script type="text/javascript" language="JavaScript1.2">
							var bar1= createBar(500,30,'white',1,'#dddddd','#E98300',75,10,5,'');
						</script>
						<noscript>
							<img name="bar" border="0">
								<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='authbar_img_file']"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='please_wait_while_authorsiation']"/></xsl:attribute>
							</img>
						</noscript>				
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
