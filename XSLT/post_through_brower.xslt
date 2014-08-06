<?xml version="1.0" encoding="ISO-8859-1"?> 
<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xhtml" encoding="ISO-8859-1" indent="yes" omit-xml-declaration="yes" media-type="text/html" 
 doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

		<!-- ***** VERY SIMPLE REDIRECT PAGE
		
		This page appears inside the inline frame and automatically redirects the customer to the issuing bank
		ACSURL.  It only displays if Javascript is turned off with a simple message asking the user to click
		Proceed to continue.  You do not need to fully customise this screen because it already appears in your
		branded Authentication.xslt frame.
		-->

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
		<xsl:variable name="imageloc">
			<xsl:value-of select="payment-model/imagesURL"/>
			<xsl:value-of select="payment-model/vendor/vendortemplate"/>
			<xsl:text disable-output-escaping="yes">/</xsl:text>		
		</xsl:variable>		
		<xsl:template match="/">
		
		<html>
			<head>
				<title>
					<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='post_through_browser_page_tittle']" />
				</title>
				<style type="text/css" media="screen">
				@import url(<xsl:copy-of select="$imageloc"/>vsp3.css);
				</style>
			</head>

			<body OnLoad="OnLoadEvent();">
				<FORM name="form" action="" method="POST">
					<xsl:attribute name="action"><xsl:value-of select="payment-model/actionurl"/></xsl:attribute>
					
					<xsl:for-each select="payment-model/postparameters/entry">
						<input type="hidden">
							<xsl:attribute name="name"><xsl:value-of select="key"/></xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="value"/></xsl:attribute>
						</input>
					</xsl:for-each>
					<NOSCRIPT>
						<center>
							<p>
								<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='post_through_click_btn_below']"/>
							</p>
							<p>
								<input type="submit">
									<xsl:attribute name="value"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='proceed']"/></xsl:attribute>								
								</input>
							</p>
						</center>
					</NOSCRIPT>
				</FORM>
				<SCRIPT LANGUAGE="Javascript"> function OnLoadEvent() { document.form.submit(); } </SCRIPT>
			</body>			

		</html>
	</xsl:template>
</xsl:stylesheet>