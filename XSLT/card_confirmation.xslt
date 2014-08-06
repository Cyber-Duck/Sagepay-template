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
		<xsl:variable name="vpsprotocol" select="payment-model/transaction/vpsprotocol"/>					
		<xsl:variable name="allowbackbutton" select="payment-model/allowbackbutton"/>
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
					 var change_btn = new Image()
					 change_btn.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='change_img_file']"/>"
					 var change_over = new Image()
					 change_over.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='change_over_img_file']"/>"
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
				<style type="text/css">
				.formTable 				{
				  width:98%;				  
				}
				.formTable  .data
				{
				font-size:11px;
				  				  
				}
				.formTable .label
				{
				  font-size:11px;			  
				}
				
				
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
                            <img src="{concat(payment-model/imagesURL,'sagepay/sagepay_logo.gif')}" id="sagePayLogo" />
                            <img src="{concat(payment-model/imagesURL,'sagepay/byebyeProtx.gif')}" id="protxLogo"/>
                        </td>
                        <td width="50%" valign="top">
                            <img src="{concat(payment-model/imagesURL,payment-model/vendor/vspvendorname,'/',payment-model/vendor/logo)}" id="vendorLogo"/>
                        </td>
                    </tr>
                </tbody>
            </table>
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
							<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='vendortxcode']"/>
						</td>
						<td class="data">
							<xsl:value-of select="payment-model/transaction/vendortxcode"/>
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
        </div>
        <div class="greyHzShadeBar">&#160;</div>
		<xsl:variable name="showbasket">
		<xsl:value-of select="payment-model/showbasket"/>
		</xsl:variable>	
		<xsl:if test="$showbasket='true'">									
		<div class="sectionheader">
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='shopping_basket']"/>			
		</div>	
	    <table class="formTable" id="shoppingBasket">
            <thead>
		        <tr>
			        <td width="40%" align="left">													
				        <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_description']"/>
			        </td>
			        <td width="12%" align="right">
				        <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_quantity']"/>
			        </td>
			        <td width="12%" align="right">
				        <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_value']"/>
			        </td>													
			        <td width="12%" align="right">
				        <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_tax']"/>													
			        </td>
			        <td width="12%" align="right">
				        <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_total']"/>																										
			        </td>													
			        <td width="12%" align="right">
				        <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_linetotal']"/>
			        </td>																																	
		        </tr>
            </thead>
            <tbody>
			    <xsl:for-each select="//lineitem">
		        <tr>
			        <td align="left"><xsl:value-of select="description"/></td>
			        <td align="right"><xsl:value-of select="quantity"/></td>															
			        <td align="right"><xsl:value-of select="itemvalue"/></td>
			        <td align="right"><xsl:value-of select="itemtax"/></td>
			        <td align="right"><xsl:value-of select="itemtotal"/></td>															
			        <td align="right"><xsl:value-of select="linetotal"/></td>																																	
		        </tr>																										
			        </xsl:for-each>
		        <tr>
			        <td align="right" colspan="5" style="font-weight:bold;">Total Price:</td>
                    <td align="right" style="font-weight:bold;"><xsl:value-of select="payment-model/transaction/formatedamount"/></td>
		        </tr>   
            </tbody>							
	    </table>
        </xsl:if>
        <div class="greyHzShadeBar">&#160;</div>
	    <div class="sectionheader">
		    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='card_details_confirm_subtitle']"/>
	    </div>
        <div>
            <table class="formTable readonly">
                <tbody>
                    <tr>
                        <td class="label">
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='paymentmethod']"/>
                        </td>
                        <td class="data">
                            <xsl:value-of select="payment-model/paymentsystem/paymentsystemname"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cardnumber']"/>
                        </td>
                        <td class="data">
                            <xsl:value-of select="payment-model/card/cardnumber"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cardholdername']"/>
                        </td>
                        <td class="data">
                            <xsl:value-of select="payment-model/card/cardholder"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='email']"/>
                        </td>
                        <td class="data">
                            <xsl:value-of select="payment-model/transaction/customeremail"/>
                        </td>
                    </tr>
                    <xsl:variable name="avscv2Required">
                        <xsl:value-of select="payment-model/paymentsystem/avscv2"/>
                    </xsl:variable>
                    <xsl:if test="$avscv2Required='true'">
                        <tr>
                            <td class="label">
                                <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='billing_address']"/>
                            </td>
                            <td class="data">
                                <xsl:variable name="input" select="payment-model/card/cardaddress" />
                                <xsl:variable name="exp">
                                    <xsl:text>&#10;</xsl:text>
                                </xsl:variable>
                                <xsl:variable name="replace">&#x3c;br/&#x3e;</xsl:variable>
                                <xsl:variable name="output" select="replace($input,$exp, $replace)" />
                                <xsl:value-of select="$output" />
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='billing_postcode']"/>
                            </td>
                            <td class="data">
                                <xsl:value-of select="payment-model/card/cardpostcode"/>
                            </td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="$vpsprotocol &lt; 2.23" >
                        <xsl:if test="$avscv2Required='false'">
                            <tr>
                                <td class="label">
                                    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='billing_address']"/>
                                </td>
                                <td class="data">
                                    <xsl:variable name="input" select="payment-model/transaction/billingaddress" />
                                    <xsl:variable name="exp">
                                        <xsl:text>&#10;</xsl:text>
                                    </xsl:variable>
                                    <xsl:variable name="replace">&#x3c;br/&#x3e;</xsl:variable>
                                    <xsl:variable name="output" select="replace($input,$exp, $replace)" />
                                    <xsl:value-of select="$output" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">
                                    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='billing_postcode']"/>
                                </td>
                                <td class="data">
                                    <xsl:value-of select="payment-model/transaction/billingpostcode"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <tr>
                            <td class="label">
                                <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='delivery_address']"/>
                            </td>
                            <td class="data">
                                <xsl:variable name="input" select="payment-model/transaction/deliveryaddress" />
                                <xsl:variable name="exp">
                                    <xsl:text>&#10;</xsl:text>
                                </xsl:variable>
                                <xsl:variable name="replace">&#x3c;br/&#x3e;</xsl:variable>
                                <xsl:variable name="output" select="replace($input,$exp, $replace)" />
                                <xsl:value-of select="$output" />
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='delivery_postcode']"/>
                            </td>
                            <td class="data">
                                <xsl:value-of select="payment-model/transaction/deliverypostcode"/>
                            </td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="$vpsprotocol &gt; 2.22" >
                        <xsl:if test="$avscv2Required='false'">
                            <tr>
                                <td class="label">
                                    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='billing_address1']"/>
                                </td>
                                <td class="data">
                                    <xsl:value-of select="payment-model/transaction/billingaddress"/>
                                </td>
                            </tr>
                            <xsl:variable name="billingaddress2">
                                <xsl:value-of select="payment-model/transaction/billingaddress2"/>
                            </xsl:variable>
                            <xsl:if test="string-length($billingaddress2)>0">
                                <tr>
                                    <td class="label">
                                        <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='billing_address2']"/>
                                    </td>
                                    <td class="data">
                                        <xsl:value-of select="payment-model/transaction/billingaddress2"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <tr>
                                <td class="label">
                                    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='billingcity']"/>
                                </td>
                                <td class="data">
                                    <xsl:value-of select="payment-model/transaction/billingcity"/>
                                </td>
                            </tr>
                            <xsl:variable name="billingstate">
                                <xsl:value-of select="payment-model/transaction/billingstate"/>
                            </xsl:variable>
                            <xsl:if test="string-length($billingstate)>0">
                                <tr>
                                    <td class="label">
                                        <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='billingstate']"/>
                                    </td>
                                    <td class="data">
                                        <xsl:value-of select="payment-model/transaction/billingstate"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <tr>
                                <td class="label">
                                    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='billing_postcode']"/>
                                </td>
                                <td class="data">
                                    <xsl:value-of select="payment-model/transaction/billingpostcode"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="label">
                                    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='billingcountry']"/>
                                </td>
                                <td class="data">
                                    <xsl:value-of select="payment-model/transaction/billingcountry"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <tr>
                            <td class="label">
                                <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='delivery_address1']"/>
                            </td>
                            <td class="data">
                                <xsl:value-of select="payment-model/transaction/deliveryaddress"/>
                            </td>
                        </tr>
                        <xsl:variable name="deliveryaddress2">
                            <xsl:value-of select="payment-model/transaction/deliveryaddress2"/>
                        </xsl:variable>
                        <xsl:if test="string-length($deliveryaddress2)>0">
                            <tr>
                                <td class="label">
                                    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='delivery_address2']"/>
                                </td>
                                <td class="data">
                                    <xsl:value-of select="payment-model/transaction/deliveryaddress2"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <tr>
                            <td class="label">
                                <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='deliverycity']"/>
                            </td>
                            <td class="data">
                                <xsl:value-of select="payment-model/transaction/deliverycity"/>
                            </td>
                        </tr>
                        <xsl:variable name="deliverystate">
                            <xsl:value-of select="payment-model/transaction/deliverystate"/>
                        </xsl:variable>
                        <xsl:if test="string-length($deliverystate)>0">
                            <tr>
                                <td class="label">
                                    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='deliverystate']"/>
                                </td>
                                <td class="data">
                                    <xsl:value-of select="payment-model/transaction/deliverystate"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <tr>
                            <td class="label">
                                <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='delivery_postcode']"/>
                            </td>
                            <td class="data">
                                <xsl:value-of select="payment-model/transaction/deliverypostcode"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='deliverycountry']"/>
                            </td>
                            <td class="data">
                                <xsl:value-of select="payment-model/transaction/deliverycountry"/>
                            </td>
                        </tr>
                    </xsl:if>
                </tbody>
            </table>
        </div>
        <div class="greyHzShadeBar">&#160;</div>
	    <xsl:variable name="cardthreed">
		    <xsl:value-of select="payment-model/paymentsystem/allow3dsec"/>
	    </xsl:variable>
	    <xsl:variable name="vendorthreed">
		    <xsl:value-of select="payment-model/vendor/threed"/>
	    </xsl:variable>

        <xsl:if test="$cardthreed='true' and $vendorthreed='true'">
        <div style="float: right;">
            <img style="margin: 30px 0px 10px 10px;">
                <xsl:attribute name="src">
                    <xsl:copy-of select="$imageloc"/>
                    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='vbv_img_file']"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='vbv']"/>
                </xsl:attribute>
            </img>
            <br />
            <img style="margin: 10px 0px 20px 10px;">
                <xsl:attribute name="src">
                    <xsl:copy-of select="$imageloc"/>
                    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='mcsc_img_file']"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='mcsc']"/>
                </xsl:attribute>
            </img>
        </div>
        <p style="margin-top: 30px;">
            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='threed_description']"/>
        </p>
        </xsl:if>
        <p style="font-weight: bold; ">
            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed_to_finalise']"/>
        </p>
        <div id="templateNavigation">
        		<xsl:choose>
        		<xsl:when test="$allowbackbutton = 'false'">
	            <form method="post" name="selectcard">
	                <xsl:attribute name="action">
	                    <xsl:value-of select="payment-model/cardselection-action-url"/>
	                </xsl:attribute>
	                <input type="hidden" name="clickedButton" value=""/>
	                <a id="backButton" href="#" onmouseover="activate('change')" onmouseout="inactivate('change')" onclick="submitTheForm('selectcard','change');return false">
	                    <script type="text/javascript" language="JavaScript1.2">
	                        document.write('<xsl:text disable-output-escaping="yes">&lt;img border="0" name="change" src="</xsl:text>');
	                        document.write('<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='change_cardtype_img_file']"/>');
	                        document.write('<xsl:text disable-output-escaping="yes">" alt="</xsl:text>');
	                        document.write('<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='change_cardtype']"/>');
	                        document.write('<xsl:text disable-output-escaping="yes">"/&gt;</xsl:text>');
	                    </script>
	                </a>
	                <noscript>
	                    <input name="change" type="image">
	                        <xsl:attribute name="src">
	                            <xsl:copy-of select="$imageloc"/>
	                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='change_cardtype_img_file']"/>
	                        </xsl:attribute>
	                        <xsl:attribute name="alt">
	                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='change_cardtype']"/>
	                        </xsl:attribute>
	                    </input>
	                </noscript>
	            </form>
	          
	          </xsl:when>
						<xsl:otherwise>								
						</xsl:otherwise>
					</xsl:choose>
					            
            <form method="post" name="cardconfirmation">
                <xsl:attribute name="action">
                    <xsl:value-of select="payment-model/cardconfirmation-action-url"/>
                </xsl:attribute>
                <input name="action" type="hidden" value="proceed"/>
                <input type="hidden" name="clickedButton" value=""/>

                <a id="proceedButton" href="#" onmouseover="activate('proceed')" onmouseout="inactivate('proceed')" onclick="submitTheForm('cardconfirmation','proceed');return false">
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
                        <xsl:attribute name="src">
                            <xsl:copy-of select="$imageloc"/>
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed_img_file']"/>
                        </xsl:attribute>
                        <xsl:attribute name="alt">
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed']"/>
                        </xsl:attribute>
                    </input>
                </noscript>
            </form>
        </div>
        <div id="templateCancel">
            <form method="post" name="cancelpayment">
                <xsl:attribute name="action">
                    <xsl:value-of select="payment-model/cancelation-action-url"/>
                </xsl:attribute>
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
</xsl:stylesheet>