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
	<xsl:variable name="transactiontypeid" select="payment-model/transaction/transactiontypeid"/>
<html>
<head>
	<title>
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='sagepay_page_title']"/>
	</title>
			<style type="text/css" media="screen">@import url("<xsl:copy-of select="$imageloc"/>vsp3.css");</style>
			<script type="text/javascript" language="JavaScript1.2">
	                function popUp(url)
	                {
	                sealWin=window.open(url,"win",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=650,height=650');
	                self.name = "mainWin";
	                }
	
	                function popUpNoMenu(url)
	                {
	                sealWin=window.open(url,"win",'toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1');
	                self.name = "mainWin";
	                }
	
	                function popUpWithMenu(url)
	                {
	                sealWin=window.open(url,"win",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1');
	                self.name = "mainWin";
	                }
	
	                function popUpSmall(url)
	                {
	                sealWin=window.open(url,"win",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=1,width=590,height=600');
	                self.name = "mainWin";
	                }
			</script>
		
			<script type="text/javascript" language="javascript">
				  <!--
				  //Preload images for this page-->
				  if (document.images) {
					 var cancel_btn = new Image()
					 cancel_btn.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cancel_img_file']"/>"
					 var cancel_over = new Image()
					 cancel_over.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cancel_over_img_file']"/>"
					 var subsmallimg = new Image()
					 subsmallimg.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='submitted_small_img_file']"/>"

					 var MC_logo = new Image()
					 MC_logo.src = "<xsl:copy-of select="$imageloc"/>MC_logo.gif"
					 var MC_over = new Image()
					 MC_over.src = "<xsl:copy-of select="$imageloc"/>MC_over.gif"					 
					 var VISA_logo = new Image()
					 VISA_logo.src = "<xsl:copy-of select="$imageloc"/>VISA_logo.gif"
					 var VISA_over = new Image()
					 VISA_over.src = "<xsl:copy-of select="$imageloc"/>VISA_over.gif"
					 var DELTA_logo = new Image()
					 DELTA_logo.src = "<xsl:copy-of select="$imageloc"/>DELTA_logo.gif"
					 var DELTA_over = new Image()
					 DELTA_over.src = "<xsl:copy-of select="$imageloc"/>DELTA_over.gif"
					 var SWITCH_logo = new Image()
					 SWITCH_logo.src = "<xsl:copy-of select="$imageloc"/>SWITCH_logo.gif"
					 var SWITCH_over = new Image()
					 SWITCH_over.src = "<xsl:copy-of select="$imageloc"/>SWITCH_over.gif"
					 var MAESTRO_logo = new Image()
					 MAESTRO_logo.src = "<xsl:copy-of select="$imageloc"/>MAESTRO_logo.gif"
					 var MAESTRO_over = new Image()
					 MAESTRO_over.src = "<xsl:copy-of select="$imageloc"/>MAESTRO_over.gif"
					 var UKE_logo = new Image()
					 UKE_logo.src = "<xsl:copy-of select="$imageloc"/>UKE_logo.gif"
					 var UKE_over = new Image()
					 UKE_over.src = "<xsl:copy-of select="$imageloc"/>UKE_over.gif"
					 var AMEX_logo = new Image()
					 AMEX_logo.src = "<xsl:copy-of select="$imageloc"/>AMEX_logo.gif"
					 var AMEX_over = new Image()
					 AMEX_over.src = "<xsl:copy-of select="$imageloc"/>AMEX_over.gif"
					 var DC_logo = new Image()
					 DC_logo.src = "<xsl:copy-of select="$imageloc"/>DC_logo.gif"
					 var DC_over = new Image()
					 DC_over.src = "<xsl:copy-of select="$imageloc"/>DC_over.gif"
					 var JCB_logo = new Image()
					 JCB_logo.src = "<xsl:copy-of select="$imageloc"/>JCB_logo.gif"
					 var JCB_over = new Image()
					 JCB_over.src = "<xsl:copy-of select="$imageloc"/>JCB_over.gif"
					 var PAYPAL_logo = new Image()
					 PAYPAL_logo.src = "<xsl:copy-of select="$imageloc"/>PAYPAL_logo.gif"
					 var PAYPAL_over = new Image()
					 PAYPAL_over.src = "<xsl:copy-of select="$imageloc"/>PAYPAL_over.gif"
					 var LASER_logo = new Image()
					 LASER_logo.src = "<xsl:copy-of select="$imageloc"/>LASER_logo.gif"
					 var LASER_over = new Image()
					 LASER_over.src = "<xsl:copy-of select="$imageloc"/>LASER_over.gif"
					 }
			</script>	 
		
		<script type="text/javascript" language="javascript" src="{concat(payment-model/imagesURL,'sagepay/buttonscript.js')}" />
</head>

<body>
<div id="pageWrapper">
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
        <xsl:if test="$transactiontypeid != 15">
		<div class="sectionheader noTopMargin">
            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='subtitle_transaction_details']"/>	
        </div>		   
        <div id="transactionDetails">
	        <table>
		        <tr>
			        <td class="label">
				        <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='topayfor']"/>
			        </td>
			        <td class="data">
				        <xsl:value-of select="payment-model/transaction/description"/>
			        </td>
		        </tr>
		        <tr>
			        <td class="label">
				        <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='amount']"/>
			        </td>
			        <td class="data"><span class="total">
				        <xsl:value-of select="payment-model/transaction/formatedamount"/>
				        <xsl:text> </xsl:text>
				        <xsl:value-of select="payment-model/transaction/currency"/></span>
			        </td>
		        </tr>
	        </table>
        </div>	
        </xsl:if>
	</div>
    <div class="greyHzShadeBar">&#160;</div>
	<div class="sectionheader">
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='subtitle_selectpaymentmethod']"/>
	</div>
	<div>
        <xsl:for-each select="//errormessage">
        <p class="errortext indent">
            <xsl:value-of select="value"/>
        </p>													
        </xsl:for-each>
	    <p class="indent">
	        <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='please_select_cardtype']"/>
	    </p>
	    <table>
	        <xsl:variable name="cardurl" select="payment-model/cardselection-action-url" as="xs:string"/>
		    <tr>
			    <xsl:for-each select="//paymentsystem">
					<xsl:if test="shortname !='SOLO'">
						<xsl:if test="position() = 8">
							<xsl:text disable-output-escaping="yes">&lt;/tr&gt;&lt;tr&gt;</xsl:text>
						</xsl:if>
						<td align="center">
							<form method="post" name="{concat('cardselection',shortname)}">
								<xsl:attribute name="action"><xsl:copy-of select="$cardurl"/></xsl:attribute>																																					
								<input type="hidden" name="clickedButton" value=""/>
								<a href="#" onmouseover="{concat('activate(''',shortname,''')')}"
								onmouseout="{concat('inactivatecard(''',shortname,''')')}"
								onclick="{concat('submitTheForm(''cardselection',shortname,''',''',shortname,''')')}">
								
								<script type="text/javascript" language="javascript">
								document.write('<xsl:text disable-output-escaping="yes">&lt;img border="0" align="center" src="</xsl:text>');
								document.write('<xsl:copy-of select="$imageloc"/><xsl:value-of select="shortname"/><xsl:text disable-output-escaping="yes">_logo.gif" name="</xsl:text>');
								document.write('<xsl:value-of select="shortname"/>');
								document.write('<xsl:text disable-output-escaping="yes">" alt="</xsl:text>');
								document.write('<xsl:choose><xsl:when test="paymentsystemname = 'UK Maestro'">');
								document.write('<xsl:text>Maestro</xsl:text></xsl:when><xsl:otherwise>');
								document.write('<xsl:value-of select="paymentsystemname"/></xsl:otherwise></xsl:choose>');
								document.write('<xsl:text disable-output-escaping="yes">"/&gt;</xsl:text>');
								</script>
								</a>
								
								<noscript>
								<input type="image" name="cardlogo">
									<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="shortname"/><xsl:text>_logo.gif</xsl:text></xsl:attribute>
									<xsl:attribute name="name"><xsl:value-of select="shortname"/></xsl:attribute>
									<xsl:attribute name="alt">
										<xsl:choose>
											<xsl:when test="paymentsystemname = 'UK Maestro'">
												<xsl:text>Maestro</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="paymentsystemname"/>
											</xsl:otherwise>
										</xsl:choose>												
									</xsl:attribute>
								</input>											
								</noscript>
								<input name="action" type="hidden" value="proceed"></input>
								<input type="hidden" name="cardselected">
									<xsl:attribute name="value"><xsl:value-of select="paymentsystemname"/></xsl:attribute>
								</input>				
							</form>
						</td>	
						</xsl:if>
			    </xsl:for-each>
		    </tr>
	    </table>
	    <form method="post" name="cancelpayment">
	    <xsl:attribute name="action"><xsl:value-of select="payment-model/cancelation-action-url"/></xsl:attribute>
	    <div id="templateCancel">
	        <p class="indent">
		        <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='please_cancel_here']"/>	
	        </p>
		    <input type="hidden" name="clickedButton" value=""/>
		    <a href="#" onmouseover="activate('cancel')" onmouseout="inactivate('cancel')" onclick="submitTheForm('cancelpayment','cancel');return false">
		        <script type="text/javascript" language="javascript">
		        document.write('<xsl:text disable-output-escaping="yes">&lt;img border="0" name="cancel" src="</xsl:text>');
		        document.write('<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cancel_img_file']"/>');
		        document.write('<xsl:text disable-output-escaping="yes">" alt="</xsl:text>');
		        document.write('<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cancel']"/>');
		        document.write('<xsl:text disable-output-escaping="yes">"/&gt;</xsl:text>');
		        </script>
		    </a>	
		    <noscript>
		        <input name="cancel" type="image">
		        <xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cancel_img_file']"/></xsl:attribute>
		        <xsl:attribute name="alt"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cancel']"/></xsl:attribute>
		        </input>
		    </noscript>
	    </div>
	    </form>										
    </div>
    <div class="greyHzShadeBar">&#160;</div>
    <div id="templatefooter">
	    <script type="text/javascript" language="javascript">
		    document.write('<xsl:text disable-output-escaping="yes">&lt;a class="bodybold" href="javascript:popUp(\'</xsl:text>');
		    document.write('<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='faq_file']"/>');
		    document.write('<xsl:text disable-output-escaping="yes">\');"&gt;FAQs&lt;/a&gt;</xsl:text>');
	    </script>
	    <noscript>
		    <a class="bodybold">
		    <xsl:attribute name="href"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='faq_file']"/></xsl:attribute>
		    <xsl:attribute name="target">_blank</xsl:attribute>
		    FAQs</a>
	    </noscript>
        <script type="text/javascript" language="javascript">
            document.write('<div id="padlockContainer">');
            document.write('<xsl:text disable-output-escaping="yes">&lt;a href="javascript:top.location.href=window.location.href;"&gt;&lt;img id="padlockimage" src="</xsl:text>');
            document.write('<xsl:copy-of select="$imageloc"/><xsl:text disable-output-escaping="yes">padlock_sml.gif"/&gt;&lt;/a&gt;</xsl:text>');
            document.write('<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='padlockmessage']"/>');
            document.write('</div>');
        </script>
    </div>	
</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
