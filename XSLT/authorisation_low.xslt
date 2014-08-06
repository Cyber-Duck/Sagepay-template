<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output version="4.01" encoding="UTF-8" indent="no" omit-xml-declaration="no" media-type="text/html" method="html"/>
	<xsl:template match="/">
		<!-- select the languages to use default is english-->
		<xsl:variable name="i18n" select="document('i18n.xml')"/>
		<xsl:variable name="requiredlang">
			<xsl:value-of select="payment-model/language"/>
		</xsl:variable>
		<xsl:variable name="testresult">
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='sagepay_page_title']"/>
		</xsl:variable>
		<xsl:variable name="lang">
			<xsl:choose>
				<xsl:when test="string-length($testresult) > 0">
					<xsl:value-of select="payment-model/language"/>
				</xsl:when>
				<xsl:otherwise>en</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="imageloc">
			<xsl:value-of select="payment-model/imagesURL"/>
			<xsl:value-of select="payment-model/vendor/vendortemplate"/>
			<xsl:text disable-output-escaping="yes">/</xsl:text>		
		</xsl:variable>
		
<html>
<head>
	<title>
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='sagepay_page_title']"/>
	</title>
	<style type="text/css" media="screen">
	@import url(<xsl:copy-of select="$imageloc"/>vsp3.css);
	</style>
	<meta http-equiv="refresh" content="2"/>			
	<script language="javascript">					
	<xsl:attribute name="src"><xsl:value-of select="payment-model/imagesURL"/><xsl:text disable-output-escaping="yes">sagepay/xp_progress.js</xsl:text></xsl:attribute>					
	</script>				
</head>
<body>
	<table align="center" border="0" width="100%">
    	<tr>
        	<td><br/><br/></td>
        </tr>    
        <tr>
        	<td align="center" class="bodytextbold"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='please_wait_while_authorsiation']"/></td>
        </tr>
        <tr>
        	<td><br/></td>
        </tr> 
        <tr>
			<td align="center">
			<img name="bar" border="0">
			<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='authbar_img_file']"/></xsl:attribute>
			<xsl:attribute name="alt"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='please_wait_while_authorsiation']"/></xsl:attribute>
			</img>
			</td>
		</tr>
	</table>			
</body>
</html>
</xsl:template>
</xsl:stylesheet>
