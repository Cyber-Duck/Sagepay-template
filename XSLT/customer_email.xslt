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

	<xsl:template match="/payment-model">
		<!-- select the languages to use default is english-->
		<xsl:variable name="i18n" select="document('i18n.xml')" />
		<xsl:variable name="requiredlang" select="language" as="xs:string"/>
		<xsl:variable name="lang">
			<xsl:choose>
				<xsl:when test="string-length($i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='clientemail_title']) > 0">
					<xsl:value-of select="language" />
				</xsl:when>
				<xsl:otherwise>en</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="imageloc" select="concat(imagesURL,vendor/vendortemplate,'/')" as="xs:string"/>
		<xsl:variable name="vpsprotocol" select="transaction/vpsprotocol"/>
		<xsl:variable name ="state" select="transactionstate/txstateid"/>

		<html>
			<head>
				<title>
                   <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_title']"/>
				</title>
				<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
				<style type="text/css">@import url("<xsl:copy-of select="$imageloc"/>vsp3.css");</style>
				<style type="text/css">
					a:hover {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 10px;
					color: #006699;
					}
					a:link {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 10px;
					color: #006699;
					}
					a:visited {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 10px;
					color: #006699;
					}
					a:active {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 10px;
					color: #006699;
					}
					#textblue {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 10px;
					color: #008469;
					}
					#smalltextwhite {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 8pt;
					color: #FFFFFF;
					}
					#largetextblue {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 12pt;
					color: #006699;
					font-weight: bold;
					}
					
					.textred {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 10pt;
					color: #CC0000;
					}
				</style>
			</head>
			<body>
		<div id="pageWrapper">
		    <div id="headerTop"/>		
		    <div id="header">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td width="50%" valign="top">
                            <img src="{concat(imagesURL,'sagepay/sagepay_logo.gif')}" id="sagePayLogo" />												
                        </td>
                        <td width="50%" valign="top">
						<xsl:if test="string-length(vendor/logo)">
                            <img src="{concat(imagesURL,vendor/vspvendorname,'/',vendor/logo)}" id="vendorLogo"/>
						</xsl:if>
                        </td>
                    </tr>
                </tbody>
            </table>
			<div class="sectionheader noTopMargin">
                	
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_notification']"/>
            </div>		   
		</div>
        <div class="greyHzShadeBar">&#160;</div>
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			  <tr>
			    <td width="100%" height="409" align="center" valign="top">
					<br/>	
					<table width="655" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td width="1">
								<img border="0">
									<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='blankpixel_img_file']"/></xsl:attribute>
								</img>
							</td>
							<td width="653" align="center">
								<table width="600" cellpadding="0" cellspacing="0" border="0">										
									<tr>
										<td width="600" align="left">
											<xsl:if test="string-length(transaction/test) != 0">
												<p class="textred"><strong>
												<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_test_message1']"/>
												<br/>
												<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_test_message2']"/>												
												</strong>
												</p>
											</xsl:if>																						 
										    <xsl:choose>
											
										        <xsl:when test = "$state='16' or $state='15' or $state='14' or $state='21'" >
                                                    <p class="bodytextGreen">
 												    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_order_from_part1']"/>													
												    <xsl:value-of select ="vendor/vendorprovidedname" />
												    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_order_from_part2']"/>													
												</p>
                                                    <p class="bodytextGreen">
													<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_unique_reference']"/>
													<b> 
														<xsl:value-of select ="transaction/vendortxcode" />
														<br/> 
													</b>
												</p>
										        </xsl:when>
											    <xsl:otherwise>
													<p class="textred">
													<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_cancel_notification']"/>
													</p>								    	
											    </xsl:otherwise>
										    </xsl:choose>
										</td>
									</tr>
									<tr>
										<td width="600" height="10px">
											<p>
											</p>
										</td>
									</tr>
									<tr>
										<td width="600" align="left">
										<p>
                                        <xsl:choose>
                                        <xsl:when test = "string-length(transaction/customername) != 0" >
										<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_greeting']"/>
                                        <xsl:value-of select ="transaction/customername" />,
                                        </xsl:when>
                                        <xsl:when test = "string-length(card/cardholder) != 0" >
										<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_greeting']"/>
                                        <xsl:value-of select ="card/cardholder" />,
                                        </xsl:when> 
                                        <xsl:otherwise>
										<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_greeting_sir_madam']"/>										
                                        </xsl:otherwise> 
                                        </xsl:choose>
										</p>
										<p>									
									    <xsl:choose>
									        <xsl:when test = "$state='16' and transaction/transactiontypeid='1' "  >
   											    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_success_msg']"/>	
									        </xsl:when>
									        <xsl:when test = "$state='14' and transaction/transactiontypeid='3' "  >									        
 											    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_success_but']"/>
												<b><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_success_msg_no_money']"/></b>
												<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_deffered_success_msg_line3']"/>
												<xsl:value-of select ="vendor/vendorprovidedname" /> 
												<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_deffered_success_msg_line4']"/>
									        </xsl:when>									        
									        <xsl:when test = "$state='16' and transaction/transactiontypeid='4' "  >									        
 											    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_success_but']"/>
												<b><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_success_msg_no_money']"/></b>				
												<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_preauth_success_msg_line3']"/>
												<b><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_preauth_success_msg_line4']"/></b>
												<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_preauth_success_msg_line5']"/>
									        </xsl:when>									        
									        <xsl:when test = "($state='15' or $state='21') and (transaction/transactiontypeid='5')"  >
 											    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_authenticate_success_msg_line1']"/>
												<b><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_success_msg_no_money']"/></b>
											    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_preauth_success_msg_line3']"/>					
												<b><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_preauth_success_msg_line4']"/></b>
												<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_preauth_success_msg_line5']"/>														
									        </xsl:when>									        
									        
										    <xsl:otherwise>											
 											    <p><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_abort_part1']"/>
											    <b><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_abort_part2']"/></b>
 											    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_abort_part3']"/>
 											    <b><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_abort_part4']"/></b></p>
 											    <p><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_abort_part5']"/></p>
 											    <p><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_abort_part6']"/></p>
										    </xsl:otherwise>
									    </xsl:choose>										
										</p>
										                               
										<xsl:if test="($state='16' or $state='15' or $state='14' or $state='21') and string-length(transaction/emailmessage) != 0">
											<xsl:value-of select ="transaction/emailmessage" disable-output-escaping="yes"/>
										</xsl:if>
								
								
										<p>
										<br/>	
										
										<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_quote_orderno_part1']"/>		
										<b> <xsl:value-of select ="transaction/vendortxcode" /> </b>
										<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_quote_orderno_part2']"/>	
										<xsl:value-of select ="vendor/vendorprovidedname" />
										<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_quote_orderno_part3']"/>											
										</p>
										</td>
									</tr>
								</table>
								<table width="600" cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td width="600" colspan="3" valign="top">
										<img border="0">
											<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='blankpixel_img_file']"/></xsl:attribute>
										</img>
										</td>
									</tr>
									<tr>
										<td width="1">
										<img border="0">
											<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='blankpixel_img_file']"/></xsl:attribute>
										</img>
										</td>
										<td width="598" align="left">
											<!--Basket contents table start-->
											<table >
												<tr>
													<td width="20" valign="top">
														<img border="0">
															<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='email_bullet_img_file']"/></xsl:attribute>
															<xsl:attribute name="alt"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='email_bullet']"/></xsl:attribute>
														</img>
													</td>
													<td width="578" class="sagepayOrangeHeading"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_ordertottal']"/><xsl:value-of select ="transaction/formatedamount" /><xsl:text> </xsl:text><xsl:value-of select ="transaction/currency" /> </td>
												</tr>	
												<tr>
													<td width="20" valign="top"></td>
													<td width="578" class="sagepaySmalltext"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_cardused']"/><xsl:value-of select ="card/cardissuer" /> - <xsl:value-of select ="paymentsystem/paymentsystemname" /> - <xsl:value-of select ="card/cardnumber" /> - <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_attempt']"/><xsl:value-of select ="authorisationstate/authorisationattempt" /></td>

												</tr>
                                                <tr><td colspan="2" height="10px" class="greyHzShadeBar"></td></tr>
												<tr><td colspan="2" height="10px" ></td></tr>													
												<tr>
													<td width="20" valign="top">
														<img border="0">
															<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='email_bullet_img_file']"/></xsl:attribute>
															<xsl:attribute name="alt"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='email_bullet']"/></xsl:attribute>
														</img>
													</td>
													<td width="578" class="sagepayOrangeHeading"><b><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_you_bought']"/><xsl:value-of select ="transaction/description" /> </b></td>
												</tr>

												<xsl:if test="showbasket = 'true'">
												<tr>
													<td colspan="2">
													<table class="formTable" id="shoppingBasket">
                                                        <thead>
														    <tr>
															    <td width="30%">													
																    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_description']"/>
															    </td>
															    <td width="14%" align="right">
                                                                    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_quantity']"/>
                                                                </td>
                                                                <td width="14%" align="right">
																    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_value']"/>
															    </td>													
															    <td width="14%" align="right">
																    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_tax']"/>													
															    </td>
															    <td width="14%" align="right">
                                                                    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_total']"/>
                                                                </td>
                                                                <td width="14%" align="right">
																    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_linetotal']"/>
															    </td>																																	
														    </tr>
                                                        </thead>
                                                        <tbody>
														    <xsl:for-each select="//lineitem">															
															    <tr>
																    <td><xsl:value-of select="description" disable-output-escaping="yes"/></td>
																    <td align="right"><xsl:value-of select="quantity" disable-output-escaping="yes"/></td>															
																    <td align="right"><xsl:value-of select="itemvalue" disable-output-escaping="yes"/></td>
																    <td align="right"><xsl:value-of select="itemtax" disable-output-escaping="yes"/></td>
																    <td align="right"><xsl:value-of select="itemtotal" disable-output-escaping="yes"/></td>															
																    <td align="right"><xsl:value-of select="linetotal" disable-output-escaping="yes"/></td>																															
															    </tr>																										
														    </xsl:for-each>	
                                                        </tbody>                                     									
													</table>
													</td>
												</tr>	
												</xsl:if>
											</table>
										</td>
										<td width="1">
										<img border="0">
											<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='blankpixel_img_file']"/></xsl:attribute>
										</img>
										</td>							
									</tr>
								 <tr><td colspan="2" height="10px" class="greyHzShadeBar"></td></tr>		
									<tr>
										<td width="600" colspan="2" valign="top">
										<img border="0">
											<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='blankpixel_img_file']"/></xsl:attribute>
										</img>
										</td>
									</tr>																												
								</table>
								<br/>
								<table width="600">
                                	<xsl:if test="$vpsprotocol &lt; 2.23" >
									<tr>
										<td width="200" style="padding-left: 10px;">
										<xsl:if test="transaction/deliveryaddress">											
											<div class="bodytextOrange"><b><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_deliveryaddress']"/></b></div>
											<div class="address">
											<xsl:variable name="input" select="transaction/deliveryaddress" />
											<xsl:variable name="exp">
											<xsl:text>&#10;</xsl:text>
											</xsl:variable>
											<xsl:variable name="replace">&#x3c;br/&#x3e;</xsl:variable>
											<xsl:variable name="output" select="replace(string($input),$exp, $replace)" />
											<xsl:value-of select="$output" disable-output-escaping="yes" />
											<br/>
											<xsl:value-of select ="transaction/deliverypostcode" />											
											</div>										
										</xsl:if>
										</td>
										<td width="200" >
										<xsl:if test="transaction/billingaddress">
											<div class="bodytextOrange"><b><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_billingaddress']"/></b></div>
											<div class="address">
											<xsl:variable name="input" select="transaction/billingaddress" />
											<xsl:variable name="exp">
											<xsl:text>&#10;</xsl:text>
											</xsl:variable>
											<xsl:variable name="replace">&#x3c;br/&#x3e;</xsl:variable>
											<xsl:variable name="output" select="replace(string($input),$exp, $replace)" />
											<xsl:value-of select="$output" disable-output-escaping="yes" />
											<br/>
											<xsl:value-of select ="transaction/billingpostcode" />											
											</div>										
										</xsl:if>	
										</td>
										<td width="200">
										<xsl:if test="card/cardaddress">
											<div class="bodytextOrange"><b><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_cardaddress']"/></b></div>
                                            <div class="address">
											<xsl:variable name="input" select="card/cardaddress" />
											<xsl:variable name="exp">
											<xsl:text>&#10;</xsl:text>
											</xsl:variable>
											<xsl:variable name="replace">&#x3c;br/&#x3e;</xsl:variable>
											<xsl:variable name="output" select="replace(string($input),$exp, $replace)" />
											<xsl:value-of select="$output" disable-output-escaping="yes" />
											<br/>
											<xsl:value-of select ="card/cardpostcode" />											
											</div>										
										</xsl:if>	
										</td>
									</tr>
                                    </xsl:if>
                                    <xsl:if test="$vpsprotocol &gt; 2.22" >
                                    <tr>
										<td width="200" style="padding-left: 10px;" valign="top">
                                        <xsl:if test="transaction/deliveryaddress">                                            
                                            <div class="bodytextOrange"><b><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_deliveryaddress']"/></b></div>
                                            <div class="address">
                                            <xsl:value-of select="transaction/deliveryfirstnames"/><xsl:text> </xsl:text>
                                            <xsl:value-of select="transaction/deliverysurname"/>
                                            <br/>
                                            <xsl:value-of select="transaction/deliveryaddress"/>
                                            <xsl:variable name="deliveryaddress2">
                                                <xsl:value-of select="transaction/deliveryaddress2"/>
                                            </xsl:variable>
                                            <xsl:if test="string-length($deliveryaddress2)>0">
                                            <br/>
                                                <xsl:value-of select="transaction/deliveryaddress2"/>
                                            </xsl:if>
                                            <br/>
                                            <xsl:value-of select ="transaction/deliverycity" />	
                                            <xsl:variable name="deliverystate">
                                                <xsl:value-of select="transaction/deliverystate"/>
                                            </xsl:variable>
                                            <xsl:if test="string-length($deliverystate)>0">
                                            <br/>
                                            <xsl:value-of select ="transaction/deliverystate" />
                                            </xsl:if>
                                            <br/>
                                            <xsl:value-of select ="transaction/deliverypostcode" />
											<br/>
                                            <xsl:value-of select ="transaction/deliverycountry" />																
                                            <xsl:if test="string-length(transaction/deliveryphone)>0">
                                            <br/><br/>
                                            Tel: <xsl:value-of select ="transaction/deliveryphone" />
                                            </xsl:if>
                                            </div>										
                                        </xsl:if>
                                        </td>
                                        <td width="190" valign="top">
                                        <xsl:if test="transaction/billingaddress">
                                            
                                            <div class="bodytextOrange"><b><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_billingaddress']"/></b></div>
											<div class="address">
                                            <xsl:value-of select="transaction/billingfirstnames"/><xsl:text> </xsl:text>
                                            <xsl:value-of select="transaction/billingsurname"/>
                                            <br/>
                                            <xsl:value-of select="transaction/billingaddress"/>
                                            <xsl:variable name="billingaddress2">
                                                <xsl:value-of select="transaction/billingaddress2"/>
                                            </xsl:variable>
                                            <xsl:if test="string-length($billingaddress2)>0">
                                            <br/>
                                                <xsl:value-of select="transaction/billingaddress2"/>
                                            </xsl:if>
                                            <br/>
                                            <xsl:value-of select ="transaction/billingcity" />	
                                            <xsl:variable name="billingstate">
                                                <xsl:value-of select="transaction/billingstate"/>
                                            </xsl:variable>
                                            <xsl:if test="string-length($billingstate)>0">
                                            <br/>
                                            <xsl:value-of select ="transaction/billingstate" />
                                            </xsl:if>
                                            <br/>
                                            <xsl:value-of select ="transaction/billingpostcode" />
											<br/>
                                            <xsl:value-of select ="transaction/billingcountry" />															
                                            <xsl:if test="string-length(transaction/billingphone)>0">
                                            <br/><br/>
                                            Tel: <xsl:value-of select ="transaction/billingphone" />
                                            </xsl:if>
                                            </div>																	
                                        </xsl:if>	
                                        </td>
                                        <td width="190" align="left" valign="top">
                                        <xsl:if test="card/cardaddress">                                            
                                            <div class="bodytextOrange"><b><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_cardaddress']"/></b></div>
                                            <div class="address">
                                            <xsl:value-of select="card/cardholder"/>
                                            <br/>
											<xsl:value-of select ="card/cardaddress" />	
                                            <xsl:variable name="input" select="card/cardaddress2" />
											  <xsl:variable name="cardaddress2">
                                                <xsl:value-of select="card/cardaddress2"/>
                                            </xsl:variable>
                                            <xsl:if test="string-length($cardaddress2)>0">
                                            <br/>
                                                <xsl:value-of select="card/cardaddress2"/>
                                            </xsl:if>
                                            <br/>
                                            <xsl:value-of select ="card/cardcity" />	
                                            <xsl:variable name="cardstate">
                                                <xsl:value-of select="card/cardstate"/>
                                            </xsl:variable>
                                            <xsl:if test="string-length($cardstate)>0">
                                            <br/>
                                            <xsl:value-of select ="card/cardstate" />
                                            </xsl:if>
                                            <br/>
                                            <xsl:value-of select ="card/cardpostcode" />
											<br/>
                                            <xsl:value-of select ="card/cardcountry" />											
                                            </div>										
                                        </xsl:if>	
                                        </td>
                                    </tr>
                                    </xsl:if>
									<tr><td colspan="3" height="10px" class="greyHzShadeBar"></td></tr>
									<tr><td colspan="3" height="10px"></td></tr>
									<tr>
										<td width="600" align="left" colspan="3">
                                            <p class="sagepaySmalltext">
                                                <xsl:choose>
                                                    <xsl:when test = "FromEMail='support@sagepay.com'"  >

														<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_anyquestion_part1']"/> 
														<xsl:value-of select ="vendor/vendorprovidedname" /> 
														<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_anyquestion_part2']"/>																										
                                                        <a>
                                                            <xsl:attribute name="href">
                                                                <xsl:text disable-output-escaping="yes">mailto:</xsl:text>
                                                                <xsl:value-of select="FromEMail"/>
                                                            </xsl:attribute>
                                                            <xsl:value-of select="FromEMail"/>

                                                        </a>
                                                    </xsl:when>
                                                    <xsl:otherwise>
														<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_anyquestion_part1']"/> 
														<xsl:value-of select ="vendor/vendorprovidedname" /> 
														<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_anyquestion_part2_via']"/>
                                                        <a>
                                                            <xsl:attribute name="href">
                                                                <xsl:value-of select="vendor/homepageurl"/>
                                                            </xsl:attribute>
                                                            <xsl:value-of select="vendor/vendorprovidedname"/>
                                                        </a>.
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </p>
                                            <p class="sagepaySmalltext">
											<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_sagepay_part1']"/>
											<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_sagepay_part2']"/><a href="mailto:support@sagepay.com">support@sagepay.com</a>
										    </p>
                                            <p class="sagepaySmalltext">
											<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_sagepay_part3']"/>
											<xsl:value-of select="vendor/vendorprovidedname"/>
											<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_sagepay_part4']"/>
										    </p>
										</td>
									</tr>					
								</table>
								<br/>										
								<table width="653" cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td width="653" align="center" class="copyright">Copyright Sage Pay 2010 </td>
									</tr>								
								</table>
							</td>
							<td width="1">
								<img border="0">
									<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='blankpixel_img_file']"/></xsl:attribute>
								</img>
							</td>
						</tr>
						<tr>
							<td width="655" colspan="3">
								<img border="0">
									<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='blankpixel_img_file']"/></xsl:attribute>
								</img>
							</td>
						</tr>	
					</table>
				</td>
			  </tr>
			</table>
		</div>
		</div>												
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
