<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output version="4.01" encoding="UTF-8" indent="no" omit-xml-declaration="no" media-type="text/html" method="html"/>
	<xsl:template match="/">

		<!-- ***** VERY SIMPLE REDIRECT PAGE
		
		This page appears inside the inline frame and automatically redirects the customer to the issuing bank
		ACSURL.  It only displays if Javascript is turned off with a simple message asking the user to click
		Proceed to continue.  You do not need to fully customise this screen because it already appears in your
		branded Authentication.xslt frame.
		-->

		<!-- select the languages to use default is english-->
		<xsl:variable name="i18n" select="document('i18n.xml')" />
		<xsl:variable name="requiredlang">
			<xsl:value-of select="payment-model/language" />
		</xsl:variable>
		<xsl:variable name="testresult">
			<xsl:value-of
				select="$i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='threed_d_page_tittle']" />
		</xsl:variable>
		<xsl:variable name="lang">
			<xsl:choose>
				<xsl:when test="string-length($testresult) > 0">
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
		
		<html>
			<head>
				<title>
					<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='threed_d_redirect_tittle']" />
				</title>
				<style type="text/css" media="screen">
				@import url(<xsl:copy-of select="$imageloc"/>vsp3.css);
				</style>
			</head>
			<body OnLoad="OnLoadEvent();">
				<FORM name="form" action="" method="POST">
					<xsl:attribute name="action"><xsl:value-of select="payment-model/pareq-env/acsurl"/></xsl:attribute>
					<input type="hidden" name="PaReq">
						<xsl:attribute name="value"><xsl:value-of select="payment-model/pareq-env/pareq"/></xsl:attribute>
					</input>
					<input type="hidden" name="TermUrl">
						<xsl:attribute name="value"><xsl:value-of select="payment-model/threedcompletionfqdn-url"/></xsl:attribute>
					</input>					
					<input type="hidden" name="MD">
						<xsl:attribute name="value"><xsl:value-of select="payment-model/pareq-env/md"/></xsl:attribute>
					</input>					
					<NOSCRIPT>
						<center>
							<p>
								<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='click_btn_below']"/>
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