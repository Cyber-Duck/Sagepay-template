<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet version="2.0" 
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fn="http://www.w3.org/2005/02/xpath-functions"
  xmlns:xdt="http://www.w3.org/2005/02/xpath-datatypes"
  xmlns:date="http://exslt.org/dates-and-times"
  exclude-result-prefixes="xsl fn xs xdt date">
  <xsl:variable name="countries" select="document('countries.xml')"/>
  <xsl:variable name="states" select="document('states.xml')"/>

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
		<xsl:variable name="now" select="date:date-time()"/>
		<xsl:variable name="currentyear" select="date:year($now)"/>
		<xsl:variable name="currentmonth" select="date:month-in-year($now)"/>
		<xsl:variable name="imageloc" select="concat(payment-model/imagesURL,payment-model/vendor/vendortemplate,'/')" as="xs:string"/>
		
		<xsl:template match="/">
		<xsl:variable name="vpsprotocol" select="payment-model/transaction/vpsprotocol"/>
		<xsl:variable name="cardtype" select="payment-model/paymentsystem/paymentsystemname"/>

		<xsl:variable name="transactiontypeid" select="payment-model/transaction/transactiontypeid"/>
		<xsl:variable name="usingtoken">
		<xsl:value-of select="payment-model/transaction/usingtoken"/>
		</xsl:variable>
		<xsl:variable name="allowbackbutton" select="payment-model/allowbackbutton"/>
		
		<html>
			<head>
				<title>
					<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='sagepay_page_title']"/>
				</title>
				<style type="text/css" media="screen">
				@import url("<xsl:copy-of select="$imageloc"/>vsp3.css");
				</style>
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
					 var back_btn = new Image()
					 back_btn.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='back_img_file']"/>"
					 var back_over = new Image()
					 back_over.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='back_over_img_file']"/>"
					 var proceed_btn = new Image()
					 proceed_btn.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed_img_file']"/>"
					 var proceed_over = new Image()
					 proceed_over.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed_over_img_file']"/>"
					 var submittedimg = new Image()
					 submittedimg.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='submitted_img_file']"/>"
					 var subsmallimg = new Image()
					 subsmallimg.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='submitted_small_img_file']"/>"
					 }
				</script>	 
								
				<script type="text/javascript" language="javascript" src="{concat(payment-model/imagesURL,'sagepay/buttonscript.js')}" />
				
				<script type="text/javascript"> 
				function showHide(obj){
					var curSel=obj.options[obj.selectedIndex].value
					var show=(document.all)? 'block' : 'table-row';
					if(curSel=='US'){ 
						document.getElementById('stateRow').style.display=show;
					}else{
						document.getElementById('stateRow').style.display="none";
					} 
				} 
				</script>
				
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
                        <td class="data">
                            <span class="total">
                                <xsl:value-of select="payment-model/transaction/formatedamount"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="payment-model/transaction/currency"/>
                            </span>
                        </td>
                    </tr>
                </table>
            </div>
            </xsl:if>
            
        </div>
        <div class="greyHzShadeBar">&#160;</div>
		<div class="sectionheader">
					<xsl:choose>
						<xsl:when test="$usingtoken != 'true'">
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='subtitle_card_details']"/>
						</xsl:when>
						<xsl:otherwise>		
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='subtitle_security_code']"/>
						</xsl:otherwise>
					</xsl:choose>	
		</div>
		<div>
            <div style="text-align: center; padding: 5px;">
				<span class="errortext">
				<xsl:for-each select="//errormessage">
				<xsl:value-of select="value"/>
				<br/>
				</xsl:for-each>
				</span>
            </div>
                
			<form method="post" name="carddetails">
				<xsl:attribute name="action"><xsl:value-of select="payment-model/carddetails-action-url"/></xsl:attribute>
				<table class="formTable" >
					<xsl:if test="$usingtoken != 'true'">
					<tr>
						<td class="label">
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cardnumber']"/><span class="errortext">*</span>
						</td>
						<td class="data">
                            <input name="cardnumber" size="30" autocomplete="off" />
						</td>
						<td class="info">
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='enter_without_spaces']"/>
						</td>
					</tr>
					<tr>
						<td class="label">
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='paymentmethod']"/>
						</td>
						<td class="data">
							<xsl:value-of select="payment-model/paymentsystem/paymentsystemname"/>
						</td>
						<td class="info" />
					</tr>
					<xsl:if test="$vpsprotocol &lt; 2.23">
					<tr>
						<td class="label">
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cardholdername']"/><span class="errortext">*</span>											       				
						</td>
						<td class="data">
							<input name="cardholder" size="30">
								<xsl:attribute name="value"><xsl:value-of select="payment-model/transaction/customername"/></xsl:attribute>
							</input>
						</td>
						<td class="info">
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='name_as_it_appears']"/>
						</td>
					</tr>
					</xsl:if>
					<xsl:if test="$vpsprotocol &gt; 2.22">
					<tr>
                        <td class="label">
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cardfirstnames']"/><span class="errortext">*</span>											       				
                        </td>
                        <td class="data">
                            <input name="cardfirstnames" size="30" maxlength="20" autocomplete="off">
                                <xsl:attribute name="value"><xsl:value-of select="payment-model/transaction/billingfirstnames"/></xsl:attribute>
                            </input>
                        </td>
                        <td class="info">
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='name_as_it_appears']"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cardsurname']"/><span class="errortext">*</span>											       				
                        </td>
                        <td class="data">
                            <input name="cardsurname" size="30" maxlength="20" autocomplete="off">
                                <xsl:attribute name="value"><xsl:value-of select="payment-model/transaction/billingsurname"/></xsl:attribute>
                            </input>
                        </td>
                        <td class="info">
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='name_as_it_appears']"/>
                        </td>
                    </tr>								
					</xsl:if>
					<tr>
						<td class="label">
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='valid_from']"/>
						</td>
                        <td class="data">
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='month']"/> 
							<select name="startmonth" size="1" style="width: 60px; margin-left: 3px;">
								<option value=""/>
									<xsl:call-template name="generate_months">
									<xsl:with-param name="start" select="1"/>
									<xsl:with-param name="end" select="13"/>																			
									</xsl:call-template>
							</select>
                            <span style="padding-left: 10px;">
							    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='year']"/>
                                <select name="startyear" size="1" style="width: 60px; margin-left: 3px;">
                                    <option value=""/>
                                    <xsl:call-template name="generate_years">
                                        <xsl:with-param name="start" select="$currentyear - 20"/>
                                        <xsl:with-param name="end" select="$currentyear + 1"/>
                                    </xsl:call-template>
                                </select>
                            </span>
						</td>
						<td class="info">
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='if_not_present_leave_blank']"/>
						</td>
					</tr>
					<tr>
						<td class="label">
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='expiry_date']"/><span class="errortext">*</span>
						</td>
						<td class="data" colspan="2">
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='month']"/> 
							<select name="expirymonth" size="1" style="width: 60px; margin-left: 4px;">
								<option value=""/>
								<xsl:call-template name="generate_months">
								<xsl:with-param name="start" select="1"/>
								<xsl:with-param name="end" select="13"/>																			
								</xsl:call-template>
							</select>
                            <span style="padding-left: 10px;">
							    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='year']"/> 
							    <select name="expiryyear" size="1" style="width: 60px; margin-left: 4px;">
									<option value=""/>
								    <xsl:call-template name="generate_years">
								    <xsl:with-param name="start" select="$currentyear"/>																			
								    <xsl:with-param name="end" select="$currentyear + 20"/>																			
								    </xsl:call-template>
							    </select>
                            </span>
						</td>
					</tr>
						<xsl:variable name="issuenumberRequired">
						<xsl:value-of select="payment-model/paymentsystem/issuenumber"/>
						</xsl:variable>
						<xsl:if test="$issuenumberRequired='true'">
					<tr>
						<td class="label">
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='issue_no']"/>
						</td>
						<td class="data">
							<input size="2" maxlength="2" name="cardissue" style="width: 27px;" autocomplete="off"/>
						</td>
						<td class="info">
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='issue_leave_it_blank']"/>
						</td>
					</tr>
						</xsl:if>
					</xsl:if>
						<xsl:variable name="avscv2Required">
						<xsl:value-of select="payment-model/paymentsystem/avscv2"/>
						</xsl:variable>
						<xsl:if test="$avscv2Required='true'">
					<tr>
						<td class="label">
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='security_code']"/><span class="errortext">*</span>
						</td>
                        <td class="data">
                            <input size="5" maxlength="4" name="securitycode" style="width: 50px;" autocomplete="off"/>
						</td>
						<td class="info">
						    <script type="text/javascript" language="JavaScript1.2">
							    document.write('<xsl:text disable-output-escaping="yes">&lt;a class="bodybold" href="javascript:popUp(\'</xsl:text>');
							    document.write('<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='securitycode_file']"/>');
							    document.write('<xsl:text disable-output-escaping="yes">\');"&gt;&lt;img border="0" src="</xsl:text>');
							    document.write('<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='infoblob_img']"/>');
							    document.write('<xsl:text disable-output-escaping="yes">"/&gt;&lt;/a&gt;</xsl:text>');
						    </script>
						    <noscript>
							    <a>
								    <xsl:attribute name="href"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='securitycode_file']"/></xsl:attribute>
								    <xsl:attribute name="target">_blank</xsl:attribute>
								    <img border="0">
									    <xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='infoblob_img']"/></xsl:attribute>
								    </img>
							    </a>
						    </noscript>
          		<xsl:if test="$cardtype='LASER'">
          			<span class="info"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='laser_000_CV2']"/></span>
          		</xsl:if>						    
						</td>
					</tr>
            </xsl:if>
					<xsl:variable name="allowgiftaid">
						<xsl:value-of select="payment-model/transaction/allowgiftaid"/>
					</xsl:variable>
					<xsl:variable name="vendorSupportGiftaid">
						<xsl:value-of select="payment-model/vendor/giftaid"/>
					</xsl:variable>
										
					 <xsl:if test="$vendorSupportGiftaid='true' and ($allowgiftaid='1' or $allowgiftaid='2')">
						<tr>
							<td class="label">
								<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='giftdetails']"/>
							</td>
							<td class="data" colspan="2">
								<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='gift_statement_part1']"/>
								<strong><xsl:value-of select="payment-model/vendor/vendorprovidedname"/></strong><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='gift_statement_part2']"/><br /><br />
								<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clickgift']"/>
								<input name="giftaid" type="checkbox" value="yes">
										<xsl:if test="$allowgiftaid='2'">
										<xsl:attribute name="selected">true</xsl:attribute>
										</xsl:if>
								</input>
							</td>
						</tr>
						</xsl:if>
                </table>
                <div id="templateNavigation">
                
					<xsl:choose>
						<xsl:when test="$allowbackbutton = 'true'">  
						<a id="backButton" onmouseover="activate('back')" onmouseout="inactivate('back')">
							<xsl:attribute name="href"><xsl:value-of select="payment-model/cardselection-action-url"/></xsl:attribute>
							<img name="back">
								<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='back_img_file']"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='back']"/></xsl:attribute>
								<xsl:attribute name="border">0</xsl:attribute>
							</img>
						</a>					
						</xsl:when>
						<xsl:otherwise>																											
						</xsl:otherwise>
					</xsl:choose>					
					
					<input name="action" type="hidden" value="proceed"/>
					<input type="hidden" name="clickedButton" value=""/>
					<a id="proceedButton" href="#" onmouseover="activate('proceed')" onmouseout="inactivate('proceed')" onclick="submitTheForm('carddetails','proceed');return false">
					    <script type="text/javascript" language="JavaScript1.2">
					        document.write('<xsl:text disable-output-escaping="yes">&lt;img border="0" name="proceed" src="</xsl:text>');
					        document.write('<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed_img_file']"/>');
					        document.write('<xsl:text disable-output-escaping="yes">" alt="</xsl:text>');
					        document.write('<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed']"/>');
					        document.write('<xsl:text disable-output-escaping="yes">"/&gt;</xsl:text>');
					    </script>
					</a>
					<noscript>
					    <input id="proceedButton" name="proceed" type="image">
					    <xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed_img_file']"/></xsl:attribute>
					    <xsl:attribute name="alt"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed']"/></xsl:attribute>
					    </input>
					</noscript>
                </div>
	  		</form>
            <form method="post" name="cancelpayment">
                <xsl:attribute name="action">
                    <xsl:value-of select="payment-model/cancelation-action-url"/>
                </xsl:attribute>
                <div id="templateCancel">
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
                            <xsl:attribute name="src">
                                <xsl:copy-of select="$imageloc"/>
                                <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cancel_img_file']"/>
                            </xsl:attribute>
                            <xsl:attribute name="alt">
                                <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cancel']"/>
                            </xsl:attribute>
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
                    <xsl:attribute name="href">
                        <xsl:copy-of select="$imageloc"/>
                        <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='faq_file']"/>
                    </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    FAQs
                </a>
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
	<xsl:template name="generate_years">
		<xsl:param name="start" select="2007"/>
		<xsl:param name="end" select="2020"/>
		<xsl:if test="$start &lt; $end">
			<option>
				<xsl:attribute name="value"><xsl:value-of select="substring( string($start),3,2)"/></xsl:attribute>
				<xsl:value-of select="$start"/>
			</option>
			<xsl:call-template name="generate_years">
				<xsl:with-param name="start" select="$start + 1"/>
				<xsl:with-param name="end" select="$end"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
    
	<xsl:template name="generate_months">
		<xsl:param name="start" select="1"/>
		<xsl:param name="end" select="13"/>
		<xsl:param name="current" select="0"/>
		<xsl:if test="$start &lt; $end">
			<option>
				<xsl:choose>
					<xsl:when test="$start  &lt; 10">
						<xsl:attribute name="value"><xsl:value-of select="concat('0',string($start))"/></xsl:attribute>
						<xsl:if test="$start = $current">
							<xsl:attribute name="selected"><xsl:value-of select="true"/></xsl:attribute>
						</xsl:if>
						<xsl:value-of select="concat('0',string($start))"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="value"><xsl:value-of select="string($start)"/></xsl:attribute>
						<xsl:if test="$start = $current">
							<xsl:attribute name="selected"><xsl:value-of select="true"/></xsl:attribute>
						</xsl:if>
						<xsl:value-of select="$start"/>
					</xsl:otherwise>
				</xsl:choose>
			</option>
			<xsl:call-template name="generate_months">
				<xsl:with-param name="start" select="$start + 1"/>
				<xsl:with-param name="end" select="$end"/>
				<xsl:with-param name="current" select="$current"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
    
	<xsl:template name="popup_info">		
		<xsl:param name="filename" select="test"/>
		<xsl:param name="i18n" select="document('i18n.xml')"/>
		<xsl:param name="imageloc" select="none"/>		
		<xsl:param name="lang" select="en"/>				
		<SCRIPT>
			document.write('<xsl:text disable-output-escaping="yes">&lt;a class="bodybold" href="javascript:popUp(\'</xsl:text>');
			document.write('<xsl:copy-of select="$imageloc"/><xsl:value-of select="$filename"/>');
			document.write('<xsl:text disable-output-escaping="yes">\');"&gt;&lt;img border="0" height="20" width="145" src="</xsl:text>');
			document.write('<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='whattodo_img']"/>');
			document.write('<xsl:text disable-output-escaping="yes">"/&gt;&lt;/a&gt;</xsl:text>');
		</SCRIPT>
		<NOSCRIPT>
			<a class="bodybold">
				<xsl:attribute name="href"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$filename"/></xsl:attribute>
				<xsl:attribute name="target">_blank</xsl:attribute>
				<img border="0" height="20" width="145">
					<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='whattodo_img']"/></xsl:attribute>
				</img>
			</a>
		</NOSCRIPT>		
	</xsl:template>
	
	<xsl:template name="liststates">
			<xsl:param name="states" select="document('states.xml')"/>
			<xsl:param name="selection" select="AL"/>				
		<xsl:for-each select="$states/states/state">		
			<option>
				<xsl:attribute name="value"><xsl:value-of select="code"/></xsl:attribute>
				<xsl:if test='$selection=code'>
					<xsl:attribute name="selected">yes</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="name"/>
			</option>
		</xsl:for-each>				
	</xsl:template>	

	<xsl:template name="listcountries">		
		<xsl:param name="countries" select="document('countries.xml')"/>
		<xsl:param name="selection" select="GB"/>
		
		<xsl:for-each select="$countries/countries/country">		
			<option>
				<xsl:attribute name="value"><xsl:value-of select="code"/></xsl:attribute>
				<xsl:if test='$selection=code'>
					<xsl:attribute name="selected">yes</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="name"/>
			</option>
		</xsl:for-each>		
	</xsl:template>
</xsl:stylesheet>
