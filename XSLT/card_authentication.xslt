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
		<xsl:variable name="imageloc" select="concat(payment-model/imagesURL,payment-model/vendor/vendortemplate,'/')" as="xs:string"/>
		<xsl:template match="/">
						
		<html>
			<head>
				<title>
					<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='sagepay_page_title']"/>
				</title>
				<style type="text/css" media="screen">
				@import url("<xsl:copy-of select="$imageloc"/>vsp3.css");
				</style>

				<script type="text/javascript" language="javascript">
				  <!--
				  //Preload images for this page-->
				  if (document.images) {
					 var skip3D_btn = new Image()
					 skip3D_btn.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='skip3D_img_file']"/>"
					 var skip3D_over = new Image()
					 skip3D_over.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='skip3D_over_img_file']"/>"
					 var subsmallimg = new Image()
					 subsmallimg.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='submitted_small_img_file']"/>"
					 }
				</script>	 
				<script type="text/javascript" language="javascript" src="{concat(payment-model/imagesURL,'sagepay/buttonscript.js')}" />
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
				<div class="sectionheader noTopMargin">
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='card_authentication']"/>
		</div>
		</div>
        <div class="greyHzShadeBar">&#160;</div>
		<br/>
		<div id="templateamount">

		<table border="0" width="100%">
			<tr>
				<td width="80%" class="bodysmalltext" valign="top"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='threed_explanation']"/></td>
				<td width="20%" align="center">
					<img align="center">
						<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='vbv_img_file']"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='vbv']"/></xsl:attribute>														
					</img>
					<br />
					<br />
					<img align="center">
						<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='mcsc_img_file']"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='mcsc']"/></xsl:attribute>														
					</img>
				</td>
			</tr>
		</table>
		<br/>
		<table border="0" width="550" title="This table is for layout purposes only" align="center">
			<tbody>
				<tr>
					<td align="left">
						<iframe name="3diframe" width="100%" height="430" frameborder="0" scrolling="auto">
						<xsl:attribute name="src"><xsl:value-of select="payment-model/threedredirect-url"/></xsl:attribute>

					<!-- Non-IFRAME browser support -->
						<html>
							<head>
								<SCRIPT LANGUAGE="Javascript"> function OnLoadEvent() { document.form.submit(); }</SCRIPT>				
								<title><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='threed_d_redirect_title']" />
								</title>
							</head>
							<body OnLoad="OnLoadEvent();">
								<FORM name="form" action="" method="POST">
									<xsl:attribute name="action"><xsl:value-of select="payment-model/pareq-env/acsurl"/></xsl:attribute>
									<NOSCRIPT>
									<center>						
									<p><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='click_btn_below']"/>
									</p>
									<input type="submit" value="Go"/>
									</center>
									</NOSCRIPT>
									<input type="hidden" name="PaReq">
										<xsl:attribute name="value"><xsl:value-of select="payment-model/pareq-env/pareq"/></xsl:attribute>
									</input>
									<input type="hidden" name="TermUrl">
										<xsl:attribute name="value"><xsl:value-of select="payment-model/pareq-env/termurl"/></xsl:attribute>					
									</input>					
									<input type="hidden" name="MD">
										<xsl:attribute name="value"><xsl:value-of select="payment-model/pareq-env/md"/></xsl:attribute>
									</input>					
								</FORM>
							</body>			
						</html>								
						</iframe>	
					</td>
				</tr>							
			</tbody>
		</table>
		<br/>
        <div class="greyHzShadeBar">&#160;</div>
		<br/>
		<form method="post" name="skipauthenticate">
			<xsl:attribute name="action"><xsl:value-of select="payment-model/threedskip-url"/></xsl:attribute>
		<input type="hidden" name="clickedButton" value=""/>
		<input type="hidden" name="action" value="skip"/>
		<table border="0" width="100%">
			<tr>
				<td width="80%" class="bodysmalltext"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='threed_skiptext']"/></td>
				<td width="20%" align="center">
					<a href="#" onmouseover="activate('skip3D')" onmouseout="inactivate('skip3D')" onclick="submitTheForm('skipauthenticate','skip3D');return false">
					<script type="text/javascript" language="JavaScript1.2">

					document.write('<xsl:text disable-output-escaping="yes">&lt;img border="0" name="skip3D" src="</xsl:text>');
					document.write('<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='skip3D_img_file']"/>');
					document.write('<xsl:text disable-output-escaping="yes">" alt="</xsl:text>');
					document.write('<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='skip3D']"/>');
					document.write('<xsl:text disable-output-escaping="yes">"/&gt;</xsl:text>');
					</script>
					</a>
					<noscript>
					<input name="skip3D" type="image">
					<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='skip3D_img_file']"/></xsl:attribute>
					<xsl:attribute name="alt"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='skip3D']"/></xsl:attribute>
					</input>
					</noscript>
				</td>
			</tr>
		</table>
		</form>	
		
				
		</div>
		</div>
	</body>
</html>
	</xsl:template>
</xsl:stylesheet>